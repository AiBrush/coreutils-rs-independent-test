#!/usr/bin/env bash
# Compatibility tests for fbase32 vs GNU base32
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="base32"
F_TOOL="fbase32"

run_base32_tests() {
    init_test_suite "base32"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"base32","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/base32_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU base32 not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Encoding ==="

    run_test "encode simple string" \
        "printf 'Hello' | $GNU_TOOL" \
        "printf 'Hello' | $F_TOOL"

    run_test "encode empty input" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    run_test "encode single byte" \
        "printf 'A' | $GNU_TOOL" \
        "printf 'A' | $F_TOOL"

    run_test "encode two bytes" \
        "printf 'AB' | $GNU_TOOL" \
        "printf 'AB' | $F_TOOL"

    run_test "encode three bytes" \
        "printf 'ABC' | $GNU_TOOL" \
        "printf 'ABC' | $F_TOOL"

    run_test "encode four bytes" \
        "printf 'ABCD' | $GNU_TOOL" \
        "printf 'ABCD' | $F_TOOL"

    run_test "encode five bytes (no padding)" \
        "printf 'ABCDE' | $GNU_TOOL" \
        "printf 'ABCDE' | $F_TOOL"

    run_test "encode with newline" \
        "printf 'Hello, World!\n' | $GNU_TOOL" \
        "printf 'Hello, World!\n' | $F_TOOL"

    run_test "encode from file" \
        "$GNU_TOOL '$TEST_DATA_DIR/basenc_input.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/basenc_input.txt'"

    echo ""
    echo "=== Decoding ==="

    run_test "decode simple" \
        "printf 'JBSWY3DP' | $GNU_TOOL -d" \
        "printf 'JBSWY3DP' | $F_TOOL -d"

    run_test "decode with padding" \
        "printf 'JBSWY3DPEB3W64TMMQ======\n' | $GNU_TOOL -d" \
        "printf 'JBSWY3DPEB3W64TMMQ======\n' | $F_TOOL -d"

    run_test "decode from file" \
        "$GNU_TOOL -d '$TEST_DATA_DIR/base32_encoded.txt'" \
        "$F_TOOL -d '$TEST_DATA_DIR/base32_encoded.txt'"

    run_test "decode with newlines in encoded data" \
        "printf 'JBSWY\n3DPEB\n3W64T\nMMQ==\n====\n' | $GNU_TOOL -d" \
        "printf 'JBSWY\n3DPEB\n3W64T\nMMQ==\n====\n' | $F_TOOL -d"

    echo ""
    echo "=== Roundtrip Tests ==="

    run_test "roundtrip ASCII" \
        "printf 'The quick brown fox' | $GNU_TOOL | $GNU_TOOL -d" \
        "printf 'The quick brown fox' | $F_TOOL | $F_TOOL -d"

    run_test "roundtrip binary" \
        "printf '\x00\x01\x02\x80\xff' | $GNU_TOOL | $GNU_TOOL -d | od -A x -t x1z" \
        "printf '\x00\x01\x02\x80\xff' | $F_TOOL | $F_TOOL -d | od -A x -t x1z"

    run_test "roundtrip empty" \
        "printf '' | $GNU_TOOL | $GNU_TOOL -d" \
        "printf '' | $F_TOOL | $F_TOOL -d"

    run_test "roundtrip multiline" \
        "$GNU_TOOL '$TEST_DATA_DIR/basenc_multiline.txt' | $GNU_TOOL -d" \
        "$F_TOOL '$TEST_DATA_DIR/basenc_multiline.txt' | $F_TOOL -d"

    echo ""
    echo "=== Wrap Option (-w) ==="

    run_test "wrap at 20 chars" \
        "printf 'Hello, World! This is a longer string for wrapping.' | $GNU_TOOL -w 20" \
        "printf 'Hello, World! This is a longer string for wrapping.' | $F_TOOL -w 20"

    run_test "no wrap (-w 0)" \
        "printf 'Hello, World! This is a longer string for wrapping.' | $GNU_TOOL -w 0" \
        "printf 'Hello, World! This is a longer string for wrapping.' | $F_TOOL -w 0"

    run_test "wrap at 10 chars" \
        "printf 'short' | $GNU_TOOL -w 10" \
        "printf 'short' | $F_TOOL -w 10"

    echo ""
    echo "=== Edge Cases ==="

    run_test "all zero bytes" \
        "printf '\x00\x00\x00\x00\x00' | $GNU_TOOL" \
        "printf '\x00\x00\x00\x00\x00' | $F_TOOL"

    run_test "all 0xFF bytes" \
        "printf '\xff\xff\xff\xff\xff' | $GNU_TOOL" \
        "printf '\xff\xff\xff\xff\xff' | $F_TOOL"

    run_test "single null byte" \
        "printf '\x00' | $GNU_TOOL" \
        "printf '\x00' | $F_TOOL"

    run_test "encode large input" \
        "dd if=/dev/zero bs=1024 count=10 2>/dev/null | $GNU_TOOL | md5sum" \
        "dd if=/dev/zero bs=1024 count=10 2>/dev/null | $F_TOOL | md5sum"

    echo ""
    echo "=== Ignore Garbage (-i) ==="

    run_test "decode ignoring garbage" \
        "printf 'JBSW!!!Y3DP###\n' | $GNU_TOOL -d -i" \
        "printf 'JBSW!!!Y3DP###\n' | $F_TOOL -d -i"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "decode invalid input" \
        "$GNU_TOOL -d <<< '!!!invalid!!!' 2>&1" \
        "$F_TOOL -d <<< '!!!invalid!!!' 2>&1"

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Unicode Input ==="

    run_test "encode unicode" \
        "printf '日本語' | $GNU_TOOL" \
        "printf '日本語' | $F_TOOL"

    run_test "roundtrip unicode" \
        "printf '日本語テスト' | $GNU_TOOL | $GNU_TOOL -d" \
        "printf '日本語テスト' | $F_TOOL | $F_TOOL -d"

    finish_test_suite
}

run_base32_tests
