#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="ls"
F_TOOL="fls"

run_ls_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"ls","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/ls_benchmark.json"
        return 0
    fi

    init_benchmark "ls"

    echo ""
    echo "=== Default listing ==="

    run_benchmark "ls current directory" \
        "$GNU_TOOL ." \
        "$F_TOOL ."

    echo ""
    echo "=== Many files ==="

    run_benchmark "100 files" \
        "$GNU_TOOL '$TEST_DATA_DIR/many_files'" \
        "$F_TOOL '$TEST_DATA_DIR/many_files'"

    echo ""
    echo "=== Long format ==="

    run_benchmark "-la 100 files" \
        "$GNU_TOOL -la '$TEST_DATA_DIR/many_files'" \
        "$F_TOOL -la '$TEST_DATA_DIR/many_files'"

    run_benchmark "-la test data dir" \
        "$GNU_TOOL -la '$TEST_DATA_DIR'" \
        "$F_TOOL -la '$TEST_DATA_DIR'"

    echo ""
    echo "=== Recursive ==="

    run_benchmark "-R test data" \
        "$GNU_TOOL -R '$TEST_DATA_DIR/many_files'" \
        "$F_TOOL -R '$TEST_DATA_DIR/many_files'"

    echo ""
    echo "=== Sort by time ==="

    run_benchmark "-lt 100 files" \
        "$GNU_TOOL -lt '$TEST_DATA_DIR/many_files'" \
        "$F_TOOL -lt '$TEST_DATA_DIR/many_files'"

    echo ""
    echo "=== Sort by size ==="

    run_benchmark "-lS test data dir" \
        "$GNU_TOOL -lS '$TEST_DATA_DIR'" \
        "$F_TOOL -lS '$TEST_DATA_DIR'"

    save_benchmark_results
}

run_ls_benchmarks
