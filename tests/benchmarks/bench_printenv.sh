#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="printenv"
F_TOOL="fprintenv"

run_printenv_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"printenv","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/printenv_benchmark.json"
        return 0
    fi

    init_benchmark "printenv"

    echo ""
    echo "=== All variables ==="

    run_benchmark "printenv (all)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    echo ""
    echo "=== Specific variable ==="

    run_benchmark "printenv HOME" \
        "$GNU_TOOL HOME" \
        "$F_TOOL HOME"

    run_benchmark "printenv PATH" \
        "$GNU_TOOL PATH" \
        "$F_TOOL PATH"

    save_benchmark_results
}

run_printenv_benchmarks
