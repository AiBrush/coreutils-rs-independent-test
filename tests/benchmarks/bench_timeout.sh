#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="timeout"
F_TOOL="ftimeout"

run_timeout_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"timeout","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/timeout_benchmark.json"
        return 0
    fi

    init_benchmark "timeout"

    echo ""
    echo "=== Startup overhead ==="

    run_benchmark "timeout 10 true" \
        "$GNU_TOOL 10 true" \
        "$F_TOOL 10 true"

    run_benchmark "timeout 10 echo hello" \
        "$GNU_TOOL 10 echo hello" \
        "$F_TOOL 10 echo hello"

    save_benchmark_results
}

run_timeout_benchmarks
