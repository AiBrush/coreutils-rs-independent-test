#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="base32"
F_TOOL="fbase32"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/base32}"
run_base32_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"base32","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/base32_benchmark.json"
        return 0
    fi

    init_benchmark "base32"

    echo ""
    echo "=== Encode (various sizes) ==="

    run_benchmark "encode 100KB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_100k.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_100k.txt'}"

    run_benchmark "encode 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "encode 10MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/text_10m.txt'}"

    run_benchmark "encode 10MB binary" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "${U_TOOL:+$U_TOOL '$TEST_DATA_DIR/random_10m.bin'}"

    echo ""
    echo "=== Decode ==="

    # Create encoded files for decode benchmarks
    local encoded_1m
    encoded_1m=$(mktemp /tmp/bench_b32_1m_XXXXXX)
    $GNU_TOOL "$TEST_DATA_DIR/text_1m.txt" > "$encoded_1m"

    local encoded_10m
    encoded_10m=$(mktemp /tmp/bench_b32_10m_XXXXXX)
    $GNU_TOOL "$TEST_DATA_DIR/text_10m.txt" > "$encoded_10m"

    run_benchmark "decode 1MB" \
        "$GNU_TOOL -d '$encoded_1m'" \
        "$F_TOOL -d '$encoded_1m'" \
        "${U_TOOL:+$U_TOOL -d '$encoded_1m'}"

    run_benchmark "decode 10MB" \
        "$GNU_TOOL -d '$encoded_10m'" \
        "$F_TOOL -d '$encoded_10m'" \
        "${U_TOOL:+$U_TOOL -d '$encoded_10m'}"

    rm -f "$encoded_1m" "$encoded_10m"

    save_benchmark_results
}

run_base32_benchmarks
