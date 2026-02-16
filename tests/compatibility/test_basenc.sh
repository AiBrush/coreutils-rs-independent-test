#!/usr/bin/env bash
# Compatibility tests for fbasenc vs GNU basenc
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="basenc"
F_TOOL="fbasenc"

run_basenc_tests() {
    init_test_suite "basenc"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"basenc","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/basenc_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU basenc not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Base64 Encoding ==="

    run_test "base64 encode simple string" \
        "printf 'Hello, World!\n' | $GNU_TOOL --base64" \
        "printf 'Hello, World!\n' | $F_TOOL --base64"

    run_test "base64 encode empty input" \
        "printf '' | $GNU_TOOL --base64" \
        "printf '' | $F_TOOL --base64"

    run_test "base64 encode single byte" \
        "printf 'A' | $GNU_TOOL --base64" \
        "printf 'A' | $F_TOOL --base64"

    run_test "base64 encode two bytes" \
        "printf 'AB' | $GNU_TOOL --base64" \
        "printf 'AB' | $F_TOOL --base64"

    run_test "base64 encode three bytes (no padding)" \
        "printf 'ABC' | $GNU_TOOL --base64" \
        "printf 'ABC' | $F_TOOL --base64"

    run_test "base64 encode file" \
        "$GNU_TOOL --base64 '$TEST_DATA_DIR/basenc_input.txt'" \
        "$F_TOOL --base64 '$TEST_DATA_DIR/basenc_input.txt'"

    run_test "base64 encode multiline" \
        "$GNU_TOOL --base64 '$TEST_DATA_DIR/basenc_multiline.txt'" \
        "$F_TOOL --base64 '$TEST_DATA_DIR/basenc_multiline.txt'"

    run_test "base64 encode binary data" \
        "$GNU_TOOL --base64 '$TEST_DATA_DIR/basenc_binary.bin'" \
        "$F_TOOL --base64 '$TEST_DATA_DIR/basenc_binary.bin'"

    echo ""
    echo "=== Base64 Decoding ==="

    run_test "base64 decode simple" \
        "printf 'SGVsbG8sIFdvcmxkIQo=' | $GNU_TOOL --base64 -d" \
        "printf 'SGVsbG8sIFdvcmxkIQo=' | $F_TOOL --base64 -d"

    run_test "base64 roundtrip" \
        "printf 'roundtrip test data 12345' | $GNU_TOOL --base64 | $GNU_TOOL --base64 -d" \
        "printf 'roundtrip test data 12345' | $F_TOOL --base64 | $F_TOOL --base64 -d"

    run_test "base64 decode with newlines in encoded data" \
        "printf 'SGVs\nbG8s\nIFdv\ncmxk\nIQo=\n' | $GNU_TOOL --base64 -d" \
        "printf 'SGVs\nbG8s\nIFdv\ncmxk\nIQo=\n' | $F_TOOL --base64 -d"

    echo ""
    echo "=== Base64URL Encoding ==="

    run_test "base64url encode" \
        "printf 'Hello+World/Test' | $GNU_TOOL --base64url" \
        "printf 'Hello+World/Test' | $F_TOOL --base64url"

    run_test "base64url encode binary" \
        "printf '\xff\xfe\xfd' | $GNU_TOOL --base64url" \
        "printf '\xff\xfe\xfd' | $F_TOOL --base64url"

    run_test "base64url roundtrip" \
        "printf 'URL safe encoding!' | $GNU_TOOL --base64url | $GNU_TOOL --base64url -d" \
        "printf 'URL safe encoding!' | $F_TOOL --base64url | $F_TOOL --base64url -d"

    echo ""
    echo "=== Base32 Encoding ==="

    run_test "base32 encode simple" \
        "printf 'Hello' | $GNU_TOOL --base32" \
        "printf 'Hello' | $F_TOOL --base32"

    run_test "base32 encode single char" \
        "printf 'A' | $GNU_TOOL --base32" \
        "printf 'A' | $F_TOOL --base32"

    run_test "base32 encode empty" \
        "printf '' | $GNU_TOOL --base32" \
        "printf '' | $F_TOOL --base32"

    run_test "base32 roundtrip" \
        "printf 'Base32 test' | $GNU_TOOL --base32 | $GNU_TOOL --base32 -d" \
        "printf 'Base32 test' | $F_TOOL --base32 | $F_TOOL --base32 -d"

    echo ""
    echo "=== Base32HEX Encoding ==="

    run_test "base32hex encode" \
        "printf 'Hello' | $GNU_TOOL --base32hex" \
        "printf 'Hello' | $F_TOOL --base32hex"

    run_test "base32hex roundtrip" \
        "printf 'hex32 test' | $GNU_TOOL --base32hex | $GNU_TOOL --base32hex -d" \
        "printf 'hex32 test' | $F_TOOL --base32hex | $F_TOOL --base32hex -d"

    echo ""
    echo "=== Base16 (Hex) Encoding ==="

    run_test "base16 encode simple" \
        "printf 'Hello' | $GNU_TOOL --base16" \
        "printf 'Hello' | $F_TOOL --base16"

    run_test "base16 encode binary" \
        "printf '\x00\x01\x02\xff' | $GNU_TOOL --base16" \
        "printf '\x00\x01\x02\xff' | $F_TOOL --base16"

    run_test "base16 decode" \
        "printf '48656C6C6F' | $GNU_TOOL --base16 -d" \
        "printf '48656C6C6F' | $F_TOOL --base16 -d"

    run_test "base16 roundtrip" \
        "printf 'hex test 0xff' | $GNU_TOOL --base16 | $GNU_TOOL --base16 -d" \
        "printf 'hex test 0xff' | $F_TOOL --base16 | $F_TOOL --base16 -d"

    echo ""
    echo "=== Base2 (Binary) Encoding ==="

    run_test "base2msbf encode" \
        "printf 'AB' | $GNU_TOOL --base2msbf" \
        "printf 'AB' | $F_TOOL --base2msbf"

    run_test "base2msbf decode" \
        "printf '0100000101000010' | $GNU_TOOL --base2msbf -d" \
        "printf '0100000101000010' | $F_TOOL --base2msbf -d"

    run_test "base2lsbf encode" \
        "printf 'AB' | $GNU_TOOL --base2lsbf" \
        "printf 'AB' | $F_TOOL --base2lsbf"

    run_test "base2lsbf roundtrip" \
        "printf 'binary' | $GNU_TOOL --base2lsbf | $GNU_TOOL --base2lsbf -d" \
        "printf 'binary' | $F_TOOL --base2lsbf | $F_TOOL --base2lsbf -d"

    echo ""
    echo "=== Z85 Encoding ==="

    # z85 requires input length divisible by 4 for encode
    run_test "z85 encode 4 bytes" \
        "printf 'test' | $GNU_TOOL --z85" \
        "printf 'test' | $F_TOOL --z85"

    run_test "z85 encode 8 bytes" \
        "printf 'testtest' | $GNU_TOOL --z85" \
        "printf 'testtest' | $F_TOOL --z85"

    run_test "z85 roundtrip" \
        "printf 'z85!' | $GNU_TOOL --z85 | $GNU_TOOL --z85 -d" \
        "printf 'z85!' | $F_TOOL --z85 | $F_TOOL --z85 -d"

    echo ""
    echo "=== Wrap Option (-w) ==="

    run_test "base64 wrap at 20" \
        "printf 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' | $GNU_TOOL --base64 -w 20" \
        "printf 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' | $F_TOOL --base64 -w 20"

    run_test "base64 no wrap (-w 0)" \
        "printf 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' | $GNU_TOOL --base64 -w 0" \
        "printf 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' | $F_TOOL --base64 -w 0"

    echo ""
    echo "=== Edge Cases ==="

    run_test "encode all zero bytes" \
        "printf '\x00\x00\x00\x00' | $GNU_TOOL --base64" \
        "printf '\x00\x00\x00\x00' | $F_TOOL --base64"

    run_test "encode all 0xFF bytes" \
        "printf '\xff\xff\xff' | $GNU_TOOL --base64" \
        "printf '\xff\xff\xff' | $F_TOOL --base64"

    run_test "large input base64" \
        "dd if=/dev/zero bs=1024 count=10 2>/dev/null | $GNU_TOOL --base64 | md5sum" \
        "dd if=/dev/zero bs=1024 count=10 2>/dev/null | $F_TOOL --base64 | md5sum"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "decode invalid base64" \
        "$GNU_TOOL --base64 -d <<< '!!!invalid!!!' 2>&1" \
        "$F_TOOL --base64 -d <<< '!!!invalid!!!' 2>&1"

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL --base64 /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL --base64 /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Unicode Input ==="

    run_test "base64 encode unicode" \
        "printf '日本語テスト' | $GNU_TOOL --base64" \
        "printf '日本語テスト' | $F_TOOL --base64"

    run_test "base64 roundtrip unicode" \
        "printf '日本語テスト' | $GNU_TOOL --base64 | $GNU_TOOL --base64 -d" \
        "printf '日本語テスト' | $F_TOOL --base64 | $F_TOOL --base64 -d"

    finish_test_suite
}

run_basenc_tests
