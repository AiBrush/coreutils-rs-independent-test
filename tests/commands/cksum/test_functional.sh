#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fcksum"
run_cksum_functional_tests() {
    init_test_suite "cksum"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cksum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/cksum_results.json"
        return 0
    fi
    run_expected_stdin_test "cksum of hello" "$F_TOOL" "$(printf 'hello\n')" "3287646509 6"
    run_expected_stdin_test "cksum empty" "$F_TOOL" "" "4294967295 0"
    run_expected_exit_test "exits 0" "printf \"test\" | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_cksum_functional_tests
