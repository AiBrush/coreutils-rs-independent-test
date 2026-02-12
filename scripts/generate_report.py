#!/usr/bin/env python3
"""Generate simplified README.md and per-version detail reports from results/."""

import json
import glob
import os
import subprocess
import sys
from datetime import datetime

TOOLS = ["wc", "cut", "sha256sum", "md5sum", "b2sum", "base64", "sort", "tr", "uniq", "tac"]
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.join(SCRIPT_DIR, "..")
RESULTS_DIR = os.path.join(PROJECT_ROOT, "results")


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

    for jf in glob.glob(os.path.join(bench_dir, "*.json")):
        try:
            with open(jf) as f:
                data = json.load(f)
            platform = data.get("platform", os.path.basename(jf).replace(".json", ""))
            platforms[platform] = data.get("tools", {})
        except (json.JSONDecodeError, IOError):
            pass
    return platforms


def load_compatibility_data(version):
    """Load all compatibility JSON files for a version."""
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

        # Check if this is a per-tool file or an aggregate
        if "summary" in data and "total_tests" in data.get("summary", {}):
            platforms[platform] = data.get("summary", {})
        elif "tool" in data:
            tool = data["tool"]
            if tool not in tool_results:
                tool_results[tool] = {}
            tool_results[tool][platform] = data

    return platforms, tool_results


def compute_speedups(bench_platforms):
    """Compute best speedup per tool across all platforms."""
    tool_speedups = {}
    for platform, tools in bench_platforms.items():
        for tool, data in tools.items():
            if not isinstance(data, dict) or data.get("status") == "NOT_IMPLEMENTED":
                continue
            for b in data.get("benchmarks", []):
                s = b.get("speedup")
                if isinstance(s, (int, float)) and s > 0:
                    if tool not in tool_speedups or s > tool_speedups[tool]:
                        tool_speedups[tool] = s
    return tool_speedups


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
        for platform in sorted(bench_platforms.keys()):
            lines.append(f"### {platform}\n")
            lines.append("| Tool | Test | GNU (mean) | fcoreutils (mean) | Speedup |")
            lines.append("|------|------|-----------|-------------------|---------|")

            for tool in TOOLS:
                data = bench_platforms[platform].get(tool, {})
                if not isinstance(data, dict):
                    continue
                if data.get("status") == "NOT_IMPLEMENTED":
                    lines.append(f"| {tool} | - | - | - | N/A |")
                    continue
                for b in data.get("benchmarks", []):
                    name = b.get("name", "")
                    gnu_t = b.get("gnu_mean")
                    f_t = b.get("f_mean")
                    speedup = b.get("speedup")
                    gnu_str = f"{gnu_t:.4f}s" if isinstance(gnu_t, (int, float)) and gnu_t > 0 else "N/A"
                    f_str = f"{f_t:.4f}s" if isinstance(f_t, (int, float)) and f_t > 0 else "-"
                    sp_str = f"**{speedup:.1f}x**" if isinstance(speedup, (int, float)) and speedup > 0 else "-"
                    lines.append(f"| {tool} | {name} | {gnu_str} | {f_str} | {sp_str} |")
            lines.append("")

    # Write to the benchmarks version dir (or compatibility dir as fallback)
    report_dir = os.path.join(RESULTS_DIR, "benchmarks", version)
    if not os.path.isdir(report_dir):
        report_dir = os.path.join(RESULTS_DIR, "compatibility", version)
    if not os.path.isdir(report_dir):
        os.makedirs(report_dir, exist_ok=True)

    report_path = os.path.join(report_dir, "report.md")
    with open(report_path, "w") as f:
        f.write("\n".join(lines))
    print(f"  Version report: {report_path}")


def generate_readme(latest_version, bench_platforms, compat_platforms, tool_speedups):
    """Generate the simplified README.md."""
    total_tests = sum(p.get("total_tests", 0) for p in compat_platforms.values())
    total_passed = sum(p.get("passed", 0) for p in compat_platforms.values())
    pass_pct = f"{total_passed / total_tests * 100:.1f}" if total_tests > 0 else "0"

    # Find fastest tool
    fastest_tool = ""
    fastest_speedup = 0
    for tool, s in tool_speedups.items():
        if s > fastest_speedup:
            fastest_speedup = s
            fastest_tool = tool

    # Build speedup table
    speedup_rows = []
    for tool in TOOLS:
        if tool in tool_speedups:
            speedup_rows.append(f"| {tool} | **{tool_speedups[tool]:.1f}x** |")
        else:
            speedup_rows.append(f"| {tool} | - |")
    speedup_table = "\n".join(speedup_rows)

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
        chart_section = "_No chart available yet. Run `python3 scripts/plot_speedup.py` after benchmarking multiple versions._"

    readme = f"""# fcoreutils vs GNU coreutils — Independent Benchmark

> Independent quality assurance for [fcoreutils](https://github.com/AiBrush/coreutils-rs), a Rust rewrite of GNU coreutils.

## Performance Over Versions

{chart_section}

## Latest Results ({latest_version})

### Summary
- **Tools tested:** {len(TOOLS)} ({', '.join(TOOLS)})
- **Compatibility:** {total_passed}/{total_tests} tests passed ({pass_pct}%)
- **Fastest speedup:** {fastest_tool} at {fastest_speedup:.1f}x faster than GNU

### Performance Highlights

| Tool | Speedup (vs GNU) |
|------|----------------:|
{speedup_table}

### Known Issues
{issues}

## Per-Version Details

Detailed results for each version (benchmarks, compatibility, failures) are in the [`results/`](results/) directory.

## How It Works
- Downloads pre-built fcoreutils binaries from GitHub releases
- Runs {total_tests}+ compatibility tests comparing output byte-for-byte against GNU coreutils
- Benchmarks using `hyperfine` with warmup runs and timed runs
- Tests run across multiple platforms via GitHub Actions

## Running Locally
```bash
# Run benchmarks for the latest version
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
        # Write a placeholder README
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
    compat_platforms, _ = load_compatibility_data(latest)
    tool_speedups = compute_speedups(bench_platforms)

    # Generate chart
    run_plot_script()

    # Generate README
    generate_readme(latest, bench_platforms, compat_platforms, tool_speedups)


if __name__ == "__main__":
    main()
