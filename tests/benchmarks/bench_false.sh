#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="false"
F_TOOL="ffalse"

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

    save_benchmark_results
}

run_false_benchmarks
