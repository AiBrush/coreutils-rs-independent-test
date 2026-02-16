#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mkdir"
F_TOOL="fmkdir"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/mkdir}"

run_mkdir_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mkdir","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/mkdir_benchmark.json"
        return 0
    fi

    init_benchmark "mkdir"

    echo ""
    echo "=== Create single directory ==="

    run_benchmark "mkdir single directory" \
        "rm -rf /tmp/bench_mkdir_gnu && $GNU_TOOL /tmp/bench_mkdir_gnu" \
        "rm -rf /tmp/bench_mkdir_f && $F_TOOL /tmp/bench_mkdir_f" \
        "${U_TOOL:+rm -rf /tmp/bench_mkdir_u && $U_TOOL /tmp/bench_mkdir_u}"

    echo ""
    echo "=== Create nested directories (-p) ==="

    run_benchmark "mkdir -p nested directories" \
        "rm -rf /tmp/bench_mkdir_p_gnu && $GNU_TOOL -p /tmp/bench_mkdir_p_gnu/a/b/c/d/e" \
        "rm -rf /tmp/bench_mkdir_p_f && $F_TOOL -p /tmp/bench_mkdir_p_f/a/b/c/d/e" \
        "${U_TOOL:+rm -rf /tmp/bench_mkdir_p_u && $U_TOOL -p /tmp/bench_mkdir_p_u/a/b/c/d/e}"

    # Cleanup
    rm -rf /tmp/bench_mkdir_gnu /tmp/bench_mkdir_f /tmp/bench_mkdir_u
    rm -rf /tmp/bench_mkdir_p_gnu /tmp/bench_mkdir_p_f /tmp/bench_mkdir_p_u

    save_benchmark_results
}

run_mkdir_benchmarks
