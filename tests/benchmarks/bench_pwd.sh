#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="pwd"
F_TOOL="fpwd"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/pwd}"

run_pwd_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pwd","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/pwd_benchmark.json"
        return 0
    fi

    init_benchmark "pwd"

    echo ""
    echo "=== Startup/execution overhead ==="

    run_benchmark "pwd (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    run_benchmark "pwd -L" \
        "$GNU_TOOL -L" \
        "$F_TOOL -L" \
        "${U_TOOL:+$U_TOOL -L}"

    run_benchmark "pwd -P" \
        "$GNU_TOOL -P" \
        "$F_TOOL -P" \
        "${U_TOOL:+$U_TOOL -P}"

    save_benchmark_results
}

run_pwd_benchmarks
