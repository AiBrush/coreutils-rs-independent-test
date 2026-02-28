#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="frev"
run_rev_functional_tests() {
    init_test_suite "rev"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"rev","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/rev_results.json"
        return 0
    fi
    run_expected_stdin_test "reverse hello" "$F_TOOL" "hello" "olleh"
    run_expected_stdin_test "reverse multiline" "$F_TOOL" "$(printf 'abc\ndef')" "$(printf 'cba\nfed')"
    run_expected_stdin_test "empty input" "$F_TOOL" "" ""
    run_expected_stdin_test "single char" "$F_TOOL" "a" "a"
    run_expected_stdin_test "palindrome" "$F_TOOL" "abcba" "abcba"
    run_expected_exit_test "exits 0" "printf 'hello' | $F_TOOL" 0
    finish_test_suite
}
run_rev_functional_tests
