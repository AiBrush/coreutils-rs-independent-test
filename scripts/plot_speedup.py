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
        json_files = glob.glob(os.path.join(version_dir, "*.json"))
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


def generate_plot(version_data):
    """Generate the speedup history chart."""
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

    fig, ax = plt.subplots(figsize=(12, 6))

    ax.plot(versions, gnu_avgs, "r--", linewidth=2, marker="o", markersize=5,
            label="GNU coreutils (avg time)")
    ax.plot(versions, f_avgs, "b-", linewidth=2, marker="s", markersize=5,
            label="fcoreutils (avg time)")

    ax.set_xlabel("Version", fontsize=12)
    ax.set_ylabel("Average Execution Time (seconds)", fontsize=12)
    ax.set_title("fcoreutils vs GNU coreutils — Performance Over Versions", fontsize=14)
    ax.legend(fontsize=11)
    ax.grid(True, alpha=0.3)

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
    generate_plot(version_data)


if __name__ == "__main__":
    main()
