#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fsort"
run_sort_functional_tests() {
    init_test_suite "sort"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sort","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sort_results.json"
        return 0
    fi
    run_expected_stdin_test "basic sort" "$F_TOOL" "$(printf 'banana\napple\ncherry')" "$(printf 'apple\nbanana\ncherry')"
    run_expected_stdin_test "reverse sort" "$F_TOOL -r" "$(printf 'banana\napple\ncherry')" "$(printf 'cherry\nbanana\napple')"
    run_expected_stdin_test "numeric sort" "$F_TOOL -n" "$(printf '10\n2\n1\n20')" "$(printf '1\n2\n10\n20')"
    run_expected_stdin_test "numeric reverse" "$F_TOOL -nr" "$(printf '10\n2\n1\n20')" "$(printf '20\n10\n2\n1')"
    run_expected_stdin_test "unique" "$F_TOOL -u" "$(printf 'a\na\nb\nb\nc')" "$(printf 'a\nb\nc')"
    run_expected_stdin_test "case insensitive" "$F_TOOL -f" "$(printf 'Banana\napple\nCherry')" "$(printf 'apple\nBanana\nCherry')"
    run_expected_stdin_test "already sorted" "$F_TOOL" "$(printf 'a\nb\nc')" "$(printf 'a\nb\nc')"
    run_expected_stdin_test "single line" "$F_TOOL" "hello" "hello"
    run_expected_stdin_test "empty input" "$F_TOOL" "" ""
    run_expected_stdin_test "duplicates" "$F_TOOL" "$(printf 'a\na\nb\nb\na\na')" "$(printf 'a\na\na\na\nb\nb')"
    run_expected_stdin_test "numeric with negatives" "$F_TOOL -n" "$(printf '10\n-5\n0\n-100\n50')" "$(printf -- '-100\n-5\n0\n10\n50')"
    run_expected_stdin_test "key field 2" "$F_TOOL -t, -k2" "$(printf 'b,1\na,2\nc,1')" "$(printf 'b,1\nc,1\na,2')"
    run_expected_stdin_test "month sort" "LC_ALL=C $F_TOOL -M" "$(printf 'MAR\nJAN\nFEB')" "$(printf 'JAN\nFEB\nMAR')"
    run_expected_stdin_test "check sorted ok" "$F_TOOL -c" "$(printf 'a\nb\nc')" ""
    run_expected_exit_test "check sorted exits 0" "printf 'a\nb\nc\n' | $F_TOOL -c" 0
    run_expected_exit_test "check unsorted exits 1" "printf 'b\na\n' | $F_TOOL -c 2>/dev/null" 1
    run_expected_exit_test "exits 0" "printf 'hello' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 2
    finish_test_suite
}
run_sort_functional_tests
