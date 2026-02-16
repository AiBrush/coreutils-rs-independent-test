#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="unlink"
F_TOOL="funlink"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/unlink}"

run_unlink_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"unlink","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/unlink_benchmark.json"
        return 0
    fi

    init_benchmark "unlink"

    echo ""
    echo "=== Unlink a file ==="

    run_benchmark "unlink a file" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_unlink_gnu && $GNU_TOOL /tmp/bench_unlink_gnu" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_unlink_f && $F_TOOL /tmp/bench_unlink_f" \
        "${U_TOOL:+cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_unlink_u && $U_TOOL /tmp/bench_unlink_u}"

    # Cleanup
    rm -f /tmp/bench_unlink_gnu /tmp/bench_unlink_f /tmp/bench_unlink_u

    save_benchmark_results
}

run_unlink_benchmarks
