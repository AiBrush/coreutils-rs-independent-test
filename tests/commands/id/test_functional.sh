#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fid"
run_id_functional_tests() {
    init_test_suite "id"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"id","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/id_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    run_expected_exit_test "user name exits 0" "$F_TOOL -un" 0
    run_expected_exit_test "group id exits 0" "$F_TOOL -g" 0
    run_expected_exit_test "user id exits 0" "$F_TOOL -u" 0
    run_expected_exit_test "nonexistent user fails" "$F_TOOL nonexistent_user_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_id_functional_tests
