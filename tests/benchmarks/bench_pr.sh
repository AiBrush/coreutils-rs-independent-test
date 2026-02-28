#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="pr"
F_TOOL="fpr"

run_pr_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pr","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/pr_benchmark.json"
        return 0
    fi

    init_benchmark "pr"

    echo ""
    echo "=== Default pagination ==="

    run_benchmark "pr 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Multi-column ==="

    run_benchmark "-2 (two columns) 1MB" \
        "$GNU_TOOL -2 '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -2 '$TEST_DATA_DIR/text_1m.txt'"

    run_benchmark "-3 (three columns) 1MB" \
        "$GNU_TOOL -3 '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -3 '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Line numbering ==="

    run_benchmark "-n 1MB text" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== No header ==="

    run_benchmark "-t 1MB text" \
        "$GNU_TOOL -t '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -t '$TEST_DATA_DIR/text_1m.txt'"

    save_benchmark_results
}

run_pr_benchmarks
