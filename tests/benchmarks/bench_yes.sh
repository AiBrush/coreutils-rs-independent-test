#!/usr/bin/env bash
# Performance benchmarks for fyes vs GNU yes
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="yes"
F_TOOL="fyes"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/yes}"

run_yes_benchmarks() {
    check_hyperfine
    # No test data needed - yes is a generator

    # NOTE: Cannot use check_tool_exists for 'yes' (it pipes stdin which hangs).
    if ! command -v "$F_TOOL" &>/dev/null; then
        echo '{"tool":"yes","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/yes_benchmark.json"
        return 0
    fi

    init_benchmark "yes"

    echo ""
    echo "=== Startup Time ==="

    run_benchmark "startup --help" \
        "$GNU_TOOL --help > /dev/null" \
        "$F_TOOL --help > /dev/null" \
        "${U_TOOL:+$U_TOOL --help > /dev/null}"

    run_benchmark "startup --version" \
        "$GNU_TOOL --version > /dev/null" \
        "$F_TOOL --version > /dev/null" \
        "${U_TOOL:+$U_TOOL --version > /dev/null}"

    echo ""
    echo "=== Throughput (default y) ==="

    run_benchmark "throughput 1M lines" \
        "$GNU_TOOL | head -n 1000000 > /dev/null" \
        "$F_TOOL | head -n 1000000 > /dev/null" \
        "${U_TOOL:+$U_TOOL | head -n 1000000 > /dev/null}"

    run_benchmark "throughput 10M lines" \
        "$GNU_TOOL | head -n 10000000 > /dev/null" \
        "$F_TOOL | head -n 10000000 > /dev/null" \
        "${U_TOOL:+$U_TOOL | head -n 10000000 > /dev/null}"

    echo ""
    echo "=== Throughput (custom arg) ==="

    run_benchmark "throughput hello 1M lines" \
        "$GNU_TOOL hello | head -n 1000000 > /dev/null" \
        "$F_TOOL hello | head -n 1000000 > /dev/null" \
        "${U_TOOL:+$U_TOOL hello | head -n 1000000 > /dev/null}"

    run_benchmark "throughput hello 10M lines" \
        "$GNU_TOOL hello | head -n 10000000 > /dev/null" \
        "$F_TOOL hello | head -n 10000000 > /dev/null" \
        "${U_TOOL:+$U_TOOL hello | head -n 10000000 > /dev/null}"

    echo ""
    echo "=== Throughput (byte volume via head -c) ==="

    run_benchmark "throughput 100MB" \
        "$GNU_TOOL | head -c 100000000 > /dev/null" \
        "$F_TOOL | head -c 100000000 > /dev/null" \
        "${U_TOOL:+$U_TOOL | head -c 100000000 > /dev/null}"

    echo ""
    echo "=== Binary Size (informational) ==="

    local gnu_path fyes_path
    gnu_path=$(command -v "$GNU_TOOL" 2>/dev/null || echo "")
    fyes_path=$(command -v "$F_TOOL" 2>/dev/null || echo "")
    if [[ -n "$gnu_path" ]] && [[ -n "$fyes_path" ]]; then
        local gnu_size fyes_size
        gnu_size=$(stat -c%s "$gnu_path" 2>/dev/null || stat -f%z "$gnu_path" 2>/dev/null || echo "?")
        fyes_size=$(stat -c%s "$fyes_path" 2>/dev/null || stat -f%z "$fyes_path" 2>/dev/null || echo "?")
        echo "  GNU yes binary size: ${gnu_size} bytes"
        echo "  fyes binary size:    ${fyes_size} bytes"
        if [[ "$gnu_size" != "?" ]] && [[ "$fyes_size" != "?" ]] && [[ "$fyes_size" -gt 0 ]]; then
            local ratio
            ratio=$(python3 -c "print(f'{$gnu_size / $fyes_size:.0f}')" 2>/dev/null || echo "?")
            echo "  Size ratio:          ${ratio}x smaller"
        fi
    fi

    save_benchmark_results
}

run_yes_benchmarks
