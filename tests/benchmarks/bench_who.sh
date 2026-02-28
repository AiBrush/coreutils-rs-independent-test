#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="who"
F_TOOL="fwho"

run_who_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"who","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/who_benchmark.json"
        return 0
    fi

    init_benchmark "who"

    echo ""
    echo "=== Default output ==="

    run_benchmark "who (default)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    echo ""
    echo "=== All users ==="

    run_benchmark "who -a (all)" \
        "$GNU_TOOL -a" \
        "$F_TOOL -a"

    echo ""
    echo "=== Boot time ==="

    run_benchmark "who -b (boot)" \
        "$GNU_TOOL -b" \
        "$F_TOOL -b"

    save_benchmark_results
}

run_who_benchmarks
