#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftouch"
run_touch_functional_tests() {
    init_test_suite "touch"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"touch","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/touch_results.json"
        return 0
    fi
    local tmp="/tmp/fcoreutils_touch_$$"
    run_expected_exit_test "create file" "$F_TOOL $tmp" 0
    rm -f "$tmp"
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    # Touch existing file
    local existing="/tmp/fcoreutils_touch_exist_$$"
    printf "data" > "$existing"
    run_expected_exit_test "touch existing" "$F_TOOL $existing" 0
    rm -f "$existing"
    finish_test_suite
}
run_touch_functional_tests
