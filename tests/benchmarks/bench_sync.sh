#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sync"
F_TOOL="fsync"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/sync}"

run_sync_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sync","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/sync_benchmark.json"
        return 0
    fi

    init_benchmark "sync"

    echo ""
    echo "=== Sync all filesystems ==="

    run_benchmark "sync (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    save_benchmark_results
}

run_sync_benchmarks
