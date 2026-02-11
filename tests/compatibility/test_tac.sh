#!/usr/bin/env bash
# Compatibility tests for ftac vs GNU tac
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tac"
F_TOOL="ftac"

run_tac_tests() {
    init_test_suite "tac"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tac","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tac_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU tac not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Line Reversal ==="

    run_test "basic reversal" \
        "$GNU_TOOL '$TEST_DATA_DIR/tac_simple.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tac_simple.txt'"

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "single line with newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/tac_single_line.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tac_single_line.txt'"

    run_test "no trailing newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/tac_no_trailing_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tac_no_trailing_newline.txt'"

    run_test "single newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/single_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/single_newline.txt'"

    run_test "only newlines" \
        "$GNU_TOOL '$TEST_DATA_DIR/only_newlines.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/only_newlines.txt'"

    run_test "stdin reversal" \
        "printf 'a\nb\nc\n' | $GNU_TOOL" \
        "printf 'a\nb\nc\n' | $F_TOOL"

    run_test "stdin no final newline" \
        "printf 'a\nb\nc' | $GNU_TOOL" \
        "printf 'a\nb\nc' | $F_TOOL"

    echo ""
    echo "=== Custom Separator (-s) ==="

    run_test "-s custom separator (---)" \
        "printf 'part1---part2---part3---' | $GNU_TOOL -s '---'" \
        "printf 'part1---part2---part3---' | $F_TOOL -s '---'"

    run_test "-s comma separator" \
        "printf 'a,b,c,d,' | $GNU_TOOL -s ','" \
        "printf 'a,b,c,d,' | $F_TOOL -s ','"

    run_test "-s colon separator" \
        "printf 'first:second:third:' | $GNU_TOOL -s ':'" \
        "printf 'first:second:third:' | $F_TOOL -s ':'"

    run_test "-s single char separator" \
        "printf 'aXbXcX' | $GNU_TOOL -s 'X'" \
        "printf 'aXbXcX' | $F_TOOL -s 'X'"

    echo ""
    echo "=== Before Mode (-b) ==="

    run_test "-b separator before instead of after" \
        "printf 'line1\nline2\nline3\n' | $GNU_TOOL -b" \
        "printf 'line1\nline2\nline3\n' | $F_TOOL -b"

    run_test "-b with custom separator" \
        "printf 'part1---part2---part3' | $GNU_TOOL -b -s '---'" \
        "printf 'part1---part2---part3' | $F_TOOL -b -s '---'"

    echo ""
    echo "=== Regex Separator (-r) ==="

    run_test "-r regex separator (digits)" \
        "printf 'alpha123beta456gamma789' | $GNU_TOOL -r -s '[0-9]+'" \
        "printf 'alpha123beta456gamma789' | $F_TOOL -r -s '[0-9]+'"

    run_test "-r regex separator (dot)" \
        "printf 'a.b.c.d.' | $GNU_TOOL -r -s '\\.'" \
        "printf 'a.b.c.d.' | $F_TOOL -r -s '\\.'"

    echo ""
    echo "=== Multiple Files ==="

    run_test "two files" \
        "$GNU_TOOL '$TEST_DATA_DIR/tac_simple.txt' '$TEST_DATA_DIR/tac_single_line.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tac_simple.txt' '$TEST_DATA_DIR/tac_single_line.txt'"

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
    echo "=== Binary Data ==="

    run_test "binary file with nulls" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'"

    echo ""
    echo "=== UTF-8 ==="

    run_test "CJK text" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    run_test "emoji" \
        "$GNU_TOOL '$TEST_DATA_DIR/emoji.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/emoji.txt'"

    echo ""
    echo "=== Long Lines ==="

    run_test "10KB line" \
        "$GNU_TOOL '$TEST_DATA_DIR/long_line_10k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/long_line_10k.txt'"

    run_test "1MB line" \
        "$GNU_TOOL '$TEST_DATA_DIR/long_line_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/long_line_1m.txt'"

    echo ""
    echo "=== Large Files ==="

    run_test "1MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt' | md5sum"

    run_test "10MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt' | md5sum"

    echo ""
    echo "=== Symlinks ==="

    if [[ -L "$TEST_DATA_DIR/symlink_to_unsorted" ]]; then
        run_test "symlink file" \
            "$GNU_TOOL '$TEST_DATA_DIR/symlink_to_unsorted'" \
            "$F_TOOL '$TEST_DATA_DIR/symlink_to_unsorted'"
    else
        skip_test "symlink file" "symlinks not available"
    fi

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Stdin vs File ==="

    run_test "stdin vs file" \
        "cat '$TEST_DATA_DIR/tac_simple.txt' | $GNU_TOOL" \
        "cat '$TEST_DATA_DIR/tac_simple.txt' | $F_TOOL"

    finish_test_suite
}

run_tac_tests
