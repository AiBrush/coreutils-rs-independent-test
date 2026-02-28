#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fbase64"
run_base64_functional_tests() {
    init_test_suite "base64"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"base64","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/base64_results.json"
        return 0
    fi
    run_expected_stdin_test "encode Hello" "$F_TOOL" "Hello" "SGVsbG8="
    run_expected_stdin_test "encode empty" "$F_TOOL" "" ""
    run_expected_stdin_test "decode Hello" "$F_TOOL -d" "SGVsbG8=" "Hello"
    run_expected_stdin_test "encode a" "$F_TOOL" "a" "YQ=="
    run_expected_stdin_test "encode ab" "$F_TOOL" "ab" "YWI="
    run_expected_stdin_test "encode abc" "$F_TOOL" "abc" "YWJj"
    run_expected_stdin_test "decode no padding" "$F_TOOL -d" "YWJj" "abc"
    run_expected_stdin_test "decode one pad" "$F_TOOL -d" "YWI=" "ab"
    run_expected_stdin_test "decode two pad" "$F_TOOL -d" "YQ==" "a"
    run_expected_exit_test "exits 0 on valid input" "printf \"test\" | $F_TOOL" 0
    run_expected_exit_test "decode invalid fails" "printf \"!!!invalid!!!\" | $F_TOOL -d 2>/dev/null" 1
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_base64_functional_tests
