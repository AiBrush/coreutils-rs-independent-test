#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="pinky"
F_TOOL="fpinky"

run_pinky_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pinky","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/pinky_benchmark.json"
        return 0
    fi

    init_benchmark "pinky"

    echo ""
    echo "=== Default output ==="

    run_benchmark "pinky (default)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    echo ""
    echo "=== Long format ==="

    run_benchmark "pinky -l" \
        "$GNU_TOOL -l" \
        "$F_TOOL -l"

    save_benchmark_results
}

run_pinky_benchmarks
