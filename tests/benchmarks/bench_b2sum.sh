#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="b2sum"
F_TOOL="fb2sum"
CLAIMED="10x"

run_b2sum_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"b2sum","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/b2sum_benchmark.json"
        return 0
    fi

    init_benchmark "b2sum"

    echo ""
    echo "=== Single file (various sizes) ==="

    run_benchmark "single 100KB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_100k.txt'" "$CLAIMED"

    run_benchmark "single 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" "$CLAIMED"

    run_benchmark "single 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'" "$CLAIMED"

    run_benchmark "single 10MB binary" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_10m.bin'" "$CLAIMED"

    if [[ -f "$TEST_DATA_DIR/text_100m.txt" ]]; then
        run_benchmark "single 100MB text" \
            "$GNU_TOOL '$TEST_DATA_DIR/text_100m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/text_100m.txt'" "$CLAIMED"
    fi

    echo ""
    echo "=== Variable length output ==="

    run_benchmark "-l 256 10MB" \
        "$GNU_TOOL -l 256 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -l 256 '$TEST_DATA_DIR/text_10m.txt'" "$CLAIMED"

    run_benchmark "-l 128 10MB" \
        "$GNU_TOOL -l 128 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -l 128 '$TEST_DATA_DIR/text_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Multiple files ==="

    local hundred_files=""
    for f in "$TEST_DATA_DIR/many_files"/file_*.txt; do
        hundred_files="$hundred_files '$f'"
    done

    run_benchmark "100 files" \
        "eval $GNU_TOOL $hundred_files" \
        "eval $F_TOOL $hundred_files" "$CLAIMED"

    save_benchmark_results "$CLAIMED"
}

run_b2sum_benchmarks
