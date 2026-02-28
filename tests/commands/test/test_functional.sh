#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftest"
run_test_functional_tests() {
    init_test_suite "test"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"test","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/test_results.json"
        return 0
    fi
    run_expected_exit_test "true string" "$F_TOOL hello" 0
    run_expected_exit_test "empty string is false" "$F_TOOL ''" 1
    run_expected_exit_test "integer equal" "$F_TOOL 1 -eq 1" 0
    run_expected_exit_test "integer not equal" "$F_TOOL 1 -eq 2" 1
    run_expected_exit_test "integer greater" "$F_TOOL 5 -gt 3" 0
    run_expected_exit_test "integer less" "$F_TOOL 3 -lt 5" 0
    run_expected_exit_test "string equal" "$F_TOOL hello = hello" 0
    run_expected_exit_test "string not equal" "$F_TOOL hello != world" 0
    run_expected_exit_test "file exists" "$F_TOOL -e /tmp" 0
    run_expected_exit_test "directory exists" "$F_TOOL -d /tmp" 0
    run_expected_exit_test "file not found" "$F_TOOL -e /tmp/nonexistent_file_functional_test" 1
    run_expected_exit_test "negation" "$F_TOOL ! hello = world" 0
    finish_test_suite
}
run_test_functional_tests
