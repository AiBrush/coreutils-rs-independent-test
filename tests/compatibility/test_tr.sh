#!/usr/bin/env bash
# Compatibility tests for ftr vs GNU tr
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tr"
F_TOOL="ftr"

run_tr_tests() {
    init_test_suite "tr"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tr","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tr_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU tr not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Simple Translation ==="

    run_test "lowercase to uppercase" \
        "echo 'hello world' | $GNU_TOOL 'a-z' 'A-Z'" \
        "echo 'hello world' | $F_TOOL 'a-z' 'A-Z'"

    run_test "uppercase to lowercase" \
        "echo 'HELLO WORLD' | $GNU_TOOL 'A-Z' 'a-z'" \
        "echo 'HELLO WORLD' | $F_TOOL 'A-Z' 'a-z'"

    run_test "single char translation" \
        "echo 'hello' | $GNU_TOOL 'h' 'H'" \
        "echo 'hello' | $F_TOOL 'h' 'H'"

    run_test "digits to letters" \
        "echo 'abc123' | $GNU_TOOL '0-9' 'a-j'" \
        "echo 'abc123' | $F_TOOL '0-9' 'a-j'"

    run_test "translate from file" \
        "$GNU_TOOL 'a-z' 'A-Z' < '$TEST_DATA_DIR/lowercase.txt'" \
        "$F_TOOL 'a-z' 'A-Z' < '$TEST_DATA_DIR/lowercase.txt'"

    run_test "spaces to underscores" \
        "echo 'hello world foo bar' | $GNU_TOOL ' ' '_'" \
        "echo 'hello world foo bar' | $F_TOOL ' ' '_'"

    run_test "translate empty input" \
        "printf '' | $GNU_TOOL 'a-z' 'A-Z'" \
        "printf '' | $F_TOOL 'a-z' 'A-Z'"

    echo ""
    echo "=== Delete Mode (-d) ==="

    run_test "-d delete lowercase" \
        "echo 'Hello World 123' | $GNU_TOOL -d 'a-z'" \
        "echo 'Hello World 123' | $F_TOOL -d 'a-z'"

    run_test "-d delete digits" \
        "echo 'abc123def456' | $GNU_TOOL -d '0-9'" \
        "echo 'abc123def456' | $F_TOOL -d '0-9'"

    run_test "-d delete spaces" \
        "echo 'hello world' | $GNU_TOOL -d ' '" \
        "echo 'hello world' | $F_TOOL -d ' '"

    run_test "-d delete newlines" \
        "printf 'line1\nline2\nline3\n' | $GNU_TOOL -d '\n'" \
        "printf 'line1\nline2\nline3\n' | $F_TOOL -d '\n'"

    run_test "-d from file" \
        "$GNU_TOOL -d '0-9' < '$TEST_DATA_DIR/digits_and_letters.txt'" \
        "$F_TOOL -d '0-9' < '$TEST_DATA_DIR/digits_and_letters.txt'"

    echo ""
    echo "=== Squeeze Mode (-s) ==="

    run_test "-s squeeze spaces" \
        "echo 'hello    world' | $GNU_TOOL -s ' '" \
        "echo 'hello    world' | $F_TOOL -s ' '"

    run_test "-s squeeze from file" \
        "$GNU_TOOL -s ' ' < '$TEST_DATA_DIR/squeeze_input.txt'" \
        "$F_TOOL -s ' ' < '$TEST_DATA_DIR/squeeze_input.txt'"

    run_test "-s squeeze newlines" \
        "printf 'a\n\n\nb\n\nc\n' | $GNU_TOOL -s '\n'" \
        "printf 'a\n\n\nb\n\nc\n' | $F_TOOL -s '\n'"

    run_test "-s squeeze with translate" \
        "echo 'HELLO    WORLD' | $GNU_TOOL -s 'A-Z ' 'a-z_'" \
        "echo 'HELLO    WORLD' | $F_TOOL -s 'A-Z ' 'a-z_'"

    echo ""
    echo "=== Complement (-c / -C) ==="

    run_test "-c complement delete (keep only digits)" \
        "echo 'abc123def456' | $GNU_TOOL -cd '0-9'" \
        "echo 'abc123def456' | $F_TOOL -cd '0-9'"

    run_test "-c complement translate" \
        "echo 'abc123' | $GNU_TOOL -c 'a-z' '*'" \
        "echo 'abc123' | $F_TOOL -c 'a-z' '*'"

    run_test "-C complement (same as -c)" \
        "echo 'abc123def456' | $GNU_TOOL -Cd '0-9'" \
        "echo 'abc123def456' | $F_TOOL -Cd '0-9'"

    run_test "-c with squeeze" \
        "echo 'abc123def456' | $GNU_TOOL -cs 'a-z' '\n'" \
        "echo 'abc123def456' | $F_TOOL -cs 'a-z' '\n'"

    echo ""
    echo "=== Truncate (-t) ==="

    run_test "-t truncate SET1 to SET2 length" \
        "echo 'abcdef' | $GNU_TOOL -t 'a-f' 'xy'" \
        "echo 'abcdef' | $F_TOOL -t 'a-f' 'xy'"

    echo ""
    echo "=== Character Classes ==="

    run_test "[:upper:] to [:lower:]" \
        "echo 'HELLO WORLD' | $GNU_TOOL '[:upper:]' '[:lower:]'" \
        "echo 'HELLO WORLD' | $F_TOOL '[:upper:]' '[:lower:]'"

    run_test "[:lower:] to [:upper:]" \
        "echo 'hello world' | $GNU_TOOL '[:lower:]' '[:upper:]'" \
        "echo 'hello world' | $F_TOOL '[:lower:]' '[:upper:]'"

    run_test "delete [:digit:]" \
        "echo 'abc123def456' | $GNU_TOOL -d '[:digit:]'" \
        "echo 'abc123def456' | $F_TOOL -d '[:digit:]'"

    run_test "delete [:alpha:]" \
        "echo 'abc123def456' | $GNU_TOOL -d '[:alpha:]'" \
        "echo 'abc123def456' | $F_TOOL -d '[:alpha:]'"

    run_test "delete [:space:]" \
        "echo 'hello world' | $GNU_TOOL -d '[:space:]'" \
        "echo 'hello world' | $F_TOOL -d '[:space:]'"

    run_test "delete [:blank:]" \
        "printf 'hello\tworld test\n' | $GNU_TOOL -d '[:blank:]'" \
        "printf 'hello\tworld test\n' | $F_TOOL -d '[:blank:]'"

    run_test "delete [:punct:]" \
        "echo 'hello, world! foo-bar.' | $GNU_TOOL -d '[:punct:]'" \
        "echo 'hello, world! foo-bar.' | $F_TOOL -d '[:punct:]'"

    run_test "delete [:cntrl:]" \
        "printf 'hello\x01world\x02test\n' | $GNU_TOOL -d '[:cntrl:]'" \
        "printf 'hello\x01world\x02test\n' | $F_TOOL -d '[:cntrl:]'"

    run_test "squeeze [:space:]" \
        "echo 'hello    world' | $GNU_TOOL -s '[:space:]'" \
        "echo 'hello    world' | $F_TOOL -s '[:space:]'"

    run_test "[:alnum:] complement delete" \
        "echo 'Hello, World! 123' | $GNU_TOOL -cd '[:alnum:]'" \
        "echo 'Hello, World! 123' | $F_TOOL -cd '[:alnum:]'"

    run_test "[:xdigit:] delete" \
        "echo 'Hello 0xDEAD 0xBEEF world' | $GNU_TOOL -d '[:xdigit:]'" \
        "echo 'Hello 0xDEAD 0xBEEF world' | $F_TOOL -d '[:xdigit:]'"

    run_test "[:print:] complement delete" \
        "printf 'hello\x01\x02world\n' | $GNU_TOOL -cd '[:print:]'" \
        "printf 'hello\x01\x02world\n' | $F_TOOL -cd '[:print:]'"

    run_test "[:graph:] complement delete" \
        "echo 'hello world test' | $GNU_TOOL -cd '[:graph:]'" \
        "echo 'hello world test' | $F_TOOL -cd '[:graph:]'"

    echo ""
    echo "=== Escape Sequences ==="

    run_test "\\n escape" \
        "echo 'hello world' | $GNU_TOOL ' ' '\n'" \
        "echo 'hello world' | $F_TOOL ' ' '\n'"

    run_test "\\t escape" \
        "echo 'hello world' | $GNU_TOOL ' ' '\t'" \
        "echo 'hello world' | $F_TOOL ' ' '\t'"

    run_test "\\\\ escape" \
        "echo 'hello' | $GNU_TOOL 'h' '\\\\'" \
        "echo 'hello' | $F_TOOL 'h' '\\\\'"

    echo ""
    echo "=== SET Length Mismatches ==="

    run_test "SET1 longer than SET2 (last char repeats)" \
        "echo 'abcdef' | $GNU_TOOL 'a-f' 'xy'" \
        "echo 'abcdef' | $F_TOOL 'a-f' 'xy'"

    run_test "SET2 longer than SET1" \
        "echo 'ab' | $GNU_TOOL 'ab' 'xyz'" \
        "echo 'ab' | $F_TOOL 'ab' 'xyz'"

    echo ""
    echo "=== Octal Escapes ==="

    run_test "octal escape \\101 (A)" \
        "echo 'hello' | $GNU_TOOL 'h' '\\101'" \
        "echo 'hello' | $F_TOOL 'h' '\\101'"

    echo ""
    echo "=== Binary Data ==="

    run_test "translate binary data" \
        "$GNU_TOOL '\\000' 'X' < '$TEST_DATA_DIR/null_bytes.bin'" \
        "$F_TOOL '\\000' 'X' < '$TEST_DATA_DIR/null_bytes.bin'"

    echo ""
    echo "=== Large File ==="

    run_test "lowercase 10MB file" \
        "$GNU_TOOL 'a-z' 'A-Z' < '$TEST_DATA_DIR/text_10m.txt' | md5sum" \
        "$F_TOOL 'a-z' 'A-Z' < '$TEST_DATA_DIR/text_10m.txt' | md5sum"

    run_test "delete digits 10MB" \
        "$GNU_TOOL -d '0-9' < '$TEST_DATA_DIR/csv_10m.csv' | md5sum" \
        "$F_TOOL -d '0-9' < '$TEST_DATA_DIR/csv_10m.csv' | md5sum"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments" \
        "echo 'hello' | $GNU_TOOL 2>&1" \
        "echo 'hello' | $F_TOOL 2>&1"

    run_exit_code_test "-d with two sets" \
        "echo 'hello' | $GNU_TOOL -d 'a-z' 'A-Z' 2>&1" \
        "echo 'hello' | $F_TOOL -d 'a-z' 'A-Z' 2>&1"

    echo ""
    echo "=== Locale Sensitivity ==="

    run_test "LC_ALL=C uppercase" \
        "LC_ALL=C echo 'hello world' | $GNU_TOOL 'a-z' 'A-Z'" \
        "LC_ALL=C echo 'hello world' | $F_TOOL 'a-z' 'A-Z'"

    finish_test_suite
}

run_tr_tests
