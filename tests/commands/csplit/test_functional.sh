#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fcsplit"
run_csplit_functional_tests() {
    init_test_suite "csplit"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"csplit","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/csplit_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test /pattern/ 2>/dev/null" 1
    finish_test_suite
}
run_csplit_functional_tests
