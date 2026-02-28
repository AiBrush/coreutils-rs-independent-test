#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fdir"
run_dir_functional_tests() {
    init_test_suite "dir"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/dir_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0 on current dir" "$F_TOOL ." 0
    run_expected_exit_test "exits 0 on /tmp" "$F_TOOL /tmp" 0
    run_expected_exit_test "nonexistent dir fails" "$F_TOOL /tmp/nonexistent_dir_functional_test 2>/dev/null" 2
    finish_test_suite
}
run_dir_functional_tests
