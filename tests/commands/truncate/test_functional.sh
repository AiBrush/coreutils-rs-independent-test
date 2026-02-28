#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftruncate"
run_truncate_functional_tests() {
    init_test_suite "truncate"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"truncate","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/truncate_results.json"
        return 0
    fi
    local tmp="/tmp/fcoreutils_truncate_$$"
    printf "hello world" > "$tmp"
    run_expected_exit_test "truncate to 5" "$F_TOOL -s 5 $tmp" 0
    rm -f "$tmp"
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_truncate_functional_tests
