#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fprintf"
run_printf_functional_tests() {
    init_test_suite "printf"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"printf","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/printf_results.json"
        return 0
    fi
    run_expected_test "simple string" "$F_TOOL 'hello\n'" "$(printf 'hello')"
    run_expected_test "format string" "$F_TOOL '%s %s\n' hello world" "$(printf 'hello world')"
    run_expected_test "integer format" "$F_TOOL '%d\n' 42" "42"
    run_expected_test "hex format" "$F_TOOL '%x\n' 255" "ff"
    run_expected_test "octal format" "$F_TOOL '%o\n' 8" "10"
    run_expected_exit_test "exits 0" "$F_TOOL hello" 0
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_printf_functional_tests
