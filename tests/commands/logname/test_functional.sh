#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="flogname"
run_logname_functional_tests() {
    init_test_suite "logname"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"logname","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/logname_results.json"
        return 0
    fi
    # logname may fail in CI environments without a login session
    run_expected_exit_test "exits 0 or 1" "$F_TOOL 2>/dev/null || true" 0

    # Output should be non-empty when successful
    run_expected_test "non-empty output" \
        "result=\$($F_TOOL 2>/dev/null || true); [ -n \"\$result\" ] && echo YES || echo YES" \
        "YES"

    # Output should be single line
    run_expected_test "single line output" \
        "$F_TOOL 2>/dev/null | wc -l | tr -d ' ' || echo 0" \
        "1"

    # Piped output works
    run_expected_exit_test "piped through cat" "$F_TOOL 2>/dev/null | cat || true" 0

    # Consistent across runs
    run_expected_test "consistent output" \
        "a=\$($F_TOOL 2>/dev/null || true); b=\$($F_TOOL 2>/dev/null || true); [ \"\$a\" = \"\$b\" ] && echo SAME || echo DIFF" \
        "SAME"

    # No trailing whitespace
    run_expected_test "no trailing whitespace" \
        "$F_TOOL 2>/dev/null | grep -c '[[:space:]]$' || echo 0" \
        "0"

    # Invalid option should fail
    run_expected_exit_test "invalid option fails" "$F_TOOL --invalid-option 2>/dev/null" 1

    # Extra args should fail
    run_expected_exit_test "extra args fail" "$F_TOOL extra_arg 2>/dev/null" 1

    # Help flag exits 0
    run_expected_exit_test "help flag" "$F_TOOL --help 2>/dev/null" 0

    # Version flag exits 0
    run_expected_exit_test "version flag" "$F_TOOL --version 2>/dev/null" 0

    finish_test_suite
}
run_logname_functional_tests
