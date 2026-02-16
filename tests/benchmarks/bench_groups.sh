#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="groups"
F_TOOL="fgroups"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/groups}"

run_groups_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"groups","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/groups_benchmark.json"
        return 0
    fi

    init_benchmark "groups"

    echo ""
    echo "=== Startup/execution overhead ==="

    run_benchmark "groups (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    save_benchmark_results
}

run_groups_benchmarks
