#!/usr/bin/env bash
# Compatibility tests for fcut vs GNU cut
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="cut"
F_TOOL="fcut"

run_cut_tests() {
    init_test_suite "cut"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cut","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/cut_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU cut not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Byte Range Tests (-b) ==="

    run_test "-b1 (first byte)" \
        "echo 'hello world' | $GNU_TOOL -b1" \
        "echo 'hello world' | $F_TOOL -b1"

    run_test "-b1-5" \
        "echo 'hello world' | $GNU_TOOL -b1-5" \
        "echo 'hello world' | $F_TOOL -b1-5"

    run_test "-b-5 (first 5 bytes)" \
        "echo 'hello world' | $GNU_TOOL -b-5" \
        "echo 'hello world' | $F_TOOL -b-5"

    run_test "-b5- (from byte 5 to end)" \
        "echo 'hello world' | $GNU_TOOL -b5-" \
        "echo 'hello world' | $F_TOOL -b5-"

    run_test "-b1,3,5 (specific bytes)" \
        "echo 'hello world' | $GNU_TOOL -b1,3,5" \
        "echo 'hello world' | $F_TOOL -b1,3,5"

    run_test "-b1-3,7-9 (multiple ranges)" \
        "echo 'hello world' | $GNU_TOOL -b1-3,7-9" \
        "echo 'hello world' | $F_TOOL -b1-3,7-9"

    run_test "-b on empty" \
        "$GNU_TOOL -b1 '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -b1 '$TEST_DATA_DIR/empty.txt'"

    run_test "-b1-100 on CSV" \
        "$GNU_TOOL -b1-100 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -b1-100 '$TEST_DATA_DIR/simple.csv'"

    echo ""
    echo "=== Character Range Tests (-c) ==="

    run_test "-c1 (first char)" \
        "echo 'hello' | $GNU_TOOL -c1" \
        "echo 'hello' | $F_TOOL -c1"

    run_test "-c1-5" \
        "echo 'hello world' | $GNU_TOOL -c1-5" \
        "echo 'hello world' | $F_TOOL -c1-5"

    run_test "-c-3" \
        "echo 'abcdef' | $GNU_TOOL -c-3" \
        "echo 'abcdef' | $F_TOOL -c-3"

    run_test "-c3-" \
        "echo 'abcdef' | $GNU_TOOL -c3-" \
        "echo 'abcdef' | $F_TOOL -c3-"

    run_test "-c on CJK text" \
        "$GNU_TOOL -c1-3 '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL -c1-3 '$TEST_DATA_DIR/cjk.txt'"

    echo ""
    echo "=== Field Tests (-f with -d) ==="

    run_test "-d, -f1 (first CSV field)" \
        "$GNU_TOOL -d, -f1 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f1 '$TEST_DATA_DIR/simple.csv'"

    run_test "-d, -f2 (second CSV field)" \
        "$GNU_TOOL -d, -f2 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f2 '$TEST_DATA_DIR/simple.csv'"

    run_test "-d, -f1,3 (fields 1 and 3)" \
        "$GNU_TOOL -d, -f1,3 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f1,3 '$TEST_DATA_DIR/simple.csv'"

    run_test "-d, -f1-3 (field range)" \
        "$GNU_TOOL -d, -f1-3 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f1-3 '$TEST_DATA_DIR/simple.csv'"

    run_test "-d, -f3- (from field 3 to end)" \
        "$GNU_TOOL -d, -f3- '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f3- '$TEST_DATA_DIR/simple.csv'"

    run_test "-d, -f-2 (first 2 fields)" \
        "$GNU_TOOL -d, -f-2 '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f-2 '$TEST_DATA_DIR/simple.csv'"

    run_test "-d: -f1 (colon delimiter)" \
        "$GNU_TOOL -d: -f1 '$TEST_DATA_DIR/colon_delimited.txt'" \
        "$F_TOOL -d: -f1 '$TEST_DATA_DIR/colon_delimited.txt'"

    run_test "-d: -f1,3,5,7 (multiple colon fields)" \
        "$GNU_TOOL -d: -f1,3,5,7 '$TEST_DATA_DIR/colon_delimited.txt'" \
        "$F_TOOL -d: -f1,3,5,7 '$TEST_DATA_DIR/colon_delimited.txt'"

    # Tab delimiter (default)
    run_test "-f1 with default tab delimiter" \
        "$GNU_TOOL -f1 '$TEST_DATA_DIR/tsv_data.txt'" \
        "$F_TOOL -f1 '$TEST_DATA_DIR/tsv_data.txt'"

    run_test "-f2 TSV" \
        "$GNU_TOOL -f2 '$TEST_DATA_DIR/tsv_data.txt'" \
        "$F_TOOL -f2 '$TEST_DATA_DIR/tsv_data.txt'"

    echo ""
    echo "=== Delimiter Edge Cases ==="

    # Delimiter not present in line
    run_test "delimiter not in line (no -s)" \
        "echo 'no delimiter here' | $GNU_TOOL -d, -f1" \
        "echo 'no delimiter here' | $F_TOOL -d, -f1"

    # Consecutive delimiters (empty fields)
    run_test "consecutive delimiters" \
        "echo 'a,,b,,c' | $GNU_TOOL -d, -f1-5" \
        "echo 'a,,b,,c' | $F_TOOL -d, -f1-5"

    run_test "consecutive delimiters -f2" \
        "echo 'a,,b,,c' | $GNU_TOOL -d, -f2" \
        "echo 'a,,b,,c' | $F_TOOL -d, -f2"

    run_test "consecutive delimiters -f3" \
        "echo 'a,,b,,c' | $GNU_TOOL -d, -f3" \
        "echo 'a,,b,,c' | $F_TOOL -d, -f3"

    # Leading/trailing delimiters
    run_test "leading delimiter" \
        "echo ',a,b,c' | $GNU_TOOL -d, -f1-4" \
        "echo ',a,b,c' | $F_TOOL -d, -f1-4"

    run_test "trailing delimiter" \
        "echo 'a,b,c,' | $GNU_TOOL -d, -f1-4" \
        "echo 'a,b,c,' | $F_TOOL -d, -f1-4"

    echo ""
    echo "=== -s (suppress lines without delimiter) ==="

    run_test "-s with delimiter present" \
        "printf 'a,b\nno-delim\nc,d\n' | $GNU_TOOL -d, -f1 -s" \
        "printf 'a,b\nno-delim\nc,d\n' | $F_TOOL -d, -f1 -s"

    run_test "-s all lines have delimiter" \
        "$GNU_TOOL -d, -f1 -s '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f1 -s '$TEST_DATA_DIR/simple.csv'"

    echo ""
    echo "=== --complement ==="

    run_test "--complement -f1 CSV" \
        "$GNU_TOOL -d, -f1 --complement '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f1 --complement '$TEST_DATA_DIR/simple.csv'"

    run_test "--complement -f2 CSV" \
        "$GNU_TOOL -d, -f2 --complement '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f2 --complement '$TEST_DATA_DIR/simple.csv'"

    run_test "--complement -b1-3" \
        "echo 'abcdefgh' | $GNU_TOOL -b1-3 --complement" \
        "echo 'abcdefgh' | $F_TOOL -b1-3 --complement"

    echo ""
    echo "=== --output-delimiter ==="

    run_test "--output-delimiter with comma fields" \
        "$GNU_TOOL -d, -f1,3 --output-delimiter='|' '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL -d, -f1,3 --output-delimiter='|' '$TEST_DATA_DIR/simple.csv'"

    run_test "--output-delimiter with bytes" \
        "echo 'abcdef' | $GNU_TOOL -b1-3,5-6 --output-delimiter=':'" \
        "echo 'abcdef' | $F_TOOL -b1-3,5-6 --output-delimiter=':'"

    echo ""
    echo "=== Null-terminated lines (-z) ==="

    run_test "-z with null-terminated input" \
        "printf 'a,b\0c,d\0e,f\0' | $GNU_TOOL -z -d, -f1" \
        "printf 'a,b\0c,d\0e,f\0' | $F_TOOL -z -d, -f1"

    echo ""
    echo "=== Error Handling ==="

    # Field 0 should error
    run_exit_code_test "field 0 (should error)" \
        "echo 'hello' | $GNU_TOOL -f0 2>&1" \
        "echo 'hello' | $F_TOOL -f0 2>&1"

    # No mode specified
    run_exit_code_test "no -b/-c/-f (should error)" \
        "echo 'hello' | $GNU_TOOL 2>&1" \
        "echo 'hello' | $F_TOOL 2>&1"

    # Nonexistent file
    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL -f1 /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL -f1 /tmp/nonexistent_$$ 2>&1"

    echo ""
    echo "=== Empty Input ==="

    run_test "-f1 empty file" \
        "$GNU_TOOL -d, -f1 '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -d, -f1 '$TEST_DATA_DIR/empty.txt'"

    run_test "-b1 empty stdin" \
        "echo -n '' | $GNU_TOOL -b1" \
        "echo -n '' | $F_TOOL -b1"

    echo ""
    echo "=== Stdin vs File ==="

    run_test "stdin vs file comparison" \
        "cat '$TEST_DATA_DIR/simple.csv' | $GNU_TOOL -d, -f1" \
        "cat '$TEST_DATA_DIR/simple.csv' | $F_TOOL -d, -f1"

    echo ""
    echo "=== Large File ==="

    run_test "10MB CSV -f1,3" \
        "$GNU_TOOL -d, -f1,3 '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL -d, -f1,3 '$TEST_DATA_DIR/csv_10m.csv'"

    run_test "10MB CSV -f2-4" \
        "$GNU_TOOL -d, -f2-4 '$TEST_DATA_DIR/csv_10m.csv'" \
        "$F_TOOL -d, -f2-4 '$TEST_DATA_DIR/csv_10m.csv'"

    echo ""
    echo "=== Special Characters in Delimiter ==="

    run_test "tab delimiter explicit" \
        "printf 'a\tb\tc\n' | $GNU_TOOL -d'\t' -f2" \
        "printf 'a\tb\tc\n' | $F_TOOL -d'\t' -f2"

    run_test "space delimiter" \
        "echo 'a b c' | $GNU_TOOL -d' ' -f2" \
        "echo 'a b c' | $F_TOOL -d' ' -f2"

    run_test "pipe delimiter" \
        "echo 'a|b|c' | $GNU_TOOL -d'|' -f2" \
        "echo 'a|b|c' | $F_TOOL -d'|' -f2"

    echo ""
    echo "=== Symlinks ==="

    if [[ -L "$TEST_DATA_DIR/symlink_to_csv" ]]; then
        run_test "symlink file" \
            "$GNU_TOOL -d, -f1 '$TEST_DATA_DIR/symlink_to_csv'" \
            "$F_TOOL -d, -f1 '$TEST_DATA_DIR/symlink_to_csv'"
    else
        skip_test "symlink file" "symlinks not available"
    fi

    finish_test_suite
}

run_cut_tests
