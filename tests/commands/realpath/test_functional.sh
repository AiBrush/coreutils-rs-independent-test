#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="frealpath"
run_realpath_functional_tests() {
    init_test_suite "realpath"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"realpath","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/realpath_results.json"
        return 0
    fi
    run_expected_test "resolve /tmp" "$F_TOOL /tmp" "$(realpath /tmp)"
    run_expected_test "resolve dot" "$F_TOOL ." "$(realpath .)"
    run_expected_exit_test "exits 0" "$F_TOOL /" 0
    finish_test_suite
}
run_realpath_functional_tests
