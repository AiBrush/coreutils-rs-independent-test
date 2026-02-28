#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ffmt"
run_fmt_functional_tests() {
    init_test_suite "fmt"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"fmt","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/fmt_results.json"
        return 0
    fi
    run_expected_stdin_test "wrap at default width" "$F_TOOL" "hello world" "hello world"
    run_expected_stdin_test "short width" "$F_TOOL -w 10" "hello beautiful world out there" "hello\nbeautiful\nworld out\nthere"
    run_expected_exit_test "exits 0" "printf \"hello\" | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_fmt_functional_tests
