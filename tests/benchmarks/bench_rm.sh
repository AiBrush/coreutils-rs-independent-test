#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="rm"
F_TOOL="frm"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/rm}"

run_rm_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"rm","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/rm_benchmark.json"
        return 0
    fi

    init_benchmark "rm"

    echo ""
    echo "=== Remove single file ==="

    run_benchmark "rm single file" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_rm_gnu && $GNU_TOOL /tmp/bench_rm_gnu" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_rm_f && $F_TOOL /tmp/bench_rm_f" \
        "${U_TOOL:+cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_rm_u && $U_TOOL /tmp/bench_rm_u}"

    echo ""
    echo "=== Remove directory recursively ==="

    run_benchmark "rm -rf directory" \
        "cp -r '$TEST_DATA_DIR/many_files' /tmp/bench_rm_dir_gnu && $GNU_TOOL -rf /tmp/bench_rm_dir_gnu" \
        "cp -r '$TEST_DATA_DIR/many_files' /tmp/bench_rm_dir_f && $F_TOOL -rf /tmp/bench_rm_dir_f" \
        "${U_TOOL:+cp -r '$TEST_DATA_DIR/many_files' /tmp/bench_rm_dir_u && $U_TOOL -rf /tmp/bench_rm_dir_u}"

    # Cleanup (in case any remain)
    rm -f /tmp/bench_rm_gnu /tmp/bench_rm_f /tmp/bench_rm_u
    rm -rf /tmp/bench_rm_dir_gnu /tmp/bench_rm_dir_f /tmp/bench_rm_dir_u

    save_benchmark_results
}

run_rm_benchmarks
