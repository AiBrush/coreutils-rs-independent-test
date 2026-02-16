#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="link"
F_TOOL="flink"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/link}"

run_link_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"link","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/link_benchmark.json"
        return 0
    fi

    init_benchmark "link"

    echo ""
    echo "=== Create hard link ==="

    run_benchmark "hard link a file" \
        "rm -f /tmp/bench_link_gnu && $GNU_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_link_gnu" \
        "rm -f /tmp/bench_link_f && $F_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_link_f" \
        "${U_TOOL:+rm -f /tmp/bench_link_u && $U_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_link_u}"

    # Cleanup
    rm -f /tmp/bench_link_gnu /tmp/bench_link_f /tmp/bench_link_u

    save_benchmark_results
}

run_link_benchmarks
