#!/usr/bin/env bash
# Compatibility tests for fbase64 vs GNU base64
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="base64"
F_TOOL="fbase64"

run_base64_tests() {
    init_test_suite "base64"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"base64","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/base64_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU base64 not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Encode Tests ==="

    run_test "encode simple string" \
        "echo 'Hello, World!' | $GNU_TOOL" \
        "echo 'Hello, World!' | $F_TOOL"

    run_test "encode empty input" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    run_test "encode single byte" \
        "printf 'a' | $GNU_TOOL" \
        "printf 'a' | $F_TOOL"

    run_test "encode two bytes" \
        "printf 'ab' | $GNU_TOOL" \
        "printf 'ab' | $F_TOOL"

    run_test "encode three bytes (no padding)" \
        "printf 'abc' | $GNU_TOOL" \
        "printf 'abc' | $F_TOOL"

    run_test "encode file" \
        "$GNU_TOOL '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL '$TEST_DATA_DIR/simple.csv'"

    run_test "encode binary data" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_1k.bin'"

    run_test "encode UTF-8" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    run_test "encode null bytes" \
        "$GNU_TOOL '$TEST_DATA_DIR/null_bytes.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/null_bytes.bin'"

    echo ""
    echo "=== Decode Tests (-d) ==="

    run_test "decode simple" \
        "echo 'SGVsbG8sIFdvcmxkIQo=' | $GNU_TOOL -d" \
        "echo 'SGVsbG8sIFdvcmxkIQo=' | $F_TOOL -d"

    run_test "decode empty" \
        "printf '' | $GNU_TOOL -d" \
        "printf '' | $F_TOOL -d"

    run_test "decode no padding" \
        "echo 'YWJj' | $GNU_TOOL -d" \
        "echo 'YWJj' | $F_TOOL -d"

    run_test "decode one pad" \
        "echo 'YWI=' | $GNU_TOOL -d" \
        "echo 'YWI=' | $F_TOOL -d"

    run_test "decode two pad" \
        "echo 'YQ==' | $GNU_TOOL -d" \
        "echo 'YQ==' | $F_TOOL -d"

    echo ""
    echo "=== Encode/Decode Roundtrip ==="

    run_test "roundtrip text" \
        "$GNU_TOOL '$TEST_DATA_DIR/simple.csv' | $GNU_TOOL -d" \
        "$F_TOOL '$TEST_DATA_DIR/simple.csv' | $F_TOOL -d"

    run_test "roundtrip binary" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_1k.bin' | $GNU_TOOL -d | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/random_1k.bin' | $F_TOOL -d | md5sum"

    run_test "cross roundtrip: encode GNU decode F" \
        "$GNU_TOOL '$TEST_DATA_DIR/simple.csv' | $F_TOOL -d" \
        "$F_TOOL '$TEST_DATA_DIR/simple.csv' | $GNU_TOOL -d"

    echo ""
    echo "=== Line Wrapping (-w) ==="

    run_test "-w 76 (default)" \
        "echo 'Hello, World!' | $GNU_TOOL -w 76" \
        "echo 'Hello, World!' | $F_TOOL -w 76"

    run_test "-w 0 (no wrapping)" \
        "$GNU_TOOL -w 0 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -w 0 '$TEST_DATA_DIR/simple.csv'"

    run_test "-w 20" \
        "$GNU_TOOL -w 20 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -w 20 '$TEST_DATA_DIR/simple.csv'"

    run_test "-w 4 (very short lines)" \
        "echo 'Hello, World!' | $GNU_TOOL -w 4" \
        "echo 'Hello, World!' | $F_TOOL -w 4"

    run_test "-w 1000 (long lines)" \
        "$GNU_TOOL -w 1000 '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL -w 1000 '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Ignore Garbage (-i) ==="

    run_test "-di (ignore garbage on decode)" \
        "echo 'SGVs!!!bG8s@@@IFdv%%%cmxk###IQo=' | $GNU_TOOL -di" \
        "echo 'SGVs!!!bG8s@@@IFdv%%%cmxk###IQo=' | $F_TOOL -di"

    run_test "-di with whitespace in encoded data" \
        "printf 'SGVs\nbG8s\nIFdv\ncmxk\nIQo=\n' | $GNU_TOOL -d" \
        "printf 'SGVs\nbG8s\nIFdv\ncmxk\nIQo=\n' | $F_TOOL -d"

    echo ""
    echo "=== Invalid Input ==="

    run_exit_code_test "decode invalid base64" \
        "echo '!!!invalid!!!' | $GNU_TOOL -d 2>&1" \
        "echo '!!!invalid!!!' | $F_TOOL -d 2>&1"

    run_exit_code_test "decode truncated padding" \
        "echo 'YQ=' | $GNU_TOOL -d 2>&1" \
        "echo 'YQ=' | $F_TOOL -d 2>&1"

    echo ""
    echo "=== Stdin vs File ==="

    run_test "stdin vs file encode" \
        "cat '$TEST_DATA_DIR/simple.csv' | $GNU_TOOL" \
        "cat '$TEST_DATA_DIR/simple.csv' | $F_TOOL"

    echo ""
    echo "=== Large Files ==="

    run_test "encode 1MB text" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    run_test "encode 10MB binary" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_10m.bin'"

    # Decode large encoded data
    local encoded_file
    encoded_file=$(mktemp /tmp/fcoreutils_b64enc_XXXXXX)
    register_temp "$encoded_file"
    $GNU_TOOL "$TEST_DATA_DIR/text_1m.txt" > "$encoded_file"

    run_test "decode 1MB encoded" \
        "$GNU_TOOL -d '$encoded_file'" \
        "$F_TOOL -d '$encoded_file'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    # Single newline
    run_test "encode single newline" \
        "printf '\n' | $GNU_TOOL" \
        "printf '\n' | $F_TOOL"

    # All bytes 0-255
    run_test "encode all byte values" \
        "python3 -c 'import sys; sys.stdout.buffer.write(bytes(range(256)))' | $GNU_TOOL" \
        "python3 -c 'import sys; sys.stdout.buffer.write(bytes(range(256)))' | $F_TOOL"

    finish_test_suite
}

run_base64_tests
