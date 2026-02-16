#!/usr/bin/env bash
# Compatibility tests for fcksum vs GNU cksum
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="cksum"
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
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    finish_test_suite
}

run_cksum_tests
