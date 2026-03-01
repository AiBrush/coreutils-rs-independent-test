#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fwhoami"
run_whoami_functional_tests() {
    init_test_suite "whoami"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"whoami","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/whoami_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0

    # Output should match the current user
    run_expected_test "matches whoami" "$F_TOOL" "$(whoami)"

    # Output should match id -un
    run_expected_test "matches id -un" "$F_TOOL" "$(id -un)"

    # Single line output
    run_expected_test "single line output" \
        "$F_TOOL | wc -l | tr -d ' '" \
        "1"

    # Piped output works
    run_expected_test "piped through cat" \
        "$F_TOOL | cat" \
        "$(whoami)"

    # Output is non-empty
    run_expected_test "non-empty output" \
        "[ -n \"\$($F_TOOL)\" ] && echo YES || echo NO" \
        "YES"

    # No trailing whitespace
    run_expected_test "no trailing whitespace" \
        "$F_TOOL | grep -c '[[:space:]]$' || echo 0" \
        "0"

    # Consistent across runs
    run_expected_test "consistent output" \
        "a=\$($F_TOOL); b=\$($F_TOOL); [ \"\$a\" = \"\$b\" ] && echo SAME || echo DIFF" \
        "SAME"

    # No stderr on success
    run_expected_test "stderr clean" \
        "$F_TOOL 2>/tmp/fwhoami_err_$$ >/dev/null; wc -c < /tmp/fwhoami_err_$$ | tr -d ' '; rm -f /tmp/fwhoami_err_$$" \
        "0"

    # Extra args should fail
    run_expected_exit_test "extra args fail" "$F_TOOL extra_arg 2>/dev/null" 1

    # Invalid option should fail
    run_expected_exit_test "invalid option fails" "$F_TOOL --invalid-option 2>/dev/null" 1

    # Help flag exits 0
    run_expected_exit_test "help flag" "$F_TOOL --help 2>/dev/null" 0

    # Version flag exits 0
    run_expected_exit_test "version flag" "$F_TOOL --version 2>/dev/null" 0

    finish_test_suite
}
run_whoami_functional_tests
