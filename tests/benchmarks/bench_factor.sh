#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="factor"
F_TOOL="ffactor"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/factor}"

run_factor_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"factor","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/factor_benchmark.json"
        return 0
    fi

    init_benchmark "factor"

    echo ""
    echo "=== Single number ==="

    run_benchmark "factor 1234567890" \
        "$GNU_TOOL 1234567890" \
        "$F_TOOL 1234567890" \
        "${U_TOOL:+$U_TOOL 1234567890}"

    echo ""
    echo "=== Large prime ==="

    run_benchmark "factor 999999999999999989 (large prime)" \
        "$GNU_TOOL 999999999999999989" \
        "$F_TOOL 999999999999999989" \
        "${U_TOOL:+$U_TOOL 999999999999999989}"

    echo ""
    echo "=== Many numbers via stdin ==="

    # Create temp file with numbers 1-100000
    local numbers_file
    numbers_file=$(mktemp /tmp/factor_bench_XXXXXX.txt)
    seq 1 100000 > "$numbers_file"

    run_stdin_benchmark "factor 1-100000 via stdin" \
        "$numbers_file" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    rm -f "$numbers_file"

    save_benchmark_results
}

run_factor_benchmarks
