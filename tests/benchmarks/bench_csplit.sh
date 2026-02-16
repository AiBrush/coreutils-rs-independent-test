#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="csplit"
F_TOOL="fcsplit"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/csplit}"

run_csplit_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"csplit","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/csplit_benchmark.json"
        return 0
    fi

    init_benchmark "csplit"

    echo ""
    echo "=== Split by pattern ==="

    run_benchmark "csplit 1MB by pattern" \
        "rm -f /tmp/bench_csplit_gnu_* && $GNU_TOOL -z --prefix=/tmp/bench_csplit_gnu_ '$TEST_DATA_DIR/text_1m.txt' '/the/' '{*}' 2>/dev/null" \
        "rm -f /tmp/bench_csplit_f_* && $F_TOOL -z --prefix=/tmp/bench_csplit_f_ '$TEST_DATA_DIR/text_1m.txt' '/the/' '{*}' 2>/dev/null" \
        "${U_TOOL:+rm -f /tmp/bench_csplit_u_* && $U_TOOL -z --prefix=/tmp/bench_csplit_u_ '$TEST_DATA_DIR/text_1m.txt' '/the/' '{*}' 2>/dev/null}"

    # Cleanup
    rm -f /tmp/bench_csplit_gnu_* /tmp/bench_csplit_f_* /tmp/bench_csplit_u_*

    save_benchmark_results
}

run_csplit_benchmarks
