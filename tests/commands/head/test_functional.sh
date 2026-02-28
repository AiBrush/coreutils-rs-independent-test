#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fhead"
run_head_functional_tests() {
    init_test_suite "head"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"head","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/head_results.json"
        return 0
    fi
    run_expected_stdin_test "default 10 lines" "$F_TOOL" "$(printf '1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12')" "$(printf '1\n2\n3\n4\n5\n6\n7\n8\n9\n10')"
    run_expected_stdin_test "first 3 lines" "$F_TOOL -n 3" "$(printf 'a\nb\nc\nd\ne')" "$(printf 'a\nb\nc')"
    run_expected_stdin_test "first 1 line" "$F_TOOL -n 1" "$(printf 'hello\nworld')" "hello"
    run_expected_stdin_test "first 5 bytes" "$F_TOOL -c 5" "helloworld" "hello"
    run_expected_stdin_test "empty input" "$F_TOOL" "" ""
    run_expected_stdin_test "fewer lines than n" "$F_TOOL -n 100" "$(printf 'a\nb')" "$(printf 'a\nb')"
    run_expected_exit_test "exits 0" "printf \"hello\" | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_head_functional_tests
