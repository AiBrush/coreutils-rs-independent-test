#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fvdir"
run_vdir_functional_tests() {
    init_test_suite "vdir"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"vdir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/vdir_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0 on /tmp" "$F_TOOL /tmp" 0
    run_expected_exit_test "nonexistent dir fails" "$F_TOOL /tmp/nonexistent_dir_functional_test 2>/dev/null" 2
    finish_test_suite
}
run_vdir_functional_tests
