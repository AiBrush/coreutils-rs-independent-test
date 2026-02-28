#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftee"
run_tee_functional_tests() {
    init_test_suite "tee"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tee","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tee_results.json"
        return 0
    fi
    run_expected_stdin_test "passthrough" "$F_TOOL" "hello world" "hello world"
    local tmp="/tmp/fcoreutils_tee_$$"
    run_expected_stdin_test "write to file" "$F_TOOL $tmp" "test data" "test data"
    rm -f "$tmp"
    run_expected_exit_test "exits 0" "printf 'test' | $F_TOOL" 0
    finish_test_suite
}
run_tee_functional_tests
