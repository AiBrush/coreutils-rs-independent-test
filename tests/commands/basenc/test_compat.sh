#!/usr/bin/env bash
# Compatibility tests for fbasenc vs GNU basenc
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "basenc")
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
    echo "=== GNU Upstream: Large Input ==="

    # From large-input.sh: coreutils v9.8 would not operate correctly with > 15,561,475 bytes
    # Test large input with base64 (base58 may not be available everywhere)
    run_test "large input base64 roundtrip 20MiB" \
        "dd if=/dev/zero bs=1M count=20 2>/dev/null | $GNU_TOOL --base64 | head -c 1000 | md5sum" \
        "dd if=/dev/zero bs=1M count=20 2>/dev/null | $F_TOOL --base64 | head -c 1000 | md5sum"

    # bounded-memory.sh: skipped (requires ulimit -v and /dev/zero streaming tests)
    skip_test "bounded memory encoding" "Requires ulimit -v memory constraints"

    # === GNU Upstream: Base64 Encoding/Decoding Vectors ===
    echo ""
    echo "=== GNU Upstream: Base64 Encoding/Decoding Vectors ==="

    # From base64.pl: encode 1-5 'a' bytes with padding variations
    run_test "gnu base64: encode 1 byte" \
        "printf 'a' | $GNU_TOOL --base64" \
        "printf 'a' | $F_TOOL --base64"

    run_test "gnu base64: encode 2 bytes" \
        "printf 'aa' | $GNU_TOOL --base64" \
        "printf 'aa' | $F_TOOL --base64"

    run_test "gnu base64: encode 3 bytes (no padding)" \
        "printf 'aaa' | $GNU_TOOL --base64" \
        "printf 'aaa' | $F_TOOL --base64"

    run_test "gnu base64: encode 4 bytes" \
        "printf 'aaaa' | $GNU_TOOL --base64" \
        "printf 'aaaa' | $F_TOOL --base64"

    run_test "gnu base64: encode 5 bytes" \
        "printf 'aaaaa' | $GNU_TOOL --base64" \
        "printf 'aaaaa' | $F_TOOL --base64"

    # From base64.pl: --wrap 0 (no wrapping, no trailing newline on encoded output)
    run_test "gnu base64: wrap 0" \
        "printf 'a' | $GNU_TOOL --base64 --wrap 0" \
        "printf 'a' | $F_TOOL --base64 --wrap 0"

    # From base64.pl: --wrap with octal prefix (08 means width 8)
    run_test "gnu base64: wrap 08" \
        "printf 'a' | $GNU_TOOL --base64 --wrap 08" \
        "printf 'a' | $F_TOOL --base64 --wrap 08"

    # From base64.pl: --wrap=5 with varying input sizes
    run_test "gnu base64: wrap=5 with 39 bytes" \
        "printf '%0.sa' {1..39} | $GNU_TOOL --base64 --wrap=5" \
        "printf '%0.sa' {1..39} | $F_TOOL --base64 --wrap=5"

    run_test "gnu base64: wrap=5 with 45 bytes" \
        "printf '%0.sa' {1..45} | $GNU_TOOL --base64 --wrap=5" \
        "printf '%0.sa' {1..45} | $F_TOOL --base64 --wrap=5"

    # From base64.pl: decode tests (1-4 bytes decoded back)
    run_test "gnu base64: decode 1 byte roundtrip" \
        "printf 'a' | $GNU_TOOL --base64 | $GNU_TOOL --base64 -d" \
        "printf 'a' | $F_TOOL --base64 | $F_TOOL --base64 -d"

    run_test "gnu base64: decode 3072 byte roundtrip" \
        "printf '%0.sa' {1..3072} | $GNU_TOOL --base64 | $GNU_TOOL --base64 -d | wc -c" \
        "printf '%0.sa' {1..3072} | $F_TOOL --base64 | $F_TOOL --base64 -d | wc -c"

    # === GNU Upstream: Base64URL Specific Tests ===
    echo ""
    echo "=== GNU Upstream: Base64URL Specific Tests ==="

    # From basenc.pl: base64url should reject base64 chars '+' and '/'
    run_exit_code_test "gnu base64url: reject base64 input with + and /" \
        "printf 'VA/c8A+vSg==' | $GNU_TOOL --base64url -d 2>&1" \
        "printf 'VA/c8A+vSg==' | $F_TOOL --base64url -d 2>&1"

    # From basenc.pl: base64url encode/decode roundtrip
    run_test "gnu base64url: encode binary" \
        "printf '\x54\x0f\xdc\xf0\x0f\xaf\x4a' | $GNU_TOOL --base64url" \
        "printf '\x54\x0f\xdc\xf0\x0f\xaf\x4a' | $F_TOOL --base64url"

    run_test "gnu base64url: decode with ignore" \
        "printf '&VA_c8A-vSg==' | $GNU_TOOL --base64url -di" \
        "printf '&VA_c8A-vSg==' | $F_TOOL --base64url -di"

    # === GNU Upstream: Base16 Decode Tests ===
    echo ""
    echo "=== GNU Upstream: Base16 Decode Tests ==="

    # From basenc.pl: base16 decode with newlines
    run_test "gnu base16: decode with embedded newline" \
        "printf 'AB\nCD' | $GNU_TOOL --base16 -d | od -An -tx1" \
        "printf 'AB\nCD' | $F_TOOL --base16 -d | od -An -tx1"

    # From basenc.pl: base16 decode lowercase is valid
    run_test "gnu base16: decode lowercase hex" \
        "printf 'fdd807d1a5' | $GNU_TOOL --base16 -d | od -An -tx1" \
        "printf 'fdd807d1a5' | $F_TOOL --base16 -d | od -An -tx1"

    # From basenc.pl: base16 invalid input chars
    run_exit_code_test "gnu base16: invalid input dot" \
        "printf '.' | $GNU_TOOL --base16 -d 2>&1" \
        "printf '.' | $F_TOOL --base16 -d 2>&1"

    run_exit_code_test "gnu base16: invalid input G" \
        "printf 'G' | $GNU_TOOL --base16 -d 2>&1" \
        "printf 'G' | $F_TOOL --base16 -d 2>&1"

    # === GNU Upstream: Z85 Encode/Decode Tests ===
    echo ""
    echo "=== GNU Upstream: Z85 Encode/Decode Tests ==="

    # From basenc.pl: z85 "HelloWorld" test vector
    run_test "gnu z85: encode HelloWorld" \
        "printf '\x86\x4F\xD2\x6F\xB5\x59\xF7\x5B' | $GNU_TOOL --z85" \
        "printf '\x86\x4F\xD2\x6F\xB5\x59\xF7\x5B' | $F_TOOL --z85"

    run_test "gnu z85: decode HelloWorld" \
        "printf 'HelloWorld' | $GNU_TOOL --z85 -d | od -An -tx1" \
        "printf 'HelloWorld' | $F_TOOL --z85 -d | od -An -tx1"

    # From basenc.pl: z85 max value encode/decode
    run_test "gnu z85: encode max 0xFFFFFFFF" \
        "printf '\xFF\xFF\xFF\xFF' | $GNU_TOOL --z85" \
        "printf '\xFF\xFF\xFF\xFF' | $F_TOOL --z85"

    # From basenc.pl: z85 input length must be multiple of 4
    run_exit_code_test "gnu z85: encode invalid length 1" \
        "printf 'A' | $GNU_TOOL --z85 2>&1" \
        "printf 'A' | $F_TOOL --z85 2>&1"

    run_exit_code_test "gnu z85: encode invalid length 2" \
        "printf 'AB' | $GNU_TOOL --z85 2>&1" \
        "printf 'AB' | $F_TOOL --z85 2>&1"

    run_exit_code_test "gnu z85: encode invalid length 3" \
        "printf 'ABC' | $GNU_TOOL --z85 2>&1" \
        "printf 'ABC' | $F_TOOL --z85 2>&1"

    run_test "gnu z85: encode valid 4 bytes ABCD" \
        "printf 'ABCD' | $GNU_TOOL --z85" \
        "printf 'ABCD' | $F_TOOL --z85"

    # From basenc.pl: z85 decode invalid encoded length
    run_exit_code_test "gnu z85: decode invalid length 1" \
        "printf 'A' | $GNU_TOOL --z85 -d 2>&1" \
        "printf 'A' | $F_TOOL --z85 -d 2>&1"

    run_exit_code_test "gnu z85: decode invalid length 4" \
        "printf 'ABCD' | $GNU_TOOL --z85 -d 2>&1" \
        "printf 'ABCD' | $F_TOOL --z85 -d 2>&1"

    run_test "gnu z85: decode valid 5 chars ABCDE" \
        "printf 'ABCDE' | $GNU_TOOL --z85 -d | od -An -tx1" \
        "printf 'ABCDE' | $F_TOOL --z85 -d | od -An -tx1"

    # === GNU Upstream: Base32 Partial Padding Decode ===
    echo ""
    echo "=== GNU Upstream: Base32 Partial Padding Decode ==="

    # From basenc.pl: base32 decode without full padding
    run_test "gnu base32: decode without padding" \
        "printf 'MFRGG' | $GNU_TOOL --base32 --decode" \
        "printf 'MFRGG' | $F_TOOL --base32 --decode"

    run_test "gnu base32: decode with full padding" \
        "printf 'MFRGG===' | $GNU_TOOL --base32 --decode" \
        "printf 'MFRGG===' | $F_TOOL --base32 --decode"

    # From basenc.pl: base32 decode concatenated with/without padding
    run_test "gnu base32: decode concatenated padded blocks" \
        "printf 'MFRGGZDFMFRGG' | $GNU_TOOL --base32 --decode" \
        "printf 'MFRGGZDFMFRGG' | $F_TOOL --base32 --decode"

    run_test "gnu base32: decode with newline separator" \
        "printf 'MFRGGZDF\nMFRGG' | $GNU_TOOL --base32 -d" \
        "printf 'MFRGGZDF\nMFRGG' | $F_TOOL --base32 -d"

    # === GNU Upstream: Base64 Auto-Padding Decode ===
    echo ""
    echo "=== GNU Upstream: Base64 Auto-Padding Decode ==="

    # From basenc.pl: auto-padding boundary conditions
    run_test "gnu base64: decode auto-pad 2 chars" \
        "printf 'QQ' | $GNU_TOOL --base64 --decode" \
        "printf 'QQ' | $F_TOOL --base64 --decode"

    run_test "gnu base64: decode auto-pad 3 chars" \
        "printf 'QWI' | $GNU_TOOL --base64 --decode" \
        "printf 'QWI' | $F_TOOL --base64 --decode"

    run_test "gnu base32: decode auto-pad 2 chars" \
        "printf 'IE' | $GNU_TOOL --base32 --decode" \
        "printf 'IE' | $F_TOOL --base32 --decode"

    run_test "gnu base32: decode auto-pad 4 chars" \
        "printf 'IFBA' | $GNU_TOOL --base32 --decode" \
        "printf 'IFBA' | $F_TOOL --base32 --decode"

    # === GNU Upstream: Base2 MSB/LSB Encode/Decode ===
    echo ""
    echo "=== GNU Upstream: Base2 MSB/LSB Encode/Decode ==="

    # From basenc.pl: base2msbf single byte
    run_test "gnu base2msbf: encode 0xC1" \
        "printf '\xC1' | $GNU_TOOL --base2msbf" \
        "printf '\xC1' | $F_TOOL --base2msbf"

    run_test "gnu base2msbf: decode 11000001" \
        "printf '11000001' | $GNU_TOOL --base2msbf -d | od -An -tx1" \
        "printf '11000001' | $F_TOOL --base2msbf -d | od -An -tx1"

    # From basenc.pl: base2msbf decode with embedded newline
    run_test "gnu base2msbf: decode with newline" \
        "printf '110\n00001' | $GNU_TOOL --base2msbf -d | od -An -tx1" \
        "printf '110\n00001' | $F_TOOL --base2msbf -d | od -An -tx1"

    # From basenc.pl: base2msbf invalid input (not multiple of 8)
    run_exit_code_test "gnu base2msbf: invalid length 1 bit" \
        "printf '1' | $GNU_TOOL --base2msbf -d 2>&1" \
        "printf '1' | $F_TOOL --base2msbf -d 2>&1"

    run_exit_code_test "gnu base2msbf: invalid length 7 bits" \
        "printf '1000100' | $GNU_TOOL --base2msbf -d 2>&1" \
        "printf '1000100' | $F_TOOL --base2msbf -d 2>&1"

    # From basenc.pl: base2lsbf single byte
    run_test "gnu base2lsbf: encode 0x83" \
        "printf '\x83' | $GNU_TOOL --base2lsbf" \
        "printf '\x83' | $F_TOOL --base2lsbf"

    run_test "gnu base2lsbf: decode 11000001" \
        "printf '11000001' | $GNU_TOOL --base2lsbf -d | od -An -tx1" \
        "printf '11000001' | $F_TOOL --base2lsbf -d | od -An -tx1"

    # === GNU Upstream: Missing Encoding Type Error ===
    echo ""
    echo "=== GNU Upstream: Missing Encoding Type Error ==="

    # From basenc.pl: basenc with no encoding type should fail
    run_exit_code_test "gnu basenc: missing encoding type" \
        "printf '' | $GNU_TOOL 2>&1" \
        "printf '' | $F_TOOL 2>&1"

    # From basenc.pl: extra operand should fail
    run_exit_code_test "gnu basenc: extra operand" \
        "$GNU_TOOL --base64 /dev/null /dev/null 2>&1" \
        "$F_TOOL --base64 /dev/null /dev/null 2>&1"

    # From basenc.pl: all encodings with empty input should produce empty output
    run_test "gnu basenc: empty z85" \
        "printf '' | $GNU_TOOL --z85" \
        "printf '' | $F_TOOL --z85"

    run_test "gnu basenc: empty base58" \
        "printf '' | $GNU_TOOL --base58" \
        "printf '' | $F_TOOL --base58"

    # === GNU Upstream: Base58 Encode/Decode ===
    echo ""
    echo "=== GNU Upstream: Base58 Encode/Decode ==="

    # From basenc.pl: base58 "Hello World!" test vector
    run_test "gnu base58: encode Hello World!" \
        "printf 'Hello World!' | $GNU_TOOL --base58" \
        "printf 'Hello World!' | $F_TOOL --base58"

    run_test "gnu base58: decode 2NEpo7TZRRrLZSi2U" \
        "printf '2NEpo7TZRRrLZSi2U' | $GNU_TOOL --base58 -d" \
        "printf '2NEpo7TZRRrLZSi2U' | $F_TOOL --base58 -d"

    # From basenc.pl: base58 NUL byte encodes to '1'
    run_test "gnu base58: encode NUL byte" \
        "printf '\x00' | $GNU_TOOL --base58" \
        "printf '\x00' | $F_TOOL --base58"

    # From basenc.pl: base58 invalid characters (0, O, I, l)
    run_exit_code_test "gnu base58: invalid char 0" \
        "printf '0' | $GNU_TOOL --base58 -d 2>&1" \
        "printf '0' | $F_TOOL --base58 -d 2>&1"

    run_exit_code_test "gnu base58: invalid char O" \
        "printf 'O' | $GNU_TOOL --base58 -d 2>&1" \
        "printf 'O' | $F_TOOL --base58 -d 2>&1"

    run_exit_code_test "gnu base58: invalid char I" \
        "printf 'I' | $GNU_TOOL --base58 -d 2>&1" \
        "printf 'I' | $F_TOOL --base58 -d 2>&1"

    run_exit_code_test "gnu base58: invalid char l" \
        "printf 'l' | $GNU_TOOL --base58 -d 2>&1" \
        "printf 'l' | $F_TOOL --base58 -d 2>&1"

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
