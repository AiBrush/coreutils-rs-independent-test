#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="true"
F_TOOL="ftrue"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/true}"

run_true_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"true","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/true_benchmark.json"
        return 0
    fi

    init_benchmark "true"

    echo ""
    echo "=== Startup overhead ==="

    run_benchmark "true (startup overhead)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    save_benchmark_results
}

run_true_benchmarks
