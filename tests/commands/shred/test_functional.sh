#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fshred"
run_shred_functional_tests() {
    init_test_suite "shred"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"shred","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/shred_results.json"
        return 0
    fi
    local tmp="/tmp/fcoreutils_shred_$$"
    printf "secret data" > "$tmp"
    run_expected_exit_test "shred file" "$F_TOOL $tmp" 0
    rm -f "$tmp"
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_shred_functional_tests
