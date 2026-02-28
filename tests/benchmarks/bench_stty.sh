#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="stty"
F_TOOL="fstty"

run_stty_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"stty","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/stty_benchmark.json"
        return 0
    fi

    init_benchmark "stty"

    echo ""
    echo "=== Print all settings ==="

    run_benchmark "stty -a" \
        "$GNU_TOOL -a < /dev/null" \
        "$F_TOOL -a < /dev/null"

    echo ""
    echo "=== Print in stty-readable form ==="

    run_benchmark "stty -g" \
        "$GNU_TOOL -g < /dev/null" \
        "$F_TOOL -g < /dev/null"

    save_benchmark_results
}

run_stty_benchmarks
