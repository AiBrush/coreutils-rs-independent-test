#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="chown"
F_TOOL="fchown"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/chown}"

run_chown_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chown","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/chown_benchmark.json"
        return 0
    fi

    init_benchmark "chown"

    local CURRENT_USER
    CURRENT_USER=$(id -un)

    echo ""
    echo "=== chown to current user ==="

    run_benchmark "chown current user on file" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chown_gnu && $GNU_TOOL $CURRENT_USER /tmp/bench_chown_gnu" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chown_f && $F_TOOL $CURRENT_USER /tmp/bench_chown_f" \
        "${U_TOOL:+cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chown_u && $U_TOOL $CURRENT_USER /tmp/bench_chown_u}"

    run_benchmark "chown current user on 1MB file" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_chown_1m_gnu && $GNU_TOOL $CURRENT_USER /tmp/bench_chown_1m_gnu" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_chown_1m_f && $F_TOOL $CURRENT_USER /tmp/bench_chown_1m_f" \
        "${U_TOOL:+cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_chown_1m_u && $U_TOOL $CURRENT_USER /tmp/bench_chown_1m_u}"

    # Cleanup
    rm -f /tmp/bench_chown_gnu /tmp/bench_chown_f /tmp/bench_chown_u
    rm -f /tmp/bench_chown_1m_gnu /tmp/bench_chown_1m_f /tmp/bench_chown_1m_u

    save_benchmark_results
}

run_chown_benchmarks
