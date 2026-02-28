#!/usr/bin/env python3
"""Generate README.md and per-version detail report from CI results.

Data sources (all for a single version):
  results/compatibility/<version>/linux_x86_64.json  -> per-tool compat data
  results/benchmarks/<version>/linux_x86_64.json     -> per-tool benchmark data
  results/benchmarks/<version>/linux_x86_64_sizes.json -> binary sizes
  results/compatibility/<version>/*.json              -> multi-platform compat summaries

The README uses Linux x86_64 as the canonical platform.
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


# ── Helpers ──────────────────────────────────────────────────────────────────


def load_json(path):
    try:
        with open(path) as f:
            return json.load(f)
    except (json.JSONDecodeError, IOError, FileNotFoundError):
        return None


def parse_version(tag):
    m = re.match(r"v?(\d+)\.(\d+)\.(\d+)", tag)
    return tuple(int(x) for x in m.groups()) if m else (0, 0, 0)


def format_size(bytes_val):
    if bytes_val is None:
        return "-"
    if bytes_val >= 1_048_576:
        return f"{bytes_val / 1_048_576:.1f} MB"
    if bytes_val >= 1024:
        return f"{bytes_val / 1024:.1f} KB"
    return f"{bytes_val} B"


# ── Data loading ─────────────────────────────────────────────────────────────


def load_tools_list():
    path = os.path.join(PROJECT_ROOT, "tests", "gnu_tools.txt")
    if not os.path.exists(path):
        print(f"WARNING: {path} not found")
        return []
    with open(path) as f:
        return [line.strip() for line in f if line.strip() and not line.startswith("#")]


def get_all_versions():
    versions = set()
    for subdir in ("benchmarks", "compatibility"):
        for d in glob.glob(os.path.join(RESULTS_DIR, subdir, "v*")):
            if os.path.isdir(d):
                versions.add(os.path.basename(d))
    return sorted(versions, key=parse_version)


def load_version_data(version):
    """Load all data files for a single version.

    Returns dict with keys:
        compat_tools:      {tool: {total, passed, failed, skipped, status, ...}}
        bench_tools:       {tool: {benchmarks: [...], ...}}
        sizes:             {tool: {f_bytes, gnu_bytes}}
        compat_platforms:  {platform: {total_tests, passed, failed, ...}}
    """
    data = {
        "compat_tools": {},
        "bench_tools": {},
        "sizes": {},
        "compat_platforms": {},
    }

    # Compatibility (Linux x86_64 = canonical)
    compat_file = os.path.join(
        RESULTS_DIR, "compatibility", version, "linux_x86_64.json"
    )
    compat_json = load_json(compat_file)
    if compat_json:
        data["compat_tools"] = compat_json.get("tools", {})
        if "summary" in compat_json:
            data["compat_platforms"]["Linux_x86_64"] = compat_json["summary"]

    # Other platforms
    compat_dir = os.path.join(RESULTS_DIR, "compatibility", version)
    if os.path.isdir(compat_dir):
        for jf in sorted(glob.glob(os.path.join(compat_dir, "*.json"))):
            d = load_json(jf)
            if not d or "summary" not in d:
                continue
            platform = d.get("platform", os.path.basename(jf).replace(".json", ""))
            if platform not in data["compat_platforms"]:
                data["compat_platforms"][platform] = d["summary"]

    # Benchmarks
    bench_file = os.path.join(
        RESULTS_DIR, "benchmarks", version, "linux_x86_64.json"
    )
    bench_json = load_json(bench_file)
    if bench_json and "tools" in bench_json:
        data["bench_tools"] = bench_json["tools"]

    # Sizes
    sizes_file = os.path.join(
        RESULTS_DIR, "benchmarks", version, "linux_x86_64_sizes.json"
    )
    sizes_json = load_json(sizes_file)
    if sizes_json and "sizes" in sizes_json:
        data["sizes"] = sizes_json["sizes"]

    return data


# ── Per-tool metrics ─────────────────────────────────────────────────────────


def compute_compat(tool, compat_tools):
    """Compute compatibility info for a tool.

    Returns a dict:
        present:  bool   - whether the tool has any compat entry
        status:   str    - "tested", "NOT_IMPLEMENTED", or "missing"
        total:    int
        passed:   int
        rate:     float or None  - pass percentage (None if total==0)
    """
    if tool not in compat_tools:
        return {"present": False, "status": "missing", "total": 0, "passed": 0, "rate": None}

    d = compat_tools[tool]
    status = d.get("status", "tested")

    if status == "NOT_IMPLEMENTED":
        return {"present": True, "status": "NOT_IMPLEMENTED", "total": 0, "passed": 0, "rate": None}

    total = d.get("total", 0)
    passed = d.get("passed", 0)

    if total == 0:
        return {"present": True, "status": "tested", "total": 0, "passed": 0, "rate": None}

    rate = passed / total * 100
    return {"present": True, "status": "tested", "total": total, "passed": passed, "rate": rate}


def compute_speedup(tool, bench_tools):
    """Compute speedup info for a tool.

    Returns a dict:
        present:     bool   - whether the tool has bench entry
        status:      str    - "benchmarked", "NOT_IMPLEMENTED", "all_errors",
                              "gnu_missing", "missing"
        best:        float or None  - best speedup value
        avg:         float or None  - average speedup across valid benchmarks
        n_scenarios: int    - total benchmark scenarios
        n_valid:     int    - scenarios with valid speedup numbers
    """
    if tool not in bench_tools:
        return {"present": False, "status": "missing", "best": None, "avg": None,
                "n_scenarios": 0, "n_valid": 0}

    d = bench_tools[tool]
    if not isinstance(d, dict):
        return {"present": False, "status": "missing", "best": None, "avg": None,
                "n_scenarios": 0, "n_valid": 0}

    if d.get("status") == "NOT_IMPLEMENTED":
        return {"present": True, "status": "NOT_IMPLEMENTED", "best": None, "avg": None,
                "n_scenarios": 0, "n_valid": 0}

    benchmarks = d.get("benchmarks", [])
    n_scenarios = len(benchmarks)
    n_errors = sum(1 for b in benchmarks if "error" in b)
    n_gnu_missing = sum(1 for b in benchmarks if b.get("gnu_missing"))

    # Collect valid speedup values (numeric, not None)
    speedups = []
    for b in benchmarks:
        s = b.get("speedup")
        if isinstance(s, (int, float)):
            speedups.append(s)

    if not speedups:
        if n_gnu_missing == n_scenarios:
            return {"present": True, "status": "gnu_missing", "best": None, "avg": None,
                    "n_scenarios": n_scenarios, "n_valid": 0}
        if n_errors > 0:
            return {"present": True, "status": "all_errors", "best": None, "avg": None,
                    "n_scenarios": n_scenarios, "n_valid": 0}
        return {"present": True, "status": "no_data", "best": None, "avg": None,
                "n_scenarios": n_scenarios, "n_valid": 0}

    best = max(speedups)
    avg = sum(speedups) / len(speedups)

    return {"present": True, "status": "benchmarked", "best": best, "avg": avg,
            "n_scenarios": n_scenarios, "n_valid": len(speedups)}


# ── Formatting ───────────────────────────────────────────────────────────────


def format_compat(info):
    """Format compatibility column based on computed info."""
    if not info["present"] or info["status"] == "missing":
        return "-"
    if info["status"] == "NOT_IMPLEMENTED":
        return "N/A"
    if info["total"] == 0:
        # Tool was tested but produced 0 test results (test script likely crashed)
        return "⏭️ 0 tests"

    rate = info["rate"]
    if rate >= 100.0:
        return f"✅ {info['passed']}/{info['total']}"
    if rate > 0:
        return f"⚠️ {rate:.0f}% ({info['passed']}/{info['total']})"
    return f"❌ 0% (0/{info['total']})"


def format_speedup(info):
    """Format speedup column based on computed info."""
    if not info["present"] or info["status"] == "missing":
        return "-"
    if info["status"] == "NOT_IMPLEMENTED":
        return "N/A"
    if info["status"] == "gnu_missing":
        return "N/A"
    if info["status"] == "all_errors":
        return "⚠️ error"

    best = info["best"]
    if best is None:
        return "-"

    if best < 0.05:
        # Very tiny ratio (e.g. shell builtins vs Rust binary startup)
        return "<0.1x"
    if best >= 1.0:
        return f"**{best:.1f}x**"
    return f"{best:.1f}x"


# ── README generation ────────────────────────────────────────────────────────


def generate_readme(version, all_tools, data):
    compat_tools = data["compat_tools"]
    bench_tools = data["bench_tools"]
    sizes = data["sizes"]

    # Summary stats (Linux x86_64)
    linux_summary = data["compat_platforms"].get("Linux_x86_64", {})
    total_tests = linux_summary.get("total_tests", 0)
    total_passed = linux_summary.get("passed", 0)
    pass_pct = f"{total_passed / total_tests * 100:.1f}" if total_tests > 0 else "0"

    # Fastest tool (using best speedup, must be meaningful > 1.0)
    fastest_tool = ""
    fastest_speedup = 0.0
    for tool in all_tools:
        info = compute_speedup(tool, bench_tools)
        if info["best"] is not None and info["best"] > fastest_speedup:
            fastest_speedup = info["best"]
            fastest_tool = tool

    # Count tools with data
    tools_with_sizes = sum(1 for t in all_tools if t in sizes)
    tools_with_compat = sum(1 for t in all_tools
                           if t in compat_tools and compat_tools[t].get("total", 0) > 0)
    tools_with_bench = sum(1 for t in all_tools
                          if t in bench_tools
                          and isinstance(bench_tools.get(t), dict)
                          and bench_tools[t].get("status") != "NOT_IMPLEMENTED"
                          and any(isinstance(b.get("speedup"), (int, float))
                                 for b in bench_tools[t].get("benchmarks", [])))

    # Known issues
    total_failed_all = sum(
        p.get("failed", 0) for p in data["compat_platforms"].values()
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
    chart_section = ("![Speedup History](results/speedup-history.png)"
                     if os.path.exists(chart_path) else "_No chart available yet._")

    # Build tools table
    table_lines = [
        "| Tool | fcoreutils size | GNU size | Compat f\\* vs GNU | Speedup f\\* vs GNU |",
        "|------|----------------:|---------:|------------------:|-------------------:|",
    ]

    for tool in all_tools:
        compat_info = compute_compat(tool, compat_tools)
        speedup_info = compute_speedup(tool, bench_tools)

        f_size = format_size(sizes.get(tool, {}).get("f_bytes"))
        gnu_size = format_size(sizes.get(tool, {}).get("gnu_bytes"))
        compat_str = format_compat(compat_info)
        speedup_str = format_speedup(speedup_info)

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
- **Tools tracked:** {len(all_tools)} total ({tools_with_sizes} with binaries)
- **Compatibility:** {total_passed}/{total_tests} tests passed ({pass_pct}%) across {tools_with_compat} tools
- **Benchmarked:** {tools_with_bench} tools with performance data
- **Fastest speedup:** {fastest_tool} at {fastest_speedup:.1f}x faster than GNU

### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
>
> Legend: `-` = no data collected | `N/A` = not applicable | `⏭️ 0 tests` = test ran but produced 0 results

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
            info = compute_compat(tool, data["compat_tools"])
            if info["present"] and info["status"] == "tested":
                if info["total"] > 0:
                    failed = info["total"] - info["passed"]
                    lines.append(f"| {tool} | {info['total']} | {info['passed']} | {failed} | {info['rate']:.0f}% |")
                else:
                    lines.append(f"| {tool} | 0 | 0 | 0 | no tests |")
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
                if isinstance(speedup, (int, float)):
                    sp_s = f"**{speedup:.1f}x**" if speedup >= 1.0 else f"{speedup:.1f}x"
                else:
                    sp_s = "-"
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

    print(f"Found {len(versions)} versions: {', '.join(versions[-5:])}")

    latest = versions[-1]
    data = load_version_data(latest)

    # Diagnostic: report data coverage
    compat_tools = data["compat_tools"]
    bench_tools = data["bench_tools"]
    sizes = data["sizes"]

    n_sizes = sum(1 for t in all_tools if t in sizes)
    n_compat = sum(1 for t in all_tools if t in compat_tools and compat_tools[t].get("total", 0) > 0)
    n_compat_zero = sum(1 for t in all_tools
                        if t in compat_tools
                        and compat_tools[t].get("status") == "tested"
                        and compat_tools[t].get("total", 0) == 0)
    n_bench = sum(1 for t in all_tools
                  if t in bench_tools
                  and isinstance(bench_tools.get(t), dict)
                  and bench_tools[t].get("status") != "NOT_IMPLEMENTED")

    print(f"\nData coverage for {latest}:")
    print(f"  Sizes:       {n_sizes}/{len(all_tools)} tools")
    print(f"  Compat:      {n_compat}/{len(all_tools)} tools with test results")
    if n_compat_zero > 0:
        zero_tools = [t for t in all_tools
                      if t in compat_tools
                      and compat_tools[t].get("status") == "tested"
                      and compat_tools[t].get("total", 0) == 0]
        print(f"  Compat (0):  {n_compat_zero} tools tested but 0 results: {', '.join(zero_tools)}")
    print(f"  Benchmarks:  {n_bench}/{len(all_tools)} tools")

    # Check for bench scripts without results
    bench_scripts_dir = os.path.join(PROJECT_ROOT, "tests", "benchmarks")
    if os.path.isdir(bench_scripts_dir):
        scripts_exist = set()
        for f in os.listdir(bench_scripts_dir):
            if f.startswith("bench_") and f.endswith(".sh") and f != "bench_common.sh":
                scripts_exist.add(f.replace("bench_", "").replace(".sh", ""))
        missing = scripts_exist - set(bench_tools.keys())
        if missing:
            print(f"  Bench scripts without results ({len(missing)}): {', '.join(sorted(missing))}")

    # Generate outputs
    generate_version_report(latest, all_tools, data)
    run_plot_script()
    generate_readme(latest, all_tools, data)


if __name__ == "__main__":
    main()
