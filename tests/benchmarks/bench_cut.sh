#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="cut"
F_TOOL="fcut"
CLAIMED="10x"

run_cut_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cut","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/cut_benchmark.json"
        return 0
    fi

    init_benchmark "cut"

    echo ""
    echo "=== Byte Range ==="

    run_benchmark "-b1-100 10MB CSV" \
        "$GNU_TOOL -b1-100 '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL -b1-100 '$TEST_DATA_DIR/csv_10m.csv'" "$CLAIMED"

    echo ""
    echo "=== Character Range ==="

    run_benchmark "-c1-100 10MB CSV" \
        "$GNU_TOOL -c1-100 '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL -c1-100 '$TEST_DATA_DIR/csv_10m.csv'" "$CLAIMED"

    echo ""
    echo "=== Field Extraction ==="

    run_benchmark "-d, -f1 10MB CSV" \
        "$GNU_TOOL -d, -f1 '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL -d, -f1 '$TEST_DATA_DIR/csv_10m.csv'" "$CLAIMED"

    run_benchmark "-d, -f1,3,5 10MB CSV" \
        "$GNU_TOOL -d, -f1,3,5 '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL -d, -f1,3,5 '$TEST_DATA_DIR/csv_10m.csv'" "$CLAIMED"

    run_benchmark "-d, -f2-4 10MB CSV" \
        "$GNU_TOOL -d, -f2-4 '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL -d, -f2-4 '$TEST_DATA_DIR/csv_10m.csv'" "$CLAIMED"

    echo ""
    echo "=== Complement ==="

    run_benchmark "--complement -d, -f1 10MB CSV" \
        "$GNU_TOOL -d, -f1 --complement '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL -d, -f1 --complement '$TEST_DATA_DIR/csv_10m.csv'" "$CLAIMED"

    echo ""
    echo "=== Different file sizes ==="

    run_benchmark "-d, -f1 100KB text" \
        "$GNU_TOOL -d, -f1 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f1 '$TEST_DATA_DIR/simple.csv'" "$CLAIMED"

    run_benchmark "-d, -f1 1MB text" \
        "$GNU_TOOL -d' ' -f1 '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -d' ' -f1 '$TEST_DATA_DIR/text_1m.txt'" "$CLAIMED"

    echo ""
    echo "=== Colon-delimited (passwd-style) ==="

    run_benchmark "-d: -f1 colon file" \
        "$GNU_TOOL -d: -f1 '$TEST_DATA_DIR/colon_delimited.txt'" \
        "$F_TOOL -d: -f1 '$TEST_DATA_DIR/colon_delimited.txt'" "$CLAIMED"

    save_benchmark_results "$CLAIMED"
}

run_cut_benchmarks
