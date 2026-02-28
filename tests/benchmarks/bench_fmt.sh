#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="fmt"
F_TOOL="ffmt"

run_fmt_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"fmt","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/fmt_benchmark.json"
        return 0
    fi

    init_benchmark "fmt"

    echo ""
    echo "=== Default formatting (width 75) ==="

    run_benchmark "fmt 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    run_benchmark "fmt 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'"

    echo ""
    echo "=== Custom width ==="

    run_benchmark "-w 40 10MB" \
        "$GNU_TOOL -w 40 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -w 40 '$TEST_DATA_DIR/text_10m.txt'"

    run_benchmark "-w 120 10MB" \
        "$GNU_TOOL -w 120 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -w 120 '$TEST_DATA_DIR/text_10m.txt'"

    echo ""
    echo "=== Wide lines ==="

    if [[ -f "$TEST_DATA_DIR/wide_lines_10m.txt" ]]; then
        run_benchmark "fmt wide lines 10MB" \
            "$GNU_TOOL '$TEST_DATA_DIR/wide_lines_10m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/wide_lines_10m.txt'"
    fi

    save_benchmark_results
}

run_fmt_benchmarks
