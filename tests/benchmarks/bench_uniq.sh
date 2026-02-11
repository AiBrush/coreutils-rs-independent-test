#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="uniq"
F_TOOL="funiq"
CLAIMED="10x"

run_uniq_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"uniq","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/uniq_benchmark.json"
        return 0
    fi

    init_benchmark "uniq"

    echo ""
    echo "=== Default mode (high duplicate ratio) ==="

    run_benchmark "default 10MB many duplicates" \
        "$GNU_TOOL '$TEST_DATA_DIR/many_duplicates_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/many_duplicates_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Default mode (low duplicate ratio) ==="

    run_benchmark "default 10MB sorted (low dup)" \
        "$GNU_TOOL '$TEST_DATA_DIR/sorted_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/sorted_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Count mode (-c) ==="

    run_benchmark "-c count 10MB many dups" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/many_duplicates_10m.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/many_duplicates_10m.txt'" "$CLAIMED"

    run_benchmark "-c count 10MB sorted" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/sorted_10m.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/sorted_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Duplicate only (-d) ==="

    run_benchmark "-d duplicates only 10MB" \
        "$GNU_TOOL -d '$TEST_DATA_DIR/many_duplicates_10m.txt'" \
        "$F_TOOL -d '$TEST_DATA_DIR/many_duplicates_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Unique only (-u) ==="

    run_benchmark "-u unique only 10MB" \
        "$GNU_TOOL -u '$TEST_DATA_DIR/many_duplicates_10m.txt'" \
        "$F_TOOL -u '$TEST_DATA_DIR/many_duplicates_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Case insensitive (-i) ==="

    run_benchmark "-i case insensitive 10MB" \
        "$GNU_TOOL -i '$TEST_DATA_DIR/sorted_10m.txt'" \
        "$F_TOOL -i '$TEST_DATA_DIR/sorted_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Repetitive content ==="

    run_benchmark "repetitive 10MB" \
        "$GNU_TOOL '$TEST_DATA_DIR/repetitive_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/repetitive_10m.txt'" "$CLAIMED"

    save_benchmark_results "$CLAIMED"
}

run_uniq_benchmarks
