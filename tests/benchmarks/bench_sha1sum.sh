#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sha1sum"
F_TOOL="fsha1sum"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/sha1sum}"

run_sha1sum_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha1sum","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/sha1sum_benchmark.json"
        return 0
    fi

    init_benchmark "sha1sum"

    echo ""
    echo "=== Single file (various sizes) ==="

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

run_sha1sum_benchmarks
