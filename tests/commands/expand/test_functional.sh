#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fexpand"
run_expand_functional_tests() {
    init_test_suite "expand"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"expand","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/expand_results.json"
        return 0
    fi
    run_expected_stdin_test "default tab expansion" "$F_TOOL" "$(printf 'a\tb')" "a       b"
    run_expected_stdin_test "tabs to 4 spaces" "$F_TOOL -t 4" "$(printf 'a\tb')" "a   b"
    run_expected_stdin_test "no tabs" "$F_TOOL" "hello" "hello"
    run_expected_stdin_test "multiple tabs" "$F_TOOL -t 4" "$(printf '\ta\t\tb')" "    a       b"
    run_expected_exit_test "exits 0" "printf \"hello\" | $F_TOOL" 0
    finish_test_suite
}
run_expand_functional_tests
