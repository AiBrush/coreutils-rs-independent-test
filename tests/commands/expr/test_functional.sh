#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fexpr"
run_expr_functional_tests() {
    init_test_suite "expr"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"expr","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/expr_results.json"
        return 0
    fi
    run_expected_test "addition" "$F_TOOL 1 + 2" "3"
    run_expected_test "subtraction" "$F_TOOL 10 - 3" "7"
    run_expected_test "multiplication" "$F_TOOL 3 \* 4" "12"
    run_expected_test "division" "$F_TOOL 10 / 3" "3"
    run_expected_test "modulo" "$F_TOOL 10 % 3" "1"
    run_expected_test "string length" "$F_TOOL length hello" "5"
    run_expected_test "string match" "$F_TOOL match hello h..." "4"
    run_expected_exit_test "true result exits 0" "$F_TOOL 1 + 1" 0
    run_expected_exit_test "false result exits 1" "$F_TOOL 0" 1
    finish_test_suite
}
run_expr_functional_tests
