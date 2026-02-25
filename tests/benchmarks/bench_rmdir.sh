#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="rmdir"
F_TOOL="frmdir"

run_rmdir_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"rmdir","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/rmdir_benchmark.json"
        return 0
    fi

    init_benchmark "rmdir"

    echo ""
    echo "=== Remove single directory ==="

    run_benchmark "rmdir single empty directory" \
        "mkdir -p /tmp/bench_rmdir_gnu && $GNU_TOOL /tmp/bench_rmdir_gnu" \
        "mkdir -p /tmp/bench_rmdir_f && $F_TOOL /tmp/bench_rmdir_f" \

    echo ""
    echo "=== Remove nested directories (-p) ==="

    run_benchmark "rmdir -p nested directories" \
        "mkdir -p /tmp/bench_rmdir_p_gnu/a/b/c && $GNU_TOOL -p /tmp/bench_rmdir_p_gnu/a/b/c" \
        "mkdir -p /tmp/bench_rmdir_p_f/a/b/c && $F_TOOL -p /tmp/bench_rmdir_p_f/a/b/c" \

    # Cleanup (in case any remain)
    rm -rf /tmp/bench_rmdir_gnu /tmp/bench_rmdir_f /tmp/bench_rmdir_u
    rm -rf /tmp/bench_rmdir_p_gnu /tmp/bench_rmdir_p_f /tmp/bench_rmdir_p_u

    save_benchmark_results
}

run_rmdir_benchmarks
