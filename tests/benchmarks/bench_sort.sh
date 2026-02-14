#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sort"
F_TOOL="fsort"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/sort}"
run_sort_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sort","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/sort_benchmark.json"
        return 0
    fi

    init_benchmark "sort"

    echo ""
    echo "=== Lexicographic sort ==="

    run_benchmark "lexicographic 1MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "lexicographic 10MB random" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_lines_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/random_lines_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/random_lines_10m.txt'}"

    echo ""
    echo "=== Already sorted input ==="

    run_benchmark "already sorted 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/sorted_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/sorted_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/sorted_10m.txt'}"

    echo ""
    echo "=== Reverse sorted input ==="

    run_benchmark "reverse sorted 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/reverse_sorted_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/reverse_sorted_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/reverse_sorted_10m.txt'}"

    echo ""
    echo "=== Numeric sort (-n) ==="

    run_benchmark "-n numeric 10MB" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/random_lines_10m.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/random_lines_10m.txt'" \
        "${U_TOOL:+$U_TOOL -n '$TEST_DATA_DIR/random_lines_10m.txt'}"

    echo ""
    echo "=== Reverse (-r) ==="

    run_benchmark "-r reverse 10MB" \
        "$GNU_TOOL -r '$TEST_DATA_DIR/random_lines_10m.txt'" \
        "$F_TOOL -r '$TEST_DATA_DIR/random_lines_10m.txt'" \
        "${U_TOOL:+$U_TOOL -r '$TEST_DATA_DIR/random_lines_10m.txt'}"

    echo ""
    echo "=== Unique (-u) ==="

    run_benchmark "-u unique 10MB" \
        "$GNU_TOOL -u '$TEST_DATA_DIR/random_lines_10m.txt'" \
        "$F_TOOL -u '$TEST_DATA_DIR/random_lines_10m.txt'" \
        "${U_TOOL:+$U_TOOL -u '$TEST_DATA_DIR/random_lines_10m.txt'}"

    echo ""
    echo "=== Key sort (-k) ==="

    run_benchmark "-t, -k2 CSV 10MB" \
        "$GNU_TOOL -t, -k2 '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL -t, -k2 '$TEST_DATA_DIR/csv_10m.csv'" \
        "${U_TOOL:+$U_TOOL -t, -k2 '$TEST_DATA_DIR/csv_10m.csv'}"

    echo ""
    echo "=== Repetitive content ==="

    run_benchmark "repetitive 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/repetitive_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/repetitive_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/repetitive_10m.txt'}"

    echo ""
    echo "=== Parallel sort ==="

    run_benchmark "--parallel=4 10MB" \
        "$GNU_TOOL --parallel=4 '$TEST_DATA_DIR/random_lines_10m.txt'" \
        "$F_TOOL --parallel=4 '$TEST_DATA_DIR/random_lines_10m.txt'" \
        "${U_TOOL:+$U_TOOL --parallel=4 '$TEST_DATA_DIR/random_lines_10m.txt'}"

    save_benchmark_results
}

run_sort_benchmarks
