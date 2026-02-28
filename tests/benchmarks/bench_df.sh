#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="df"
F_TOOL="fdf"

run_df_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"df","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/df_benchmark.json"
        return 0
    fi

    init_benchmark "df"

    echo ""
    echo "=== Default output ==="

    run_benchmark "df (default)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    echo ""
    echo "=== Human readable ==="

    run_benchmark "-h (human readable)" \
        "$GNU_TOOL -h" \
        "$F_TOOL -h"

    echo ""
    echo "=== Specific path ==="

    run_benchmark "df /" \
        "$GNU_TOOL /" \
        "$F_TOOL /"

    echo ""
    echo "=== Inode info ==="

    run_benchmark "-i (inodes)" \
        "$GNU_TOOL -i" \
        "$F_TOOL -i"

    save_benchmark_results
}

run_df_benchmarks
