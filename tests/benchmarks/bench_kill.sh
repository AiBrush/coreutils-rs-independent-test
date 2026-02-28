#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="kill"
F_TOOL="fkill"

run_kill_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"kill","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/kill_benchmark.json"
        return 0
    fi

    init_benchmark "kill"

    echo ""
    echo "=== List signals ==="

    run_benchmark "kill -l (list signals)" \
        "$GNU_TOOL -l" \
        "$F_TOOL -l"

    save_benchmark_results
}

run_kill_benchmarks
