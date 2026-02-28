#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="funexpand"
run_unexpand_functional_tests() {
    init_test_suite "unexpand"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"unexpand","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/unexpand_results.json"
        return 0
    fi
    run_expected_stdin_test "spaces to tabs" "$F_TOOL" "        hello" "$(printf '\thello')"
    run_expected_stdin_test "no spaces" "$F_TOOL" "hello" "hello"
    run_expected_stdin_test "all spaces" "$F_TOOL -a -t 4" "    a   b" "$(printf '\ta\t b')"
    run_expected_exit_test "exits 0" "printf 'hello' | $F_TOOL" 0
    finish_test_suite
}
run_unexpand_functional_tests
