#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fmkfifo"
run_mkfifo_functional_tests() {
    init_test_suite "mkfifo"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mkfifo","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mkfifo_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    local fifo="/tmp/fcoreutils_mkfifo_$$"
    run_expected_exit_test "create fifo" "$F_TOOL $fifo" 0
    rm -f "$fifo"
    finish_test_suite
}
run_mkfifo_functional_tests
