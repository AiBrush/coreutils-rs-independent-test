#!/usr/bin/env bash
# Compatibility tests for fsha224sum vs GNU sha224sum
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sha224sum"
F_TOOL="fsha224sum"

run_sha224sum_tests() {
    init_test_suite "sha224sum"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha224sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha224sum_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU sha224sum not found, cannot compare" >&2
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

    run_test "binary file" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Stdin ==="

    run_test "stdin" \
        "printf 'hello' | $GNU_TOOL" \
        "printf 'hello' | $F_TOOL"

    run_test "stdin empty" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    echo ""
    echo "=== Multiple Files ==="

    run_test "multiple files" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'"

    echo ""
    echo "=== Check Mode (-c) ==="

    run_test "check mode" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt' > /tmp/sha224_gnu_$$ && $GNU_TOOL -c /tmp/sha224_gnu_$$ && rm -f /tmp/sha224_gnu_$$" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt' > /tmp/sha224_f_$$ && $F_TOOL -c /tmp/sha224_f_$$ && rm -f /tmp/sha224_f_$$"

    echo ""
    echo "=== Large Files ==="

    run_test "1MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    finish_test_suite
}

run_sha224sum_tests
