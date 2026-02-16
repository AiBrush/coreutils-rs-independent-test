#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="test"
F_TOOL="ftest"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/test}"

run_test_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"test","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/test_benchmark.json"
        return 0
    fi

    init_benchmark "test"

    echo ""
    echo "=== File exists check ==="

    run_benchmark "test -f (file exists)" \
        "$GNU_TOOL -f '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -f '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL -f '$TEST_DATA_DIR/text_1m.txt'}"

    echo ""
    echo "=== Integer comparison ==="

    run_benchmark "test 1 -eq 1" \
        "$GNU_TOOL 1 -eq 1" \
        "$F_TOOL 1 -eq 1" \
        "${U_TOOL:+$U_TOOL 1 -eq 1}"

    echo ""
    echo "=== String comparison ==="

    run_benchmark "test 'hello' = 'hello'" \
        "$GNU_TOOL 'hello' = 'hello'" \
        "$F_TOOL 'hello' = 'hello'" \
        "${U_TOOL:+$U_TOOL 'hello' = 'hello'}"

    echo ""
    echo "=== Directory check ==="

    run_benchmark "test -d /tmp" \
        "$GNU_TOOL -d /tmp" \
        "$F_TOOL -d /tmp" \
        "${U_TOOL:+$U_TOOL -d /tmp}"

    save_benchmark_results
}

run_test_benchmarks
