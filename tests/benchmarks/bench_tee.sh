#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tee"
F_TOOL="ftee"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/tee}"

run_tee_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tee","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/tee_benchmark.json"
        return 0
    fi

    init_benchmark "tee"

    echo ""
    echo "=== Pipe through tee to /dev/null ==="

    run_stdin_benchmark "tee 1MB to /dev/null" \
        "$TEST_DATA_DIR/text_1m.txt" \
        "$GNU_TOOL /dev/null > /dev/null" \
        "$F_TOOL /dev/null > /dev/null" \
        "${U_TOOL:+$U_TOOL /dev/null > /dev/null}"

    run_stdin_benchmark "tee 10MB to /dev/null" \
        "$TEST_DATA_DIR/text_10m.txt" \
        "$GNU_TOOL /dev/null > /dev/null" \
        "$F_TOOL /dev/null > /dev/null" \
        "${U_TOOL:+$U_TOOL /dev/null > /dev/null}"

    save_benchmark_results
}

run_tee_benchmarks
