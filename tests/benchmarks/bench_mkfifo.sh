#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mkfifo"
F_TOOL="fmkfifo"
U_TOOL=""

run_mkfifo_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mkfifo","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/mkfifo_benchmark.json"
        return 0
    fi

    init_benchmark "mkfifo"

    echo ""
    echo "=== Create FIFO ==="

    run_benchmark "mkfifo single fifo" \
        "rm -f /tmp/bench_mkfifo_gnu && $GNU_TOOL /tmp/bench_mkfifo_gnu" \
        "rm -f /tmp/bench_mkfifo_f && $F_TOOL /tmp/bench_mkfifo_f" \
        ""

    # Cleanup
    rm -f /tmp/bench_mkfifo_gnu /tmp/bench_mkfifo_f

    save_benchmark_results
}

run_mkfifo_benchmarks
