#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="expand"
F_TOOL="fexpand"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/expand}"

run_expand_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"expand","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/expand_benchmark.json"
        return 0
    fi

    init_benchmark "expand"

    echo ""
    echo "=== Default tab expansion (8 spaces) ==="

    if [[ -f "$TEST_DATA_DIR/tabbed_10m.txt" ]]; then
        run_benchmark "expand 10MB tabbed (default)" \
            "$GNU_TOOL '$TEST_DATA_DIR/tabbed_10m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/tabbed_10m.txt'" \
            "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/tabbed_10m.txt'}"
    fi

    run_benchmark "expand 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    echo ""
    echo "=== Custom tab stops ==="

    if [[ -f "$TEST_DATA_DIR/tabbed_10m.txt" ]]; then
        run_benchmark "-t 4 10MB tabbed" \
            "$GNU_TOOL -t 4 '$TEST_DATA_DIR/tabbed_10m.txt'" \
            "$F_TOOL -t 4 '$TEST_DATA_DIR/tabbed_10m.txt'" \
            "${U_TOOL:+$U_TOOL -t 4 '$TEST_DATA_DIR/tabbed_10m.txt'}"

        run_benchmark "-t 2 10MB tabbed" \
            "$GNU_TOOL -t 2 '$TEST_DATA_DIR/tabbed_10m.txt'" \
            "$F_TOOL -t 2 '$TEST_DATA_DIR/tabbed_10m.txt'" \
            "${U_TOOL:+$U_TOOL -t 2 '$TEST_DATA_DIR/tabbed_10m.txt'}"
    fi

    echo ""
    echo "=== Initial only ==="

    if [[ -f "$TEST_DATA_DIR/tabbed_10m.txt" ]]; then
        run_benchmark "--initial 10MB tabbed" \
            "$GNU_TOOL --initial '$TEST_DATA_DIR/tabbed_10m.txt'" \
            "$F_TOOL --initial '$TEST_DATA_DIR/tabbed_10m.txt'" \
            "${U_TOOL:+$U_TOOL --initial '$TEST_DATA_DIR/tabbed_10m.txt'}"
    fi

    echo ""
    echo "=== TSV data ==="

    run_benchmark "expand CSV 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL '$TEST_DATA_DIR/csv_10m.csv'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/csv_10m.csv'}"

    save_benchmark_results
}

run_expand_benchmarks
