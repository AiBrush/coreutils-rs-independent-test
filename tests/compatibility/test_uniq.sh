#!/usr/bin/env bash
# Compatibility tests for funiq vs GNU uniq
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="uniq"
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
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    finish_test_suite
}

run_uniq_tests
