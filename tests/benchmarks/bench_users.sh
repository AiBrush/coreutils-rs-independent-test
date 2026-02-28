#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="users"
F_TOOL="fusers"

run_users_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"users","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/users_benchmark.json"
        return 0
    fi

    init_benchmark "users"

    echo ""
    echo "=== Default output ==="

    run_benchmark "users (default)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    save_benchmark_results
}

run_users_benchmarks
