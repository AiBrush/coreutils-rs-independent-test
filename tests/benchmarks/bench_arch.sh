#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="arch"
F_TOOL="farch"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/arch}"

run_arch_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"arch","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/arch_benchmark.json"
        return 0
    fi

    init_benchmark "arch"

    echo ""
    echo "=== Startup/execution overhead ==="

    run_benchmark "arch (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    save_benchmark_results
}

run_arch_benchmarks
