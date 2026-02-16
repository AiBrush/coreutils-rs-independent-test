#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tty"
F_TOOL="ftty"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/tty}"

run_tty_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tty","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/tty_benchmark.json"
        return 0
    fi

    init_benchmark "tty"

    echo ""
    echo "=== Startup/execution overhead ==="

    # Note: tty will exit non-zero in CI since there is no terminal,
    # so we wrap all invocations with "|| true".
    run_benchmark "tty (no args)" \
        "$GNU_TOOL || true" \
        "$F_TOOL || true" \
        "${U_TOOL:+$U_TOOL || true}"

    save_benchmark_results
}

run_tty_benchmarks
