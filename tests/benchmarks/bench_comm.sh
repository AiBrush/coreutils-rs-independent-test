#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="comm"
F_TOOL="fcomm"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/comm}"

run_comm_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"comm","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/comm_benchmark.json"
        return 0
    fi

    init_benchmark "comm"

    echo ""
    echo "=== Default (3-column output) ==="

    if [[ -f "$TEST_DATA_DIR/comm_bench_file1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/comm_bench_file2_10m.txt" ]]; then
        run_benchmark "default 10MB sorted" \
            "$GNU_TOOL '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'" \
            "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'}"
    fi

    echo ""
    echo "=== Suppress columns ==="

    if [[ -f "$TEST_DATA_DIR/comm_bench_file1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/comm_bench_file2_10m.txt" ]]; then
        run_benchmark "-12 (common only) 10MB" \
            "$GNU_TOOL -12 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'" \
            "$F_TOOL -12 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'" \
            "${U_TOOL:+$U_TOOL -12 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'}"

        run_benchmark "-23 (unique to file1) 10MB" \
            "$GNU_TOOL -23 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'" \
            "$F_TOOL -23 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'" \
            "${U_TOOL:+$U_TOOL -23 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'}"

        run_benchmark "-3 10MB" \
            "$GNU_TOOL -3 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'" \
            "$F_TOOL -3 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'" \
            "${U_TOOL:+$U_TOOL -3 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt'}"
    fi

    echo ""
    echo "=== Identical files (all common) ==="

    run_benchmark "identical 10MB sorted" \
        "$GNU_TOOL '$TEST_DATA_DIR/sorted_10m.txt' '$TEST_DATA_DIR/sorted_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/sorted_10m.txt' '$TEST_DATA_DIR/sorted_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/sorted_10m.txt' '$TEST_DATA_DIR/sorted_10m.txt'}"

    save_benchmark_results
}

run_comm_benchmarks
