#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fbase32"
run_base32_functional_tests() {
    init_test_suite "base32"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"base32","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/base32_results.json"
        return 0
    fi
    run_expected_stdin_test "encode hello" "$F_TOOL" "Hello" "JBSWY3DP"
    run_expected_stdin_test "encode empty" "$F_TOOL" "" ""
    run_expected_stdin_test "decode hello" "$F_TOOL -d" "JBSWY3DP" "Hello"
    run_expected_stdin_test "encode abc" "$F_TOOL" "abc" "MFRGG==="
    run_expected_stdin_test "decode abc" "$F_TOOL -d" "MFRGG===" "abc"
    run_expected_exit_test "exits 0" "printf \"test\" | $F_TOOL" 0
    run_expected_exit_test "decode invalid fails" "printf \"!!!\" | $F_TOOL -d 2>/dev/null" 1
    finish_test_suite
}
run_base32_functional_tests
