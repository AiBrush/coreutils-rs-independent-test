#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="base64"
F_TOOL="fbase64"
run_base64_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"base64","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/base64_benchmark.json"
        return 0
    fi

    init_benchmark "base64"

    echo ""
    echo "=== Encode (various sizes) ==="

    run_benchmark "encode 100KB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_100k.txt'"

    run_benchmark "encode 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    run_benchmark "encode 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'"

    run_benchmark "encode 10MB binary" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_10m.bin'"

    echo ""
    echo "=== Decode ==="

    # Create encoded files for decode benchmarks
    local encoded_1m
    encoded_1m=$(mktemp /tmp/bench_b64_1m_XXXXXX)
    $GNU_TOOL "$TEST_DATA_DIR/text_1m.txt" > "$encoded_1m"

    local encoded_10m
    encoded_10m=$(mktemp /tmp/bench_b64_10m_XXXXXX)
    $GNU_TOOL "$TEST_DATA_DIR/text_10m.txt" > "$encoded_10m"

    run_benchmark "decode 1MB" \
        "$GNU_TOOL -d '$encoded_1m'" \
        "$F_TOOL -d '$encoded_1m'"

    run_benchmark "decode 10MB" \
        "$GNU_TOOL -d '$encoded_10m'" \
        "$F_TOOL -d '$encoded_10m'"

    rm -f "$encoded_1m" "$encoded_10m"

    echo ""
    echo "=== Line wrapping ==="

    run_benchmark "encode -w 76 10MB" \
        "$GNU_TOOL -w 76 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -w 76 '$TEST_DATA_DIR/text_10m.txt'"

    run_benchmark "encode -w 0 (no wrap) 10MB" \
        "$GNU_TOOL -w 0 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -w 0 '$TEST_DATA_DIR/text_10m.txt'"

    save_benchmark_results
}

run_base64_benchmarks
