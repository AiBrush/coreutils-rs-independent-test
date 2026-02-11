#!/usr/bin/env python3
"""Generate REPORT.md from collected CI results."""

import json
import glob
import os
from datetime import datetime

TOOLS = ["wc", "cut", "sha256sum", "md5sum", "b2sum", "base64", "sort", "tr", "uniq", "tac"]
CLAIMED_SPEEDUPS = {
    "wc": "30x",
    "cut": "10x",
    "sha256sum": "4x single, 10x parallel",
    "md5sum": "10x single, 30x parallel",
    "b2sum": "10x",
    "base64": "10x",
    "sort": "10x",
    "tr": "10x",
    "uniq": "10x",
    "tac": "10x",
}


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

    # Count verified performance claims
    perf_verified = 0
    perf_total = 0
    for platform, tools in bench_platforms.items():
        for tool, data in tools.items():
            if isinstance(data, dict) and data.get("status") != "NOT_IMPLEMENTED":
                benchmarks = data.get("benchmarks", [])
                for b in benchmarks:
                    if b.get("verdict"):
                        perf_total += 1
                        if b["verdict"] in ("MEETS/EXCEEDS",):
                            perf_verified += 1

    if total_failed == 0 and total_tests > 0:
        recommendation = "READY"
    elif pass_rate >= 95:
        recommendation = "NEEDS WORK"
    elif total_tests == 0:
        recommendation = "NO DATA"
    else:
        recommendation = "NOT READY"

    lines.append("## Executive Summary\n")
    lines.append("| Metric | Result |")
    lines.append("|--------|--------|")
    lines.append(f"| Tools Implemented | {tools_implemented}/10 |")
    lines.append(f"| Overall Compatibility | {pass_rate:.1f}% |")
    lines.append(f"| Performance Claims Verified | {perf_verified}/{perf_total} |")
    lines.append(f"| Platforms Tested | {len(compat_platforms)} |")
    lines.append(f"| Recommendation | **{recommendation}** |")
    lines.append("")

    # Platform Results
    lines.append("## Platform Results\n")

    for platform, summary in sorted(compat_platforms.items()):
        lines.append(f"### {platform}\n")
        lines.append(f"- Compatibility: {summary.get('passed', 0)}/{summary.get('total_tests', 0)} tests passed")
        lines.append(f"- Failed: {summary.get('failed', 0)}")
        lines.append(f"- Skipped: {summary.get('skipped', 0)}")
        lines.append("")

    # Compatibility Matrix
    lines.append("## Compatibility Matrix\n")
    lines.append("| Tool | Tests Run | Passed | Failed | Pass Rate |")
    lines.append("|------|-----------|--------|--------|-----------|")

    for tool in TOOLS:
        if tool in tool_results:
            # Aggregate across platforms
            total = 0
            passed = 0
            failed = 0
            for platform, data in tool_results[tool].items():
                if data.get("status") == "NOT_IMPLEMENTED":
                    continue
                s = data.get("summary", {})
                total += s.get("total", 0)
                passed += s.get("passed", 0)
                failed += s.get("failed", 0)
            rate = f"{passed/total*100:.1f}%" if total > 0 else "N/A"
            lines.append(f"| {tool} | {total} | {passed} | {failed} | {rate} |")
        else:
            lines.append(f"| {tool} | - | - | - | NOT TESTED |")

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
    lines.append("| Tool | Claimed | " + " | ".join(sorted(bench_platforms.keys()) or ["No Data"]) + " |")
    lines.append("|------|---------" + "|--------" * max(len(bench_platforms), 1) + "|")

    for tool in TOOLS:
        claimed = CLAIMED_SPEEDUPS.get(tool, "N/A")
        row = f"| {tool} | {claimed}"
        if bench_platforms:
            for platform in sorted(bench_platforms.keys()):
                data = bench_platforms[platform].get(tool, {})
                if isinstance(data, dict):
                    if data.get("status") == "NOT_IMPLEMENTED":
                        row += " | N/A"
                    else:
                        benchmarks = data.get("benchmarks", [])
                        speedups = [b.get("speedup", 0) for b in benchmarks
                                    if isinstance(b.get("speedup", 0), (int, float)) and b.get("speedup", 0) > 0]
                        if speedups:
                            best = max(speedups)
                            avg = sum(speedups) / len(speedups)
                            row += f" | {avg:.1f}x (best: {best:.1f}x)"
                        else:
                            row += " | no data"
                else:
                    row += " | -"
        else:
            row += " | No Data"
        row += " |"
        lines.append(row)

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

    # Write report
    report = "\n".join(lines)
    with open("REPORT.md", "w") as f:
        f.write(report)

    print(f"Report generated: REPORT.md ({len(lines)} lines)")
    print(f"  Compatibility: {total_passed}/{total_tests} passed")
    print(f"  Platforms: {len(compat_platforms)}")
    print(f"  Recommendation: {recommendation}")


if __name__ == "__main__":
    generate_report()
