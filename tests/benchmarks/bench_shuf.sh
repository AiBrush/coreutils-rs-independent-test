#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="shuf"
F_TOOL="fshuf"

run_shuf_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"shuf","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/shuf_benchmark.json"
        return 0
    fi

    init_benchmark "shuf"

    echo ""
    echo "=== Shuffle file ==="

    run_benchmark "shuf 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    run_benchmark "shuf 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'"

    echo ""
    echo "=== Head count (-n) ==="

    run_benchmark "-n 100 from 10MB" \
        "$GNU_TOOL -n 100 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -n 100 '$TEST_DATA_DIR/text_10m.txt'"

    run_benchmark "-n 10000 from 10MB" \
        "$GNU_TOOL -n 10000 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -n 10000 '$TEST_DATA_DIR/text_10m.txt'"

    echo ""
    echo "=== Integer range (-i) ==="

    run_benchmark "-i 1-1000000" \
        "$GNU_TOOL -i 1-1000000" \
        "$F_TOOL -i 1-1000000"

    run_benchmark "-i 1-1000000 -n 100" \
        "$GNU_TOOL -i 1-1000000 -n 100" \
        "$F_TOOL -i 1-1000000 -n 100"

    save_benchmark_results
}

run_shuf_benchmarks
