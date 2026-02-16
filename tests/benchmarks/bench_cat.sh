#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="cat"
F_TOOL="fcat"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/cat}"

run_cat_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cat","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/cat_benchmark.json"
        return 0
    fi

    init_benchmark "cat"

    echo ""
    echo "=== Basic concatenation ==="

    run_benchmark "passthrough 1MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "passthrough 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_10m.txt'}"

    if [[ -f "$TEST_DATA_DIR/text_100m.txt" ]]; then
        run_benchmark "passthrough 100MB" \
            "$GNU_TOOL '$TEST_DATA_DIR/text_100m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/text_100m.txt'" \
            "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_100m.txt'}"
    fi

    echo ""
    echo "=== With line numbering (-n) ==="

    run_benchmark "-n 1MB" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL -n '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "-n 10MB" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -n '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Non-blank numbering (-b) ==="

    run_benchmark "-b 10MB" \
        "$GNU_TOOL -b '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -b '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -b '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Show all (-A = -vET) ==="

    run_benchmark "-A 1MB" \
        "$GNU_TOOL -A '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -A '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL -A '$TEST_DATA_DIR/text_1m.txt'}"

    echo ""
    echo "=== Multiple files concatenation ==="

    local many_files=""
    for i in $(seq 1 100); do
        many_files="$many_files '$TEST_DATA_DIR/many_files/file_$(printf '%04d' $i).txt'"
    done
    run_benchmark "100 small files" \
        "eval $GNU_TOOL $many_files" \
        "eval $F_TOOL $many_files" \
        "${U_TOOL:+eval $U_TOOL $many_files}"

    echo ""
    echo "=== Binary data ==="

    run_benchmark "binary 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/random_10m.bin'}"

    save_benchmark_results
}

run_cat_benchmarks
