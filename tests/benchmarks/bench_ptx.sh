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

    # Create a small test file (ptx is very slow on large inputs)
    local small_file="/tmp/ptx_test_10k.txt"
    head -c 10240 "$TEST_DATA_DIR/text_100k.txt" > "$small_file"

    echo ""
    echo "=== Default permuted index ==="

    run_benchmark "ptx 10KB text" \
        "$GNU_TOOL '$small_file'" \
        "$F_TOOL '$small_file'"

    run_benchmark "ptx 100KB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_100k.txt'"

    echo ""
    echo "=== Custom width ==="

    run_benchmark "-w 60 100KB text" \
        "$GNU_TOOL -w 60 '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL -w 60 '$TEST_DATA_DIR/text_100k.txt'"

    rm -f "$small_file"

    save_benchmark_results
}

run_ptx_benchmarks
