#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="logname"
F_TOOL="flogname"
U_TOOL=""

run_logname_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"logname","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/logname_benchmark.json"
        return 0
    fi

    init_benchmark "logname"

    echo ""
    echo "=== Startup/execution overhead ==="

    # Note: logname may fail in CI environments where there is no login name,
    # so we wrap with "|| true" to allow benchmarking regardless.
    run_benchmark "logname (no args)" \
        "$GNU_TOOL || true" \
        "$F_TOOL || true" \
        ""

    save_benchmark_results
}

run_logname_benchmarks
