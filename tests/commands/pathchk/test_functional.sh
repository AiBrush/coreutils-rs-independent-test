#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fpathchk"
run_pathchk_functional_tests() {
    init_test_suite "pathchk"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pathchk","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/pathchk_results.json"
        return 0
    fi
    run_expected_exit_test "valid path" "$F_TOOL /tmp" 0
    run_expected_exit_test "empty string fails" "$F_TOOL '' 2>/dev/null" 1
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_pathchk_functional_tests
