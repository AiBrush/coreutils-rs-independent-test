#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fsleep"
run_sleep_functional_tests() {
    init_test_suite "sleep"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sleep","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sleep_results.json"
        return 0
    fi
    run_expected_exit_test "sleep 0 exits 0" "$F_TOOL 0" 0
    run_expected_exit_test "sleep 0.01 exits 0" "$F_TOOL 0.01" 0
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_sleep_functional_tests
