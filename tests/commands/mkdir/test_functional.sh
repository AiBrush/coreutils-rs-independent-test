#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fmkdir"
run_mkdir_functional_tests() {
    init_test_suite "mkdir"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mkdir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mkdir_results.json"
        return 0
    fi
    local testdir="/tmp/fcoreutils_mkdir_$$"
    run_expected_exit_test "create dir" "$F_TOOL $testdir" 0
    rm -rf "$testdir"
    run_expected_exit_test "create nested dirs" "$F_TOOL -p $testdir/a/b/c" 0
    rm -rf "$testdir"
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_mkdir_functional_tests
