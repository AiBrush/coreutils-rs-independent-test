#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="du"
F_TOOL="fdu"

run_du_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"du","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/du_benchmark.json"
        return 0
    fi

    init_benchmark "du"

    echo ""
    echo "=== Default ==="

    run_benchmark "du test data dir" \
        "$GNU_TOOL '$TEST_DATA_DIR'" \
        "$F_TOOL '$TEST_DATA_DIR'"

    echo ""
    echo "=== Summary ==="

    run_benchmark "-s (summary)" \
        "$GNU_TOOL -s '$TEST_DATA_DIR'" \
        "$F_TOOL -s '$TEST_DATA_DIR'"

    echo ""
    echo "=== Human readable ==="

    run_benchmark "-sh (human summary)" \
        "$GNU_TOOL -sh '$TEST_DATA_DIR'" \
        "$F_TOOL -sh '$TEST_DATA_DIR'"

    echo ""
    echo "=== Max depth ==="

    run_benchmark "--max-depth=1" \
        "$GNU_TOOL --max-depth=1 '$TEST_DATA_DIR'" \
        "$F_TOOL --max-depth=1 '$TEST_DATA_DIR'"

    echo ""
    echo "=== Bytes ==="

    run_benchmark "-b (bytes)" \
        "$GNU_TOOL -b '$TEST_DATA_DIR'" \
        "$F_TOOL -b '$TEST_DATA_DIR'"

    save_benchmark_results
}

run_du_benchmarks
