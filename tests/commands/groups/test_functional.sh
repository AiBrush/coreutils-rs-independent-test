#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fgroups"
run_groups_functional_tests() {
    init_test_suite "groups"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"groups","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/groups_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    run_expected_exit_test "nonexistent user fails" "$F_TOOL nonexistent_user_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_groups_functional_tests
