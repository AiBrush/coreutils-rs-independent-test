#!/usr/bin/env bash
# Compatibility tests for funiq vs GNU uniq
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "uniq")
F_TOOL="funiq"

run_uniq_tests() {
    init_test_suite "uniq"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"uniq","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/uniq_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU uniq not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Dedup (Adjacent) ==="

    run_test "basic dedup" \
        "$GNU_TOOL '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/duplicates.txt'"

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "all unique (adjacent)" \
        "$GNU_TOOL '$TEST_DATA_DIR/adjacent_unique.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/adjacent_unique.txt'"

    run_test "single line" \
        "echo 'hello' | $GNU_TOOL" \
        "echo 'hello' | $F_TOOL"

    run_test "all same" \
        "printf 'aaa\naaa\naaa\n' | $GNU_TOOL" \
        "printf 'aaa\naaa\naaa\n' | $F_TOOL"

    run_test "no trailing newline" \
        "printf 'a\na\nb' | $GNU_TOOL" \
        "printf 'a\na\nb' | $F_TOOL"

    run_test "stdin dedup" \
        "printf 'apple\napple\nbanana\nbanana\n' | $GNU_TOOL" \
        "printf 'apple\napple\nbanana\nbanana\n' | $F_TOOL"

    echo ""
    echo "=== Count Mode (-c) ==="

    run_test "-c count" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/duplicates.txt'"

    run_test "-c all unique" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/adjacent_unique.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/adjacent_unique.txt'"

    run_test "-c all same" \
        "printf 'x\nx\nx\n' | $GNU_TOOL -c" \
        "printf 'x\nx\nx\n' | $F_TOOL -c"

    run_test "-c empty file" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/empty.txt'"

    echo ""
    echo "=== Duplicate Only (-d) ==="

    run_test "-d show duplicates only" \
        "$GNU_TOOL -d '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL -d '$TEST_DATA_DIR/duplicates.txt'"

    run_test "-d no duplicates" \
        "$GNU_TOOL -d '$TEST_DATA_DIR/adjacent_unique.txt'" \
        "$F_TOOL -d '$TEST_DATA_DIR/adjacent_unique.txt'"

    run_test "-d all same" \
        "printf 'x\nx\nx\n' | $GNU_TOOL -d" \
        "printf 'x\nx\nx\n' | $F_TOOL -d"

    echo ""
    echo "=== All Duplicates (-D) ==="

    run_test "-D all repeated" \
        "$GNU_TOOL -D '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL -D '$TEST_DATA_DIR/duplicates.txt'"

    run_test "-D no duplicates" \
        "$GNU_TOOL -D '$TEST_DATA_DIR/adjacent_unique.txt'" \
        "$F_TOOL -D '$TEST_DATA_DIR/adjacent_unique.txt'"

    echo ""
    echo "=== --all-repeated with method ==="

    run_test "--all-repeated=none" \
        "$GNU_TOOL --all-repeated=none '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL --all-repeated=none '$TEST_DATA_DIR/duplicates.txt'"

    run_test "--all-repeated=prepend" \
        "$GNU_TOOL --all-repeated=prepend '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL --all-repeated=prepend '$TEST_DATA_DIR/duplicates.txt'"

    run_test "--all-repeated=separate" \
        "$GNU_TOOL --all-repeated=separate '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL --all-repeated=separate '$TEST_DATA_DIR/duplicates.txt'"

    echo ""
    echo "=== Unique Only (-u) ==="

    run_test "-u unique only" \
        "$GNU_TOOL -u '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL -u '$TEST_DATA_DIR/duplicates.txt'"

    run_test "-u all duplicates" \
        "printf 'x\nx\ny\ny\n' | $GNU_TOOL -u" \
        "printf 'x\nx\ny\ny\n' | $F_TOOL -u"

    run_test "-u all unique" \
        "$GNU_TOOL -u '$TEST_DATA_DIR/adjacent_unique.txt'" \
        "$F_TOOL -u '$TEST_DATA_DIR/adjacent_unique.txt'"

    echo ""
    echo "=== Case Insensitive (-i) ==="

    run_test "-i case insensitive" \
        "$GNU_TOOL -i '$TEST_DATA_DIR/case_duplicates.txt'" \
        "$F_TOOL -i '$TEST_DATA_DIR/case_duplicates.txt'"

    run_test "-i -c case insensitive count" \
        "$GNU_TOOL -ic '$TEST_DATA_DIR/case_duplicates.txt'" \
        "$F_TOOL -ic '$TEST_DATA_DIR/case_duplicates.txt'"

    run_test "-i -d case insensitive duplicates" \
        "$GNU_TOOL -id '$TEST_DATA_DIR/case_duplicates.txt'" \
        "$F_TOOL -id '$TEST_DATA_DIR/case_duplicates.txt'"

    echo ""
    echo "=== Skip Fields (-f) ==="

    run_test "-f1 skip 1 field" \
        "printf 'a hello\nb hello\nc world\nd world\n' | $GNU_TOOL -f1" \
        "printf 'a hello\nb hello\nc world\nd world\n' | $F_TOOL -f1"

    run_test "-f2 skip 2 fields" \
        "printf 'a b same\nc d same\ne f diff\n' | $GNU_TOOL -f2" \
        "printf 'a b same\nc d same\ne f diff\n' | $F_TOOL -f2"

    echo ""
    echo "=== Skip Characters (-s) ==="

    run_test "-s1 skip 1 char" \
        "printf 'ahello\nbhello\ncworld\n' | $GNU_TOOL -s1" \
        "printf 'ahello\nbhello\ncworld\n' | $F_TOOL -s1"

    run_test "-s3 skip 3 chars" \
        "printf 'xxxhello\nyyyworld\nzzzworld\n' | $GNU_TOOL -s3" \
        "printf 'xxxhello\nyyyworld\nzzzworld\n' | $F_TOOL -s3"

    echo ""
    echo "=== Compare N Characters (-w) ==="

    run_test "-w3 compare first 3 chars" \
        "printf 'abcXXX\nabcYYY\ndefZZZ\n' | $GNU_TOOL -w3" \
        "printf 'abcXXX\nabcYYY\ndefZZZ\n' | $F_TOOL -w3"

    run_test "-w1 compare first char only" \
        "printf 'apple\napricot\nbanana\nblueberry\n' | $GNU_TOOL -w1" \
        "printf 'apple\napricot\nbanana\nblueberry\n' | $F_TOOL -w1"

    echo ""
    echo "=== Zero-Terminated (-z) ==="

    run_test "-z null-terminated" \
        "printf 'apple\0apple\0banana\0banana\0cherry\0' | $GNU_TOOL -z" \
        "printf 'apple\0apple\0banana\0banana\0cherry\0' | $F_TOOL -z"

    run_test "-z -c count null-terminated" \
        "printf 'apple\0apple\0banana\0' | $GNU_TOOL -zc" \
        "printf 'apple\0apple\0banana\0' | $F_TOOL -zc"

    echo ""
    echo "=== Group Mode (--group) ==="

    run_test "--group=prepend" \
        "$GNU_TOOL --group=prepend '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL --group=prepend '$TEST_DATA_DIR/duplicates.txt'"

    run_test "--group=append" \
        "$GNU_TOOL --group=append '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL --group=append '$TEST_DATA_DIR/duplicates.txt'"

    run_test "--group=separate" \
        "$GNU_TOOL --group=separate '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL --group=separate '$TEST_DATA_DIR/duplicates.txt'"

    run_test "--group=both" \
        "$GNU_TOOL --group=both '$TEST_DATA_DIR/duplicates.txt'" \
        "$F_TOOL --group=both '$TEST_DATA_DIR/duplicates.txt'"

    echo ""
    echo "=== Combined Flags ==="

    run_test "-f1 -s2 -w5" \
        "printf 'a xxHELLO1\nb xxHELLO2\nc yyWORLD1\n' | $GNU_TOOL -f1 -s2 -w5" \
        "printf 'a xxHELLO1\nb xxHELLO2\nc yyWORLD1\n' | $F_TOOL -f1 -s2 -w5"

    run_test "-c -i combined" \
        "printf 'Hello\nhello\nWorld\nworld\n' | $GNU_TOOL -ci" \
        "printf 'Hello\nhello\nWorld\nworld\n' | $F_TOOL -ci"

    echo ""
    echo "=== Edge Cases ==="

    run_test "empty lines" \
        "printf '\n\nhello\n\n\nworld\n' | $GNU_TOOL" \
        "printf '\n\nhello\n\n\nworld\n' | $F_TOOL"

    run_test "lines differing only in whitespace" \
        "printf 'hello \nhello\n hello\n' | $GNU_TOOL" \
        "printf 'hello \nhello\n hello\n' | $F_TOOL"

    run_test "single character lines" \
        "printf 'a\na\nb\nb\nc\n' | $GNU_TOOL" \
        "printf 'a\na\nb\nb\nc\n' | $F_TOOL"

    echo ""
    echo "=== Output to File ==="

    local gnu_outfile="/tmp/gnu_uniq_out_$$"
    local f_outfile="/tmp/f_uniq_out_$$"
    register_temp "$gnu_outfile"
    register_temp "$f_outfile"

    $GNU_TOOL "$TEST_DATA_DIR/duplicates.txt" "$gnu_outfile"
    $F_TOOL "$TEST_DATA_DIR/duplicates.txt" "$f_outfile"

    local diff_result=""
    if diff_result=$(diff "$gnu_outfile" "$f_outfile" 2>&1); then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: output to file argument"
        record_result "output to file argument" "PASS" "" "" ""
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: output to file argument"
        record_result "output to file argument" "FAIL" "$diff_result" "" ""
    fi

    echo ""
    echo "=== Large File ==="

    run_test "10MB many duplicates" \
        "$GNU_TOOL '$TEST_DATA_DIR/many_duplicates_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/many_duplicates_10m.txt' | md5sum"

    run_test "10MB many duplicates -c" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/many_duplicates_10m.txt' | md5sum" \
        "$F_TOOL -c '$TEST_DATA_DIR/many_duplicates_10m.txt' | md5sum"

    echo ""
    echo "=== GNU Upstream: uniq-perf (Large Skip-Fields) ==="

    # From uniq-perf.sh: ensure uniq -f with huge field count doesn't run for days
    # (coreutils-8.10 bug: seq 100000|uniq -f 10000000000 would hang)
    local uniq_perf_tmp=$(make_temp "$(seq 100)")
    register_temp "$uniq_perf_tmp"

    run_test "-f 10000000000 large skip fields" \
        "$GNU_TOOL -f 10000000000 '$uniq_perf_tmp'" \
        "$F_TOOL -f 10000000000 '$uniq_perf_tmp'"

    # uniq-collate.sh: skipped (requires specific locales: French UTF-8, Korean, CJK)
    skip_test "uniq collation with locales" "Requires LOCALE_FR_UTF8 and other locales"

    # === GNU Upstream: Eight-Bit Characters (uniq.pl test 8) ===
    echo ""
    echo "=== GNU Upstream: Eight-Bit Characters ==="

    # From uniq.pl test 8: eight-bit characters should be handled correctly
    run_test "GNU: 8-bit characters (ö vs v)" \
        "printf 'ö\nv\n' | $GNU_TOOL" \
        "printf 'ö\nv\n' | $F_TOOL"

    # === GNU Upstream: NUL Byte and Special Content (uniq.pl tests 90-94) ===
    echo ""
    echo "=== GNU Upstream: NUL Byte and Special Content ==="

    # From uniq.pl test 90: file containing NUL byte in line content
    run_test "GNU: NUL byte within line content" \
        "printf 'a\0a\na\n' | $GNU_TOOL" \
        "printf 'a\0a\na\n' | $F_TOOL"

    # From uniq.pl test 91: tab vs space are different characters
    run_test "GNU: tab vs space separators are distinct" \
        "printf 'a\ta\na a\n' | $GNU_TOOL" \
        "printf 'a\ta\na a\n' | $F_TOOL"

    # From uniq.pl test 92: -f1 with tab vs space field separators
    run_test "GNU: -f1 tab vs space field separators" \
        "printf 'a\ta\na a\n' | $GNU_TOOL -f 1" \
        "printf 'a\ta\na a\n' | $F_TOOL -f 1"

    # From uniq.pl test 93: -f2 with mixed tab/space fields
    run_test "GNU: -f2 mixed tab and space fields" \
        "printf 'a\ta a\na a a\n' | $GNU_TOOL -f 2" \
        "printf 'a\ta a\na a a\n' | $F_TOOL -f 2"

    # From uniq.pl test 94: -f1 with tab-separated identical fields
    run_test "GNU: -f1 tab-separated identical" \
        "printf 'a\ta\na\ta\n' | $GNU_TOOL -f 1" \
        "printf 'a\ta\na\ta\n' | $F_TOOL -f 1"

    # === GNU Upstream: Skip Past End of Line (uniq.pl tests 54-57) ===
    echo ""
    echo "=== GNU Upstream: Skip Past End and Zero Width ==="

    # From uniq.pl test 54: -s4 skip past end makes lines compare equal
    run_test "GNU: -s4 skip past shorter line" \
        "printf 'abc\nabcd\n' | $GNU_TOOL -s 4" \
        "printf 'abc\nabcd\n' | $F_TOOL -s 4"

    # From uniq.pl test 55: -s0 is identity (no skip)
    run_test "GNU: -s0 no skip, different lines" \
        "printf 'abc\nabcd\n' | $GNU_TOOL -s 0" \
        "printf 'abc\nabcd\n' | $F_TOOL -s 0"

    # From uniq.pl test 57: -w0 compare zero characters (all lines match)
    run_test "GNU: -w0 compare zero chars (all match)" \
        "printf 'abc\nabcd\n' | $GNU_TOOL -w 0" \
        "printf 'abc\nabcd\n' | $F_TOOL -w 0"

    # === GNU Upstream: -z Null-Delimited Behavior (uniq.pl tests 2z-20z) ===
    echo ""
    echo "=== GNU Upstream: Null-Delimited (-z) Extended ==="

    # From uniq.pl test 2z: -z treats newlines as literal characters
    run_test "GNU: -z newlines within NUL-terminated records" \
        "printf 'a\na\n' | $GNU_TOOL -z | od -A x -t x1z" \
        "printf 'a\na\n' | $F_TOOL -z | od -A x -t x1z"

    # From uniq.pl test 10z: -z -f1 with NUL-delimited fields
    run_test "GNU: -z -f1 NUL-delimited with fields" \
        "printf 'a\nb\n\0c\nb\n\0' | $GNU_TOOL -z -f 1" \
        "printf 'a\nb\n\0c\nb\n\0' | $F_TOOL -z -f 1"

    # From uniq.pl test 20z: -dz with repeated NUL-delimited records
    run_test "GNU: -dz no duplicates in NUL-delimited" \
        "printf 'a\na\n' | $GNU_TOOL -dz | od -A x -t x1z" \
        "printf 'a\na\n' | $F_TOOL -dz | od -A x -t x1z"

    # === GNU Upstream: -D -c Conflict (uniq.pl test 112) ===
    echo ""
    echo "=== GNU Upstream: Option Conflicts ==="

    # From uniq.pl test 112: -D -c is meaningless and should fail
    run_exit_code_test "GNU: -D -c conflict fails" \
        "printf 'a a\na b\n' | $GNU_TOOL -D -c 2>&1" \
        "printf 'a a\na b\n' | $F_TOOL -D -c 2>&1"

    # From uniq.pl test 119: --all-repeated=badoption should fail
    run_exit_code_test "GNU: --all-repeated=badoption fails" \
        "printf 'a\n' | $GNU_TOOL --all-repeated=badoption 2>&1" \
        "printf 'a\n' | $F_TOOL --all-repeated=badoption 2>&1"

    # From uniq.pl test 120: -d -u together suppress all output
    run_test "GNU: -d -u suppress all output" \
        "printf 'a\na\nb\n' | $GNU_TOOL -d -u" \
        "printf 'a\na\nb\n' | $F_TOOL -d -u"

    # From uniq.pl tests 141-144: --group is mutually exclusive with -c/-d/-D/-u
    run_exit_code_test "GNU: --group -c conflict fails" \
        "printf '' | $GNU_TOOL --group -c 2>&1" \
        "printf '' | $F_TOOL --group -c 2>&1"

    run_exit_code_test "GNU: --group -d conflict fails" \
        "printf '' | $GNU_TOOL --group -d 2>&1" \
        "printf '' | $F_TOOL --group -d 2>&1"

    run_exit_code_test "GNU: --group -u conflict fails" \
        "printf '' | $GNU_TOOL --group -u 2>&1" \
        "printf '' | $F_TOOL --group -u 2>&1"

    run_exit_code_test "GNU: --group -D conflict fails" \
        "printf '' | $GNU_TOOL --group -D 2>&1" \
        "printf '' | $F_TOOL --group -D 2>&1"

    # From uniq.pl test 145: --group=badoption should fail
    run_exit_code_test "GNU: --group=badoption fails" \
        "printf '' | $GNU_TOOL --group=badoption 2>&1" \
        "printf '' | $F_TOOL --group=badoption 2>&1"

    # === GNU Upstream: Count Format (uniq.pl tests 101-102) ===
    echo ""
    echo "=== GNU Upstream: Count Format ==="

    # From uniq.pl test 101: -c format with padding
    run_test "GNU: -c format two unique lines" \
        "printf 'a\nb\n' | $GNU_TOOL -c" \
        "printf 'a\nb\n' | $F_TOOL -c"

    # From uniq.pl test 102: -c format with repeated line
    run_test "GNU: -c format repeated line" \
        "printf 'a\na\n' | $GNU_TOOL -c" \
        "printf 'a\na\n' | $F_TOOL -c"

    # === GNU Upstream: Field and Char Skip Combinations (uniq.pl tests 50-65) ===
    echo ""
    echo "=== GNU Upstream: Field and Char Skip Combinations ==="

    # From uniq.pl test 50: -f1 -s1 different after skip
    run_test "GNU: -f1 -s1 different after skip" \
        "printf 'a aaa\nb ab\n' | $GNU_TOOL -f 1 -s 1" \
        "printf 'a aaa\nb ab\n' | $F_TOOL -f 1 -s 1"

    # From uniq.pl test 51: -f1 -s1 same after skip
    run_test "GNU: -f1 -s1 same after skip" \
        "printf 'a aaa\nb aaa\n' | $GNU_TOOL -f 1 -s 1" \
        "printf 'a aaa\nb aaa\n' | $F_TOOL -f 1 -s 1"

    # From uniq.pl test 60: -w1 compare first char only (with fields)
    run_test "GNU: -w1 first char only" \
        "printf 'a a\nb a\n' | $GNU_TOOL -w 1" \
        "printf 'a a\nb a\n' | $F_TOOL -w 1"

    # From uniq.pl test 62: -w1 -f1 combined
    run_test "GNU: -w1 -f1 combined" \
        "printf 'a a a\nb a c\n' | $GNU_TOOL -w 1 -f 1" \
        "printf 'a a a\nb a c\n' | $F_TOOL -w 1 -f 1"

    # From uniq.pl test 64: -f1 -w4 blank after field is included in comparison
    run_test "GNU: -f1 -w4 includes blank after field" \
        "printf 'a a a\nb a c\n' | $GNU_TOOL -f 1 -w 4" \
        "printf 'a a a\nb a c\n' | $F_TOOL -f 1 -w 4"

    # From uniq.pl test 65: -f1 -w3 stops before distinguishing part
    run_test "GNU: -f1 -w3 stops before difference" \
        "printf 'a a a\nb a c\n' | $GNU_TOOL -f 1 -w 3" \
        "printf 'a a a\nb a c\n' | $F_TOOL -f 1 -w 3"

    # === GNU Upstream: Grouping Edge Cases (uniq.pl tests 133-140) ===
    echo ""
    echo "=== GNU Upstream: Grouping Edge Cases ==="

    # From uniq.pl test 133: --group=prepend single group
    run_test "GNU: --group=prepend single group" \
        "printf 'a\na\n' | $GNU_TOOL --group=prepend" \
        "printf 'a\na\n' | $F_TOOL --group=prepend"

    # From uniq.pl test 134: --group=append single group
    run_test "GNU: --group=append single group" \
        "printf 'a\na\n' | $GNU_TOOL --group=append" \
        "printf 'a\na\n' | $F_TOOL --group=append"

    # From uniq.pl test 137-140: --group with empty input
    run_test "GNU: --group=prepend empty input" \
        "printf '' | $GNU_TOOL --group=prepend" \
        "printf '' | $F_TOOL --group=prepend"

    run_test "GNU: --group=append empty input" \
        "printf '' | $GNU_TOOL --group=append" \
        "printf '' | $F_TOOL --group=append"

    run_test "GNU: --group=both empty input" \
        "printf '' | $GNU_TOOL --group=both" \
        "printf '' | $F_TOOL --group=both"

    # === GNU Upstream: --all-repeated Edge Cases (uniq.pl tests 113-118) ===
    echo ""
    echo "=== GNU Upstream: All-Repeated Edge Cases ==="

    # From uniq.pl test 114: --all-repeated=separate with mixed groups
    run_test "GNU: --all-repeated=separate mixed groups" \
        "printf 'a\na\nb\nc\nc\n' | $GNU_TOOL --all-repeated=separate" \
        "printf 'a\na\nb\nc\nc\n' | $F_TOOL --all-repeated=separate"

    # From uniq.pl test 115: --all-repeated=separate two groups
    run_test "GNU: --all-repeated=separate two adjacent groups" \
        "printf 'a\na\nb\nb\nc\n' | $GNU_TOOL --all-repeated=separate" \
        "printf 'a\na\nb\nb\nc\n' | $F_TOOL --all-repeated=separate"

    # From uniq.pl test 116: --all-repeated=prepend single group
    run_test "GNU: --all-repeated=prepend single group" \
        "printf 'a\na\n' | $GNU_TOOL --all-repeated=prepend" \
        "printf 'a\na\n' | $F_TOOL --all-repeated=prepend"

    # From uniq.pl test 117: --all-repeated=prepend with mixed groups
    run_test "GNU: --all-repeated=prepend mixed groups" \
        "printf 'a\na\nb\nc\nc\n' | $GNU_TOOL --all-repeated=prepend" \
        "printf 'a\na\nb\nc\nc\n' | $F_TOOL --all-repeated=prepend"

    # From uniq.pl test 118: --all-repeated=prepend no duplicates
    run_test "GNU: --all-repeated=prepend no duplicates" \
        "printf 'a\nb\n' | $GNU_TOOL --all-repeated=prepend" \
        "printf 'a\nb\n' | $F_TOOL --all-repeated=prepend"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"


    finish_test_suite
}

run_uniq_tests
