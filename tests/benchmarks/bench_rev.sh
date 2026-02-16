#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="rev"
F_TOOL="frev"
# rev is not in uutils/coreutils (it's from util-linux)
U_TOOL=""

run_rev_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"rev","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/rev_benchmark.json"
        return 0
    fi

    init_benchmark "rev"

    echo ""
    echo "=== Various file sizes ==="

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
    echo "=== Long lines ==="

    run_benchmark "reverse 10KB single line" \
        "$GNU_TOOL '$TEST_DATA_DIR/long_line_10k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/long_line_10k.txt'"

    save_benchmark_results
}

run_rev_benchmarks
