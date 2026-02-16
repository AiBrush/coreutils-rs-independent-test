#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="split"
F_TOOL="fsplit"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/split}"

run_split_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"split","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/split_benchmark.json"
        return 0
    fi

    init_benchmark "split"

    echo ""
    echo "=== Split by size ==="

    run_benchmark "split 10MB into 1MB chunks (-b 1m)" \
        "rm -f /tmp/bench_split_gnu_* && $GNU_TOOL -b 1m '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_split_gnu_" \
        "rm -f /tmp/bench_split_f_* && $F_TOOL -b 1m '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_split_f_" \
        "${U_TOOL:+rm -f /tmp/bench_split_u_* && $U_TOOL -b 1m '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_split_u_}"

    echo ""
    echo "=== Split by lines ==="

    run_benchmark "split 10MB by 1000 lines (-l 1000)" \
        "rm -f /tmp/bench_split_lines_gnu_* && $GNU_TOOL -l 1000 '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_split_lines_gnu_" \
        "rm -f /tmp/bench_split_lines_f_* && $F_TOOL -l 1000 '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_split_lines_f_" \
        "${U_TOOL:+rm -f /tmp/bench_split_lines_u_* && $U_TOOL -l 1000 '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_split_lines_u_}"

    # Cleanup
    rm -f /tmp/bench_split_gnu_* /tmp/bench_split_f_* /tmp/bench_split_u_*
    rm -f /tmp/bench_split_lines_gnu_* /tmp/bench_split_lines_f_* /tmp/bench_split_lines_u_*

    save_benchmark_results
}

run_split_benchmarks
