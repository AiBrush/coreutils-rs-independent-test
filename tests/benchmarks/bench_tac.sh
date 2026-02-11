#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tac"
F_TOOL="ftac"
run_tac_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tac","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/tac_benchmark.json"
        return 0
    fi

    init_benchmark "tac"

    echo ""
    echo "=== Line reversal (various sizes) ==="

    run_benchmark "reverse 100KB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_100k.txt'"

    run_benchmark "reverse 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    run_benchmark "reverse 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'"

    if [[ -f "$TEST_DATA_DIR/text_100m.txt" ]]; then
        run_benchmark "reverse 100MB text" \
            "$GNU_TOOL '$TEST_DATA_DIR/text_100m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/text_100m.txt'"
    fi

    echo ""
    echo "=== Different content types ==="

    run_benchmark "reverse CSV 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL '$TEST_DATA_DIR/csv_10m.csv'"

    run_benchmark "reverse repetitive 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/repetitive_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/repetitive_10m.txt'"

    echo ""
    echo "=== Custom separator ==="

    run_stdin_benchmark "custom separator 1MB" \
        "$TEST_DATA_DIR/text_1m.txt" \
        "$GNU_TOOL -s ' '" \
        "$F_TOOL -s ' '"

    save_benchmark_results
}

run_tac_benchmarks
