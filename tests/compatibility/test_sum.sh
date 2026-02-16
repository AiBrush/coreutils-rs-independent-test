#!/usr/bin/env bash
# Compatibility tests for fsum vs GNU sum
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sum"
F_TOOL="fsum"

run_sum_tests() {
    init_test_suite "sum"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sum_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU sum not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Default (BSD Algorithm) ==="

    run_test "simple text file" \
        "$GNU_TOOL '$TEST_DATA_DIR/basenc_input.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/basenc_input.txt'"

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "single byte" \
        "$GNU_TOOL '$TEST_DATA_DIR/single_byte.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/single_byte.txt'"

    run_test "abc checksum" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "fox checksum" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_fox.txt'"

    run_test "binary file" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_1k.bin'"

    run_test "stdin input" \
        "printf 'hello world' | $GNU_TOOL" \
        "printf 'hello world' | $F_TOOL"

    echo ""
    echo "=== SysV Algorithm (-s) ==="

    run_test "-s simple text" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/basenc_input.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/basenc_input.txt'"

    run_test "-s empty file" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/empty.txt'"

    run_test "-s single byte" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/single_byte.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/single_byte.txt'"

    run_test "-s abc" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "-s fox" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/checksum_fox.txt'"

    run_test "-s binary" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL -s '$TEST_DATA_DIR/random_1k.bin'"

    run_test "-s stdin" \
        "printf 'hello world' | $GNU_TOOL -s" \
        "printf 'hello world' | $F_TOOL -s"

    echo ""
    echo "=== BSD Explicit (-r) ==="

    run_test "-r explicit BSD" \
        "$GNU_TOOL -r '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL -r '$TEST_DATA_DIR/checksum_abc.txt'"

    echo ""
    echo "=== Multiple Files ==="

    run_test "multiple files" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt' '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt' '$TEST_DATA_DIR/empty.txt'"

    run_test "-s multiple files" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'"

    echo ""
    echo "=== Large Files ==="

    run_test "1MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    run_test "1MB file sysv" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Edge Cases ==="

    run_test "all null bytes" \
        "printf '\x00\x00\x00\x00' | $GNU_TOOL" \
        "printf '\x00\x00\x00\x00' | $F_TOOL"

    run_test "all 0xFF bytes" \
        "printf '\xff\xff\xff\xff' | $GNU_TOOL" \
        "printf '\xff\xff\xff\xff' | $F_TOOL"

    run_test "unicode text" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    finish_test_suite
}

run_sum_tests
