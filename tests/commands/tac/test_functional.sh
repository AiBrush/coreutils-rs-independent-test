#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftac"
run_tac_functional_tests() {
    init_test_suite "tac"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tac","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tac_results.json"
        return 0
    fi
    run_expected_stdin_test "reverse lines" "$F_TOOL" "$(printf 'a\nb\nc')" "$(printf 'c\nb\na')"
    run_expected_stdin_test "single line" "$F_TOOL" "hello" "hello"
    run_expected_stdin_test "empty input" "$F_TOOL" "" ""
    run_expected_stdin_test "two lines" "$F_TOOL" "$(printf 'first\nlast')" "$(printf 'last\nfirst')"
    run_expected_stdin_test "with trailing newline" "$F_TOOL" "$(printf 'a\nb\nc\n')" "$(printf 'c\nb\na\n')"
    run_expected_exit_test "exits 0" "printf 'hello' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_tac_functional_tests
