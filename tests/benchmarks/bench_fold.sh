#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="fold"
F_TOOL="ffold"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/fold}"

run_fold_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"fold","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/fold_benchmark.json"
        return 0
    fi

    init_benchmark "fold"

    echo ""
    echo "=== Default width (80) ==="

    if [[ -f "$TEST_DATA_DIR/wide_lines_10m.txt" ]]; then
        run_benchmark "fold 10MB wide lines (default)" \
            "$GNU_TOOL '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/wide_lines_10m.txt'}"
    fi

    run_benchmark "fold 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "fold 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Custom widths ==="

    if [[ -f "$TEST_DATA_DIR/wide_lines_10m.txt" ]]; then
        run_benchmark "-w 40 10MB" \
            "$GNU_TOOL -w 40 '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "$F_TOOL -w 40 '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "${U_TOOL:+$U_TOOL -w 40 '$TEST_DATA_DIR/wide_lines_10m.txt'}"

        run_benchmark "-w 20 10MB" \
            "$GNU_TOOL -w 20 '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "$F_TOOL -w 20 '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "${U_TOOL:+$U_TOOL -w 20 '$TEST_DATA_DIR/wide_lines_10m.txt'}"
    fi

    echo ""
    echo "=== Break at spaces (-s) ==="

    if [[ -f "$TEST_DATA_DIR/wide_lines_10m.txt" ]]; then
        run_benchmark "-s -w 60 10MB" \
            "$GNU_TOOL -s -w 60 '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "$F_TOOL -s -w 60 '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "${U_TOOL:+$U_TOOL -s -w 60 '$TEST_DATA_DIR/wide_lines_10m.txt'}"

        run_benchmark "-s -w 40 10MB" \
            "$GNU_TOOL -s -w 40 '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "$F_TOOL -s -w 40 '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "${U_TOOL:+$U_TOOL -s -w 40 '$TEST_DATA_DIR/wide_lines_10m.txt'}"
    fi

    echo ""
    echo "=== Byte mode (-b) ==="

    run_benchmark "-b -w 40 10MB" \
        "$GNU_TOOL -b -w 40 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -b -w 40 '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -b -w 40 '$TEST_DATA_DIR/text_10m.txt'}"

    save_benchmark_results
}

run_fold_benchmarks
