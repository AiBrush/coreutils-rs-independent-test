#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftr"
run_tr_functional_tests() {
    init_test_suite "tr"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tr","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tr_results.json"
        return 0
    fi
    run_expected_stdin_test "lowercase to uppercase" "$F_TOOL a-z A-Z" "hello" "HELLO"
    run_expected_stdin_test "uppercase to lowercase" "$F_TOOL A-Z a-z" "HELLO" "hello"
    run_expected_stdin_test "delete chars" "$F_TOOL -d aeiou" "hello world" "hll wrld"
    run_expected_stdin_test "squeeze repeats" "$F_TOOL -s ' '" "hello   world" "hello world"
    run_expected_stdin_test "complement delete" "$F_TOOL -cd 'a-zA-Z'" "hello 123 world" "helloworld"
    run_expected_stdin_test "translate single char" "$F_TOOL a b" "banana" "bbnbnb"
    run_expected_stdin_test "character class lower" "$F_TOOL '[:lower:]' '[:upper:]'" "hello" "HELLO"
    run_expected_stdin_test "character class upper" "$F_TOOL '[:upper:]' '[:lower:]'" "HELLO" "hello"
    run_expected_stdin_test "delete digits" "$F_TOOL -d '[:digit:]'" "abc123def456" "abcdef"
    run_expected_stdin_test "squeeze newlines" "$F_TOOL -s '\n'" "$(printf 'a\n\n\nb')" "$(printf 'a\nb')"
    run_expected_stdin_test "replace spaces with underscores" "$F_TOOL ' ' '_'" "hello world" "hello_world"
    run_expected_stdin_test "empty input" "$F_TOOL a b" "" ""
    run_expected_exit_test "exits 0" "printf 'hello' | $F_TOOL a b" 0
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_tr_functional_tests
