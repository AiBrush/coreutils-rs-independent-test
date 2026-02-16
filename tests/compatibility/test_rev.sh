#!/usr/bin/env bash
# Compatibility tests for frev vs GNU rev
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="rev"
F_TOOL="frev"

run_rev_tests() {
    init_test_suite "rev"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"rev","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/rev_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU rev not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Reversal ==="

    run_test "simple lines" \
        "$GNU_TOOL '$TEST_DATA_DIR/rev_simple.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/rev_simple.txt'"

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "single char" \
        "echo 'a' | $GNU_TOOL" \
        "echo 'a' | $F_TOOL"

    run_test "single line no newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/rev_no_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/rev_no_newline.txt'"

    run_test "stdin reversal" \
        "printf 'hello\nworld\n' | $GNU_TOOL" \
        "printf 'hello\nworld\n' | $F_TOOL"

    run_test "palindrome" \
        "printf 'racecar\nlevel\nmadam\n' | $GNU_TOOL" \
        "printf 'racecar\nlevel\nmadam\n' | $F_TOOL"

    echo ""
    echo "=== Whitespace Handling ==="

    run_test "leading spaces" \
        "printf '  hello\n  world\n' | $GNU_TOOL" \
        "printf '  hello\n  world\n' | $F_TOOL"

    run_test "trailing spaces" \
        "printf 'hello  \nworld  \n' | $GNU_TOOL" \
        "printf 'hello  \nworld  \n' | $F_TOOL"

    run_test "only spaces" \
        "printf '   \n     \n' | $GNU_TOOL" \
        "printf '   \n     \n' | $F_TOOL"

    run_test "tabs" \
        "printf 'a\tb\tc\n' | $GNU_TOOL" \
        "printf 'a\tb\tc\n' | $F_TOOL"

    run_test "blank lines" \
        "$GNU_TOOL '$TEST_DATA_DIR/rev_blank_lines.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/rev_blank_lines.txt'"

    run_test "only newlines" \
        "$GNU_TOOL '$TEST_DATA_DIR/only_newlines.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/only_newlines.txt'"

    echo ""
    echo "=== Numbers and Special Chars ==="

    run_test "numbers" \
        "printf '12345\n67890\n' | $GNU_TOOL" \
        "printf '12345\n67890\n' | $F_TOOL"

    run_test "special characters" \
        "printf '!@#\$%%^&*()\n[]{}|\\\\n' | $GNU_TOOL" \
        "printf '!@#\$%%^&*()\n[]{}|\\\\n' | $F_TOOL"

    run_test "mixed content" \
        "printf 'abc 123 !@#\ndef 456 \$%%^\n' | $GNU_TOOL" \
        "printf 'abc 123 !@#\ndef 456 \$%%^\n' | $F_TOOL"

    echo ""
    echo "=== Unicode / Multibyte ==="

    run_test "CJK text" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    run_test "emoji" \
        "$GNU_TOOL '$TEST_DATA_DIR/emoji.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/emoji.txt'"

    run_test "UTF-8 accents" \
        "$GNU_TOOL '$TEST_DATA_DIR/utf8_accent.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/utf8_accent.txt'"

    run_test "UTF-8 multibyte" \
        "$GNU_TOOL '$TEST_DATA_DIR/utf8_multibyte.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/utf8_multibyte.txt'"

    run_test "combining chars" \
        "$GNU_TOOL '$TEST_DATA_DIR/combining_umlaut.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/combining_umlaut.txt'"

    echo ""
    echo "=== Line Endings ==="

    run_test "unix endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/unix_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/unix_endings.txt'"

    run_test "dos endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/dos_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/dos_endings.txt'"

    run_test "mixed endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/mixed_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/mixed_endings.txt'"

    echo ""
    echo "=== Long Lines ==="

    run_test "10KB line" \
        "$GNU_TOOL '$TEST_DATA_DIR/long_line_10k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/long_line_10k.txt'"

    run_test "1MB line" \
        "$GNU_TOOL '$TEST_DATA_DIR/long_line_1m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/long_line_1m.txt' | md5sum"

    echo ""
    echo "=== Multiple Files ==="

    run_test "two files" \
        "$GNU_TOOL '$TEST_DATA_DIR/rev_simple.txt' '$TEST_DATA_DIR/tac_simple.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/rev_simple.txt' '$TEST_DATA_DIR/tac_simple.txt'"

    echo ""
    echo "=== Large Files ==="

    run_test "1MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt' | md5sum"

    run_test "10MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt' | md5sum"

    echo ""
    echo "=== Binary Data ==="

    run_test "binary with nulls" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'"

    echo ""
    echo "=== CSV Data ==="

    run_test "CSV lines" \
        "$GNU_TOOL '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL '$TEST_DATA_DIR/simple.csv'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Stdin vs File ==="

    run_test "stdin vs file" \
        "cat '$TEST_DATA_DIR/rev_simple.txt' | $GNU_TOOL" \
        "cat '$TEST_DATA_DIR/rev_simple.txt' | $F_TOOL"

    finish_test_suite
}

run_rev_tests
