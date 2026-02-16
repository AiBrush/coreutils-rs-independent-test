#!/usr/bin/env bash
# Compatibility tests for fnl vs GNU nl
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="nl"
F_TOOL="fnl"

run_nl_tests() {
    init_test_suite "nl"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nl","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/nl_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU nl not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Numbering (default: -b t, number non-blank) ==="

    run_test "simple file" \
        "$GNU_TOOL '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "file with blank lines" \
        "$GNU_TOOL '$TEST_DATA_DIR/nl_blank_lines.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/nl_blank_lines.txt'"

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "single line" \
        "echo 'hello' | $GNU_TOOL" \
        "echo 'hello' | $F_TOOL"

    run_test "stdin" \
        "printf 'line1\nline2\nline3\n' | $GNU_TOOL" \
        "printf 'line1\nline2\nline3\n' | $F_TOOL"

    echo ""
    echo "=== Body Numbering Style (-b) ==="

    run_test "-b a (number all lines)" \
        "$GNU_TOOL -b a '$TEST_DATA_DIR/nl_blank_lines.txt'" \
        "$F_TOOL -b a '$TEST_DATA_DIR/nl_blank_lines.txt'"

    run_test "-b t (number non-blank, default)" \
        "$GNU_TOOL -b t '$TEST_DATA_DIR/nl_blank_lines.txt'" \
        "$F_TOOL -b t '$TEST_DATA_DIR/nl_blank_lines.txt'"

    run_test "-b n (no numbering)" \
        "$GNU_TOOL -b n '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -b n '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-b p regex (number matching lines)" \
        "$GNU_TOOL -b 'pline' '$TEST_DATA_DIR/nl_blank_lines.txt'" \
        "$F_TOOL -b 'pline' '$TEST_DATA_DIR/nl_blank_lines.txt'"

    run_test "-b p with complex regex" \
        "printf 'foo\nbar\nfoo2\nbaz\nfoobar\n' | $GNU_TOOL -b 'p^foo'" \
        "printf 'foo\nbar\nfoo2\nbaz\nfoobar\n' | $F_TOOL -b 'p^foo'"

    echo ""
    echo "=== Number Format (-n) ==="

    run_test "-n ln (left justified)" \
        "$GNU_TOOL -n ln '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -n ln '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-n rn (right justified, default)" \
        "$GNU_TOOL -n rn '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -n rn '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-n rz (right justified, zero-padded)" \
        "$GNU_TOOL -n rz '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -n rz '$TEST_DATA_DIR/nl_simple.txt'"

    echo ""
    echo "=== Number Width (-w) ==="

    run_test "-w 3 (narrow)" \
        "$GNU_TOOL -w 3 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -w 3 '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-w 1 (minimal)" \
        "$GNU_TOOL -w 1 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -w 1 '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-w 10 (wide)" \
        "$GNU_TOOL -w 10 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -w 10 '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-w 3 -n rz (zero-padded narrow)" \
        "$GNU_TOOL -w 3 -n rz '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -w 3 -n rz '$TEST_DATA_DIR/nl_simple.txt'"

    echo ""
    echo "=== Separator (-s) ==="

    run_test "-s '. '" \
        "$GNU_TOOL -s '. ' '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -s '. ' '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-s ':'" \
        "$GNU_TOOL -s ':' '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -s ':' '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-s '' (empty separator)" \
        "$GNU_TOOL -s '' '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -s '' '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-s ' | '" \
        "$GNU_TOOL -s ' | ' '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -s ' | ' '$TEST_DATA_DIR/nl_simple.txt'"

    echo ""
    echo "=== Increment (-i) ==="

    run_test "-i 1 (default)" \
        "$GNU_TOOL -i 1 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -i 1 '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-i 2 (even numbers)" \
        "$GNU_TOOL -i 2 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -i 2 '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-i 5" \
        "$GNU_TOOL -i 5 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -i 5 '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-i 10" \
        "$GNU_TOOL -i 10 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -i 10 '$TEST_DATA_DIR/nl_simple.txt'"

    echo ""
    echo "=== Starting Value (-v) ==="

    run_test "-v 0" \
        "$GNU_TOOL -v 0 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -v 0 '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-v 100" \
        "$GNU_TOOL -v 100 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -v 100 '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-v 1 -i 2 combined" \
        "$GNU_TOOL -v 1 -i 2 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -v 1 -i 2 '$TEST_DATA_DIR/nl_simple.txt'"

    run_test "-v 10 -i 10 -w 4 -n rz combined" \
        "$GNU_TOOL -v 10 -i 10 -w 4 -n rz '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -v 10 -i 10 -w 4 -n rz '$TEST_DATA_DIR/nl_simple.txt'"

    echo ""
    echo "=== Blank Line Counting (-l) ==="

    run_test "-l 1 (count single blank as blank)" \
        "$GNU_TOOL -b a -l 1 '$TEST_DATA_DIR/nl_blank_lines.txt'" \
        "$F_TOOL -b a -l 1 '$TEST_DATA_DIR/nl_blank_lines.txt'"

    run_test "-l 2 (2 consecutive blanks = one blank line)" \
        "$GNU_TOOL -b a -l 2 '$TEST_DATA_DIR/nl_blank_lines.txt'" \
        "$F_TOOL -b a -l 2 '$TEST_DATA_DIR/nl_blank_lines.txt'"

    echo ""
    echo "=== Section Delimiters ==="

    run_test "section delimiters" \
        "$GNU_TOOL '$TEST_DATA_DIR/nl_sections.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/nl_sections.txt'"

    run_test "sections with -b a" \
        "$GNU_TOOL -b a '$TEST_DATA_DIR/nl_sections.txt'" \
        "$F_TOOL -b a '$TEST_DATA_DIR/nl_sections.txt'"

    echo ""
    echo "=== Header and Footer Numbering ==="

    run_test "-h a (number header)" \
        "$GNU_TOOL -h a '$TEST_DATA_DIR/nl_sections.txt'" \
        "$F_TOOL -h a '$TEST_DATA_DIR/nl_sections.txt'"

    run_test "-f a (number footer)" \
        "$GNU_TOOL -f a '$TEST_DATA_DIR/nl_sections.txt'" \
        "$F_TOOL -f a '$TEST_DATA_DIR/nl_sections.txt'"

    run_test "-h a -f a (number all sections)" \
        "$GNU_TOOL -h a -f a '$TEST_DATA_DIR/nl_sections.txt'" \
        "$F_TOOL -h a -f a '$TEST_DATA_DIR/nl_sections.txt'"

    echo ""
    echo "=== Page Reset (-p) ==="

    run_test "-p (no reset at pages)" \
        "$GNU_TOOL -p '$TEST_DATA_DIR/nl_sections.txt'" \
        "$F_TOOL -p '$TEST_DATA_DIR/nl_sections.txt'"

    echo ""
    echo "=== Combined Flags ==="

    run_test "full combo: -b a -n rz -w 4 -s ': ' -v 100 -i 5" \
        "$GNU_TOOL -b a -n rz -w 4 -s ': ' -v 100 -i 5 '$TEST_DATA_DIR/nl_blank_lines.txt'" \
        "$F_TOOL -b a -n rz -w 4 -s ': ' -v 100 -i 5 '$TEST_DATA_DIR/nl_blank_lines.txt'"

    run_test "-b a -n ln -w 2" \
        "$GNU_TOOL -b a -n ln -w 2 '$TEST_DATA_DIR/nl_simple.txt'" \
        "$F_TOOL -b a -n ln -w 2 '$TEST_DATA_DIR/nl_simple.txt'"

    echo ""
    echo "=== Line Endings ==="

    run_test "dos endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/dos_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/dos_endings.txt'"

    echo ""
    echo "=== Unicode ==="

    run_test "CJK text" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    run_test "emoji" \
        "$GNU_TOOL '$TEST_DATA_DIR/emoji.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/emoji.txt'"

    echo ""
    echo "=== Large Files ==="

    run_test "1MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt' | md5sum"

    run_test "10MB file -b a" \
        "$GNU_TOOL -b a '$TEST_DATA_DIR/text_10m.txt' | md5sum" \
        "$F_TOOL -b a '$TEST_DATA_DIR/text_10m.txt' | md5sum"

    echo ""
    echo "=== Edge Cases ==="

    run_test "only newlines" \
        "$GNU_TOOL '$TEST_DATA_DIR/only_newlines.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/only_newlines.txt'"

    run_test "no trailing newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    finish_test_suite
}

run_nl_tests
