#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="cp"
F_TOOL="fcp"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/cp}"

run_cp_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cp","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/cp_benchmark.json"
        return 0
    fi

    init_benchmark "cp"

    echo ""
    echo "=== Copy single file ==="

    run_benchmark "cp 1MB file" \
        "rm -f /tmp/bench_cp_gnu && $GNU_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_cp_gnu" \
        "rm -f /tmp/bench_cp_f && $F_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_cp_f" \
        "${U_TOOL:+rm -f /tmp/bench_cp_u && $U_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_cp_u}"

    run_benchmark "cp 10MB file" \
        "rm -f /tmp/bench_cp_10m_gnu && $GNU_TOOL '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_cp_10m_gnu" \
        "rm -f /tmp/bench_cp_10m_f && $F_TOOL '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_cp_10m_f" \
        "${U_TOOL:+rm -f /tmp/bench_cp_10m_u && $U_TOOL '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_cp_10m_u}"

    echo ""
    echo "=== Copy directory recursively ==="

    run_benchmark "cp -r directory (many_files)" \
        "rm -rf /tmp/bench_cp_dir_gnu && $GNU_TOOL -r '$TEST_DATA_DIR/many_files' /tmp/bench_cp_dir_gnu" \
        "rm -rf /tmp/bench_cp_dir_f && $F_TOOL -r '$TEST_DATA_DIR/many_files' /tmp/bench_cp_dir_f" \
        "${U_TOOL:+rm -rf /tmp/bench_cp_dir_u && $U_TOOL -r '$TEST_DATA_DIR/many_files' /tmp/bench_cp_dir_u}"

    # Cleanup
    rm -f /tmp/bench_cp_gnu /tmp/bench_cp_f /tmp/bench_cp_u
    rm -f /tmp/bench_cp_10m_gnu /tmp/bench_cp_10m_f /tmp/bench_cp_10m_u
    rm -rf /tmp/bench_cp_dir_gnu /tmp/bench_cp_dir_f /tmp/bench_cp_dir_u

    save_benchmark_results
}

run_cp_benchmarks
