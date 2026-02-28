#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ffold"
run_fold_functional_tests() {
    init_test_suite "fold"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"fold","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/fold_results.json"
        return 0
    fi
    run_expected_stdin_test "fold at 5" "$F_TOOL -w 5" "helloworld" "$(printf 'hello\nworld')"
    run_expected_stdin_test "fold at 3" "$F_TOOL -w 3" "abcdef" "$(printf 'abc\ndef')"
    run_expected_stdin_test "short line no fold" "$F_TOOL -w 80" "hello" "hello"
    run_expected_stdin_test "fold at spaces" "$F_TOOL -s -w 10" "hello beautiful world" "$(printf 'hello \nbeautiful \nworld')"
    run_expected_stdin_test "fold bytes" "$F_TOOL -b -w 5" "helloworld" "$(printf 'hello\nworld')"
    run_expected_exit_test "exits 0" "printf \"test\" | $F_TOOL" 0
    finish_test_suite
}
run_fold_functional_tests
