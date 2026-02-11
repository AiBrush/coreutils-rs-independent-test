#!/usr/bin/env bash
# Compatibility tests for fwc vs GNU wc
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="wc"
F_TOOL="fwc"

run_wc_tests() {
    init_test_suite "wc"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"wc","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/wc_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU wc not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Empty / Tiny Input Tests ==="

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "single byte file" \
        "$GNU_TOOL '$TEST_DATA_DIR/single_byte.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/single_byte.txt'"

    run_test "no trailing newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'"

    run_test "with trailing newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/with_trailing_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/with_trailing_newline.txt'"

    run_test "single newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/single_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/single_newline.txt'"

    run_test "only newlines" \
        "$GNU_TOOL '$TEST_DATA_DIR/only_newlines.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/only_newlines.txt'"

    run_test "empty stdin" \
        "echo -n '' | $GNU_TOOL" \
        "echo -n '' | $F_TOOL"

    echo ""
    echo "=== Whitespace Tests ==="

    run_test "whitespace only file" \
        "$GNU_TOOL '$TEST_DATA_DIR/whitespace_only.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/whitespace_only.txt'"

    run_test "spaces no newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/spaces_no_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/spaces_no_newline.txt'"

    run_test "tabs no newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/tabs_no_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tabs_no_newline.txt'"

    echo ""
    echo "=== Flag Tests (-c byte count) ==="

    run_test "-c empty" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/empty.txt'"

    run_test "-c text file" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/text_100k.txt'"

    run_test "-c binary file" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL -c '$TEST_DATA_DIR/random_1k.bin'"

    run_test "-c stdin" \
        "echo 'hello world' | $GNU_TOOL -c" \
        "echo 'hello world' | $F_TOOL -c"

    echo ""
    echo "=== Flag Tests (-l line count) ==="

    run_test "-l empty" \
        "$GNU_TOOL -l '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -l '$TEST_DATA_DIR/empty.txt'"

    run_test "-l no trailing newline" \
        "$GNU_TOOL -l '$TEST_DATA_DIR/no_trailing_newline.txt'" \
        "$F_TOOL -l '$TEST_DATA_DIR/no_trailing_newline.txt'"

    run_test "-l text file" \
        "$GNU_TOOL -l '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL -l '$TEST_DATA_DIR/text_100k.txt'"

    run_test "-l only newlines" \
        "$GNU_TOOL -l '$TEST_DATA_DIR/only_newlines.txt'" \
        "$F_TOOL -l '$TEST_DATA_DIR/only_newlines.txt'"

    run_test "-l stdin" \
        "printf 'a\nb\nc\n' | $GNU_TOOL -l" \
        "printf 'a\nb\nc\n' | $F_TOOL -l"

    run_test "-l stdin no final newline" \
        "printf 'a\nb\nc' | $GNU_TOOL -l" \
        "printf 'a\nb\nc' | $F_TOOL -l"

    echo ""
    echo "=== Flag Tests (-w word count) ==="

    run_test "-w empty" \
        "$GNU_TOOL -w '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -w '$TEST_DATA_DIR/empty.txt'"

    run_test "-w whitespace only" \
        "$GNU_TOOL -w '$TEST_DATA_DIR/whitespace_only.txt'" \
        "$F_TOOL -w '$TEST_DATA_DIR/whitespace_only.txt'"

    run_test "-w text file" \
        "$GNU_TOOL -w '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL -w '$TEST_DATA_DIR/text_100k.txt'"

    run_test "-w single word" \
        "echo 'hello' | $GNU_TOOL -w" \
        "echo 'hello' | $F_TOOL -w"

    run_test "-w multiple spaces between words" \
        "echo 'hello    world   test' | $GNU_TOOL -w" \
        "echo 'hello    world   test' | $F_TOOL -w"

    echo ""
    echo "=== Flag Tests (-m character count) ==="

    run_test "-m ASCII file" \
        "$GNU_TOOL -m '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -m '$TEST_DATA_DIR/simple.csv'"

    run_test "-m UTF-8 CJK" \
        "$GNU_TOOL -m '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL -m '$TEST_DATA_DIR/cjk.txt'"

    run_test "-m emoji" \
        "$GNU_TOOL -m '$TEST_DATA_DIR/emoji.txt'" \
        "$F_TOOL -m '$TEST_DATA_DIR/emoji.txt'"

    run_test "-m combining umlaut" \
        "$GNU_TOOL -m '$TEST_DATA_DIR/combining_umlaut.txt'" \
        "$F_TOOL -m '$TEST_DATA_DIR/combining_umlaut.txt'"

    run_test "-m vs -c on UTF-8" \
        "$GNU_TOOL -m '$TEST_DATA_DIR/utf8_multibyte.txt'" \
        "$F_TOOL -m '$TEST_DATA_DIR/utf8_multibyte.txt'"

    run_test "-m empty" \
        "$GNU_TOOL -m '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -m '$TEST_DATA_DIR/empty.txt'"

    echo ""
    echo "=== Flag Tests (-L max line length) ==="

    run_test "-L empty" \
        "$GNU_TOOL -L '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -L '$TEST_DATA_DIR/empty.txt'"

    run_test "-L simple text" \
        "$GNU_TOOL -L '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -L '$TEST_DATA_DIR/simple.csv'"

    run_test "-L with tabs (tab stop at 8)" \
        "$GNU_TOOL -L '$TEST_DATA_DIR/tabs.txt'" \
        "$F_TOOL -L '$TEST_DATA_DIR/tabs.txt'"

    run_test "-L only tabs" \
        "$GNU_TOOL -L '$TEST_DATA_DIR/only_tabs.txt'" \
        "$F_TOOL -L '$TEST_DATA_DIR/only_tabs.txt'"

    run_test "-L tab at position 8" \
        "$GNU_TOOL -L '$TEST_DATA_DIR/tab_at_8.txt'" \
        "$F_TOOL -L '$TEST_DATA_DIR/tab_at_8.txt'"

    run_test "-L long line 10k" \
        "$GNU_TOOL -L '$TEST_DATA_DIR/long_line_10k.txt'" \
        "$F_TOOL -L '$TEST_DATA_DIR/long_line_10k.txt'"

    run_test "-L CJK" \
        "$GNU_TOOL -L '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL -L '$TEST_DATA_DIR/cjk.txt'"

    echo ""
    echo "=== Combined Flags ==="

    run_test "-lw (lines and words)" \
        "$GNU_TOOL -lw '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL -lw '$TEST_DATA_DIR/text_100k.txt'"

    run_test "-lc (lines and bytes)" \
        "$GNU_TOOL -lc '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL -lc '$TEST_DATA_DIR/text_100k.txt'"

    run_test "-lwc (all three)" \
        "$GNU_TOOL -lwc '$TEST_DATA_DIR/text_100k.txt'" \
        "$F_TOOL -lwc '$TEST_DATA_DIR/text_100k.txt'"

    run_test "-cm (chars and bytes mismatch on UTF-8)" \
        "$GNU_TOOL -cm '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL -cm '$TEST_DATA_DIR/cjk.txt'"

    run_test "-Lw (max line and words)" \
        "$GNU_TOOL -Lw '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -Lw '$TEST_DATA_DIR/simple.csv'"

    echo ""
    echo "=== Multiple Files ==="

    run_test "two files" \
        "$GNU_TOOL '$TEST_DATA_DIR/simple.csv' '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/simple.csv' '$TEST_DATA_DIR/unsorted.txt'"

    run_test "three files with flags" \
        "$GNU_TOOL -lw '$TEST_DATA_DIR/simple.csv' '$TEST_DATA_DIR/unsorted.txt' '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL -lw '$TEST_DATA_DIR/simple.csv' '$TEST_DATA_DIR/unsorted.txt' '$TEST_DATA_DIR/duplicates.txt'"

    # --total flag (GNU wc shows total for multiple files by default)
    run_test "multiple files total line" \
        "$GNU_TOOL '$TEST_DATA_DIR/simple.csv' '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/simple.csv' '$TEST_DATA_DIR/unsorted.txt'"

    echo ""
    echo "=== Line Ending Tests ==="

    run_test "unix line endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/unix_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/unix_endings.txt'"

    run_test "dos line endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/dos_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/dos_endings.txt'"

    run_test "CR-only endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/cr_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cr_endings.txt'"

    run_test "mixed line endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/mixed_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/mixed_endings.txt'"

    echo ""
    echo "=== Binary Data ==="

    run_test "binary file with null bytes" \
        "$GNU_TOOL '$TEST_DATA_DIR/null_bytes.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/null_bytes.bin'"

    run_test "text with embedded nulls" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'"

    run_test "random binary 1k" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Stdin vs File ==="

    run_test "stdin vs file (same content)" \
        "cat '$TEST_DATA_DIR/simple.csv' | $GNU_TOOL" \
        "cat '$TEST_DATA_DIR/simple.csv' | $F_TOOL"

    run_test "stdin -l" \
        "cat '$TEST_DATA_DIR/text_100k.txt' | $GNU_TOOL -l" \
        "cat '$TEST_DATA_DIR/text_100k.txt' | $F_TOOL -l"

    echo ""
    echo "=== Symlinks ==="

    if [[ -L "$TEST_DATA_DIR/symlink_to_csv" ]]; then
        run_test "symlink file" \
            "$GNU_TOOL '$TEST_DATA_DIR/symlink_to_csv'" \
            "$F_TOOL '$TEST_DATA_DIR/symlink_to_csv'"
    else
        skip_test "symlink file" "symlinks not available"
    fi

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    if [[ -f "$TEST_DATA_DIR/unreadable.txt" ]]; then
        run_exit_code_test "permission denied" \
            "$GNU_TOOL '$TEST_DATA_DIR/unreadable.txt' 2>&1" \
            "$F_TOOL '$TEST_DATA_DIR/unreadable.txt' 2>&1"
    fi

    echo ""
    echo "=== Locale Sensitivity ==="

    run_test "LC_ALL=C default count" \
        "LC_ALL=C $GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "LC_ALL=C $F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    run_test "LC_ALL=C -m char count" \
        "LC_ALL=C $GNU_TOOL -m '$TEST_DATA_DIR/cjk.txt'" \
        "LC_ALL=C $F_TOOL -m '$TEST_DATA_DIR/cjk.txt'"

    run_test "LC_ALL=en_US.UTF-8 -m char count" \
        "LC_ALL=en_US.UTF-8 $GNU_TOOL -m '$TEST_DATA_DIR/cjk.txt'" \
        "LC_ALL=en_US.UTF-8 $F_TOOL -m '$TEST_DATA_DIR/cjk.txt'"

    echo ""
    echo "=== Long Line Tests ==="

    run_test "10KB line" \
        "$GNU_TOOL '$TEST_DATA_DIR/long_line_10k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/long_line_10k.txt'"

    run_test "1MB line" \
        "$GNU_TOOL '$TEST_DATA_DIR/long_line_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/long_line_1m.txt'"

    run_test "1MB line -L" \
        "$GNU_TOOL -L '$TEST_DATA_DIR/long_line_1m.txt'" \
        "$F_TOOL -L '$TEST_DATA_DIR/long_line_1m.txt'"

    echo ""
    echo "=== files0-from ==="

    local filelist
    filelist=$(mktemp /tmp/fcoreutils_filelist_XXXXXX)
    printf '%s\0' "$TEST_DATA_DIR/simple.csv" "$TEST_DATA_DIR/unsorted.txt" > "$filelist"
    register_temp "$filelist"

    run_test "--files0-from" \
        "$GNU_TOOL --files0-from='$filelist'" \
        "$F_TOOL --files0-from='$filelist'"

    # files0-from with empty file
    local empty_filelist
    empty_filelist=$(mktemp /tmp/fcoreutils_emptylist_XXXXXX)
    register_temp "$empty_filelist"
    touch "$empty_filelist"

    run_test "--files0-from empty list" \
        "$GNU_TOOL --files0-from='$empty_filelist'" \
        "$F_TOOL --files0-from='$empty_filelist'"

    echo ""
    echo "=== Larger File Tests ==="

    run_test "1MB file default" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    run_test "10MB file -l" \
        "$GNU_TOOL -l '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -l '$TEST_DATA_DIR/text_10m.txt'"

    run_test "10MB file -w" \
        "$GNU_TOOL -w '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -w '$TEST_DATA_DIR/text_10m.txt'"

    run_test "10MB file -c" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/text_10m.txt'"

    run_test "10MB file all flags" \
        "$GNU_TOOL -lwcmL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL -lwcmL '$TEST_DATA_DIR/text_10m.txt'"

    finish_test_suite
}

run_wc_tests
