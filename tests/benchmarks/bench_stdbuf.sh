#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="stdbuf"
F_TOOL="fstdbuf"

run_stdbuf_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"stdbuf","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/stdbuf_benchmark.json"
        return 0
    fi

    init_benchmark "stdbuf"

    echo ""
    echo "=== Line buffered passthrough ==="

    run_benchmark "-oL cat 1MB" \
        "$GNU_TOOL -oL cat '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -oL cat '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Unbuffered ==="

    run_benchmark "-o0 cat 100KB" \
        "$GNU_TOOL -o0 cat '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL -o0 cat '$TEST_DATA_DIR/text_100k.txt'"

    save_benchmark_results
}

run_stdbuf_benchmarks
