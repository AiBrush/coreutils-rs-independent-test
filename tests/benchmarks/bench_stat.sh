#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="stat"
F_TOOL="fstat"

run_stat_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"stat","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/stat_benchmark.json"
        return 0
    fi

    init_benchmark "stat"

    echo ""
    echo "=== Single file ==="

    run_benchmark "stat single file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Multiple files ==="

    local many_files=""
    for f in "$TEST_DATA_DIR/many_files"/file_*.txt; do
        many_files="$many_files '$f'"
    done

    run_benchmark "100 files" \
        "eval $GNU_TOOL $many_files" \
        "eval $F_TOOL $many_files"

    echo ""
    echo "=== Format string ==="

    run_benchmark "--format=%s (size only)" \
        "$GNU_TOOL --format=%s '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL --format=%s '$TEST_DATA_DIR/text_10m.txt'"

    run_benchmark "--format='%n %s %Y'" \
        "$GNU_TOOL --format='%n %s %Y' '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL --format='%n %s %Y' '$TEST_DATA_DIR/text_10m.txt'"

    echo ""
    echo "=== Filesystem stat ==="

    run_benchmark "-f (filesystem)" \
        "$GNU_TOOL -f '$TEST_DATA_DIR'" \
        "$F_TOOL -f '$TEST_DATA_DIR'"

    save_benchmark_results
}

run_stat_benchmarks
