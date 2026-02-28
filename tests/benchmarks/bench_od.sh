#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="od"
F_TOOL="fod"

run_od_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"od","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/od_benchmark.json"
        return 0
    fi

    init_benchmark "od"

    echo ""
    echo "=== Default (octal bytes) ==="

    run_benchmark "default 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Hex output ==="

    run_benchmark "-A x -t x1z 1MB" \
        "$GNU_TOOL -A x -t x1z '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -A x -t x1z '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Character output ==="

    run_benchmark "-c 1MB text" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Binary data ==="

    run_benchmark "default 10MB binary" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_10m.bin'"

    echo ""
    echo "=== Limited output ==="

    run_benchmark "-N 10000 10MB" \
        "$GNU_TOOL -N 10000 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -N 10000 '$TEST_DATA_DIR/text_10m.txt'"

    save_benchmark_results
}

run_od_benchmarks
