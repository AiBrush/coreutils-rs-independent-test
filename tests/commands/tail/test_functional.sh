#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftail"
run_tail_functional_tests() {
    init_test_suite "tail"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tail","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tail_results.json"
        return 0
    fi
    run_expected_stdin_test "default last 10" "$F_TOOL" "$(printf '1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12')" "$(printf '3\n4\n5\n6\n7\n8\n9\n10\n11\n12')"
    run_expected_stdin_test "last 3 lines" "$F_TOOL -n 3" "$(printf 'a\nb\nc\nd\ne')" "$(printf 'c\nd\ne')"
    run_expected_stdin_test "last 1 line" "$F_TOOL -n 1" "$(printf 'hello\nworld')" "world"
    run_expected_stdin_test "last 5 bytes" "$F_TOOL -c 5" "helloworld" "world"
    run_expected_stdin_test "empty input" "$F_TOOL" "" ""
    run_expected_stdin_test "fewer lines than n" "$F_TOOL -n 100" "$(printf 'a\nb')" "$(printf 'a\nb')"
    run_expected_stdin_test "from line 3 onward" "$F_TOOL -n +3" "$(printf 'a\nb\nc\nd\ne')" "$(printf 'c\nd\ne')"
    run_expected_exit_test "exits 0" "printf 'hello' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_tail_functional_tests
