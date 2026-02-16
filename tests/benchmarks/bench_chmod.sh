#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="chmod"
F_TOOL="fchmod"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/chmod}"

run_chmod_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chmod","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/chmod_benchmark.json"
        return 0
    fi

    init_benchmark "chmod"

    echo ""
    echo "=== chmod numeric mode ==="

    run_benchmark "chmod 644 on file" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chmod_gnu && $GNU_TOOL 644 /tmp/bench_chmod_gnu" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chmod_f && $F_TOOL 644 /tmp/bench_chmod_f" \
        "${U_TOOL:+cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chmod_u && $U_TOOL 644 /tmp/bench_chmod_u}"

    echo ""
    echo "=== chmod symbolic mode ==="

    run_benchmark "chmod u+x on file" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chmod_ux_gnu && $GNU_TOOL u+x /tmp/bench_chmod_ux_gnu" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chmod_ux_f && $F_TOOL u+x /tmp/bench_chmod_ux_f" \
        "${U_TOOL:+cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chmod_ux_u && $U_TOOL u+x /tmp/bench_chmod_ux_u}"

    # Cleanup
    rm -f /tmp/bench_chmod_gnu /tmp/bench_chmod_f /tmp/bench_chmod_u
    rm -f /tmp/bench_chmod_ux_gnu /tmp/bench_chmod_ux_f /tmp/bench_chmod_ux_u

    save_benchmark_results
}

run_chmod_benchmarks
