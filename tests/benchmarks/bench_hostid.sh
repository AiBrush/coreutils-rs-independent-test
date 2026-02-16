#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="hostid"
F_TOOL="fhostid"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/hostid}"

run_hostid_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"hostid","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/hostid_benchmark.json"
        return 0
    fi

    init_benchmark "hostid"

    echo ""
    echo "=== Startup/execution overhead ==="

    run_benchmark "hostid (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    save_benchmark_results
}

run_hostid_benchmarks
