#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="funiq"
run_uniq_functional_tests() {
    init_test_suite "uniq"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"uniq","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/uniq_results.json"
        return 0
    fi
    run_expected_stdin_test "basic unique" "$F_TOOL" "$(printf 'a\na\nb\nb\nc')" "$(printf 'a\nb\nc')"
    run_expected_stdin_test "count occurrences" "$F_TOOL -c" "$(printf 'a\na\nb\nb\nb\nc')" "$(printf '      2 a\n      3 b\n      1 c')"
    run_expected_stdin_test "only duplicates" "$F_TOOL -d" "$(printf 'a\na\nb\nc\nc')" "$(printf 'a\nc')"
    run_expected_stdin_test "only unique" "$F_TOOL -u" "$(printf 'a\na\nb\nc\nc')" "b"
    run_expected_stdin_test "case insensitive" "$F_TOOL -i" "$(printf 'Hello\nhello\nWorld')" "$(printf 'Hello\nWorld')"
    run_expected_stdin_test "no duplicates" "$F_TOOL" "$(printf 'a\nb\nc')" "$(printf 'a\nb\nc')"
    run_expected_stdin_test "all same" "$F_TOOL" "$(printf 'a\na\na')" "a"
    run_expected_stdin_test "empty input" "$F_TOOL" "" ""
    run_expected_stdin_test "skip field" "$F_TOOL -f 1" "$(printf 'a 1\nb 1\na 2')" "$(printf 'a 1\na 2')"
    run_expected_stdin_test "skip chars" "$F_TOOL -s 1" "$(printf 'ax\nbx\nay')" "$(printf 'ax\nay')"
    run_expected_exit_test "exits 0" "printf 'hello' | $F_TOOL" 0
    finish_test_suite
}
run_uniq_functional_tests
