#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fwc"
run_wc_functional_tests() {
    init_test_suite "wc"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"wc","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/wc_results.json"
        return 0
    fi
    run_expected_stdin_test "count lines" "$F_TOOL -l" "$(printf 'a\nb\nc\n')" "3"
    run_expected_stdin_test "count words" "$F_TOOL -w" "hello world foo" "3"
    run_expected_stdin_test "count bytes" "$F_TOOL -c" "hello" "5"
    run_expected_stdin_test "lines no trailing nl" "$F_TOOL -l" "$(printf 'a\nb\nc')" "2"
    run_expected_stdin_test "words multi spaces" "$F_TOOL -w" "hello    world    test" "3"
    run_expected_stdin_test "empty input lines" "$F_TOOL -l" "" "0"
    run_expected_stdin_test "empty input words" "$F_TOOL -w" "" "0"
    run_expected_stdin_test "empty input bytes" "$F_TOOL -c" "" "0"
    run_expected_stdin_test "single word" "$F_TOOL -w" "hello" "1"
    run_expected_stdin_test "single newline line count" "$F_TOOL -l" "$(printf '\n')" "1"
    run_expected_stdin_test "default output" "$F_TOOL" "$(printf 'hello world\n')" "      1       2      12"
    run_expected_stdin_test "max line length" "$F_TOOL -L" "$(printf 'short\nmediumtext\nhi')" "10"
    run_expected_exit_test "exits 0" "printf 'hello' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_wc_functional_tests
