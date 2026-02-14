#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="b2sum"
F_TOOL="fb2sum"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/b2sum}"
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
        "$F_TOOL '$TEST_DATA_DIR/text_100k.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_100k.txt'}"

    run_benchmark "single 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "single 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_10m.txt'}"

    run_benchmark "single 10MB binary" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/random_10m.bin'}"

    if [[ -f "$TEST_DATA_DIR/text_100m.txt" ]]; then
        run_benchmark "single 100MB text" \
            "$GNU_TOOL '$TEST_DATA_DIR/text_100m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/text_100m.txt'" \
            "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_100m.txt'}"
    fi

    echo ""
    echo "=== Variable length output ==="

    run_benchmark "-l 256 10MB" \
        "$GNU_TOOL -l 256 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -l 256 '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -l 256 '$TEST_DATA_DIR/text_10m.txt'}"

    run_benchmark "-l 128 10MB" \
        "$GNU_TOOL -l 128 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -l 128 '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -l 128 '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Multiple files ==="

    local hundred_files=""
    for f in "$TEST_DATA_DIR/many_files"/file_*.txt; do
        hundred_files="$hundred_files '$f'"
    done

    run_benchmark "100 files" \
        "eval $GNU_TOOL $hundred_files" \
        "eval $F_TOOL $hundred_files" \
        "${U_TOOL:+eval $U_TOOL $hundred_files}"

    save_benchmark_results
}

run_b2sum_benchmarks
