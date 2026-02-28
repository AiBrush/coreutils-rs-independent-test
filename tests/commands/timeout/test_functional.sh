#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftimeout"
run_timeout_functional_tests() {
    init_test_suite "timeout"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"timeout","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/timeout_results.json"
        return 0
    fi
    run_expected_exit_test "fast command exits 0" "$F_TOOL 5 true" 0
    run_expected_exit_test "fast false exits 1" "$F_TOOL 5 false" 1
    run_expected_exit_test "actual timeout exits 124" "$F_TOOL 0.1 sleep 10" 124
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_timeout_functional_tests
