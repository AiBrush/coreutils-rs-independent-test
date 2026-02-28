#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fuptime"
run_uptime_functional_tests() {
    init_test_suite "uptime"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"uptime","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/uptime_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    finish_test_suite
}
run_uptime_functional_tests
