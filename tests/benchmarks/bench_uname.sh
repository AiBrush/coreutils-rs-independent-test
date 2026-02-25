#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="uname"
F_TOOL="funame"

run_uname_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"uname","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/uname_benchmark.json"
        return 0
    fi

    init_benchmark "uname"

    echo ""
    echo "=== Startup/execution overhead ==="

    run_benchmark "uname (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL" \

    run_benchmark "uname -a" \
        "$GNU_TOOL -a" \
        "$F_TOOL -a" \

    run_benchmark "uname -r" \
        "$GNU_TOOL -r" \
        "$F_TOOL -r" \

    run_benchmark "uname -m" \
        "$GNU_TOOL -m" \
        "$F_TOOL -m" \

    save_benchmark_results
}

run_uname_benchmarks
