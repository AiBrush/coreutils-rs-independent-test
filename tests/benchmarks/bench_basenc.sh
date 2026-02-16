#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="basenc"
F_TOOL="fbasenc"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/basenc}"
run_basenc_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"basenc","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/basenc_benchmark.json"
        return 0
    fi

    init_benchmark "basenc"

    echo ""
    echo "=== Encode with --base64 ==="

    run_benchmark "encode --base64 1MB" \
        "$GNU_TOOL --base64 '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL --base64 '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL --base64 '$TEST_DATA_DIR/text_1m.txt'}"

    run_benchmark "encode --base64 10MB" \
        "$GNU_TOOL --base64 '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL --base64 '$TEST_DATA_DIR/text_10m.txt'" \
        "${U_TOOL:+$U_TOOL --base64 '$TEST_DATA_DIR/text_10m.txt'}"

    echo ""
    echo "=== Encode with --base32 ==="

    run_benchmark "encode --base32 1MB" \
        "$GNU_TOOL --base32 '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL --base32 '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL --base32 '$TEST_DATA_DIR/text_1m.txt'}"

    echo ""
    echo "=== Encode with --base16 ==="

    run_benchmark "encode --base16 1MB" \
        "$GNU_TOOL --base16 '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL --base16 '$TEST_DATA_DIR/text_1m.txt'" \
        "${U_TOOL:+$U_TOOL --base16 '$TEST_DATA_DIR/text_1m.txt'}"

    echo ""
    echo "=== Decode with --base64 ==="

    # Create encoded file for decode benchmark
    local encoded_1m
    encoded_1m=$(mktemp /tmp/bench_basenc_b64_1m_XXXXXX)
    $GNU_TOOL --base64 "$TEST_DATA_DIR/text_1m.txt" > "$encoded_1m"

    run_benchmark "decode --base64 -d 1MB" \
        "$GNU_TOOL --base64 -d '$encoded_1m'" \
        "$F_TOOL --base64 -d '$encoded_1m'" \
        "${U_TOOL:+$U_TOOL --base64 -d '$encoded_1m'}"

    rm -f "$encoded_1m"

    save_benchmark_results
}

run_basenc_benchmarks
