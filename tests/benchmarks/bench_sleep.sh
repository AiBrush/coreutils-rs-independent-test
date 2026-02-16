#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sleep"
F_TOOL="fsleep"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/sleep}"

run_sleep_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sleep","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/sleep_benchmark.json"
        return 0
    fi

    init_benchmark "sleep"

    echo ""
    echo "=== Startup overhead (sleep 0) ==="

    run_benchmark "sleep 0 (startup overhead)" \
        "$GNU_TOOL 0" \
        "$F_TOOL 0" \
        "${U_TOOL:+$U_TOOL 0}"

    echo ""
    echo "=== Tiny sleep ==="

    run_benchmark "sleep 0.001 (tiny sleep)" \
        "$GNU_TOOL 0.001" \
        "$F_TOOL 0.001" \
        "${U_TOOL:+$U_TOOL 0.001}"

    save_benchmark_results
}

run_sleep_benchmarks
