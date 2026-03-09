#!/usr/bin/env python3
"""Generate README.md and per-version detail report from CI results.

Data sources (all for a single version):
  results/compatibility/<version>/linux_x86_64.json  -> per-tool compat data
  results/benchmarks/<version>/linux_x86_64.json     -> per-tool benchmark data
  results/benchmarks/<version>/linux_x86_64_sizes.json -> binary sizes
  results/compatibility/<version>/*.json              -> multi-platform compat summaries
  results/assembly/<version>/linux_x86_64.json        -> assembly tool data

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

# Assembly tools that have x86-64 assembly implementations
ASM_TOOLS = {
    "arch", "base64", "cat", "cut", "echo", "expand", "false", "fold",
    "head", "hostid", "logname", "md5sum", "nl", "od", "pwd", "rev",
    "seq", "sleep", "sort", "sync", "tac", "tail", "tr", "true",
    "tty", "unexpand", "uniq", "wc", "whoami", "yes",
}


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
    for subdir in ("benchmarks", "compatibility", "assembly"):
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
        asm_data:          {compatibility: {...}, security: {...}, benchmarks: {...}, sizes: {...}}
    """
    data = {
        "compat_tools": {},
        "bench_tools": {},
        "sizes": {},
        "compat_platforms": {},
        "asm_data": {},
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

    # Assembly data
    asm_file = os.path.join(
        RESULTS_DIR, "assembly", version, "linux_x86_64.json"
    )
    asm_json = load_json(asm_file)
    if asm_json:
        data["asm_data"] = asm_json

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


def compute_asm_info(tool, asm_data):
    """Compute assembly info for a tool (size, compat, security, speedup).

    Returns a dict with:
        has_asm:         bool
        asm_size:        int or None
        compat_passed:   int
        compat_failed:   int
        compat_total:    int
        security_passed: int
        security_failed: int
        security_total:  int
        asm_vs_gnu:      float or None  (best speedup)
        asm_vs_rust:     float or None  (best speedup)
    """
    if tool not in ASM_TOOLS or not asm_data:
        return {"has_asm": False}

    result = {
        "has_asm": True,
        "asm_size": None,
        "compat_passed": 0, "compat_failed": 0, "compat_total": 0,
        "security_passed": 0, "security_failed": 0, "security_total": 0,
        "asm_vs_gnu": None, "asm_vs_rust": None,
    }

    # Sizes
    asm_sizes = asm_data.get("sizes", {})
    if tool in asm_sizes:
        result["asm_size"] = asm_sizes[tool].get("asm_bytes")

    # Compatibility
    asm_compat = asm_data.get("compatibility", {})
    if tool in asm_compat:
        tc = asm_compat[tool]
        result["compat_passed"] = tc.get("passed", 0)
        result["compat_failed"] = tc.get("failed", 0)
        result["compat_total"] = tc.get("total", 0)

    # Security
    asm_security = asm_data.get("security", {})
    if tool in asm_security:
        ts = asm_security[tool]
        result["security_passed"] = ts.get("passed", 0)
        result["security_failed"] = ts.get("failed", 0)
        result["security_total"] = ts.get("total", 0)

    # Benchmarks (find best asm_vs_gnu and asm_vs_rust)
    asm_bench = asm_data.get("benchmarks", {})
    if tool in asm_bench:
        benchmarks = asm_bench[tool].get("benchmarks", [])
        best_vs_gnu = None
        best_vs_rust = None
        for b in benchmarks:
            avg = b.get("asm_vs_gnu")
            if isinstance(avg, (int, float)):
                if best_vs_gnu is None or avg > best_vs_gnu:
                    best_vs_gnu = avg
            avr = b.get("asm_vs_rust")
            if isinstance(avr, (int, float)):
                if best_vs_rust is None or avr > best_vs_rust:
                    best_vs_rust = avr
        result["asm_vs_gnu"] = best_vs_gnu
        result["asm_vs_rust"] = best_vs_rust

    return result


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


def format_asm_column(tool, asm_info):
    """Format the assembly column for a tool.

    Shows: ASM size | ASM vs GNU | compat pass rate | security pass rate
    Returns a single string for the ASM column.
    """
    if not asm_info.get("has_asm"):
        return "-"

    parts = []

    # Size
    asm_size = asm_info.get("asm_size")
    if asm_size is not None:
        parts.append(format_size(asm_size))
    else:
        parts.append("-")

    # ASM vs GNU speedup
    asm_vs_gnu = asm_info.get("asm_vs_gnu")
    if asm_vs_gnu is not None:
        if asm_vs_gnu >= 1.0:
            parts.append(f"**{asm_vs_gnu:.1f}x**")
        else:
            parts.append(f"{asm_vs_gnu:.1f}x")
    else:
        parts.append("-")

    # Compat
    ct = asm_info.get("compat_total", 0)
    cp = asm_info.get("compat_passed", 0)
    if ct > 0:
        rate = cp / ct * 100
        if rate >= 100:
            parts.append(f"✅ {cp}/{ct}")
        else:
            parts.append(f"⚠️ {rate:.0f}%")
    else:
        parts.append("-")

    # Security
    st = asm_info.get("security_total", 0)
    sp = asm_info.get("security_passed", 0)
    if st > 0:
        rate = sp / st * 100
        if rate >= 100:
            parts.append(f"✅ {sp}/{st}")
        elif rate >= 90:
            parts.append(f"⚠️ {rate:.0f}%")
        else:
            parts.append(f"❌ {rate:.0f}%")
    else:
        parts.append("-")

    return " | ".join(parts)


# ── README generation ────────────────────────────────────────────────────────


def generate_readme(version, all_tools, data):
    compat_tools = data["compat_tools"]
    bench_tools = data["bench_tools"]
    sizes = data["sizes"]
    asm_data = data.get("asm_data", {})

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

    # Count assembly tools with data
    asm_tools_with_data = 0
    if asm_data:
        for tool in ASM_TOOLS:
            asm_info = compute_asm_info(tool, asm_data)
            if asm_info.get("has_asm") and asm_info.get("asm_size") is not None:
                asm_tools_with_data += 1

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

    # Determine if we have any assembly data to show
    has_asm = asm_tools_with_data > 0

    # Build tools table
    if has_asm:
        table_lines = [
            "| Tool | fcoreutils size | GNU size | Compat f\\* vs GNU | Speedup f\\* vs GNU | ASM size | ASM vs GNU | ASM Compat | ASM Security |",
            "|------|----------------:|---------:|------------------:|-------------------:|---------:|-----------:|-----------:|-------------:|",
        ]
    else:
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

        if has_asm:
            asm_info = compute_asm_info(tool, asm_data)
            if asm_info.get("has_asm"):
                asm_size_str = format_size(asm_info.get("asm_size"))
                # ASM vs GNU speedup
                asm_vs_gnu = asm_info.get("asm_vs_gnu")
                if asm_vs_gnu is not None:
                    asm_speedup_str = f"**{asm_vs_gnu:.1f}x**" if asm_vs_gnu >= 1.0 else f"{asm_vs_gnu:.1f}x"
                else:
                    asm_speedup_str = "-"
                # ASM compat
                ct = asm_info.get("compat_total", 0)
                cp = asm_info.get("compat_passed", 0)
                if ct > 0:
                    rate = cp / ct * 100
                    if rate >= 100:
                        asm_compat_str = f"✅ {cp}/{ct}"
                    else:
                        asm_compat_str = f"⚠️ {rate:.0f}%"
                else:
                    asm_compat_str = "-"
                # ASM security
                st = asm_info.get("security_total", 0)
                sp = asm_info.get("security_passed", 0)
                if st > 0:
                    srate = sp / st * 100
                    if srate >= 100:
                        asm_sec_str = f"✅ {sp}/{st}"
                    elif srate >= 90:
                        asm_sec_str = f"⚠️ {srate:.0f}%"
                    else:
                        asm_sec_str = f"❌ {srate:.0f}%"
                else:
                    asm_sec_str = "-"
            else:
                asm_size_str = "-"
                asm_speedup_str = "-"
                asm_compat_str = "-"
                asm_sec_str = "-"

            table_lines.append(
                f"| {tool} | {f_size} | {gnu_size} | {compat_str} | {speedup_str} "
                f"| {asm_size_str} | {asm_speedup_str} | {asm_compat_str} | {asm_sec_str} |"
            )
        else:
            table_lines.append(
                f"| {tool} | {f_size} | {gnu_size} | {compat_str} | {speedup_str} |"
            )

    full_table = "\n".join(table_lines)

    # Assembly summary section
    asm_summary = ""
    if has_asm:
        asm_compat_data = asm_data.get("compatibility", {})
        asm_security_data = asm_data.get("security", {})
        asm_bench_data = asm_data.get("benchmarks", {})

        total_compat_pass = sum(t.get("passed", 0) for t in asm_compat_data.values())
        total_compat_fail = sum(t.get("failed", 0) for t in asm_compat_data.values())
        total_sec_pass = sum(t.get("passed", 0) for t in asm_security_data.values())
        total_sec_total = sum(t.get("total", 0) for t in asm_security_data.values())
        sec_rate = f"{total_sec_pass / total_sec_total * 100:.1f}" if total_sec_total > 0 else "0"

        asm_summary = f"""
### Assembly (x86-64 nasm) Summary
- **Assembly tools:** {asm_tools_with_data} tools (static ELF binaries, no libc)
- **GNU compat tests:** {total_compat_pass} passed, {total_compat_fail} failed
- **Security tests:** {total_sec_pass}/{total_sec_total} passed ({sec_rate}%)
- **Tools:** {', '.join(sorted(ASM_TOOLS))}
"""

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
{asm_summary}
### Full Tools Comparison

> Sizes from release binaries. Compat = pass rate on Linux x86_64. Speedup = peak across all benchmark scenarios.
>
> Legend: `-` = no data collected | `N/A` = not applicable | `⏭️ 0 tests` = test ran but produced 0 results
> ASM columns only shown for tools with x86-64 assembly implementations.

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
- Builds and tests x86-64 assembly implementations (nasm) for {len(ASM_TOOLS)} tools
- Tests run across multiple platforms via GitHub Actions

## Running Locally
```bash
# Install and test (Rust)
./scripts/install_from_github.sh
./tests/compatibility/run_all.sh
./tests/benchmarks/run_all.sh

# Install and test (Assembly — Linux x86-64 only)
./scripts/install_assembly.sh
./tests/assembly/run_all.sh --repo-dir /path/to/fcoreutils --asm-dir ~/.local/bin/asm
./tests/assembly/bench_all.sh

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

    # Assembly section
    asm_data = data.get("asm_data", {})
    if asm_data:
        lines.append("## Assembly (x86-64 nasm)\n")

        # Assembly compatibility
        asm_compat = asm_data.get("compatibility", {})
        if asm_compat:
            lines.append("### Assembly GNU Compatibility\n")
            lines.append("| Tool | Binary | Total | Passed | Failed | Rate |")
            lines.append("|------|--------|------:|-------:|-------:|-----:|")
            for tool in sorted(ASM_TOOLS):
                if tool in asm_compat:
                    tc = asm_compat[tool]
                    total = tc.get("total", 0)
                    passed = tc.get("passed", 0)
                    failed = tc.get("failed", 0)
                    binary = tc.get("binary", f"f{tool}")
                    rate = f"{passed/total*100:.0f}%" if total > 0 else "-"
                    lines.append(f"| {tool} | {binary} | {total} | {passed} | {failed} | {rate} |")
            lines.append("")

        # Assembly security
        asm_security = asm_data.get("security", {})
        if asm_security:
            lines.append("### Assembly Security Tests\n")
            lines.append("| Tool | Total | Passed | Failed | Skipped | Rate |")
            lines.append("|------|------:|-------:|-------:|--------:|-----:|")
            for tool in sorted(ASM_TOOLS):
                if tool in asm_security:
                    ts = asm_security[tool]
                    total = ts.get("total", 0)
                    passed = ts.get("passed", 0)
                    failed = ts.get("failed", 0)
                    skipped = ts.get("skipped", 0)
                    rate = f"{passed/total*100:.0f}%" if total > 0 else "-"
                    lines.append(f"| {tool} | {total} | {passed} | {failed} | {skipped} | {rate} |")
            lines.append("")

        # Assembly benchmarks (3-way)
        asm_bench = asm_data.get("benchmarks", {})
        if asm_bench:
            lines.append("### Assembly Performance (3-way: GNU vs Rust vs ASM)\n")
            lines.append("| Tool | Test | GNU (mean) | Rust (mean) | ASM (mean) | ASM vs GNU | ASM vs Rust |")
            lines.append("|------|------|----------:|-----------:|-----------:|-----------:|------------:|")
            for tool in sorted(ASM_TOOLS):
                if tool in asm_bench:
                    for b in asm_bench[tool].get("benchmarks", []):
                        name = b.get("name", "")
                        gnu_t = b.get("gnu_mean")
                        rust_t = b.get("rust_mean")
                        asm_t = b.get("asm_mean")
                        avg = b.get("asm_vs_gnu")
                        avr = b.get("asm_vs_rust")

                        gnu_s = f"{gnu_t:.4f}s" if isinstance(gnu_t, (int, float)) else "-"
                        rust_s = f"{rust_t:.4f}s" if isinstance(rust_t, (int, float)) else "-"
                        asm_s = f"{asm_t:.4f}s" if isinstance(asm_t, (int, float)) else "-"
                        avg_s = f"**{avg:.1f}x**" if isinstance(avg, (int, float)) and avg >= 1.0 else (f"{avg:.1f}x" if isinstance(avg, (int, float)) else "-")
                        avr_s = f"**{avr:.1f}x**" if isinstance(avr, (int, float)) and avr >= 1.0 else (f"{avr:.1f}x" if isinstance(avr, (int, float)) else "-")

                        lines.append(f"| {tool} | {name} | {gnu_s} | {rust_s} | {asm_s} | {avg_s} | {avr_s} |")
            lines.append("")

        # Assembly sizes
        asm_sizes = asm_data.get("sizes", {})
        if asm_sizes:
            lines.append("### Assembly Binary Sizes\n")
            lines.append("| Tool | ASM Binary | GNU Binary | Size Ratio |")
            lines.append("|------|----------:|-----------:|-----------:|")
            for tool in sorted(ASM_TOOLS):
                if tool in asm_sizes:
                    s = asm_sizes[tool]
                    asm_b = s.get("asm_bytes")
                    gnu_b = s.get("gnu_bytes")
                    asm_str = format_size(asm_b)
                    gnu_str = format_size(gnu_b)
                    if asm_b and gnu_b:
                        ratio = f"{asm_b / gnu_b:.3f}x"
                    else:
                        ratio = "-"
                    lines.append(f"| {tool} | {asm_str} | {gnu_str} | {ratio} |")
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
    asm_data = data.get("asm_data", {})

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

    # Assembly data coverage
    if asm_data:
        asm_compat = asm_data.get("compatibility", {})
        asm_security = asm_data.get("security", {})
        asm_bench_d = asm_data.get("benchmarks", {})
        asm_sizes_d = asm_data.get("sizes", {})
        print(f"  Assembly:    {len(asm_sizes_d)} sizes, {len(asm_compat)} compat, "
              f"{len(asm_security)} security, {len(asm_bench_d)} bench")

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
