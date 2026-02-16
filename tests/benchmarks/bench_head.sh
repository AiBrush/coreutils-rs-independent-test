#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="head"
F_TOOL="fhead"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/head}"

run_head_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"head","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/head_benchmark.json"
        return 0
    fi

    init_benchmark "head"

    echo ""
    echo "=== Default (first 10 lines) ==="

    run_benchmark "default 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "default 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_10m.txt'}"

    if [[ -f "$TEST_DATA_DIR/text_100m.txt" ]]; then
        run_benchmark "default 100MB text" \
            "$GNU_TOOL '$TEST_DATA_DIR/text_100m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/text_100m.txt'" \
            "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_100m.txt'}"
    fi

    echo ""
    echo "=== Line count (-n) ==="

    run_benchmark "-n 1000 10MB" \
        "$GNU_TOOL -n 1000 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -n 1000 '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -n 1000 '$TEST_DATA_DIR/text_10m.txt'}"

    run_benchmark "-n 100000 10MB" \
        "$GNU_TOOL -n 100000 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -n 100000 '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -n 100000 '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Byte count (-c) ==="

    run_benchmark "-c 1000000 10MB" \
        "$GNU_TOOL -c 1000000 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -c 1000000 '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -c 1000000 '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Negative count (-n -N) ==="

    run_benchmark "-n -100 10MB (all but last 100)" \
        "$GNU_TOOL -n -100 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -n -100 '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -n -100 '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Multiple files ==="

    local many_files=""
    for i in $(seq 1 100); do
        many_files="$many_files '$TEST_DATA_DIR/many_files/file_$(printf '%04d' $i).txt'"
    done
    run_benchmark "100 small files" \
        "eval $GNU_TOOL $many_files" \
        "eval $F_TOOL $many_files" \
        "${U_TOOL:+eval $U_TOOL $many_files}"

    save_benchmark_results
}

run_head_benchmarks
