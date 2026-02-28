#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="funlink"
run_unlink_functional_tests() {
    init_test_suite "unlink"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"unlink","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/unlink_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    local tmp="/tmp/fcoreutils_unlink_$$"
    printf "hello" > "$tmp"
    run_expected_exit_test "unlink file" "$F_TOOL $tmp" 0
    finish_test_suite
}
run_unlink_functional_tests
