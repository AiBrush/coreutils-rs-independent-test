#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="vdir"
F_TOOL="fvdir"

run_vdir_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"vdir","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/vdir_benchmark.json"
        return 0
    fi

    init_benchmark "vdir"

    echo ""
    echo "=== Default listing ==="

    run_benchmark "vdir current directory" \
        "$GNU_TOOL ." \
        "$F_TOOL ."

    echo ""
    echo "=== Many files ==="

    run_benchmark "100 files directory" \
        "$GNU_TOOL '$TEST_DATA_DIR/many_files'" \
        "$F_TOOL '$TEST_DATA_DIR/many_files'"

    echo ""
    echo "=== Recursive ==="

    run_benchmark "-R test data" \
        "$GNU_TOOL -R '$TEST_DATA_DIR/many_files'" \
        "$F_TOOL -R '$TEST_DATA_DIR/many_files'"

    save_benchmark_results
}

run_vdir_benchmarks
