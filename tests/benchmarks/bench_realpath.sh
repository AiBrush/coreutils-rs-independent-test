#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="realpath"
F_TOOL="frealpath"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/realpath}"

run_realpath_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"realpath","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/realpath_benchmark.json"
        return 0
    fi

    init_benchmark "realpath"

    echo ""
    echo "=== Resolve current directory ==="

    run_benchmark "realpath ." \
        "$GNU_TOOL ." \
        "$F_TOOL ." \
        "${U_TOOL:+$U_TOOL .}"

    echo ""
    echo "=== Resolve absolute path ==="

    run_benchmark "realpath /tmp" \
        "$GNU_TOOL /tmp" \
        "$F_TOOL /tmp" \
        "${U_TOOL:+$U_TOOL /tmp}"

    echo ""
    echo "=== Resolve file path ==="

    run_benchmark "realpath test data file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    save_benchmark_results
}

run_realpath_benchmarks
