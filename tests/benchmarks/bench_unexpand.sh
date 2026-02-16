#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="unexpand"
F_TOOL="funexpand"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/unexpand}"

run_unexpand_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"unexpand","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/unexpand_benchmark.json"
        return 0
    fi

    init_benchmark "unexpand"

    echo ""
    echo "=== Default (leading spaces to tabs) ==="

    run_benchmark "unexpand 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "unexpand 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== All spaces (-a) ==="

    run_benchmark "-a 1MB text" \
        "$GNU_TOOL -a '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -a '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL -a '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "-a 10MB text" \
        "$GNU_TOOL -a '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -a '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -a '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Custom tab stop ==="

    run_benchmark "-t 4 10MB text" \
        "$GNU_TOOL -t 4 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -t 4 '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -t 4 '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Expanded tabbed content ==="

    if [[ -f "$TEST_DATA_DIR/tabbed_10m.txt" ]]; then
        # Expand first then unexpand (realistic pipeline)
        run_stdin_benchmark "expand|unexpand pipeline 10MB" \
            "$TEST_DATA_DIR/tabbed_10m.txt" \
            "expand | $GNU_TOOL -a" \
            "expand | $F_TOOL -a" \
            "${U_TOOL:+expand | $U_TOOL -a}"
    fi

    save_benchmark_results
}

run_unexpand_benchmarks
