#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tr"
F_TOOL="ftr"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/tr}"
run_tr_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tr","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/tr_benchmark.json"
        return 0
    fi

    init_benchmark "tr"

    echo ""
    echo "=== Simple translation ==="

    run_stdin_benchmark "a-z to A-Z 1MB" \
        "$TEST_DATA_DIR/text_1m.txt" \
        "$GNU_TOOL 'a-z' 'A-Z'" \
        "$F_TOOL 'a-z' 'A-Z'" \
        "${U_TOOL:+$U_TOOL 'a-z' 'A-Z'}"

    run_stdin_benchmark "a-z to A-Z 10MB" \
        "$TEST_DATA_DIR/text_10m.txt" \
        "$GNU_TOOL 'a-z' 'A-Z'" \
        "$F_TOOL 'a-z' 'A-Z'" \
        "${U_TOOL:+$U_TOOL 'a-z' 'A-Z'}"

    echo ""
    echo "=== Delete mode (-d) ==="

    run_stdin_benchmark "-d digits 10MB" \
        "$TEST_DATA_DIR/csv_10m.csv" \
        "$GNU_TOOL -d '0-9'" \
        "$F_TOOL -d '0-9'" \
        "${U_TOOL:+$U_TOOL -d '0-9'}"

    run_stdin_benchmark "-d lowercase 10MB" \
        "$TEST_DATA_DIR/text_10m.txt" \
        "$GNU_TOOL -d 'a-z'" \
        "$F_TOOL -d 'a-z'" \
        "${U_TOOL:+$U_TOOL -d 'a-z'}"

    echo ""
    echo "=== Squeeze mode (-s) ==="

    run_stdin_benchmark "-s spaces 10MB" \
        "$TEST_DATA_DIR/text_10m.txt" \
        "$GNU_TOOL -s ' '" \
        "$F_TOOL -s ' '" \
        "${U_TOOL:+$U_TOOL -s ' '}"

    echo ""
    echo "=== Character class translation ==="

    run_stdin_benchmark "[:lower:] to [:upper:] 10MB" \
        "$TEST_DATA_DIR/text_10m.txt" \
        "$GNU_TOOL '[:lower:]' '[:upper:]'" \
        "$F_TOOL '[:lower:]' '[:upper:]'" \
        "${U_TOOL:+$U_TOOL '[:lower:]' '[:upper:]'}"

    run_stdin_benchmark "-d [:digit:] 10MB CSV" \
        "$TEST_DATA_DIR/csv_10m.csv" \
        "$GNU_TOOL -d '[:digit:]'" \
        "$F_TOOL -d '[:digit:]'" \
        "${U_TOOL:+$U_TOOL -d '[:digit:]'}"

    echo ""
    echo "=== Binary data ==="

    run_stdin_benchmark "translate binary 10MB" \
        "$TEST_DATA_DIR/random_10m.bin" \
        "$GNU_TOOL '\\000-\\037' 'X'" \
        "$F_TOOL '\\000-\\037' 'X'" \
        "${U_TOOL:+$U_TOOL '\\000-\\037' 'X'}"

    save_benchmark_results
}

run_tr_benchmarks
