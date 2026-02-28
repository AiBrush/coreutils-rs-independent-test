#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fwhoami"
run_whoami_functional_tests() {
    init_test_suite "whoami"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"whoami","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/whoami_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    # Output should match the current user
    run_expected_test "matches whoami" "$F_TOOL" "$(whoami)"
    finish_test_suite
}
run_whoami_functional_tests
