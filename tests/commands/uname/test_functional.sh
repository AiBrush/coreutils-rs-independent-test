#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="funame"
run_uname_functional_tests() {
    init_test_suite "uname"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"uname","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/uname_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    run_expected_exit_test "all info exits 0" "$F_TOOL -a" 0
    run_expected_test "kernel name" "$F_TOOL -s" "$(uname -s)"
    run_expected_test "machine" "$F_TOOL -m" "$(uname -m)"
    finish_test_suite
}
run_uname_functional_tests
