#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ffactor"
run_factor_functional_tests() {
    init_test_suite "factor"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"factor","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/factor_results.json"
        return 0
    fi
    run_expected_test "factor 12" "$F_TOOL 12" "12: 2 2 3"
    run_expected_test "factor 1" "$F_TOOL 1" "1:"
    run_expected_test "factor prime 7" "$F_TOOL 7" "7: 7"
    run_expected_test "factor prime 13" "$F_TOOL 13" "13: 13"
    run_expected_test "factor 100" "$F_TOOL 100" "100: 2 2 5 5"
    run_expected_test "factor 2" "$F_TOOL 2" "2: 2"
    run_expected_stdin_test "factor from stdin" "$F_TOOL" "15" "15: 3 5"
    run_expected_exit_test "exits 0" "$F_TOOL 42" 0
    finish_test_suite
}
run_factor_functional_tests
