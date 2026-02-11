#!/usr/bin/env python3
"""Generate REPORT.md from collected CI results."""

import json
import glob
import os
from datetime import datetime

TOOLS = ["wc", "cut", "sha256sum", "md5sum", "b2sum", "base64", "sort", "tr", "uniq", "tac"]


def load_json_files(pattern):
    """Load all JSON files matching a glob pattern."""
    results = {}
    for filepath in glob.glob(pattern):
        try:
            with open(filepath) as f:
                data = json.load(f)
                results[filepath] = data
        except (json.JSONDecodeError, IOError) as e:
            print(f"Warning: Could not load {filepath}: {e}")
    return results


def collect_compatibility_results():
    """Collect compatibility results from all platforms."""
    platforms = {}
    tool_results = {}

    for dirpath in glob.glob("collected/compatibility/*/"):
        # Try to find compatibility_results.json
        overall = os.path.join(dirpath, "compatibility_results.json")
        if os.path.exists(overall):
            try:
                with open(overall) as f:
                    data = json.load(f)
                platform = data.get("platform", os.path.basename(dirpath.rstrip("/")))
                platforms[platform] = data.get("summary", {})
            except (json.JSONDecodeError, IOError):
                pass

        # Collect per-tool results
        for tool in TOOLS:
            result_file = os.path.join(dirpath, f"{tool}_results.json")
            if os.path.exists(result_file):
                try:
                    with open(result_file) as f:
                        data = json.load(f)
                    platform = data.get("platform", "unknown")
                    if tool not in tool_results:
                        tool_results[tool] = {}
                    tool_results[tool][platform] = data
                except (json.JSONDecodeError, IOError):
                    pass

    return platforms, tool_results


def collect_benchmark_results():
    """Collect benchmark results from all platforms."""
    platforms = {}

    for dirpath in glob.glob("collected/benchmarks/*/"):
        overall = os.path.join(dirpath, "benchmark_results.json")
        if os.path.exists(overall):
            try:
                with open(overall) as f:
                    data = json.load(f)
                platform = data.get("platform", os.path.basename(dirpath.rstrip("/")))
                platforms[platform] = data.get("tools", {})
            except (json.JSONDecodeError, IOError):
                pass

        # Also check individual benchmark files
        for tool in TOOLS:
            bench_file = os.path.join(dirpath, f"{tool}_benchmark.json")
            if os.path.exists(bench_file):
                try:
                    with open(bench_file) as f:
                        data = json.load(f)
                    platform = data.get("platform", "unknown")
                    if platform not in platforms:
                        platforms[platform] = {}
                    platforms[platform][tool] = data
                except (json.JSONDecodeError, IOError):
                    pass

    return platforms


def collect_failures():
    """Collect failed test details."""
    failures = []
    for dirpath in glob.glob("collected/failures/*/"):
        for fail_dir in glob.glob(os.path.join(dirpath, "*/")):
            reproduce = os.path.join(fail_dir, "reproduce.sh")
            diff_file = os.path.join(fail_dir, "diff")
            if os.path.exists(reproduce):
                name = os.path.basename(fail_dir.rstrip("/"))
                diff_content = ""
                if os.path.exists(diff_file):
                    with open(diff_file) as f:
                        diff_content = f.read()[:500]
                reproduce_content = ""
                with open(reproduce) as f:
                    reproduce_content = f.read()
                failures.append({
                    "name": name,
                    "diff": diff_content,
                    "reproduce": reproduce_content,
                })
    return failures


def generate_report():
    """Generate the full REPORT.md."""
    compat_platforms, tool_results = collect_compatibility_results()
    bench_platforms = collect_benchmark_results()
    failures = collect_failures()

    lines = []
    lines.append("# fcoreutils Independent Test Report\n")
    lines.append(f"Generated: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S UTC')}\n")

    # Executive Summary
    total_tests = sum(p.get("total_tests", 0) for p in compat_platforms.values())
    total_passed = sum(p.get("passed", 0) for p in compat_platforms.values())
    total_failed = sum(p.get("failed", 0) for p in compat_platforms.values())
    tools_tested = max((p.get("tools_tested", 0) for p in compat_platforms.values()), default=0)
    tools_skipped = max((p.get("tools_skipped", 0) for p in compat_platforms.values()), default=0)
    tools_implemented = tools_tested - tools_skipped if tools_tested > 0 else 0

    pass_rate = (total_passed / total_tests * 100) if total_tests > 0 else 0

    if total_failed == 0 and total_tests > 0:
        recommendation = "READY"
    elif pass_rate >= 95:
        recommendation = "NEEDS WORK"
    elif total_tests == 0:
        recommendation = "NO DATA"
    else:
        recommendation = "NOT READY"

    # Compute per-tool best speedup across all platforms (for summary)
    tool_best_speedups = {}
    for platform, tools in bench_platforms.items():
        for tool, data in tools.items():
            if isinstance(data, dict) and data.get("status") != "NOT_IMPLEMENTED":
                for b in data.get("benchmarks", []):
                    s = b.get("speedup")
                    if isinstance(s, (int, float)) and s > 0:
                        if tool not in tool_best_speedups or s > tool_best_speedups[tool]:
                            tool_best_speedups[tool] = s

    lines.append("## Executive Summary\n")
    lines.append("| Metric | Result |")
    lines.append("|--------|--------|")
    lines.append(f"| Tools Implemented | {tools_implemented}/10 |")
    lines.append(f"| Total Tests | {total_tests} |")
    lines.append(f"| Passed | {total_passed} |")
    lines.append(f"| Failed | {total_failed} |")
    lines.append(f"| Overall Compatibility | {pass_rate:.1f}% |")
    lines.append(f"| Platforms Tested | {len(compat_platforms)} |")
    lines.append(f"| Recommendation | **{recommendation}** |")
    lines.append("")

    # Performance overview — best speedup per tool
    if tool_best_speedups:
        lines.append("## Performance Overview\n")
        lines.append("Best measured speedup (fcoreutils vs GNU) across all platforms:\n")
        lines.append("| Tool | Best Speedup |")
        lines.append("|------|-------------|")
        for tool in TOOLS:
            if tool in tool_best_speedups:
                lines.append(f"| {tool} | **{tool_best_speedups[tool]:.1f}x** |")
            else:
                lines.append(f"| {tool} | - |")
        lines.append("")

    # Compatibility overview — per-tool pass rate
    lines.append("## Compatibility Overview\n")
    lines.append("| Tool | Tests | Passed | Failed | Pass Rate |")
    lines.append("|------|-------|--------|--------|-----------|")
    for tool in TOOLS:
        if tool in tool_results:
            t_total = 0
            t_passed = 0
            t_failed = 0
            for platform, data in tool_results[tool].items():
                if data.get("status") == "NOT_IMPLEMENTED":
                    continue
                s = data.get("summary", {})
                t_total += s.get("total", 0)
                t_passed += s.get("passed", 0)
                t_failed += s.get("failed", 0)
            t_rate = f"{t_passed/t_total*100:.1f}%" if t_total > 0 else "N/A"
            lines.append(f"| {tool} | {t_total} | {t_passed} | {t_failed} | {t_rate} |")
        else:
            lines.append(f"| {tool} | - | - | - | NOT TESTED |")
    lines.append("")

    # Platform Results
    lines.append("## Platform Results\n")

    for platform, summary in sorted(compat_platforms.items()):
        lines.append(f"### {platform}\n")
        lines.append(f"- Compatibility: {summary.get('passed', 0)}/{summary.get('total_tests', 0)} tests passed")
        lines.append(f"- Failed: {summary.get('failed', 0)}")
        lines.append(f"- Skipped: {summary.get('skipped', 0)}")
        lines.append("")

    # Failed Test Details
    if failures:
        lines.append("## Failed Test Details\n")
        for failure in failures:
            lines.append(f"### {failure['name']}\n")
            if failure["diff"]:
                lines.append("**Diff:**")
                lines.append("```")
                lines.append(failure["diff"])
                lines.append("```")
            if failure["reproduce"]:
                lines.append("**Reproduction:**")
                lines.append("```bash")
                lines.append(failure["reproduce"])
                lines.append("```")
            lines.append("")
    else:
        lines.append("## Failed Test Details\n")
        lines.append("No failures recorded (or no failure artifacts available).\n")

    # Performance Results
    lines.append("## Performance Results\n")

    if bench_platforms:
        for platform in sorted(bench_platforms.keys()):
            lines.append(f"### {platform}\n")
            lines.append("| Tool | GNU (mean) | fcoreutils (mean) | Speedup |")
            lines.append("|------|-----------|-------------------|---------|")

            for tool in TOOLS:
                data = bench_platforms[platform].get(tool, {})
                if isinstance(data, dict):
                    if data.get("status") == "NOT_IMPLEMENTED":
                        lines.append(f"| {tool} | - | - | N/A (not implemented) |")
                    else:
                        benchmarks = data.get("benchmarks", [])
                        if benchmarks:
                            for b in benchmarks:
                                gnu_t = b.get("gnu_mean")
                                f_t = b.get("f_mean")
                                speedup = b.get("speedup")
                                gnu_missing = b.get("gnu_missing", False)
                                name = b.get("name", "")
                                label = f"{tool} ({name})" if name else tool
                                if gnu_missing:
                                    gnu_str = "N/A (not installed)"
                                elif isinstance(gnu_t, (int, float)) and gnu_t > 0:
                                    gnu_str = f"{gnu_t:.4f}s"
                                else:
                                    gnu_str = "-"
                                if isinstance(f_t, (int, float)) and f_t > 0:
                                    f_str = f"{f_t:.4f}s"
                                else:
                                    f_str = "-"
                                if gnu_missing:
                                    sp_str = "N/A"
                                elif isinstance(speedup, (int, float)) and speedup > 0:
                                    sp_str = f"**{speedup:.1f}x**"
                                else:
                                    sp_str = "-"
                                lines.append(f"| {label} | {gnu_str} | {f_str} | {sp_str} |")
                        else:
                            lines.append(f"| {tool} | - | - | no data |")
                else:
                    lines.append(f"| {tool} | - | - | - |")

            lines.append("")
    else:
        lines.append("No benchmark data available.\n")

    lines.append("")

    # Issues Found
    lines.append("## Issues Found\n")
    if total_failed > 0:
        lines.append(f"1. {total_failed} compatibility test failures detected across {len(compat_platforms)} platforms")
        lines.append("2. See Failed Test Details above for specifics")
    else:
        lines.append("No critical issues found in available test data.\n")

    # Recommendations
    lines.append("\n## Recommendations\n")
    if recommendation == "READY":
        lines.append("Based on test results, fcoreutils appears ready for real-world use as a GNU coreutils replacement.")
        lines.append("All compatibility tests pass and output is byte-identical to GNU coreutils.")
    elif recommendation == "NEEDS WORK":
        lines.append("fcoreutils shows promise but has compatibility gaps that need to be addressed before production use.")
        lines.append("Review the failed test details above for specific issues.")
    elif recommendation == "NO DATA":
        lines.append("Insufficient test data to make a recommendation. Run the CI workflows to generate results.")
    else:
        lines.append("fcoreutils is not yet ready for production use as a GNU coreutils replacement.")
        lines.append("Significant compatibility issues need to be resolved.")

    lines.append("")

    # Write report to both REPORT.md and README.md
    report = "\n".join(lines)
    for filename in ("REPORT.md", "README.md"):
        with open(filename, "w") as f:
            f.write(report)

    print(f"Report generated: REPORT.md + README.md ({len(lines)} lines)")
    print(f"  Compatibility: {total_passed}/{total_tests} passed")
    print(f"  Platforms: {len(compat_platforms)}")
    print(f"  Recommendation: {recommendation}")


if __name__ == "__main__":
    generate_report()
