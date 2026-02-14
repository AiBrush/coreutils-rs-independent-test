#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="md5sum"
F_TOOL="fmd5sum"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/md5sum}"
run_md5sum_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"md5sum","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/md5sum_benchmark.json"
        return 0
    fi

    init_benchmark "md5sum"

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
    echo "=== Multiple files (parallel potential) ==="

    local ten_files=""
    for f in "$TEST_DATA_DIR/many_files"/file_000{1..9}.txt "$TEST_DATA_DIR/many_files/file_0010.txt"; do
        ten_files="$ten_files '$f'"
    done

    run_benchmark "10 files" \
        "eval $GNU_TOOL $ten_files" \
        "eval $F_TOOL $ten_files" \
        "${U_TOOL:+eval $U_TOOL $ten_files}"

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

run_md5sum_benchmarks
