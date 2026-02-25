#!/usr/bin/env bash
# Compatibility tests for fcksum vs GNU cksum
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "cksum")
F_TOOL="fcksum"

run_cksum_tests() {
    init_test_suite "cksum"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cksum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/cksum_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU cksum not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic CRC-32 Checksums ==="

    run_test "simple text file" \
        "$GNU_TOOL '$TEST_DATA_DIR/basenc_input.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/basenc_input.txt'"

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "single byte" \
        "$GNU_TOOL '$TEST_DATA_DIR/single_byte.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/single_byte.txt'"

    run_test "abc" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "fox string" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_fox.txt'"

    run_test "binary file" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Stdin Input ==="

    run_test "stdin simple" \
        "printf 'hello world\n' | $GNU_TOOL" \
        "printf 'hello world\n' | $F_TOOL"

    run_test "stdin empty" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    run_test "stdin single byte" \
        "printf 'A' | $GNU_TOOL" \
        "printf 'A' | $F_TOOL"

    run_test "stdin binary" \
        "printf '\x00\x01\x02\xff' | $GNU_TOOL" \
        "printf '\x00\x01\x02\xff' | $F_TOOL"

    echo ""
    echo "=== Multiple Files ==="

    run_test "two files" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'"

    run_test "three files" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'"

    echo ""
    echo "=== Large Files ==="

    run_test "1MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    run_test "10MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'"

    echo ""
    echo "=== Edge Cases ==="

    run_test "null bytes" \
        "printf '\x00\x00\x00\x00' | $GNU_TOOL" \
        "printf '\x00\x00\x00\x00' | $F_TOOL"

    run_test "all 0xFF" \
        "printf '\xff\xff\xff' | $GNU_TOOL" \
        "printf '\xff\xff\xff' | $F_TOOL"

    run_test "unicode text" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    run_test "emoji" \
        "$GNU_TOOL '$TEST_DATA_DIR/emoji.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/emoji.txt'"

    run_test "dos line endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/dos_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/dos_endings.txt'"

    run_test "long line" \
        "$GNU_TOOL '$TEST_DATA_DIR/long_line_10k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/long_line_10k.txt'"

    echo ""
    echo "=== GNU Upstream: Basic CRC Validation ==="

    # From cksum.sh: validate CRC for known byte sequences
    local tmp_crc=$(mktemp /tmp/fcoreutils_cksum_crc_XXXXXX)
    register_temp "$tmp_crc"

    # Byte range 0..130 (>128 bytes)
    printf "$(printf '\\%03o' $(seq 0 130))" > "$tmp_crc"
    run_test "gnu: crc bytes 0-130" \
        "$GNU_TOOL '$tmp_crc'" \
        "$F_TOOL '$tmp_crc'"

    # Byte range 0..64 (>32 but <128 bytes)
    printf "$(printf '\\%03o' $(seq 0 64))" > "$tmp_crc"
    run_test "gnu: crc bytes 0-64" \
        "$GNU_TOOL '$tmp_crc'" \
        "$F_TOOL '$tmp_crc'"

    # seq output checksum (>65k buffer boundary)
    seq 1 12780 > "$tmp_crc"
    run_test "gnu: crc seq 1-12780" \
        "$GNU_TOOL '$tmp_crc'" \
        "$F_TOOL '$tmp_crc'"

    seq 1 12795 > "$tmp_crc"
    run_test "gnu: crc seq 1-12795" \
        "$GNU_TOOL '$tmp_crc'" \
        "$F_TOOL '$tmp_crc'"

    # Missing file should fail
    run_exit_code_test "gnu: cksum missing file" \
        "$GNU_TOOL /tmp/nonexistent_cksum_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_cksum_$$ 2>&1"

    echo ""
    echo "=== GNU Upstream: Algorithm Selection ==="

    # From cksum-a.sh: test --algorithm with /dev/null
    local tmp_devnull=$(mktemp /tmp/fcoreutils_cksum_devnull_XXXXXX)
    register_temp "$tmp_devnull"
    printf '' > "$tmp_devnull"

    run_test "gnu: -a md5 /dev/null" \
        "$GNU_TOOL -a md5 '$tmp_devnull'" \
        "$F_TOOL -a md5 '$tmp_devnull'"

    run_test "gnu: -a sha1 /dev/null" \
        "$GNU_TOOL -a sha1 '$tmp_devnull'" \
        "$F_TOOL -a sha1 '$tmp_devnull'"

    run_test "gnu: -a sha256 /dev/null" \
        "$GNU_TOOL -a sha256 '$tmp_devnull'" \
        "$F_TOOL -a sha256 '$tmp_devnull'"

    run_test "gnu: -a sha512 /dev/null" \
        "$GNU_TOOL -a sha512 '$tmp_devnull'" \
        "$F_TOOL -a sha512 '$tmp_devnull'"

    run_test "gnu: -a blake2b /dev/null" \
        "$GNU_TOOL -a blake2b '$tmp_devnull'" \
        "$F_TOOL -a blake2b '$tmp_devnull'"

    run_test "gnu: -a crc /dev/null" \
        "$GNU_TOOL -a crc '$tmp_devnull'" \
        "$F_TOOL -a crc '$tmp_devnull'"

    run_test "gnu: -a bsd /dev/null" \
        "$GNU_TOOL -a bsd '$tmp_devnull'" \
        "$F_TOOL -a bsd '$tmp_devnull'"

    run_test "gnu: -a sysv /dev/null" \
        "$GNU_TOOL -a sysv '$tmp_devnull'" \
        "$F_TOOL -a sysv '$tmp_devnull'"

    # Untagged output should match legacy tools
    run_test "gnu: --untagged -a md5 /dev/null" \
        "$GNU_TOOL --untagged -a md5 '$tmp_devnull'" \
        "$F_TOOL --untagged -a md5 '$tmp_devnull'"

    run_test "gnu: --untagged -a sha256 /dev/null" \
        "$GNU_TOOL --untagged -a sha256 '$tmp_devnull'" \
        "$F_TOOL --untagged -a sha256 '$tmp_devnull'"

    # Ensure abbreviations not supported for algorithm selection
    run_exit_code_test "gnu: reject abbreviated algo" \
        "$GNU_TOOL -a sha22 </dev/null 2>&1" \
        "$F_TOOL -a sha22 </dev/null 2>&1"

    # Ensure --check not allowed with older algorithms
    run_exit_code_test "gnu: -a bsd --check rejected" \
        "$GNU_TOOL -a bsd --check </dev/null 2>&1" \
        "$F_TOOL -a bsd --check </dev/null 2>&1"

    echo ""
    echo "=== GNU Upstream: Check Mode ==="

    # From cksum-c.sh: generate and verify checksums
    local tmp_chk_dir=$(mktemp -d /tmp/fcoreutils_cksum_chk_XXXXXX)
    register_temp "$tmp_chk_dir"
    echo "test data for checking" > "$tmp_chk_dir/input"

    # Generate checksum file with GNU, verify with both
    $GNU_TOOL -a sha256 "$tmp_chk_dir/input" > "$tmp_chk_dir/checksums.sha256" 2>/dev/null || true
    run_test "gnu: --check sha256" \
        "$GNU_TOOL --check '$tmp_chk_dir/checksums.sha256'" \
        "$F_TOOL --check '$tmp_chk_dir/checksums.sha256'"

    $GNU_TOOL -a md5 "$tmp_chk_dir/input" > "$tmp_chk_dir/checksums.md5" 2>/dev/null || true
    run_test "gnu: --check md5" \
        "$GNU_TOOL --check '$tmp_chk_dir/checksums.md5'" \
        "$F_TOOL --check '$tmp_chk_dir/checksums.md5'"

    $GNU_TOOL -a blake2b "$tmp_chk_dir/input" > "$tmp_chk_dir/checksums.b2" 2>/dev/null || true
    run_test "gnu: --check blake2b" \
        "$GNU_TOOL --check '$tmp_chk_dir/checksums.b2'" \
        "$F_TOOL --check '$tmp_chk_dir/checksums.b2'"

    # --check with crc should fail
    $GNU_TOOL -a crc "$tmp_chk_dir/input" > "$tmp_chk_dir/checksums.crc" 2>/dev/null || true
    run_exit_code_test "gnu: --check crc rejected" \
        "$GNU_TOOL --check '$tmp_chk_dir/checksums.crc' 2>&1" \
        "$F_TOOL --check '$tmp_chk_dir/checksums.crc' 2>&1"

    # --tag and --check mutually exclusive
    run_exit_code_test "gnu: --tag --check rejected" \
        "$GNU_TOOL --tag --check /dev/null 2>&1" \
        "$F_TOOL --tag --check /dev/null 2>&1"

    echo ""
    echo "=== GNU Upstream: SYSV Sum ==="

    # From sum-sysv.sh: test cksum -a sysv mode
    local tmp_sysv=$(mktemp /tmp/fcoreutils_cksum_sysv_XXXXXX)
    register_temp "$tmp_sysv"

    echo "hello world" > "$tmp_sysv"
    run_test "gnu: sysv sum hello" \
        "$GNU_TOOL -a sysv '$tmp_sysv'" \
        "$F_TOOL -a sysv '$tmp_sysv'"

    printf 'ABCDEF' > "$tmp_sysv"
    run_test "gnu: sysv sum ABCDEF" \
        "$GNU_TOOL -a sysv '$tmp_sysv'" \
        "$F_TOOL -a sysv '$tmp_sysv'"

    echo ""
    echo "=== GNU Upstream: BSD Tag Format ==="

    # From md5sum-bsd.sh: tagged output and check
    local tmp_bsd_dir=$(mktemp -d /tmp/fcoreutils_cksum_bsd_XXXXXX)
    register_temp "$tmp_bsd_dir"
    echo "a" > "$tmp_bsd_dir/a"
    echo "dd" > "$tmp_bsd_dir/dd"

    # Generate tagged format
    run_test "gnu: -a md5 tagged output" \
        "$GNU_TOOL -a md5 '$tmp_bsd_dir/a'" \
        "$F_TOOL -a md5 '$tmp_bsd_dir/a'"

    # Generate and verify tagged checksum
    $GNU_TOOL -a md5 "$tmp_bsd_dir/a" "$tmp_bsd_dir/dd" > "$tmp_bsd_dir/check.md5" 2>/dev/null || true
    run_test "gnu: --check tagged md5" \
        "$GNU_TOOL --check '$tmp_bsd_dir/check.md5'" \
        "$F_TOOL --check '$tmp_bsd_dir/check.md5'"

    # --text --tag combo should be rejected
    run_exit_code_test "gnu: --text --tag rejected" \
        "$GNU_TOOL --text --tag -a md5 </dev/null 2>&1" \
        "$F_TOOL --text --tag -a md5 </dev/null 2>&1"

    rm -rf "$tmp_chk_dir" "$tmp_bsd_dir"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"


    finish_test_suite
}

run_cksum_tests
