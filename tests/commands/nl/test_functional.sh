#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fnl"
run_nl_functional_tests() {
    init_test_suite "nl"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nl","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/nl_results.json"
        return 0
    fi
    run_expected_stdin_test "number lines" "$F_TOOL" "$(printf 'a\nb\nc')" "$(printf '     1\ta\n     2\tb\n     3\tc')"
    run_expected_stdin_test "skip blanks default" "$F_TOOL" "$(printf 'a\n\nb')" "$(printf '     1\ta\n       \n     2\tb')"
    run_expected_stdin_test "number all lines" "$F_TOOL -ba" "$(printf 'a\n\nb')" "$(printf '     1\ta\n     2\t\n     3\tb')"
    run_expected_stdin_test "custom format ln" "$F_TOOL -n ln" "$(printf 'a\nb')" "$(printf '1     \ta\n2     \tb')"
    run_expected_stdin_test "right justify zero fill" "$F_TOOL -n rz" "$(printf 'a\nb')" "$(printf '000001\ta\n000002\tb')"
    run_expected_exit_test "exits 0" "printf 'hello' | $F_TOOL" 0
    finish_test_suite
}
run_nl_functional_tests
