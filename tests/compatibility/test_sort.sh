#!/usr/bin/env bash
# Compatibility tests for fsort vs GNU sort
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sort"
F_TOOL="fsort"

run_sort_tests() {
    init_test_suite "sort"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sort","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sort_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU sort not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Lexicographic Sort ==="

    run_test "basic sort" \
        "$GNU_TOOL '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/unsorted.txt'"

    run_test "empty file sort" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "single line" \
        "echo 'hello' | $GNU_TOOL" \
        "echo 'hello' | $F_TOOL"

    run_test "already sorted" \
        "$GNU_TOOL '$TEST_DATA_DIR/sorted_10m.txt' | head -100" \
        "$F_TOOL '$TEST_DATA_DIR/sorted_10m.txt' | head -100"

    run_test "stdin sort" \
        "printf 'banana\napple\ncherry\n' | $GNU_TOOL" \
        "printf 'banana\napple\ncherry\n' | $F_TOOL"

    echo ""
    echo "=== Reverse Sort (-r) ==="

    run_test "-r basic" \
        "$GNU_TOOL -r '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL -r '$TEST_DATA_DIR/unsorted.txt'"

    run_test "-r single line" \
        "echo 'hello' | $GNU_TOOL -r" \
        "echo 'hello' | $F_TOOL -r"

    echo ""
    echo "=== Numeric Sort (-n) ==="

    run_test "-n numeric" \
        "$GNU_TOOL -n '$TEST_DATA_DIR/numeric_unsorted.txt'" \
        "$F_TOOL -n '$TEST_DATA_DIR/numeric_unsorted.txt'"

    run_test "-n with text" \
        "printf '10\n2\nabc\n1\n' | $GNU_TOOL -n" \
        "printf '10\n2\nabc\n1\n' | $F_TOOL -n"

    run_test "-n reverse" \
        "$GNU_TOOL -nr '$TEST_DATA_DIR/numeric_unsorted.txt'" \
        "$F_TOOL -nr '$TEST_DATA_DIR/numeric_unsorted.txt'"

    run_test "-n with leading spaces" \
        "printf '  10\n 2\n  30\n1\n' | $GNU_TOOL -n" \
        "printf '  10\n 2\n  30\n1\n' | $F_TOOL -n"

    run_test "-n with negatives" \
        "printf '10\n-5\n0\n-100\n50\n' | $GNU_TOOL -n" \
        "printf '10\n-5\n0\n-100\n50\n' | $F_TOOL -n"

    run_test "-n with decimals" \
        "printf '1.5\n1.10\n1.2\n0.9\n' | $GNU_TOOL -n" \
        "printf '1.5\n1.10\n1.2\n0.9\n' | $F_TOOL -n"

    echo ""
    echo "=== Human Numeric Sort (-h) ==="

    run_test "-h human sizes" \
        "$GNU_TOOL -h '$TEST_DATA_DIR/human_sizes.txt'" \
        "$F_TOOL -h '$TEST_DATA_DIR/human_sizes.txt'"

    run_test "-h reverse" \
        "$GNU_TOOL -hr '$TEST_DATA_DIR/human_sizes.txt'" \
        "$F_TOOL -hr '$TEST_DATA_DIR/human_sizes.txt'"

    echo ""
    echo "=== Version Sort (-V) ==="

    run_test "-V versions" \
        "$GNU_TOOL -V '$TEST_DATA_DIR/versions.txt'" \
        "$F_TOOL -V '$TEST_DATA_DIR/versions.txt'"

    run_test "-V reverse" \
        "$GNU_TOOL -Vr '$TEST_DATA_DIR/versions.txt'" \
        "$F_TOOL -Vr '$TEST_DATA_DIR/versions.txt'"

    echo ""
    echo "=== Month Sort (-M) ==="

    run_test "-M months" \
        "$GNU_TOOL -M '$TEST_DATA_DIR/months.txt'" \
        "$F_TOOL -M '$TEST_DATA_DIR/months.txt'"

    echo ""
    echo "=== Unique (-u) ==="

    run_test "-u unique" \
        "$GNU_TOOL -u '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL -u '$TEST_DATA_DIR/unsorted.txt'"

    run_test "-u numeric unique" \
        "$GNU_TOOL -nu '$TEST_DATA_DIR/numeric_unsorted.txt'" \
        "$F_TOOL -nu '$TEST_DATA_DIR/numeric_unsorted.txt'"

    run_test "-u all same" \
        "printf 'a\na\na\n' | $GNU_TOOL -u" \
        "printf 'a\na\na\n' | $F_TOOL -u"

    run_test "-u all unique" \
        "printf 'a\nb\nc\n' | $GNU_TOOL -u" \
        "printf 'a\nb\nc\n' | $F_TOOL -u"

    echo ""
    echo "=== Case Insensitive (-f) ==="

    run_test "-f case insensitive" \
        "printf 'Banana\napple\nCherry\n' | $GNU_TOOL -f" \
        "printf 'Banana\napple\nCherry\n' | $F_TOOL -f"

    echo ""
    echo "=== Dictionary Order (-d) ==="

    run_test "-d dictionary order" \
        "printf 'hello world\nhello-world\nhello_world\nhelloworld\n' | $GNU_TOOL -d" \
        "printf 'hello world\nhello-world\nhello_world\nhelloworld\n' | $F_TOOL -d"

    echo ""
    echo "=== Ignore Non-Printing (-i) ==="

    run_test "-i ignore non-printing" \
        "printf 'abc\ndef\n\x01ghi\n' | $GNU_TOOL -i" \
        "printf 'abc\ndef\n\x01ghi\n' | $F_TOOL -i"

    echo ""
    echo "=== Ignore Leading Blanks (-b) ==="

    run_test "-b ignore leading blanks" \
        "printf '  banana\napple\n  cherry\n' | $GNU_TOOL -b" \
        "printf '  banana\napple\n  cherry\n' | $F_TOOL -b"

    echo ""
    echo "=== Key Sorting (-k) ==="

    run_test "-k2 (sort by field 2)" \
        "$GNU_TOOL -t, -k2 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -t, -k2 '$TEST_DATA_DIR/simple.csv'"

    run_test "-k2,2 (sort by exactly field 2)" \
        "$GNU_TOOL -t, -k2,2 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -t, -k2,2 '$TEST_DATA_DIR/simple.csv'"

    run_test "-k2n (numeric sort by field 2)" \
        "$GNU_TOOL -t, -k2n '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -t, -k2n '$TEST_DATA_DIR/simple.csv'"

    run_test "-k3 (sort by field 3)" \
        "$GNU_TOOL -t, -k3 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -t, -k3 '$TEST_DATA_DIR/simple.csv'"

    run_test "-k1,1 -k2,2n (multi-key)" \
        "$GNU_TOOL -t: -k1,1 -k3,3n '$TEST_DATA_DIR/colon_delimited.txt'" \
        "$F_TOOL -t: -k1,1 -k3,3n '$TEST_DATA_DIR/colon_delimited.txt'"

    echo ""
    echo "=== Field Separator (-t) ==="

    run_test "-t: colon separator" \
        "$GNU_TOOL -t: -k1 '$TEST_DATA_DIR/colon_delimited.txt'" \
        "$F_TOOL -t: -k1 '$TEST_DATA_DIR/colon_delimited.txt'"

    run_test "-t, comma separator" \
        "$GNU_TOOL -t, -k1 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -t, -k1 '$TEST_DATA_DIR/simple.csv'"

    echo ""
    echo "=== Stable Sort (-s) ==="

    run_test "-s stable" \
        "$GNU_TOOL -s -t, -k2,2 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -s -t, -k2,2 '$TEST_DATA_DIR/simple.csv'"

    echo ""
    echo "=== Check Sorted (-c) ==="

    run_exit_code_test "-c on sorted input" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/sorted_10m.txt' 2>&1" \
        "$F_TOOL -c '$TEST_DATA_DIR/sorted_10m.txt' 2>&1"

    run_exit_code_test "-c on unsorted input" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/unsorted.txt' 2>&1" \
        "$F_TOOL -c '$TEST_DATA_DIR/unsorted.txt' 2>&1"

    echo ""
    echo "=== Output to File (-o) ==="

    local gnu_outfile="/tmp/gnu_sort_out_$$"
    local f_outfile="/tmp/f_sort_out_$$"
    register_temp "$gnu_outfile"
    register_temp "$f_outfile"

    $GNU_TOOL -o "$gnu_outfile" "$TEST_DATA_DIR/unsorted.txt"
    $F_TOOL -o "$f_outfile" "$TEST_DATA_DIR/unsorted.txt"

    local diff_result=""
    if diff_result=$(diff "$gnu_outfile" "$f_outfile" 2>&1); then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -o output file"
        record_result "-o output file" "PASS" "" "" ""
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -o output file"
        record_result "-o output file" "FAIL" "$diff_result" "" ""
    fi

    echo ""
    echo "=== General Numeric Sort (-g) ==="

    run_test "-g general numeric" \
        "printf '1.5e2\n1.5\n100\n1e3\n' | $GNU_TOOL -g" \
        "printf '1.5e2\n1.5\n100\n1e3\n' | $F_TOOL -g"

    echo ""
    echo "=== Random Sort (-R) ==="

    # Can't compare output directly (random), but check it doesn't crash and exit code matches
    run_exit_code_test "-R (random sort runs without error)" \
        "$GNU_TOOL -R '$TEST_DATA_DIR/unsorted.txt' 2>&1" \
        "$F_TOOL -R '$TEST_DATA_DIR/unsorted.txt' 2>&1"

    echo ""
    echo "=== Null-Terminated (-z) ==="

    run_test "-z null-terminated" \
        "printf 'banana\0apple\0cherry\0' | $GNU_TOOL -z" \
        "printf 'banana\0apple\0cherry\0' | $F_TOOL -z"

    echo ""
    echo "=== Merge (-m) ==="

    local sorted1
    sorted1=$(mktemp /tmp/fcoreutils_sorted1_XXXXXX)
    register_temp "$sorted1"
    printf 'apple\ncherry\ngrape\n' > "$sorted1"

    local sorted2
    sorted2=$(mktemp /tmp/fcoreutils_sorted2_XXXXXX)
    register_temp "$sorted2"
    printf 'banana\ndate\nfig\n' > "$sorted2"

    run_test "-m merge two sorted files" \
        "$GNU_TOOL -m '$sorted1' '$sorted2'" \
        "$F_TOOL -m '$sorted1' '$sorted2'"

    echo ""
    echo "=== Empty and Edge Cases ==="

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "single line no newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'"

    run_test "many duplicates" \
        "printf 'a\na\nb\nb\na\na\n' | $GNU_TOOL" \
        "printf 'a\na\nb\nb\na\na\n' | $F_TOOL"

    echo ""
    echo "=== Large Files ==="

    run_test "10MB random sort" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_lines_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/random_lines_10m.txt' | md5sum"

    run_test "10MB already sorted" \
        "$GNU_TOOL '$TEST_DATA_DIR/sorted_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/sorted_10m.txt' | md5sum"

    run_test "10MB reverse sorted" \
        "$GNU_TOOL '$TEST_DATA_DIR/reverse_sorted_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/reverse_sorted_10m.txt' | md5sum"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Locale Sensitivity ==="

    run_test "LC_ALL=C sort" \
        "LC_ALL=C $GNU_TOOL '$TEST_DATA_DIR/unsorted.txt'" \
        "LC_ALL=C $F_TOOL '$TEST_DATA_DIR/unsorted.txt'"

    finish_test_suite
}

run_sort_tests
