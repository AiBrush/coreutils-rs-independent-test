#!/usr/bin/env bash
# Compatibility tests for fcat vs GNU cat
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="cat"
F_TOOL="fcat"

run_cat_tests() {
    init_test_suite "cat"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cat","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/cat_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU cat not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Concatenation ==="

    run_test "single file" \
        "$GNU_TOOL '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "two files" \
        "$GNU_TOOL '$TEST_DATA_DIR/tac_simple.txt' '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tac_simple.txt' '$TEST_DATA_DIR/unsorted.txt'"

    run_test "three files" \
        "$GNU_TOOL '$TEST_DATA_DIR/tac_simple.txt' '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tac_simple.txt' '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/unsorted.txt'"

    run_test "single line no newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'"

    run_test "stdin passthrough" \
        "printf 'hello world\n' | $GNU_TOOL" \
        "printf 'hello world\n' | $F_TOOL"

    echo ""
    echo "=== Number Lines (-n) ==="

    run_test "-n number all lines" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-n with blank lines" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/cat_squeeze.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/cat_squeeze.txt'"

    run_test "-n empty file" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/empty.txt'"

    run_test "-n single line" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/with_trailing_newline.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/with_trailing_newline.txt'"

    run_test "-n no trailing newline" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/no_trailing_newline.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/no_trailing_newline.txt'"

    run_test "-n multiple files" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/tac_simple.txt' '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/tac_simple.txt' '$TEST_DATA_DIR/unsorted.txt'"

    echo ""
    echo "=== Number Non-Blank (-b) ==="

    run_test "-b number non-blank" \
        "$GNU_TOOL -b '$TEST_DATA_DIR/cat_squeeze.txt'" \
        "$F_TOOL -b '$TEST_DATA_DIR/cat_squeeze.txt'"

    run_test "-b with blank lines file" \
        "$GNU_TOOL -b '$TEST_DATA_DIR/nl_blank_lines.txt'" \
        "$F_TOOL -b '$TEST_DATA_DIR/nl_blank_lines.txt'"

    run_test "-b overrides -n" \
        "$GNU_TOOL -bn '$TEST_DATA_DIR/cat_squeeze.txt'" \
        "$F_TOOL -bn '$TEST_DATA_DIR/cat_squeeze.txt'"

    echo ""
    echo "=== Squeeze Blank Lines (-s) ==="

    run_test "-s squeeze blanks" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/cat_squeeze.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/cat_squeeze.txt'"

    run_test "-sn squeeze and number" \
        "$GNU_TOOL -sn '$TEST_DATA_DIR/cat_squeeze.txt'" \
        "$F_TOOL -sn '$TEST_DATA_DIR/cat_squeeze.txt'"

    run_test "-sb squeeze and number non-blank" \
        "$GNU_TOOL -sb '$TEST_DATA_DIR/cat_squeeze.txt'" \
        "$F_TOOL -sb '$TEST_DATA_DIR/cat_squeeze.txt'"

    run_test "-s only newlines file" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/only_newlines.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/only_newlines.txt'"

    echo ""
    echo "=== Show Ends (-E) ==="

    run_test "-E show line ends" \
        "$GNU_TOOL -E '$TEST_DATA_DIR/tac_simple.txt'" \
        "$F_TOOL -E '$TEST_DATA_DIR/tac_simple.txt'"

    run_test "-E with tabs" \
        "$GNU_TOOL -E '$TEST_DATA_DIR/tabs.txt'" \
        "$F_TOOL -E '$TEST_DATA_DIR/tabs.txt'"

    run_test "-E no trailing newline" \
        "$GNU_TOOL -E '$TEST_DATA_DIR/no_trailing_newline.txt'" \
        "$F_TOOL -E '$TEST_DATA_DIR/no_trailing_newline.txt'"

    echo ""
    echo "=== Show Tabs (-T) ==="

    run_test "-T show tabs" \
        "$GNU_TOOL -T '$TEST_DATA_DIR/tabs.txt'" \
        "$F_TOOL -T '$TEST_DATA_DIR/tabs.txt'"

    run_test "-T only tabs" \
        "$GNU_TOOL -T '$TEST_DATA_DIR/only_tabs.txt'" \
        "$F_TOOL -T '$TEST_DATA_DIR/only_tabs.txt'"

    run_test "-T mixed whitespace" \
        "$GNU_TOOL -T '$TEST_DATA_DIR/whitespace_only.txt'" \
        "$F_TOOL -T '$TEST_DATA_DIR/whitespace_only.txt'"

    echo ""
    echo "=== Show Non-Printing (-v) ==="

    run_test "-v nonprinting chars" \
        "$GNU_TOOL -v '$TEST_DATA_DIR/cat_nonprinting.txt'" \
        "$F_TOOL -v '$TEST_DATA_DIR/cat_nonprinting.txt'"

    echo ""
    echo "=== Show All (-A = -vET) ==="

    run_test "-A show all" \
        "$GNU_TOOL -A '$TEST_DATA_DIR/cat_special_chars.txt'" \
        "$F_TOOL -A '$TEST_DATA_DIR/cat_special_chars.txt'"

    run_test "-A tabs file" \
        "$GNU_TOOL -A '$TEST_DATA_DIR/tabs.txt'" \
        "$F_TOOL -A '$TEST_DATA_DIR/tabs.txt'"

    echo ""
    echo "=== Combined Flags ==="

    run_test "-nET combined" \
        "$GNU_TOOL -nET '$TEST_DATA_DIR/cat_special_chars.txt'" \
        "$F_TOOL -nET '$TEST_DATA_DIR/cat_special_chars.txt'"

    run_test "-nsE combined" \
        "$GNU_TOOL -nsE '$TEST_DATA_DIR/cat_squeeze.txt'" \
        "$F_TOOL -nsE '$TEST_DATA_DIR/cat_squeeze.txt'"

    echo ""
    echo "=== Line Endings ==="

    run_test "dos endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/dos_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/dos_endings.txt'"

    run_test "-A dos endings (show CR)" \
        "$GNU_TOOL -A '$TEST_DATA_DIR/dos_endings.txt'" \
        "$F_TOOL -A '$TEST_DATA_DIR/dos_endings.txt'"

    run_test "mixed endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/mixed_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/mixed_endings.txt'"

    echo ""
    echo "=== Unicode / Multibyte ==="

    run_test "CJK text" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    run_test "-n CJK text" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/cjk.txt'"

    run_test "emoji" \
        "$GNU_TOOL '$TEST_DATA_DIR/emoji.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/emoji.txt'"

    echo ""
    echo "=== Binary Data ==="

    run_test "binary with nulls" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'"

    run_test "random binary" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_1k.bin' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/random_1k.bin' | md5sum"

    echo ""
    echo "=== Large Files ==="

    run_test "1MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt' | md5sum"

    run_test "10MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt' | md5sum"

    run_test "10MB file with -n" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/text_10m.txt' | md5sum" \
        "$F_TOOL -n '$TEST_DATA_DIR/text_10m.txt' | md5sum"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

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
    echo "=== Multiple Small Files ==="

    local many_files=""
    for i in $(seq 1 10); do
        many_files="$many_files '$TEST_DATA_DIR/many_files/file_$(printf '%04d' $i).txt'"
    done
    run_test "10 files concatenated" \
        "eval $GNU_TOOL $many_files | md5sum" \
        "eval $F_TOOL $many_files | md5sum"

    finish_test_suite
}

run_cat_tests
