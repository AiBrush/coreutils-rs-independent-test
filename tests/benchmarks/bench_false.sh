#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="false"
F_TOOL="ffalse"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/false}"

run_false_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"false","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/false_benchmark.json"
        return 0
    fi

    init_benchmark "false"

    echo ""
    echo "=== Startup overhead (false exits 1) ==="

    run_benchmark "false (startup overhead)" \
        "$GNU_TOOL || true" \
        "$F_TOOL || true" \
        "${U_TOOL:+$U_TOOL || true}"

    save_benchmark_results
}

run_false_benchmarks
