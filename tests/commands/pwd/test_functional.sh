#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fpwd"
run_pwd_functional_tests() {
    init_test_suite "pwd"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pwd","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/pwd_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    run_expected_exit_test "output is non-empty" "test -n \"$($F_TOOL)\"" 0
    finish_test_suite
}
run_pwd_functional_tests
