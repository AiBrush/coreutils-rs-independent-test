#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="touch"
F_TOOL="ftouch"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/touch}"

run_touch_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"touch","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/touch_benchmark.json"
        return 0
    fi

    init_benchmark "touch"

    echo ""
    echo "=== Touch new file ==="

    run_benchmark "create new file" \
        "rm -f /tmp/bench_touch_gnu && $GNU_TOOL /tmp/bench_touch_gnu" \
        "rm -f /tmp/bench_touch_f && $F_TOOL /tmp/bench_touch_f" \
        "${U_TOOL:+rm -f /tmp/bench_touch_u && $U_TOOL /tmp/bench_touch_u}"

    echo ""
    echo "=== Touch existing file ==="

    run_benchmark "update existing file timestamp" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    echo ""
    echo "=== Touch with timestamp (-t) ==="

    run_benchmark "set specific timestamp (-t)" \
        "rm -f /tmp/bench_touch_t_gnu && $GNU_TOOL -t 202301011200.00 /tmp/bench_touch_t_gnu" \
        "rm -f /tmp/bench_touch_t_f && $F_TOOL -t 202301011200.00 /tmp/bench_touch_t_f" \
        "${U_TOOL:+rm -f /tmp/bench_touch_t_u && $U_TOOL -t 202301011200.00 /tmp/bench_touch_t_u}"

    # Cleanup
    rm -f /tmp/bench_touch_gnu /tmp/bench_touch_f /tmp/bench_touch_u
    rm -f /tmp/bench_touch_t_gnu /tmp/bench_touch_t_f /tmp/bench_touch_t_u

    save_benchmark_results
}

run_touch_benchmarks
