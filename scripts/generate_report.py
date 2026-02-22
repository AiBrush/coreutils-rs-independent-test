#!/usr/bin/env python3
"""Generate README.md and per-version detail reports from results/."""

import json
import glob
import os
import subprocess
import sys
from datetime import datetime

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.join(SCRIPT_DIR, "..")
RESULTS_DIR = os.path.join(PROJECT_ROOT, "results")

# Load canonical tool list from tests/gnu_tools.txt
_GNU_TOOLS_FILE = os.path.join(PROJECT_ROOT, "tests", "gnu_tools.txt")
if os.path.exists(_GNU_TOOLS_FILE):
    with open(_GNU_TOOLS_FILE) as _f:
        ALL_TOOLS = [line.strip() for line in _f if line.strip() and not line.startswith('#')]
else:
    # Fallback: hardcoded sorted list
    ALL_TOOLS = sorted([
        "arch", "b2sum", "base32", "base64", "basename", "basenc", "cat", "chcon",
        "chgrp", "chmod", "chown", "chroot", "cksum", "comm", "cp", "csplit", "cut",
        "date", "dd", "df", "dir", "dircolors", "dirname", "du", "echo", "env",
        "expand", "expr", "factor", "false", "fmt", "fold", "groups", "head",
        "hostid", "id", "install", "join", "kill", "link", "ln", "logname", "ls",
        "md5sum", "mkdir", "mkfifo", "mknod", "mktemp", "mv", "nice", "nl",
        "nohup", "nproc", "numfmt", "od", "paste", "pathchk", "pinky", "pr",
        "printenv", "printf", "ptx", "pwd", "readlink", "realpath", "rev", "rm",
        "rmdir", "runcon", "seq", "sha1sum", "sha224sum", "sha256sum", "sha384sum",
        "sha512sum", "shred", "shuf", "sleep", "sort", "split", "stat", "stdbuf",
        "stty", "sum", "sync", "tac", "tail", "tee", "test", "timeout", "touch",
        "tr", "true", "truncate", "tsort", "tty", "uname", "unexpand", "uniq",
        "unlink", "uptime", "users", "vdir", "wc", "who", "whoami", "yes",
    ], key=str.lower)


def parse_version(tag):
    """Extract (major, minor, patch) from version tag."""
    import re
    m = re.match(r"v?(\d+)\.(\d+)\.(\d+)", tag)
    if m:
        return (int(m.group(1)), int(m.group(2)), int(m.group(3)))
    return (0, 0, 0)


def get_all_versions():
    """Get all versions that have benchmark or compatibility data."""
    versions = set()
    for subdir in ["benchmarks", "compatibility"]:
        pattern = os.path.join(RESULTS_DIR, subdir, "v*")
        for d in glob.glob(pattern):
            if os.path.isdir(d):
                versions.add(os.path.basename(d))
    return sorted(versions, key=parse_version)


def load_benchmark_data(version):
    """Load all benchmark JSON files for a version."""
    bench_dir = os.path.join(RESULTS_DIR, "benchmarks", version)
    platforms = {}
    if not os.path.isdir(bench_dir):
        return platforms

    for jf in glob.glob(os.path.join(bench_dir, "linux_*.json")):
        # Skip sizes files
        if "_sizes.json" in jf:
            continue
        try:
            with open(jf) as f:
                data = json.load(f)
            platform = data.get("platform", os.path.basename(jf).replace(".json", ""))
            platforms[platform] = data.get("tools", {})
        except (json.JSONDecodeError, IOError):
            pass
    return platforms


def load_compatibility_data(version):
    """Load all compatibility JSON files for a version.

    Returns (platforms, tool_results) where:
      platforms: dict of platform -> summary dict
      tool_results: dict of tool_name -> dict of platform -> per-tool data
    """
    compat_dir = os.path.join(RESULTS_DIR, "compatibility", version)
    platforms = {}
    tool_results = {}
    if not os.path.isdir(compat_dir):
        return platforms, tool_results

    for jf in glob.glob(os.path.join(compat_dir, "*.json")):
        try:
            with open(jf) as f:
                data = json.load(f)
        except (json.JSONDecodeError, IOError):
            continue

        platform = data.get("platform", os.path.basename(jf).replace(".json", ""))

        if "summary" in data and "total_tests" in data.get("summary", {}):
            platforms[platform] = data.get("summary", {})
            # New format: extract per-tool data from "tools" field
            if "tools" in data and isinstance(data["tools"], dict):
                for tool, tool_data in data["tools"].items():
                    if tool not in tool_results:
                        tool_results[tool] = {}
                    tool_results[tool][platform] = tool_data
        elif "tool" in data:
            # Legacy per-tool file format
            tool = data["tool"]
            if tool not in tool_results:
                tool_results[tool] = {}
            tool_results[tool][platform] = data

    return platforms, tool_results


def load_size_data(version):
    """Load binary size data for a version from linux_*_sizes.json files."""
    bench_dir = os.path.join(RESULTS_DIR, "benchmarks", version)
    sizes = {}
    if not os.path.isdir(bench_dir):
        return sizes

    for jf in glob.glob(os.path.join(bench_dir, "linux_*_sizes.json")):
        try:
            with open(jf) as f:
                data = json.load(f)
            for tool, sz in data.get("sizes", {}).items():
                if tool not in sizes:
                    sizes[tool] = sz
        except (json.JSONDecodeError, IOError):
            pass
    return sizes


def load_source_sizes():
    """Load binary sizes from results/source_sizes.json (collected during source build)."""
    sizes_file = os.path.join(RESULTS_DIR, "source_sizes.json")
    if not os.path.exists(sizes_file):
        return {}
    try:
        with open(sizes_file) as f:
            data = json.load(f)
        return data.get("sizes", {})
    except (json.JSONDecodeError, IOError):
        return {}


def load_new_tools_data():
    """Load source-built compat + bench data."""
    bench_data = {}
    compat_data = {}   # tool -> {platform_key -> per_tool_data}

    # Benchmark data: Linux x86_64 only (canonical benchmark platform)
    bench_file = os.path.join(RESULTS_DIR, "source_bench.json")
    if os.path.exists(bench_file):
        try:
            with open(bench_file) as f:
                d = json.load(f)
            for tool, data in d.get("tools", {}).items():
                if isinstance(data, dict) and data.get("status") != "NOT_IMPLEMENTED":
                    bench_data[tool] = data
        except (json.JSONDecodeError, IOError):
            pass

    # Compat data: source_compat_*.json (platform-specific) and source_compat.json (single file)
    source_compat_files = glob.glob(os.path.join(RESULTS_DIR, "source_compat_*.json"))
    # Also handle the single source_compat.json file (no platform suffix)
    single_compat = os.path.join(RESULTS_DIR, "source_compat.json")
    if os.path.exists(single_compat):
        source_compat_files.append(single_compat)

    for jf in source_compat_files:
        try:
            with open(jf) as f:
                d = json.load(f)
            # Use the platform field from the JSON, falling back to Linux_x86_64
            # (source builds run on Linux x86_64 with real GNU tools)
            platform_key = d.get("platform", "Linux_x86_64")
            for tool, data in d.get("tools", {}).items():
                if tool not in compat_data:
                    compat_data[tool] = {}
                compat_data[tool][platform_key] = data
        except (json.JSONDecodeError, IOError):
            pass

    return bench_data, compat_data


def compute_speedups(bench_platforms):
    """Compute best speedup per tool across all platforms.

    Returns (tool_speedups, tool_f_vs_uutils) dicts mapping tool -> best speedup value.
    """
    tool_speedups = {}
    tool_f_vs_uutils = {}
    for platform, tools in bench_platforms.items():
        for tool, data in tools.items():
            if not isinstance(data, dict) or data.get("status") == "NOT_IMPLEMENTED":
                continue
            for b in data.get("benchmarks", []):
                s = b.get("speedup")
                if isinstance(s, (int, float)) and s > 0:
                    if tool not in tool_speedups or s > tool_speedups[tool]:
                        tool_speedups[tool] = s
                fvu = b.get("f_vs_uutils")
                if isinstance(fvu, (int, float)) and fvu > 0:
                    if tool not in tool_f_vs_uutils or fvu > tool_f_vs_uutils[tool]:
                        tool_f_vs_uutils[tool] = fvu
    return tool_speedups, tool_f_vs_uutils


def compute_compat_rate(tool, tool_results):
    """Compute compatibility pass rate (0-100) for a tool.

    Uses Linux x86_64 as the canonical GNU compatibility platform, since
    macOS and Windows use BSD tools with different output formats.
    Falls back to any Linux platform, then any platform.
    """
    if tool not in tool_results:
        return None

    platforms = tool_results[tool]

    # Preferred: Linux x86_64 (actual GNU tools)
    for platform, data in platforms.items():
        if "Linux_x86_64" in platform:
            if data.get("status") == "NOT_IMPLEMENTED":
                return None
            t = data.get("total", 0)
            p = data.get("passed", 0)
            if t > 0:
                return p / t * 100

    # Fallback: any Linux platform
    for platform, data in platforms.items():
        if platform.startswith("Linux_"):
            if data.get("status") == "NOT_IMPLEMENTED":
                continue
            t = data.get("total", 0)
            p = data.get("passed", 0)
            if t > 0:
                return p / t * 100

    return None


def get_size_ratio(tool, sizes, key_a, key_b):
    """Compute ratio key_a/key_b for a tool's binary sizes. Returns float or None."""
    if tool not in sizes:
        return None
    s = sizes[tool]
    a = s.get(key_a)
    b = s.get(key_b)
    if a and b and b > 0:
        return a / b
    return None


def format_size(bytes_val):
    """Format bytes as human-readable size string."""
    if bytes_val is None:
        return "-"
    if bytes_val >= 1_048_576:
        return f"{bytes_val / 1_048_576:.1f} MB"
    elif bytes_val >= 1024:
        return f"{bytes_val / 1024:.1f} KB"
    return f"{bytes_val} B"


def generate_version_report(version, bench_platforms, compat_platforms, tool_results):
    """Generate a detailed per-version report at results/benchmarks/VERSION/report.md."""
    lines = []
    lines.append(f"# fcoreutils {version} — Detailed Results\n")
    lines.append(f"Generated: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S UTC')}\n")

    # Compatibility summary
    total_tests = sum(p.get("total_tests", 0) for p in compat_platforms.values())
    total_passed = sum(p.get("passed", 0) for p in compat_platforms.values())
    total_failed = sum(p.get("failed", 0) for p in compat_platforms.values())

    if total_tests > 0:
        pass_rate = total_passed / total_tests * 100
        lines.append("## Compatibility\n")
        lines.append("| Platform | Tests | Passed | Failed | Pass Rate |")
        lines.append("|----------|-------|--------|--------|-----------|")
        for platform, summary in sorted(compat_platforms.items()):
            t = summary.get("total_tests", 0)
            p = summary.get("passed", 0)
            f = summary.get("failed", 0)
            r = f"{p/t*100:.1f}%" if t > 0 else "N/A"
            lines.append(f"| {platform} | {t} | {p} | {f} | {r} |")
        lines.append(f"\n**Overall: {total_passed}/{total_tests} ({pass_rate:.1f}%)**\n")

    # Benchmark results
    if bench_platforms:
        lines.append("## Performance\n")

        has_uutils = False
        for platform, tools in bench_platforms.items():
            for tool, data in tools.items():
                if isinstance(data, dict):
                    for b in data.get("benchmarks", []):
                        if isinstance(b.get("uutils_mean"), (int, float)):
                            has_uutils = True
                            break

        for platform in sorted(bench_platforms.keys()):
            lines.append(f"### {platform}\n")
            if has_uutils:
                lines.append("| Tool | Test | GNU (mean) | fcoreutils (mean) | uutils (mean) | f* vs GNU | f* vs uutils |")
                lines.append("|------|------|-----------|-------------------|---------------|----------:|-------------:|")
            else:
                lines.append("| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |")
                lines.append("|------|------|-----------|-------------------|---------|")

            for tool in ALL_TOOLS:
                data = bench_platforms[platform].get(tool, {})
                if not isinstance(data, dict):
                    continue
                if data.get("status") == "NOT_IMPLEMENTED":
                    if has_uutils:
                        lines.append(f"| {tool} | - | - | - | - | N/A | N/A |")
                    else:
                        lines.append(f"| {tool} | - | - | - | N/A |")
                    continue
                benchmarks = data.get("benchmarks", [])
                if not benchmarks:
                    continue
                for b in benchmarks:
                    name = b.get("name", "")
                    gnu_t = b.get("gnu_mean")
                    f_t = b.get("f_mean")
                    speedup = b.get("speedup")
                    gnu_str = f"{gnu_t:.4f}s" if isinstance(gnu_t, (int, float)) and gnu_t > 0 else "N/A"
                    f_str = f"{f_t:.4f}s" if isinstance(f_t, (int, float)) and f_t > 0 else "-"
                    sp_str = f"**{speedup:.1f}x**" if isinstance(speedup, (int, float)) and speedup > 0 else "-"

                    if has_uutils:
                        uutils_t = b.get("uutils_mean")
                        fvu = b.get("f_vs_uutils")
                        u_str = f"{uutils_t:.4f}s" if isinstance(uutils_t, (int, float)) and uutils_t > 0 else "N/A"
                        fvu_str = f"**{fvu:.1f}x**" if isinstance(fvu, (int, float)) and fvu > 0 else "N/A"
                        lines.append(f"| {tool} | {name} | {gnu_str} | {f_str} | {u_str} | {sp_str} | {fvu_str} |")
                    else:
                        lines.append(f"| {tool} | {name} | {gnu_str} | {f_str} | {sp_str} |")
            lines.append("")

    report_dir = os.path.join(RESULTS_DIR, "benchmarks", version)
    if not os.path.isdir(report_dir):
        report_dir = os.path.join(RESULTS_DIR, "compatibility", version)
    if not os.path.isdir(report_dir):
        os.makedirs(report_dir, exist_ok=True)

    report_path = os.path.join(report_dir, "report.md")
    with open(report_path, "w") as f:
        f.write("\n".join(lines))
    print(f"  Version report: {report_path}")


def generate_readme(latest_version, bench_platforms, compat_platforms,
                    tool_speedups, tool_f_vs_uutils, tool_results, sizes):
    """Generate the README.md with a full tools comparison table."""
    total_tests = sum(p.get("total_tests", 0) for p in compat_platforms.values())
    total_passed = sum(p.get("passed", 0) for p in compat_platforms.values())
    pass_pct = f"{total_passed / total_tests * 100:.1f}" if total_tests > 0 else "0"

    # Count tools with any data
    tools_with_data = sum(
        1 for t in ALL_TOOLS
        if t in tool_speedups or t in tool_results
    )

    # Find fastest tool
    fastest_tool = ""
    fastest_speedup = 0
    for tool, s in tool_speedups.items():
        if s > fastest_speedup:
            fastest_speedup = s
            fastest_tool = tool

    # Known issues
    total_failed = sum(p.get("failed", 0) for p in compat_platforms.values())
    if total_failed > 0:
        issues = f"- {total_failed} compatibility test failures across {len(compat_platforms)} platforms"
    else:
        issues = "- No known issues"

    # Check if chart exists
    chart_path = os.path.join(RESULTS_DIR, "speedup-history.png")
    chart_section = "![Speedup History](results/speedup-history.png)"
    if not os.path.exists(chart_path):
        chart_section = "_No chart available yet._"

    # Build the full tools table
    table_lines = []
    table_lines.append("| Tool | fcoreutils size | GNU size | uutils size | Compat f\\* vs GNU | Speedup f\\* vs GNU | Speedup f\\* vs uutils |")
    table_lines.append("|------|----------------:|----------:|----------:|------------------:|-------------------:|----------------------:|")

    for tool in ALL_TOOLS:
        compat_gnu = compute_compat_rate(tool, tool_results)

        f_size   = format_size(sizes.get(tool, {}).get("f_bytes"))
        gnu_size = format_size(sizes.get(tool, {}).get("gnu_bytes"))
        uu_size  = format_size(sizes.get(tool, {}).get("uutils_bytes"))

        if compat_gnu is None:
            compat_gnu_str = "-"
        elif compat_gnu >= 100.0:
            compat_gnu_str = "\u2705 100%"
        elif compat_gnu > 0:
            compat_gnu_str = f"\u26a0\ufe0f {compat_gnu:.0f}%"
        else:
            compat_gnu_str = "\u274c 0%"

        sg = tool_speedups.get(tool)
        su = tool_f_vs_uutils.get(tool)
        speedup_gnu_str = f"**{sg:.1f}x**" if sg is not None else "-"
        speedup_uutils_str = f"**{su:.1f}x**" if su is not None else "-"

        table_lines.append(
            f"| {tool} | {f_size} | {gnu_size} | {uu_size} | {compat_gnu_str} | {speedup_gnu_str} | {speedup_uutils_str} |"
        )

    full_table = "\n".join(table_lines)

    sources = """## Sources
- [fcoreutils](https://github.com/AiBrush/fcoreutils) — installed from GitHub Releases
- [uutils/coreutils](https://github.com/uutils/coreutils) — built from source (latest main)
- GNU coreutils — system-installed baseline"""

    readme = f"""# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/fcoreutils), a Rust rewrite of GNU coreutils.

## Performance Over Versions

{chart_section}

## Latest Results ({latest_version})

### Summary
- **Tools tracked:** {len(ALL_TOOLS)} total
- **Compatibility:** {total_passed}/{total_tests} tests passed ({pass_pct}%)
- **Fastest speedup:** {fastest_tool} at {fastest_speedup:.1f}x faster than GNU

### Full Tools Comparison

> Sizes are raw binary sizes. Compat is GNU test pass rate. Speedup is peak across all benchmark scenarios.
> `-` = no data collected yet for this tool/metric.

{full_table}

### Known Issues
{issues}

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

{sources}

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Builds uutils/coreutils from source for comparison
- Runs {total_tests}+ compatibility tests comparing output byte-for-byte against GNU coreutils
- Benchmarks using `hyperfine` with warmup runs and timed runs
- Measures binary sizes of f\\*, GNU, and uutils for each tool
- Tests run across multiple platforms via GitHub Actions

## Running Locally
```bash
# Run benchmarks for the latest version (includes uutils build)
./scripts/install_from_github.sh
./tests/benchmarks/run_all.sh

# Run compatibility tests
./tests/compatibility/run_all.sh

# Generate the plot
pip install matplotlib
python3 scripts/plot_speedup.py
```
"""

    readme_path = os.path.join(PROJECT_ROOT, "README.md")
    with open(readme_path, "w") as f:
        f.write(readme)
    print(f"README.md generated ({latest_version})")


def run_plot_script():
    """Run plot_speedup.py to regenerate the chart."""
    plot_script = os.path.join(SCRIPT_DIR, "plot_speedup.py")
    if os.path.exists(plot_script):
        print("Generating speedup chart...")
        try:
            subprocess.run([sys.executable, plot_script], check=False)
        except Exception as e:
            print(f"Warning: Could not generate chart: {e}")


def main():
    versions = get_all_versions()
    if not versions:
        print("No versioned results found in results/. Generating minimal README.")
        readme_path = os.path.join(PROJECT_ROOT, "README.md")
        with open(readme_path, "w") as f:
            f.write("# fcoreutils vs GNU coreutils — Independent Benchmark\n\n"
                    "> No benchmark results available yet. Run CI to generate results.\n")
        return

    print(f"Found {len(versions)} versions: {', '.join(versions)}")

    # Generate per-version reports
    for version in versions:
        bench_platforms = load_benchmark_data(version)
        compat_platforms, tool_results = load_compatibility_data(version)
        if bench_platforms or compat_platforms:
            generate_version_report(version, bench_platforms, compat_platforms, tool_results)

    # Use latest version for README
    latest = versions[-1]
    bench_platforms = load_benchmark_data(latest)
    compat_platforms, tool_results = load_compatibility_data(latest)
    tool_speedups, tool_f_vs_uutils = compute_speedups(bench_platforms)
    sizes = load_size_data(latest)

    # Supplement versioned sizes with source-built sizes for all 84 tools
    source_sizes = load_source_sizes()
    for tool, sz in source_sizes.items():
        if tool not in sizes:
            sizes[tool] = sz
        else:
            for k, v in sz.items():
                if k not in sizes[tool]:
                    sizes[tool][k] = v

    # Supplement with new-tools data for tools not in versioned results
    new_tools_bench, new_tools_compat = load_new_tools_data()

    for tool, data in new_tools_bench.items():
        if tool not in tool_speedups:
            for b in data.get("benchmarks", []):
                s = b.get("speedup")
                if isinstance(s, (int, float)) and s > 0:
                    if tool not in tool_speedups or s > tool_speedups[tool]:
                        tool_speedups[tool] = s
                fvu = b.get("f_vs_uutils")
                if isinstance(fvu, (int, float)) and fvu > 0:
                    if tool not in tool_f_vs_uutils or fvu > tool_f_vs_uutils[tool]:
                        tool_f_vs_uutils[tool] = fvu

    for tool, platform_data in new_tools_compat.items():
        if tool not in tool_results:
            tool_results[tool] = {}
        for platform_key, data in platform_data.items():
            existing = tool_results[tool].get(platform_key)
            # Override NOT_IMPLEMENTED entries with actual source-built test data
            if existing is None or existing.get("status") == "NOT_IMPLEMENTED":
                tool_results[tool][platform_key] = data

    # Generate chart
    run_plot_script()

    # Generate README
    generate_readme(latest, bench_platforms, compat_platforms,
                    tool_speedups, tool_f_vs_uutils, tool_results, sizes)


if __name__ == "__main__":
    main()
