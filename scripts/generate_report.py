#!/usr/bin/env python3
"""Generate README.md and per-version detail report from results/.

Data sources (all for a single version):
  results/compatibility/<version>/linux_x86_64.json  -> per-tool compat data
  results/benchmarks/<version>/linux_x86_64.json     -> per-tool benchmark data
  results/benchmarks/<version>/linux_x86_64_sizes.json -> binary sizes
  results/compatibility/<version>/*.json              -> multi-platform compat summaries

The README uses Linux x86_64 as the canonical platform for both
compatibility and performance data.
"""

import json
import glob
import os
import re
import subprocess
import sys
from datetime import datetime, timezone

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.join(SCRIPT_DIR, "..")
RESULTS_DIR = os.path.join(PROJECT_ROOT, "results")


# ── Tool list ────────────────────────────────────────────────────────────────

def load_tools_list():
    """Load canonical tool list from tests/gnu_tools.txt."""
    path = os.path.join(PROJECT_ROOT, "tests", "gnu_tools.txt")
    if not os.path.exists(path):
        print(f"WARNING: {path} not found")
        return []
    with open(path) as f:
        return [line.strip() for line in f if line.strip() and not line.startswith("#")]


# ── Version discovery ────────────────────────────────────────────────────────

def parse_version(tag):
    """Extract (major, minor, patch) tuple for sorting."""
    m = re.match(r"v?(\d+)\.(\d+)\.(\d+)", tag)
    return tuple(int(x) for x in m.groups()) if m else (0, 0, 0)


def get_all_versions():
    """Discover all version tags that have any result data."""
    versions = set()
    for subdir in ("benchmarks", "compatibility"):
        for d in glob.glob(os.path.join(RESULTS_DIR, subdir, "v*")):
            if os.path.isdir(d):
                versions.add(os.path.basename(d))
    return sorted(versions, key=parse_version)


# ── Data loading ─────────────────────────────────────────────────────────────

def load_json(path):
    """Load a JSON file, returning None on any error."""
    try:
        with open(path) as f:
            return json.load(f)
    except (json.JSONDecodeError, IOError, FileNotFoundError):
        return None


def load_version_data(version):
    """Load all data for a single version into a flat structure.

    Returns dict:
        compat_tools:  {tool: {total, passed, failed, skipped, status, ...}}
        bench_tools:   {tool: {benchmarks: [...], ...}}
        sizes:         {tool: {f_bytes, gnu_bytes}}
        compat_platforms: {platform_key: {total_tests, passed, failed, ...}}
    """
    data = {
        "compat_tools": {},
        "bench_tools": {},
        "sizes": {},
        "compat_platforms": {},
    }

    # ── Compatibility (Linux x86_64 = canonical) ──
    compat_file = os.path.join(
        RESULTS_DIR, "compatibility", version, "linux_x86_64.json"
    )
    compat_json = load_json(compat_file)
    if compat_json:
        data["compat_tools"] = compat_json.get("tools", {})
        if "summary" in compat_json:
            data["compat_platforms"]["Linux_x86_64"] = compat_json["summary"]

    # ── Other platforms (for the platform table) ──
    compat_dir = os.path.join(RESULTS_DIR, "compatibility", version)
    if os.path.isdir(compat_dir):
        for jf in sorted(glob.glob(os.path.join(compat_dir, "*.json"))):
            d = load_json(jf)
            if not d or "summary" not in d:
                continue
            platform = d.get("platform", os.path.basename(jf).replace(".json", ""))
            if platform not in data["compat_platforms"]:
                data["compat_platforms"][platform] = d["summary"]

    # ── Benchmarks ──
    bench_file = os.path.join(
        RESULTS_DIR, "benchmarks", version, "linux_x86_64.json"
    )
    bench_json = load_json(bench_file)
    if bench_json and "tools" in bench_json:
        data["bench_tools"] = bench_json["tools"]

    # ── Sizes ──
    sizes_file = os.path.join(
        RESULTS_DIR, "benchmarks", version, "linux_x86_64_sizes.json"
    )
    sizes_json = load_json(sizes_file)
    if sizes_json and "sizes" in sizes_json:
        data["sizes"] = sizes_json["sizes"]

    return data


# ── Per-tool data extraction ─────────────────────────────────────────────────

def get_compat_rate(tool, compat_tools):
    """Get compatibility pass rate for a tool.

    Returns (rate_pct, total, passed) or (None, 0, 0) if no data.
    """
    if tool not in compat_tools:
        return None, 0, 0
    d = compat_tools[tool]
    if d.get("status") == "NOT_IMPLEMENTED":
        return None, 0, 0
    total = d.get("total", 0)
    passed = d.get("passed", 0)
    if total == 0:
        return None, 0, 0
    return passed / total * 100, total, passed


def get_best_speedup(tool, bench_tools):
    """Get best (peak) speedup for a tool across all benchmark scenarios."""
    if tool not in bench_tools:
        return None
    d = bench_tools[tool]
    if not isinstance(d, dict) or d.get("status") == "NOT_IMPLEMENTED":
        return None
    best = None
    for b in d.get("benchmarks", []):
        s = b.get("speedup")
        if isinstance(s, (int, float)) and s > 0:
            if best is None or s > best:
                best = s
    return best


# ── Formatting helpers ───────────────────────────────────────────────────────

def format_size(bytes_val):
    """Format bytes as human-readable string."""
    if bytes_val is None:
        return "-"
    if bytes_val >= 1_048_576:
        return f"{bytes_val / 1_048_576:.1f} MB"
    if bytes_val >= 1024:
        return f"{bytes_val / 1024:.1f} KB"
    return f"{bytes_val} B"


def format_compat(rate):
    """Format compatibility rate with status emoji."""
    if rate is None:
        return "-"
    if rate >= 100.0:
        return "\u2705 100%"
    if rate > 0:
        return f"\u26a0\ufe0f {rate:.0f}%"
    return "\u274c 0%"


def format_speedup(s):
    """Format speedup multiplier."""
    if s is None:
        return "-"
    return f"**{s:.1f}x**"


# ── README generation ────────────────────────────────────────────────────────

def generate_readme(version, all_tools, data):
    """Generate README.md from the latest version's data."""
    compat_tools = data["compat_tools"]
    bench_tools = data["bench_tools"]
    sizes = data["sizes"]

    # Summary stats (Linux x86_64)
    linux_summary = data["compat_platforms"].get("Linux_x86_64", {})
    total_tests = linux_summary.get("total_tests", 0)
    total_passed = linux_summary.get("passed", 0)
    pass_pct = f"{total_passed / total_tests * 100:.1f}" if total_tests > 0 else "0"

    # Fastest tool
    fastest_tool = ""
    fastest_speedup = 0
    for tool in all_tools:
        s = get_best_speedup(tool, bench_tools)
        if s is not None and s > fastest_speedup:
            fastest_speedup = s
            fastest_tool = tool

    # Known issues
    total_failed_all = sum(
        p.get("failed", 0)
        for p in data["compat_platforms"].values()
    )
    n_platforms = len(
        [p for p in data["compat_platforms"].values() if p.get("total_tests", 0) > 0]
    )
    if total_failed_all > 0:
        issues = (
            f"- {total_failed_all} compatibility test failures"
            f" across {n_platforms} platform(s)"
        )
    else:
        issues = "- No known issues"

    # Chart
    chart_path = os.path.join(RESULTS_DIR, "speedup-history.png")
    if os.path.exists(chart_path):
        chart_section = "![Speedup History](results/speedup-history.png)"
    else:
        chart_section = "_No chart available yet._"

    # ── Build tools table ──
    table_lines = [
        "| Tool | fcoreutils size | GNU size | Compat f\\* vs GNU | Speedup f\\* vs GNU |",
        "|------|----------------:|----------:|------------------:|-------------------:|",
    ]

    for tool in all_tools:
        rate, total, passed = get_compat_rate(tool, compat_tools)
        speedup = get_best_speedup(tool, bench_tools)

        f_size = format_size(sizes.get(tool, {}).get("f_bytes"))
        gnu_size = format_size(sizes.get(tool, {}).get("gnu_bytes"))
        compat_str = format_compat(rate)
        speedup_str = format_speedup(speedup)

        table_lines.append(
            f"| {tool} | {f_size} | {gnu_size} | {compat_str} | {speedup_str} |"
        )

    full_table = "\n".join(table_lines)

    readme = f"""\
# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

{chart_section}

## Latest Results ({version})

### Summary
- **Tools tracked:** {len(all_tools)} total
- **Compatibility:** {total_passed}/{total_tests} tests passed ({pass_pct}%)
- **Fastest speedup:** {fastest_tool} at {fastest_speedup:.1f}x faster than GNU

### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

{full_table}

### Known Issues
{issues}

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
- GNU coreutils — system-installed baseline

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Runs {total_tests}+ compatibility tests comparing output byte-for-byte against GNU coreutils
- Benchmarks using `hyperfine` with warmup runs and timed runs
- Measures binary sizes of f\\* and GNU for each tool
- Tests run across multiple platforms via GitHub Actions

## Running Locally
```bash
# Install and test
./scripts/install_from_github.sh
./tests/compatibility/run_all.sh
./tests/benchmarks/run_all.sh

# Generate chart
pip install matplotlib
python3 scripts/plot_speedup.py
```
"""

    readme_path = os.path.join(PROJECT_ROOT, "README.md")
    with open(readme_path, "w") as f:
        f.write(readme)
    print(f"README.md generated ({version})")


# ── Per-version report ───────────────────────────────────────────────────────

def generate_version_report(version, all_tools, data):
    """Generate a detailed report at results/benchmarks/<version>/report.md."""
    lines = [f"# fcoreutils {version} — Detailed Results\n"]
    ts = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")
    lines.append(f"Generated: {ts}\n")

    # Platform compatibility table
    if data["compat_platforms"]:
        lines.append("## Compatibility\n")
        lines.append("| Platform | Tests | Passed | Failed | Pass Rate |")
        lines.append("|----------|------:|-------:|-------:|----------:|")
        for platform, summary in sorted(data["compat_platforms"].items()):
            t = summary.get("total_tests", 0)
            p = summary.get("passed", 0)
            f = summary.get("failed", 0)
            r = f"{p / t * 100:.1f}%" if t > 0 else "N/A"
            lines.append(f"| {platform} | {t} | {p} | {f} | {r} |")
        lines.append("")

    # Per-tool compatibility
    if data["compat_tools"]:
        lines.append("## Per-Tool Compatibility (Linux x86_64)\n")
        lines.append("| Tool | Total | Passed | Failed | Rate |")
        lines.append("|------|------:|-------:|-------:|-----:|")
        for tool in all_tools:
            rate, total, passed = get_compat_rate(tool, data["compat_tools"])
            if rate is not None:
                failed = total - passed
                lines.append(f"| {tool} | {total} | {passed} | {failed} | {rate:.0f}% |")
        lines.append("")

    # Benchmarks
    if data["bench_tools"]:
        lines.append("## Performance (Linux x86_64)\n")
        lines.append("| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |")
        lines.append("|------|------|----------:|-----------------:|--------:|")
        for tool in all_tools:
            td = data["bench_tools"].get(tool, {})
            if not isinstance(td, dict) or td.get("status") == "NOT_IMPLEMENTED":
                continue
            for b in td.get("benchmarks", []):
                name = b.get("name", "")
                gnu_t = b.get("gnu_mean")
                f_t = b.get("f_mean")
                speedup = b.get("speedup")
                gnu_s = f"{gnu_t:.4f}s" if isinstance(gnu_t, (int, float)) else "-"
                f_s = f"{f_t:.4f}s" if isinstance(f_t, (int, float)) else "-"
                sp_s = f"**{speedup:.1f}x**" if isinstance(speedup, (int, float)) else "-"
                lines.append(f"| {tool} | {name} | {gnu_s} | {f_s} | {sp_s} |")
        lines.append("")

    # Write report
    report_dir = os.path.join(RESULTS_DIR, "benchmarks", version)
    if not os.path.isdir(report_dir):
        report_dir = os.path.join(RESULTS_DIR, "compatibility", version)
    os.makedirs(report_dir, exist_ok=True)

    report_path = os.path.join(report_dir, "report.md")
    with open(report_path, "w") as f:
        f.write("\n".join(lines))
    print(f"  Version report: {report_path}")


# ── Chart ────────────────────────────────────────────────────────────────────

def run_plot_script():
    """Regenerate the speedup-history chart."""
    plot_script = os.path.join(SCRIPT_DIR, "plot_speedup.py")
    if os.path.exists(plot_script):
        print("Generating speedup chart...")
        try:
            subprocess.run([sys.executable, plot_script], check=False)
        except Exception as e:
            print(f"Warning: Could not generate chart: {e}")


# ── Main ─────────────────────────────────────────────────────────────────────

def main():
    all_tools = load_tools_list()
    if not all_tools:
        print("ERROR: Could not load tool list from tests/gnu_tools.txt")
        return

    versions = get_all_versions()
    if not versions:
        print("No versioned results found. Generating minimal README.")
        readme_path = os.path.join(PROJECT_ROOT, "README.md")
        with open(readme_path, "w") as f:
            f.write(
                "# fcoreutils vs GNU coreutils — Independent Benchmark\n\n"
                "> No benchmark results available yet. Run CI to generate results.\n"
            )
        return

    print(f"Found {len(versions)} versions: {', '.join(versions)}")

    # Only generate report for the latest version
    latest = versions[-1]
    data = load_version_data(latest)

    # Version report (only latest — old reports are immutable)
    generate_version_report(latest, all_tools, data)

    # Chart
    run_plot_script()

    # README
    generate_readme(latest, all_tools, data)


if __name__ == "__main__":
    main()
