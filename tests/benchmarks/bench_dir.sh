#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="dir"
F_TOOL="fdir"

run_dir_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dir","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/dir_benchmark.json"
        return 0
    fi

    init_benchmark "dir"

    echo ""
    echo "=== Default listing ==="

    run_benchmark "dir current directory" \
        "$GNU_TOOL ." \
        "$F_TOOL ."

    echo ""
    echo "=== Many files ==="

    run_benchmark "100 files directory" \
        "$GNU_TOOL '$TEST_DATA_DIR/many_files'" \
        "$F_TOOL '$TEST_DATA_DIR/many_files'"

    run_benchmark "-la 100 files" \
        "$GNU_TOOL -la '$TEST_DATA_DIR/many_files'" \
        "$F_TOOL -la '$TEST_DATA_DIR/many_files'"

    echo ""
    echo "=== Recursive ==="

    run_benchmark "-R test data" \
        "$GNU_TOOL -R '$TEST_DATA_DIR/many_files'" \
        "$F_TOOL -R '$TEST_DATA_DIR/many_files'"

    save_benchmark_results
}

run_dir_benchmarks
