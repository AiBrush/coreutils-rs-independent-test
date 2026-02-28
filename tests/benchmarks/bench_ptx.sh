#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="ptx"
F_TOOL="fptx"

run_ptx_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"ptx","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/ptx_benchmark.json"
        return 0
    fi

    init_benchmark "ptx"

    echo ""
    echo "=== Default permuted index ==="

    run_benchmark "ptx 100KB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_100k.txt'"

    run_benchmark "ptx 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Custom width ==="

    run_benchmark "-w 60 1MB text" \
        "$GNU_TOOL -w 60 '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -w 60 '$TEST_DATA_DIR/text_1m.txt'"

    save_benchmark_results
}

run_ptx_benchmarks
