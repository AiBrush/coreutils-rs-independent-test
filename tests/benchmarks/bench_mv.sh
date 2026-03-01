#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mv"
F_TOOL="fmv"

run_mv_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mv","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/mv_benchmark.json"
        return 0
    fi

    init_benchmark "mv"

    echo ""
    echo "=== Move small file (same filesystem) ==="

    run_benchmark "mv same-fs small (1MB)" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_mv_gnu_src && $GNU_TOOL /tmp/bench_mv_gnu_src /tmp/bench_mv_gnu_dst && rm -f /tmp/bench_mv_gnu_dst" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_mv_f_src && $F_TOOL /tmp/bench_mv_f_src /tmp/bench_mv_f_dst && rm -f /tmp/bench_mv_f_dst" \

    echo ""
    echo "=== Move large file (same filesystem) ==="

    run_benchmark "mv same-fs large (10MB)" \
        "cp '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_mv_10m_gnu_src && $GNU_TOOL /tmp/bench_mv_10m_gnu_src /tmp/bench_mv_10m_gnu_dst && rm -f /tmp/bench_mv_10m_gnu_dst" \
        "cp '$TEST_DATA_DIR/text_10m.txt' /tmp/bench_mv_10m_f_src && $F_TOOL /tmp/bench_mv_10m_f_src /tmp/bench_mv_10m_f_dst && rm -f /tmp/bench_mv_10m_f_dst" \

    echo ""
    echo "=== Move many files ==="

    # Create a directory of many small files for each benchmark iteration
    # Since mv is destructive, each run needs fresh files
    run_benchmark "mv many files (100 files)" \
        "d=/tmp/bench_mv_many_gnu_\$\$; mkdir -p \$d/src \$d/dst; for i in \$(seq 1 100); do echo x > \$d/src/f\$i; done; $GNU_TOOL \$d/src/* \$d/dst/; rm -rf \$d" \
        "d=/tmp/bench_mv_many_f_\$\$; mkdir -p \$d/src \$d/dst; for i in \$(seq 1 100); do echo x > \$d/src/f\$i; done; $F_TOOL \$d/src/* \$d/dst/; rm -rf \$d" \

    # Cleanup (in case any remain)
    rm -f /tmp/bench_mv_gnu_src /tmp/bench_mv_gnu_dst /tmp/bench_mv_f_src /tmp/bench_mv_f_dst /tmp/bench_mv_u_src /tmp/bench_mv_u_dst
    rm -f /tmp/bench_mv_10m_gnu_src /tmp/bench_mv_10m_gnu_dst /tmp/bench_mv_10m_f_src /tmp/bench_mv_10m_f_dst /tmp/bench_mv_10m_u_src /tmp/bench_mv_10m_u_dst
    rm -rf /tmp/bench_mv_many_gnu_* /tmp/bench_mv_many_f_*

    save_benchmark_results
}

run_mv_benchmarks
