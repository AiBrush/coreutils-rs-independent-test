#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="uptime"
F_TOOL="fuptime"

run_uptime_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"uptime","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/uptime_benchmark.json"
        return 0
    fi

    init_benchmark "uptime"

    echo ""
    echo "=== Default output ==="

    run_benchmark "uptime (default)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    echo ""
    echo "=== Since boot ==="

    run_benchmark "uptime -s (since)" \
        "$GNU_TOOL -s" \
        "$F_TOOL -s"

    save_benchmark_results
}

run_uptime_benchmarks
