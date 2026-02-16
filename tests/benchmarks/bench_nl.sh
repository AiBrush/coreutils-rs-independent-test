#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="nl"
F_TOOL="fnl"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/nl}"

run_nl_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nl","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/nl_benchmark.json"
        return 0
    fi

    init_benchmark "nl"

    echo ""
    echo "=== Default numbering ==="

    run_benchmark "default 1MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "default 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Number all lines (-b a) ==="

    run_benchmark "-b a 10MB" \
        "$GNU_TOOL -b a '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -b a '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -b a '$TEST_DATA_DIR/text_10m.txt'}"

    if [[ -f "$TEST_DATA_DIR/nl_bench_10m.txt" ]]; then
        run_benchmark "-b a 10MB with blanks" \
            "$GNU_TOOL -b a '$TEST_DATA_DIR/nl_bench_10m.txt'" \
            "$F_TOOL -b a '$TEST_DATA_DIR/nl_bench_10m.txt'" \
            "${U_TOOL:+$U_TOOL -b a '$TEST_DATA_DIR/nl_bench_10m.txt'}"
    fi

    echo ""
    echo "=== Zero-padded format ==="

    run_benchmark "-b a -n rz 10MB" \
        "$GNU_TOOL -b a -n rz '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -b a -n rz '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -b a -n rz '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Custom width and separator ==="

    run_benchmark "-b a -w 8 -s ': ' 10MB" \
        "$GNU_TOOL -b a -w 8 -s ': ' '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -b a -w 8 -s ': ' '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -b a -w 8 -s ': ' '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Regex pattern numbering ==="

    run_benchmark "-b p'^the' 10MB" \
        "$GNU_TOOL -b 'p^the' '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -b 'p^the' '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL -b 'p^the' '$TEST_DATA_DIR/text_10m.txt'}"

    save_benchmark_results
}

run_nl_benchmarks
