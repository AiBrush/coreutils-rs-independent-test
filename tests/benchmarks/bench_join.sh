#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="join"
F_TOOL="fjoin"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/join}"

run_join_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"join","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/join_benchmark.json"
        return 0
    fi

    init_benchmark "join"

    echo ""
    echo "=== Default join ==="

    if [[ -f "$TEST_DATA_DIR/join_bench_file1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/join_bench_file2_10m.txt" ]]; then
        run_benchmark "default join 10MB" \
            "$GNU_TOOL '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'" \
            "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'}"
    fi

    echo ""
    echo "=== Full outer join (-a 1 -a 2) ==="

    if [[ -f "$TEST_DATA_DIR/join_bench_file1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/join_bench_file2_10m.txt" ]]; then
        run_benchmark "outer join 10MB" \
            "$GNU_TOOL -a 1 -a 2 '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'" \
            "$F_TOOL -a 1 -a 2 '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'" \
            "${U_TOOL:+$U_TOOL -a 1 -a 2 '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'}"
    fi

    echo ""
    echo "=== Only unpaired (-v) ==="

    if [[ -f "$TEST_DATA_DIR/join_bench_file1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/join_bench_file2_10m.txt" ]]; then
        run_benchmark "-v 1 (unmatched from file1) 10MB" \
            "$GNU_TOOL -v 1 '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'" \
            "$F_TOOL -v 1 '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'" \
            "${U_TOOL:+$U_TOOL -v 1 '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'}"
    fi

    echo ""
    echo "=== Custom output format ==="

    if [[ -f "$TEST_DATA_DIR/join_bench_file1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/join_bench_file2_10m.txt" ]]; then
        run_benchmark "-o 0,1.2,2.2 10MB" \
            "$GNU_TOOL -o '0,1.2,2.2' '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'" \
            "$F_TOOL -o '0,1.2,2.2' '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'" \
            "${U_TOOL:+$U_TOOL -o '0,1.2,2.2' '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt'}"
    fi

    echo ""
    echo "=== Self-join (identical files) ==="

    run_benchmark "self-join sorted 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/sorted_10m.txt' '$TEST_DATA_DIR/sorted_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/sorted_10m.txt' '$TEST_DATA_DIR/sorted_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/sorted_10m.txt' '$TEST_DATA_DIR/sorted_10m.txt'}"

    save_benchmark_results
}

run_join_benchmarks
