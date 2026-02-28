#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fcat"
run_cat_functional_tests() {
    init_test_suite "cat"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cat","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/cat_results.json"
        return 0
    fi
    run_expected_stdin_test "passthrough" "$F_TOOL" "hello world" "hello world"
    run_expected_stdin_test "multiline" "$F_TOOL" "$(printf 'line1\nline2\nline3')" "$(printf 'line1\nline2\nline3')"
    run_expected_stdin_test "empty input" "$F_TOOL" "" ""
    run_expected_stdin_test "number lines" "$F_TOOL -n" "$(printf 'a\nb\nc')" "$(printf '     1\ta\n     2\tb\n     3\tc')"
    run_expected_stdin_test "show ends" "$F_TOOL -E" "$(printf 'hello\nworld')" "$(printf 'hello$\nworld$')"
    run_expected_stdin_test "show tabs" "$F_TOOL -T" "$(printf 'a\tb')" "a^Ib"
    run_expected_stdin_test "squeeze blanks" "$F_TOOL -s" "$(printf 'a\n\n\nb')" "$(printf 'a\n\nb')"
    run_expected_exit_test "exits 0" "printf \"hello\" | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_cat_functional_tests
