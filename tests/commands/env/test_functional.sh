#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fenv"
run_env_functional_tests() {
    init_test_suite "env"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"env","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/env_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    run_expected_test "set and print var" "$F_TOOL TESTVAR=hello printenv TESTVAR" "hello"
    run_expected_exit_test "run true exits 0" "$F_TOOL true" 0
    run_expected_exit_test "run false exits 1" "$F_TOOL false" 1
    finish_test_suite
}
run_env_functional_tests
