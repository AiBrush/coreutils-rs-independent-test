#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fmknod"
run_mknod_functional_tests() {
    init_test_suite "mknod"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mknod","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mknod_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    local fifo="/tmp/fcoreutils_mknod_$$"
    run_expected_exit_test "create pipe" "$F_TOOL $fifo p" 0
    rm -f "$fifo"
    finish_test_suite
}
run_mknod_functional_tests
