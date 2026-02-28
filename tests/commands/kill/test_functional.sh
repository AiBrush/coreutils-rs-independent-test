#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fkill"
run_kill_functional_tests() {
    init_test_suite "kill"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"kill","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/kill_results.json"
        return 0
    fi
    run_expected_exit_test "list signals exits 0" "$F_TOOL -l" 0
    run_expected_exit_test "invalid pid fails" "$F_TOOL 99999999 2>/dev/null" 1
    finish_test_suite
}
run_kill_functional_tests
