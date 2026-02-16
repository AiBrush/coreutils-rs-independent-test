#!/usr/bin/env bash
# Compatibility tests for fsha1sum vs GNU sha1sum
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sha1sum"
F_TOOL="fsha1sum"

run_sha1sum_tests() {
    init_test_suite "sha1sum"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha1sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha1sum_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU sha1sum not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Hashing ==="

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_empty.txt'"

    run_test "abc" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "fox string" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_fox.txt'"

    run_test "single byte" \
        "$GNU_TOOL '$TEST_DATA_DIR/single_byte.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/single_byte.txt'"

    run_test "binary file" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Stdin ==="

    run_test "stdin simple" \
        "printf 'hello' | $GNU_TOOL" \
        "printf 'hello' | $F_TOOL"

    run_test "stdin empty" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    run_test "stdin binary" \
        "printf '\x00\x01\xff' | $GNU_TOOL" \
        "printf '\x00\x01\xff' | $F_TOOL"

    echo ""
    echo "=== Multiple Files ==="

    run_test "multiple files" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt' '$TEST_DATA_DIR/checksum_empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt' '$TEST_DATA_DIR/checksum_empty.txt'"

    echo ""
    echo "=== Check Mode (-c) ==="

    run_test "check mode" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt' > /tmp/sha1_gnu_check_$$ && $GNU_TOOL -c /tmp/sha1_gnu_check_$$ && rm -f /tmp/sha1_gnu_check_$$" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt' > /tmp/sha1_f_check_$$ && $F_TOOL -c /tmp/sha1_f_check_$$ && rm -f /tmp/sha1_f_check_$$"

    echo ""
    echo "=== Binary Mode (-b) ==="

    run_test "-b binary mode" \
        "$GNU_TOOL -b '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL -b '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Large Files ==="

    run_test "1MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Edge Cases ==="

    run_test "null bytes" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'"

    run_test "unicode" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    finish_test_suite
}

run_sha1sum_tests
