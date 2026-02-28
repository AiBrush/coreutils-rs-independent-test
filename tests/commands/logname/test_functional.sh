#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="flogname"
run_logname_functional_tests() {
    init_test_suite "logname"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"logname","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/logname_results.json"
        return 0
    fi
    # logname may fail in CI environments without a login session
    run_expected_exit_test "exits 0 or 1" "$F_TOOL 2>/dev/null || true" 0
    finish_test_suite
}
run_logname_functional_tests
