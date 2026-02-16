#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="dd"
F_TOOL="fdd"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/dd}"

run_dd_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dd","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/dd_benchmark.json"
        return 0
    fi

    init_benchmark "dd"

    echo ""
    echo "=== Read file to /dev/null ==="

    run_benchmark "dd read 10MB (bs=4096)" \
        "$GNU_TOOL if='$TEST_DATA_DIR/text_10m.txt' of=/dev/null bs=4096 2>/dev/null" \
        "$F_TOOL if='$TEST_DATA_DIR/text_10m.txt' of=/dev/null bs=4096 2>/dev/null" \
        "${U_TOOL:+$U_TOOL if='$TEST_DATA_DIR/text_10m.txt' of=/dev/null bs=4096 2>/dev/null}"

    echo ""
    echo "=== Write from /dev/zero ==="

    run_benchmark "dd write 10MB from /dev/zero (bs=1M count=10)" \
        "$GNU_TOOL if=/dev/zero of=/tmp/bench_dd_gnu bs=1M count=10 2>/dev/null && rm -f /tmp/bench_dd_gnu" \
        "$F_TOOL if=/dev/zero of=/tmp/bench_dd_f bs=1M count=10 2>/dev/null && rm -f /tmp/bench_dd_f" \
        "${U_TOOL:+$U_TOOL if=/dev/zero of=/tmp/bench_dd_u bs=1M count=10 2>/dev/null && rm -f /tmp/bench_dd_u}"

    # Cleanup
    rm -f /tmp/bench_dd_gnu /tmp/bench_dd_f /tmp/bench_dd_u

    save_benchmark_results
}

run_dd_benchmarks
