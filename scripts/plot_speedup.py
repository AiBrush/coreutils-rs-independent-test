#!/usr/bin/env python3
"""Generate a speedup-over-versions chart from benchmark results."""

import json
import glob
import os
import re
import sys


def parse_version(tag):
    """Extract (major, minor, patch) from a version tag like v0.0.27."""
    m = re.match(r"v?(\d+)\.(\d+)\.(\d+)", tag)
    if m:
        return (int(m.group(1)), int(m.group(2)), int(m.group(3)))
    return (0, 0, 0)


def load_results():
    """Load all benchmark results from results/benchmarks/v*/*.json."""
    results_dir = os.path.join(os.path.dirname(__file__), "..", "results", "benchmarks")
    if not os.path.isdir(results_dir):
        print(f"No results directory found at {results_dir}")
        return {}

    version_data = {}
    for version_dir in sorted(glob.glob(os.path.join(results_dir, "v*"))):
        version = os.path.basename(version_dir)
        json_files = glob.glob(os.path.join(version_dir, "linux_*.json"))
        if not json_files:
            continue

        gnu_times = []
        f_times = []

        for jf in json_files:
            try:
                with open(jf) as f:
                    data = json.load(f)
            except (json.JSONDecodeError, IOError):
                continue

            tools = data.get("tools", {})
            for tool_name, tool_data in tools.items():
                if not isinstance(tool_data, dict):
                    continue
                if tool_data.get("status") == "NOT_IMPLEMENTED":
                    continue
                for bench in tool_data.get("benchmarks", []):
                    gnu_mean = bench.get("gnu_mean")
                    f_mean = bench.get("f_mean")
                    if (isinstance(gnu_mean, (int, float)) and gnu_mean > 0 and
                            isinstance(f_mean, (int, float)) and f_mean > 0):
                        gnu_times.append(gnu_mean)
                        f_times.append(f_mean)

        if gnu_times and f_times:
            version_data[version] = {
                "avg_gnu": sum(gnu_times) / len(gnu_times),
                "avg_f": sum(f_times) / len(f_times),
            }

    return version_data


def load_compatibility():
    """Load compatibility results and compute pass % per version."""
    compat_dir = os.path.join(os.path.dirname(__file__), "..", "results", "compatibility")
    if not os.path.isdir(compat_dir):
        return {}

    compat_data = {}
    for version_dir in sorted(glob.glob(os.path.join(compat_dir, "v*"))):
        version = os.path.basename(version_dir)
        total = 0
        passed = 0

        for jf in glob.glob(os.path.join(version_dir, "linux_*.json")):
            try:
                with open(jf) as f:
                    data = json.load(f)
            except (json.JSONDecodeError, IOError):
                continue

            summary = data.get("summary", {})
            t = summary.get("total_tests", 0)
            p = summary.get("passed", 0)
            if t > 0:
                total += t
                passed += p

        if total > 0:
            compat_data[version] = passed / total * 100

    return compat_data


def generate_plot(version_data, compat_data):
    """Generate the speedup history chart with compatibility annotations."""
    try:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
    except ImportError:
        print("ERROR: matplotlib is required. Install with: pip install matplotlib")
        sys.exit(1)

    # Sort versions
    versions = sorted(version_data.keys(), key=parse_version)
    if not versions:
        print("No benchmark data to plot.")
        return

    gnu_avgs = [version_data[v]["avg_gnu"] for v in versions]
    f_avgs = [version_data[v]["avg_f"] for v in versions]

    fig, ax1 = plt.subplots(figsize=(14, 6))

    # Performance lines on left axis
    ax1.plot(versions, gnu_avgs, "r--", linewidth=2, marker="o", markersize=5,
             label="GNU coreutils (avg time)")
    ax1.plot(versions, f_avgs, "b-", linewidth=2, marker="s", markersize=5,
             label="fcoreutils (avg time)")

    ax1.set_xlabel("Version", fontsize=12)
    ax1.set_ylabel("Average Execution Time (seconds)", fontsize=12)
    ax1.grid(True, alpha=0.3)

    # Compatibility % on right axis
    compat_versions = [v for v in versions if v in compat_data]
    if compat_versions:
        ax2 = ax1.twinx()
        compat_pcts = [compat_data[v] for v in compat_versions]
        ax2.plot(compat_versions, compat_pcts, "g-.", linewidth=1.5, marker="^",
                 markersize=5, alpha=0.8, label="Compatibility %")
        ax2.set_ylabel("Compatibility (%)", fontsize=12, color="green")
        ax2.tick_params(axis="y", labelcolor="green")
        ax2.set_ylim(0, 105)

        # Annotate each point with the percentage
        for v, pct in zip(compat_versions, compat_pcts):
            ax2.annotate(f"{pct:.0f}%", (v, pct), textcoords="offset points",
                         xytext=(0, 8), ha="center", fontsize=7, color="green")

        # Combined legend
        lines1, labels1 = ax1.get_legend_handles_labels()
        lines2, labels2 = ax2.get_legend_handles_labels()
        ax1.legend(lines1 + lines2, labels1 + labels2, fontsize=10, loc="upper left")
    else:
        ax1.legend(fontsize=11)

    ax1.set_title("fcoreutils vs GNU coreutils — Performance Over Versions", fontsize=14)

    # Rotate x labels if many versions
    if len(versions) > 10:
        plt.xticks(rotation=45, ha="right")

    plt.tight_layout()

    output_dir = os.path.join(os.path.dirname(__file__), "..", "results")
    os.makedirs(output_dir, exist_ok=True)
    output_path = os.path.join(output_dir, "speedup-history.png")
    plt.savefig(output_path, dpi=150)
    plt.close()

    print(f"Chart saved to {output_path}")
    print(f"Versions plotted: {len(versions)}")


def main():
    version_data = load_results()
    if not version_data:
        print("No benchmark data found in results/benchmarks/. Skipping chart generation.")
        return
    compat_data = load_compatibility()
    generate_plot(version_data, compat_data)


if __name__ == "__main__":
    main()
