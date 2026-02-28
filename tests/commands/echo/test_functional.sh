#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fecho"
run_echo_functional_tests() {
    init_test_suite "echo"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"echo","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/echo_results.json"
        return 0
    fi
    run_expected_test "simple string" "$F_TOOL hello" "hello"
    run_expected_test "multiple args" "$F_TOOL hello world" "hello world"
    run_expected_test "no args (empty line)" "$F_TOOL" ""
    run_expected_test "no newline -n" "$F_TOOL -n hello | cat; printf '\n'" "hello"
    run_expected_test "escape sequences -e" "$F_TOOL -e 'hello\tworld'" "$(printf 'hello\tworld')"
    run_expected_test "backslash no escape" "$F_TOOL 'hello\\nworld'" "hello\\nworld"
    run_expected_exit_test "exits 0" "$F_TOOL hello" 0
    finish_test_suite
}
run_echo_functional_tests
