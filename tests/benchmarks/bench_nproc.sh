#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="nproc"
F_TOOL="fnproc"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/nproc}"

run_nproc_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nproc","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/nproc_benchmark.json"
        return 0
    fi

    init_benchmark "nproc"

    echo ""
    echo "=== Startup/execution overhead ==="

    run_benchmark "nproc (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    run_benchmark "nproc --all" \
        "$GNU_TOOL --all" \
        "$F_TOOL --all" \
        "${U_TOOL:+$U_TOOL --all}"

    save_benchmark_results
}

run_nproc_benchmarks
