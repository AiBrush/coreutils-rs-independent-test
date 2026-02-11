#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="wc"
F_TOOL="fwc"
CLAIMED="30x"

run_wc_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"wc","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/wc_benchmark.json"
        return 0
    fi

    init_benchmark "wc"

    echo ""
    echo "=== Default mode (lines, words, bytes) ==="

    run_benchmark "default 100KB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_100k.txt'" "$CLAIMED"

    run_benchmark "default 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" "$CLAIMED"

    run_benchmark "default 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'" "$CLAIMED"

    if [[ -f "$TEST_DATA_DIR/text_100m.txt" ]]; then
        run_benchmark "default 100MB text" \
            "$GNU_TOOL '$TEST_DATA_DIR/text_100m.txt'" \
            "$F_TOOL '$TEST_DATA_DIR/text_100m.txt'" "$CLAIMED"
    fi

    echo ""
    echo "=== Lines only (-l) ==="

    run_benchmark "-l 10MB text" \
        "$GNU_TOOL -l '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -l '$TEST_DATA_DIR/text_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Words only (-w) ==="

    run_benchmark "-w 10MB text" \
        "$GNU_TOOL -w '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -w '$TEST_DATA_DIR/text_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Bytes only (-c) ==="

    run_benchmark "-c 10MB text" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/text_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Characters (-m) ==="

    run_benchmark "-m 10MB text" \
        "$GNU_TOOL -m '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -m '$TEST_DATA_DIR/text_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Max line length (-L) ==="

    run_benchmark "-L 10MB text" \
        "$GNU_TOOL -L '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -L '$TEST_DATA_DIR/text_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Binary data ==="

    run_benchmark "default 10MB binary" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_10m.bin'" "$CLAIMED"

    echo ""
    echo "=== Repetitive content ==="

    run_benchmark "default 10MB repetitive" \
        "$GNU_TOOL '$TEST_DATA_DIR/repetitive_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/repetitive_10m.txt'" "$CLAIMED"

    echo ""
    echo "=== Multiple files ==="

    local ten_files=""
    for f in "$TEST_DATA_DIR/many_files"/file_000{1..9}.txt "$TEST_DATA_DIR/many_files/file_0010.txt"; do
        ten_files="$ten_files '$f'"
    done

    run_benchmark "10 files" \
        "eval $GNU_TOOL $ten_files" \
        "eval $F_TOOL $ten_files" "$CLAIMED"

    local hundred_files=""
    for f in "$TEST_DATA_DIR/many_files"/file_*.txt; do
        hundred_files="$hundred_files '$f'"
    done

    run_benchmark "100 files" \
        "eval $GNU_TOOL $hundred_files" \
        "eval $F_TOOL $hundred_files" "$CLAIMED"

    save_benchmark_results "$CLAIMED"
}

run_wc_benchmarks
