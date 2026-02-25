#!/usr/bin/env bash
# Compatibility tests for fcut vs GNU cut
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "cut")
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

    # === GNU Upstream: Field Extraction with Colon Delimiter ===
    echo ""
    echo "=== GNU Upstream: Field Extraction with Colon Delimiter ==="

    # From cut.pl: basic field extraction tests
    run_test "gnu cut.pl 1: -d: -f1,3-" \
        "printf 'a:b:c\n' | $GNU_TOOL -d: -f1,3-" \
        "printf 'a:b:c\n' | $F_TOOL -d: -f1,3-"

    run_test "gnu cut.pl 3: -d: -f2-" \
        "printf 'a:b:c\n' | $GNU_TOOL -d: -f2-" \
        "printf 'a:b:c\n' | $F_TOOL -d: -f2-"

    run_test "gnu cut.pl 4: -d: -f4 (beyond fields)" \
        "printf 'a:b:c\n' | $GNU_TOOL -d: -f4" \
        "printf 'a:b:c\n' | $F_TOOL -d: -f4"

    run_test "gnu cut.pl 5: -d: -f4 empty input" \
        "printf '' | $GNU_TOOL -d: -f4" \
        "printf '' | $F_TOOL -d: -f4"

    # From cut.pl: -c (character position) beyond line length
    run_test "gnu cut.pl 6: -c4 short line" \
        "printf '123\n' | $GNU_TOOL -c4" \
        "printf '123\n' | $F_TOOL -c4"

    run_test "gnu cut.pl 7: -c4 no newline" \
        "printf '123' | $GNU_TOOL -c4" \
        "printf '123' | $F_TOOL -c4"

    run_test "gnu cut.pl 8: -c4 two lines" \
        "printf '123\n1' | $GNU_TOOL -c4" \
        "printf '123\n1' | $F_TOOL -c4"

    run_test "gnu cut.pl 9: -c4 empty" \
        "printf '' | $GNU_TOOL -c4" \
        "printf '' | $F_TOOL -c4"

    # === GNU Upstream: Suppress Non-Delimited Lines (-s) ===
    echo ""
    echo "=== GNU Upstream: Suppress Non-Delimited Lines (-s) ==="

    # From cut.pl: -s -d: -f with various patterns
    run_test "gnu cut.pl a: -s -d: -f3-" \
        "printf 'a:b:c\n' | $GNU_TOOL -s -d: -f3-" \
        "printf 'a:b:c\n' | $F_TOOL -s -d: -f3-"

    run_test "gnu cut.pl b: -s -d: -f2,3" \
        "printf 'a:b:c\n' | $GNU_TOOL -s -d: -f2,3" \
        "printf 'a:b:c\n' | $F_TOOL -s -d: -f2,3"

    # From cut.pl: trailing colon should not be output
    run_test "gnu cut.pl d: trailing colon -s -d: -f1,3" \
        "printf 'a:b:c:\n' | $GNU_TOOL -s -d: -f1,3" \
        "printf 'a:b:c:\n' | $F_TOOL -s -d: -f1,3"

    run_test "gnu cut.pl e: -s -d: -f3- with trailing colon" \
        "printf 'a:b:c:\n' | $GNU_TOOL -s -d: -f3-" \
        "printf 'a:b:c:\n' | $F_TOOL -s -d: -f3-"

    # From cut.pl: -s suppresses non-delimited lines
    run_test "gnu cut.pl h: -s suppresses non-delimited" \
        "printf 'abc\n' | $GNU_TOOL -s -d: -f2,3" \
        "printf 'abc\n' | $F_TOOL -s -d: -f2,3"

    # === GNU Upstream: Consecutive Delimiter Fields ===
    echo ""
    echo "=== GNU Upstream: Consecutive Delimiter Fields ==="

    # From cut.pl: empty fields from consecutive delimiters
    run_test "gnu cut.pl i: -d: -f1-3 consecutive delims" \
        "printf ':::\n' | $GNU_TOOL -d: -f1-3" \
        "printf ':::\n' | $F_TOOL -d: -f1-3"

    run_test "gnu cut.pl j: -d: -f1-4 consecutive delims" \
        "printf ':::\n' | $GNU_TOOL -d: -f1-4" \
        "printf ':::\n' | $F_TOOL -d: -f1-4"

    run_test "gnu cut.pl k: -d: -f2-3 consecutive delims" \
        "printf ':::\n' | $GNU_TOOL -d: -f2-3" \
        "printf ':::\n' | $F_TOOL -d: -f2-3"

    run_test "gnu cut.pl q: -s -d: multi-line" \
        "printf ':::\n:\n' | $GNU_TOOL -s -d: -f2-4" \
        "printf ':::\n:\n' | $F_TOOL -s -d: -f2-4"

    # === GNU Upstream: Output Delimiter (--output-delimiter) ===
    echo ""
    echo "=== GNU Upstream: Output Delimiter (--output-delimiter) ==="

    # From cut.pl: --output-delimiter tests
    run_test "gnu cut.pl o-delim: -d: --out=_ -f2,3" \
        "printf 'a:b:c\n' | $GNU_TOOL -d: --output-delimiter=_ -f2,3" \
        "printf 'a:b:c\n' | $F_TOOL -d: --output-delimiter=_ -f2,3"

    run_test "gnu cut.pl multichar-od: --out=_._ -f2,3" \
        "printf 'a:b:c\n' | $GNU_TOOL -d: --output-delimiter=_._ -f2,3" \
        "printf 'a:b:c\n' | $F_TOOL -d: --output-delimiter=_._ -f2,3"

    # From cut.pl: output-delimiter with byte ranges
    run_test "gnu cut.pl out-delim1: -c1-3,5- --output-d=:" \
        "printf 'abcdefg\n' | $GNU_TOOL -c1-3,5- --output-delimiter=:" \
        "printf 'abcdefg\n' | $F_TOOL -c1-3,5- --output-delimiter=:"

    run_test "gnu cut.pl out-delim2: overlapped -c1-3,2,5-" \
        "printf 'abcdefg\n' | $GNU_TOOL -c1-3,2,5- --output-delimiter=:" \
        "printf 'abcdefg\n' | $F_TOOL -c1-3,2,5- --output-delimiter=:"

    run_test "gnu cut.pl out-delim3: partial overlap -c1-3,2-4,6" \
        "printf 'abcdefg\n' | $GNU_TOOL -c1-3,2-4,6 --output-delimiter=:" \
        "printf 'abcdefg\n' | $F_TOOL -c1-3,2-4,6 --output-delimiter=:"

    run_test "gnu cut.pl od-abut: abutting ranges -b1-2,3-4 --output-d=:" \
        "printf 'abcd\n' | $GNU_TOOL -b1-2,3-4 --output-delimiter=:" \
        "printf 'abcd\n' | $F_TOOL -b1-2,3-4 --output-delimiter=:"

    run_test "gnu cut.pl od-overlap: -b1-2,2 --output-d=:" \
        "printf 'abc\n' | $GNU_TOOL -b1-2,2 --output-delimiter=:" \
        "printf 'abc\n' | $F_TOOL -b1-2,2 --output-delimiter=:"

    # === GNU Upstream: Newline Processing ===
    echo ""
    echo "=== GNU Upstream: Newline Processing ==="

    # From cut.pl: newline-1 through various newline scenarios
    run_test "gnu cut.pl newline-1: -f1- no trailing nl" \
        "printf 'a\nb' | $GNU_TOOL -f1-" \
        "printf 'a\nb' | $F_TOOL -f1-"

    run_test "gnu cut.pl newline-3: -d: -f1 multi-line" \
        "printf 'a:1\nb:2\n' | $GNU_TOOL -d: -f1" \
        "printf 'a:1\nb:2\n' | $F_TOOL -d: -f1"

    run_test "gnu cut.pl newline-4: -d: -f1 no final nl" \
        "printf 'a:1\nb:2' | $GNU_TOOL -d: -f1" \
        "printf 'a:1\nb:2' | $F_TOOL -d: -f1"

    run_test "gnu cut.pl newline-5: -d: -f2 multi-line" \
        "printf 'a:1\nb:2\n' | $GNU_TOOL -d: -f2" \
        "printf 'a:1\nb:2\n' | $F_TOOL -d: -f2"

    run_test "gnu cut.pl newline-9: -s -d: -f1 no delim" \
        "printf 'a1\nb2' | $GNU_TOOL -s -d: -f1" \
        "printf 'a1\nb2' | $F_TOOL -s -d: -f1"

    # === GNU Upstream: Zero-Terminated Lines (-z) ===
    echo ""
    echo "=== GNU Upstream: Zero-Terminated Lines (-z) ==="

    # From cut.pl: zerot tests
    run_test "gnu cut.pl zerot-1: -z -c1" \
        "printf 'ab\0cd\0' | $GNU_TOOL -z -c1 | od -An -tx1" \
        "printf 'ab\0cd\0' | $F_TOOL -z -c1 | od -An -tx1"

    run_test "gnu cut.pl zerot-2: -z -c1 no trailing NUL" \
        "printf 'ab\0cd' | $GNU_TOOL -z -c1 | od -An -tx1" \
        "printf 'ab\0cd' | $F_TOOL -z -c1 | od -An -tx1"

    run_test "gnu cut.pl zerot-4: -z -d: -f1" \
        "printf 'a:1\0b:2' | $GNU_TOOL -z -d: -f1 | od -An -tx1" \
        "printf 'a:1\0b:2' | $F_TOOL -z -d: -f1 | od -An -tx1"

    # === GNU Upstream: Overlapping/Unbounded Ranges ===
    echo ""
    echo "=== GNU Upstream: Overlapping/Unbounded Ranges ==="

    # From cut.pl: overlapping unbounded ranges
    run_test "gnu cut.pl overlapping-unbounded-1: -b3-,2-" \
        "printf '1234\n' | $GNU_TOOL -b3-,2-" \
        "printf '1234\n' | $F_TOOL -b3-,2-"

    run_test "gnu cut.pl overlapping-unbounded-2: -b2-,3-" \
        "printf '1234\n' | $GNU_TOOL -b2-,3-" \
        "printf '1234\n' | $F_TOOL -b2-,3-"

    # From cut.pl: big unbounded range with output delimiter
    run_test "gnu cut.pl big-unbounded-b2a: -b1,9- --output-d=:" \
        "printf '123456789' | $GNU_TOOL --output-delimiter=: -b1,9-" \
        "printf '123456789' | $F_TOOL --output-delimiter=: -b1,9-"

    # From cut.pl: EOL-subsumed ranges (coreutils 8.20 bug)
    run_test "gnu cut.pl EOL-subsumed-1: -b2-,3,4-4,5 --output-d=:" \
        "printf '123456\n' | $GNU_TOOL --output-delimiter=: -b2-,3,4-4,5" \
        "printf '123456\n' | $F_TOOL --output-delimiter=: -b2-,3,4-4,5"

    run_test "gnu cut.pl EOL-subsumed-3: --complement -b3,4-4,5,2-" \
        "printf '123456\n' | $GNU_TOOL --complement -b3,4-4,5,2-" \
        "printf '123456\n' | $F_TOOL --complement -b3,4-4,5,2-"

    # === GNU Upstream: Error Cases ===
    echo ""
    echo "=== GNU Upstream: Error Cases ==="

    # From cut.pl: zero byte/field position errors
    run_exit_code_test "gnu cut.pl zero-1: -b0" \
        "echo x | $GNU_TOOL -b0 2>&1" \
        "echo x | $F_TOOL -b0 2>&1"

    run_exit_code_test "gnu cut.pl zero-2: -f0-2" \
        "echo x | $GNU_TOOL -f0-2 2>&1" \
        "echo x | $F_TOOL -f0-2 2>&1"

    run_exit_code_test "gnu cut.pl zero-3b: -b0-" \
        "echo x | $GNU_TOOL -b0- 2>&1" \
        "echo x | $F_TOOL -b0- 2>&1"

    run_exit_code_test "gnu cut.pl zero-3f: -f0-" \
        "echo x | $GNU_TOOL -f0- 2>&1" \
        "echo x | $F_TOOL -f0- 2>&1"

    # From cut.pl: invalid decreasing range
    run_exit_code_test "gnu cut.pl inval1: -f 2-0" \
        "printf '' | $GNU_TOOL -f 2-0 2>&1" \
        "printf '' | $F_TOOL -f 2-0 2>&1"

    # From cut.pl: invalid range with no endpoint
    run_exit_code_test "gnu cut.pl inval2: -f -" \
        "printf '' | $GNU_TOOL -f - 2>&1" \
        "printf '' | $F_TOOL -f - 2>&1"

    # From cut.pl: -s may only be used with -f
    run_exit_code_test "gnu cut.pl y: -s -b4" \
        "printf ':\n' | $GNU_TOOL -s -b4 2>&1" \
        "printf ':\n' | $F_TOOL -s -b4 2>&1"

    # From cut.pl: delimiter without field mode
    run_exit_code_test "gnu cut.pl delim-no-field: -d: -b1" \
        "echo x | $GNU_TOOL -d: -b1 2>&1" \
        "echo x | $F_TOOL -d: -b1 2>&1"

    # bounded-memory.sh: skipped (requires ulimit -v)
    skip_test "bounded memory cut" "Requires ulimit -v memory constraints"

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
    echo "=== GNU Upstream: Huge Range Handling ==="

    # From cut-huge-range.sh: ensure cut handles very large byte ranges
    # without excessive memory allocation (coreutils-8.10 through 8.20 bug)
    run_test "huge range -b999999999-" \
        "echo 'test' | $GNU_TOOL -b999999999-" \
        "echo 'test' | $F_TOOL -b999999999-"

    run_test "huge range -b1-999999999" \
        "echo 'test' | $GNU_TOOL -b1-999999999" \
        "echo 'test' | $F_TOOL -b1-999999999"

    # bounded-memory.sh: skipped (requires ulimit -v and /dev/zero streaming)
    skip_test "bounded memory cut" "Requires ulimit -v memory constraints"

    # cut-huge-range.sh overflow tests: skipped (requires getlimits_ / UINTMAX values)
    skip_test "cut UINTMAX range" "Requires getlimits_ overflow values"

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
