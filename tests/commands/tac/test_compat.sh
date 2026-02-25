#!/usr/bin/env bash
# Compatibility tests for ftac vs GNU tac
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "tac")
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
    echo "=== GNU Upstream: Basic Reversal Patterns (tac.pl) ==="

    # From tac.pl: basic-a - single char no newline
    run_test "gnu basic-a: single char no newline" \
        "printf 'a' | $GNU_TOOL" \
        "printf 'a' | $F_TOOL"

    # From tac.pl: basic-b - single newline
    run_test "gnu basic-b: single newline" \
        "printf '\n' | $GNU_TOOL" \
        "printf '\n' | $F_TOOL"

    # From tac.pl: basic-c - single line with newline
    run_test "gnu basic-c: single line with newline" \
        "printf 'a\n' | $GNU_TOOL" \
        "printf 'a\n' | $F_TOOL"

    # From tac.pl: basic-d - two lines, no trailing newline
    run_test "gnu basic-d: two lines no trailing newline" \
        "printf 'a\nb' | $GNU_TOOL" \
        "printf 'a\nb' | $F_TOOL"

    # From tac.pl: basic-e - two lines with trailing newline
    run_test "gnu basic-e: two lines with trailing newline" \
        "printf 'a\nb\n' | $GNU_TOOL" \
        "printf 'a\nb\n' | $F_TOOL"

    # From tac.pl: basic-f - different length lines
    run_test "gnu basic-f: 7-char and 1-char lines" \
        "printf '1234567\n8\n' | $GNU_TOOL" \
        "printf '1234567\n8\n' | $F_TOOL"

    # From tac.pl: basic-g - 8-char and 1-char lines
    run_test "gnu basic-g: 8-char and 1-char lines" \
        "printf '12345678\n9\n' | $GNU_TOOL" \
        "printf '12345678\n9\n' | $F_TOOL"

    # From tac.pl: basic-h through basic-k - various line lengths
    run_test "gnu basic-h: 6-char and 1-char lines" \
        "printf '123456\n8\n' | $GNU_TOOL" \
        "printf '123456\n8\n' | $F_TOOL"

    run_test "gnu basic-i: 5-char and 1-char lines" \
        "printf '12345\n8\n' | $GNU_TOOL" \
        "printf '12345\n8\n' | $F_TOOL"

    run_test "gnu basic-j: 4-char and 1-char lines" \
        "printf '1234\n8\n' | $GNU_TOOL" \
        "printf '1234\n8\n' | $F_TOOL"

    run_test "gnu basic-k: 3-char and 1-char lines" \
        "printf '123\n8\n' | $GNU_TOOL" \
        "printf '123\n8\n' | $F_TOOL"

    echo ""
    echo "=== GNU Upstream: NUL Separator (tac.pl) ==="

    # From tac.pl: nul-0 through nul-e - NUL as separator with -s ""
    run_test "gnu nul-a: single char with nul sep" \
        "printf 'a' | $GNU_TOOL -s ''" \
        "printf 'a' | $F_TOOL -s ''"

    run_test "gnu nul-b: single NUL with nul sep" \
        "printf '\0' | $GNU_TOOL -s ''" \
        "printf '\0' | $F_TOOL -s ''"

    run_test "gnu nul-c: char+NUL with nul sep" \
        "printf 'a\0' | $GNU_TOOL -s ''" \
        "printf 'a\0' | $F_TOOL -s ''"

    run_test "gnu nul-d: two parts no trailing NUL" \
        "printf 'a\0b' | $GNU_TOOL -s ''" \
        "printf 'a\0b' | $F_TOOL -s ''"

    run_test "gnu nul-e: two parts with trailing NUL" \
        "printf 'a\0b\0' | $GNU_TOOL -s ''" \
        "printf 'a\0b\0' | $F_TOOL -s ''"

    echo ""
    echo "=== GNU Upstream: Option Combinations (tac.pl) ==="

    # From tac.pl: opt-b - before flag with newline input
    run_test "gnu opt-b: -b with leading newline" \
        "printf '\na\nb\nc' | $GNU_TOOL -b" \
        "printf '\na\nb\nc' | $F_TOOL -b"

    # From tac.pl: opt-s - custom separator colon
    run_test "gnu opt-s: -s colon" \
        "printf 'a:b:c:' | $GNU_TOOL -s ':'" \
        "printf 'a:b:c:' | $F_TOOL -s ':'"

    # From tac.pl: opt-sb - combined -s and -b with colon
    run_test "gnu opt-sb: -s colon -b" \
        "printf ':a:b:c' | $GNU_TOOL -s ':' -b" \
        "printf ':a:b:c' | $F_TOOL -s ':' -b"

    # From tac.pl: opt-r - regex separator with underscore-dot pattern
    run_test "gnu opt-r: regex separator \\._+" \
        "printf '1._2.__3.___4._' | $GNU_TOOL -r -s '\\._+'" \
        "printf '1._2.__3.___4._' | $F_TOOL -r -s '\\._+'"

    # From tac.pl: opt-r2 - longer regex separator input
    run_test "gnu opt-r2: regex separator longer input" \
        "printf 'a.___b.__1._2.__3.___4._' | $GNU_TOOL -r -s '\\._+'" \
        "printf 'a.___b.__1._2.__3.___4._' | $F_TOOL -r -s '\\._+'"

    # From tac.pl: opt-br - combined -b -r
    run_test "gnu opt-br: -b -r combined" \
        "printf '._1._2.__3.___4' | $GNU_TOOL -b -r -s '\\._+'" \
        "printf '._1._2.__3.___4' | $F_TOOL -b -r -s '\\._+'"

    # From tac.pl: opt-br2 - combined -b -r longer input
    run_test "gnu opt-br2: -b -r longer input" \
        "printf '.__x.___y.____z._1._2.__3.___4' | $GNU_TOOL -b -r -s '\\._+'" \
        "printf '.__x.___y.____z._1._2.__3.___4' | $F_TOOL -b -r -s '\\._+'"

    echo ""
    echo "=== GNU Upstream: Regex Anchors (tac.pl) ==="

    # From tac.pl: opt-r3 - regex separator with ^ anchor
    run_test "gnu opt-r3: -r -s ^ anchor" \
        "printf 'a\nb\nc\n' | $GNU_TOOL -r -s '^'" \
        "printf 'a\nb\nc\n' | $F_TOOL -r -s '^'"

    # From tac.pl: opt-r4 - regex separator with $ anchor
    run_test "gnu opt-r4: -r -s dollar anchor" \
        "printf 'a\nb\nc\n' | $GNU_TOOL -r -s '$'" \
        "printf 'a\nb\nc\n' | $F_TOOL -r -s '$'"

    # From tac.pl: opt-r5 - regex separator with ^$ anchor
    run_test "gnu opt-r5: -r -s ^$ empty line anchor" \
        "printf 'a\nb\nc\n' | $GNU_TOOL -r -s '^$'" \
        "printf 'a\nb\nc\n' | $F_TOOL -r -s '^$'"

    echo ""
    echo "=== GNU Upstream: Segfault Regression (tac.pl) ==="

    # From tac.pl: segfault - -r with two inputs
    run_test "gnu segfault: -r with two inputs" \
        "printf 'a\nb\n' | $GNU_TOOL -r" \
        "printf 'a\nb\n' | $F_TOOL -r"

    echo ""
    echo "=== GNU Upstream: Long Line Double-Free Regression (tac.pl) ==="

    # From tac.pl: double-free - line longer than 16KiB to trigger double free in coreutils-8.5
    run_test "gnu double-free: 16KiB+ line" \
        "python3 -c \"print('o' * (16 * 1024 + 1), end='')\" | $GNU_TOOL" \
        "python3 -c \"print('o' * (16 * 1024 + 1), end='')\" | $F_TOOL"

    echo ""
    echo "=== GNU Upstream: Stdin with Duplicate Args (tac-2-nonseekable.sh) ==="

    # From tac-2-nonseekable.sh: tac - - reads stdin twice (merged output)
    run_test "gnu stdin duplicate: tac - -" \
        "echo x | $GNU_TOOL - -" \
        "echo x | $F_TOOL - -"

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
