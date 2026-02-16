#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="paste"
F_TOOL="fpaste"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/paste}"

run_paste_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"paste","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/paste_benchmark.json"
        return 0
    fi

    init_benchmark "paste"

    echo ""
    echo "=== Two files (default tab delimiter) ==="

    if [[ -f "$TEST_DATA_DIR/paste_bench_col1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/paste_bench_col2_10m.txt" ]]; then
        run_benchmark "2 columns 10MB" \
            "$GNU_TOOL '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt'" \
            "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt'}"
    fi

    echo ""
    echo "=== Three files ==="

    if [[ -f "$TEST_DATA_DIR/paste_bench_col1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/paste_bench_col2_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/paste_bench_col3_10m.txt" ]]; then
        run_benchmark "3 columns 10MB" \
            "$GNU_TOOL '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt' '$TEST_DATA_DIR/paste_bench_col3_10m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt' '$TEST_DATA_DIR/paste_bench_col3_10m.txt'" \
            "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt' '$TEST_DATA_DIR/paste_bench_col3_10m.txt'}"
    fi

    echo ""
    echo "=== Custom delimiter ==="

    if [[ -f "$TEST_DATA_DIR/paste_bench_col1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/paste_bench_col2_10m.txt" ]]; then
        run_benchmark "-d comma 10MB" \
            "$GNU_TOOL -d, '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt'" \
            "$F_TOOL -d, '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt'" \
            "${U_TOOL:+$U_TOOL -d, '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt'}"
    fi

    echo ""
    echo "=== Serial mode (-s) ==="

    if [[ -f "$TEST_DATA_DIR/paste_bench_col1_10m.txt" ]]; then
        run_benchmark "-s 10MB single file" \
            "$GNU_TOOL -s '$TEST_DATA_DIR/paste_bench_col1_10m.txt'" \
            "$F_TOOL -s '$TEST_DATA_DIR/paste_bench_col1_10m.txt'" \
            "${U_TOOL:+$U_TOOL -s '$TEST_DATA_DIR/paste_bench_col1_10m.txt'}"
    fi

    echo ""
    echo "=== Stdin splitting ==="

    run_stdin_benchmark "stdin split 2-way 10MB" \
        "$TEST_DATA_DIR/text_10m.txt" \
        "$GNU_TOOL - -" \
        "$F_TOOL - -" \
        "${U_TOOL:+$U_TOOL - -}"

    save_benchmark_results
}

run_paste_benchmarks
