#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mknod"
F_TOOL="fmknod"
U_TOOL=""

run_mknod_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mknod","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/mknod_benchmark.json"
        return 0
    fi

    init_benchmark "mknod"

    echo ""
    echo "=== Create named pipe (FIFO) node ==="

    run_benchmark "mknod named pipe" \
        "rm -f /tmp/bench_mknod_gnu && $GNU_TOOL /tmp/bench_mknod_gnu p" \
        "rm -f /tmp/bench_mknod_f && $F_TOOL /tmp/bench_mknod_f p" \
        ""

    # Cleanup
    rm -f /tmp/bench_mknod_gnu /tmp/bench_mknod_f

    save_benchmark_results
}

run_mknod_benchmarks
