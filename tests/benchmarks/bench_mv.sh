#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mv"
F_TOOL="fmv"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/mv}"

run_mv_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mv","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/mv_benchmark.json"
        return 0
    fi

    init_benchmark "mv"

    echo ""
    echo "=== Move single file ==="

    run_benchmark "mv 1MB file" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_mv_gnu_src && $GNU_TOOL /tmp/bench_mv_gnu_src /tmp/bench_mv_gnu_dst && rm -f /tmp/bench_mv_gnu_dst" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_mv_f_src && $F_TOOL /tmp/bench_mv_f_src /tmp/bench_mv_f_dst && rm -f /tmp/bench_mv_f_dst" \
        "${U_TOOL:+cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_mv_u_src && $U_TOOL /tmp/bench_mv_u_src /tmp/bench_mv_u_dst && rm -f /tmp/bench_mv_u_dst}"

    run_benchmark "mv 10MB file" \
        "cp '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_mv_10m_gnu_src && $GNU_TOOL /tmp/bench_mv_10m_gnu_src /tmp/bench_mv_10m_gnu_dst && rm -f /tmp/bench_mv_10m_gnu_dst" \
        "cp '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_mv_10m_f_src && $F_TOOL /tmp/bench_mv_10m_f_src /tmp/bench_mv_10m_f_dst && rm -f /tmp/bench_mv_10m_f_dst" \
        "${U_TOOL:+cp '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_mv_10m_u_src && $U_TOOL /tmp/bench_mv_10m_u_src /tmp/bench_mv_10m_u_dst && rm -f /tmp/bench_mv_10m_u_dst}"

    # Cleanup (in case any remain)
    rm -f /tmp/bench_mv_gnu_src /tmp/bench_mv_gnu_dst /tmp/bench_mv_f_src /tmp/bench_mv_f_dst /tmp/bench_mv_u_src /tmp/bench_mv_u_dst
    rm -f /tmp/bench_mv_10m_gnu_src /tmp/bench_mv_10m_gnu_dst /tmp/bench_mv_10m_f_src /tmp/bench_mv_10m_f_dst /tmp/bench_mv_10m_u_src /tmp/bench_mv_10m_u_dst

    save_benchmark_results
}

run_mv_benchmarks
