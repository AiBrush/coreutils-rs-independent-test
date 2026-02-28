#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fdu"
run_du_functional_tests() {
    init_test_suite "du"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"du","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/du_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0 on /tmp" "$F_TOOL -s /tmp" 0
    run_expected_exit_test "human readable exits 0" "$F_TOOL -sh /tmp" 0
    run_expected_exit_test "nonexistent dir fails" "$F_TOOL /tmp/nonexistent_dir_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_du_functional_tests
