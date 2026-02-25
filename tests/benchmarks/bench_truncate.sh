#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="truncate"
F_TOOL="ftruncate"

run_truncate_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"truncate","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/truncate_benchmark.json"
        return 0
    fi

    init_benchmark "truncate"

    echo ""
    echo "=== Truncate to zero ==="

    run_benchmark "truncate to zero (-s 0)" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_truncate_gnu && $GNU_TOOL -s 0 /tmp/bench_truncate_gnu" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_truncate_f && $F_TOOL -s 0 /tmp/bench_truncate_f" \

    echo ""
    echo "=== Truncate to specific size ==="

    run_benchmark "create 1M file (-s 1M)" \
        "rm -f /tmp/bench_truncate_1m_gnu && $GNU_TOOL -s 1M /tmp/bench_truncate_1m_gnu" \
        "rm -f /tmp/bench_truncate_1m_f && $F_TOOL -s 1M /tmp/bench_truncate_1m_f" \

    # Cleanup
    rm -f /tmp/bench_truncate_gnu /tmp/bench_truncate_f /tmp/bench_truncate_u
    rm -f /tmp/bench_truncate_1m_gnu /tmp/bench_truncate_1m_f /tmp/bench_truncate_1m_u

    save_benchmark_results
}

run_truncate_benchmarks
