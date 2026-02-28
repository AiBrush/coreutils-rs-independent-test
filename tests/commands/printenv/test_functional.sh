#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fprintenv"
run_printenv_functional_tests() {
    init_test_suite "printenv"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"printenv","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/printenv_results.json"
        return 0
    fi
    run_expected_exit_test "list all exits 0" "$F_TOOL" 0
    run_expected_test "specific var" "TESTVAR_FUNC=hello123 $F_TOOL TESTVAR_FUNC" "hello123"
    run_expected_exit_test "nonexistent var fails" "$F_TOOL NONEXISTENT_VAR_FUNC_TEST_$$ 2>/dev/null" 1
    finish_test_suite
}
run_printenv_functional_tests
