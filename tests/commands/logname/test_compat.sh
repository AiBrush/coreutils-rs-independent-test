#!/usr/bin/env bash
# Compatibility tests for flogname vs GNU logname
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "logname")
F_TOOL="flogname"

run_logname_tests() {
    init_test_suite "logname"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"logname","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/logname_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU logname not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    # logname may fail in CI environments without a login session
    run_exit_code_test "logname exit code match" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # Compare stdout when both succeed
    run_stdout_test "logname output" \
        "$GNU_TOOL 2>/dev/null || true" \
        "$F_TOOL 2>/dev/null || true"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "extra arguments" \
        "$GNU_TOOL extra_arg 2>&1" \
        "$F_TOOL extra_arg 2>&1"

    run_exit_code_test "multiple extra args" \
        "$GNU_TOOL arg1 arg2 2>&1" \
        "$F_TOOL arg1 arg2 2>&1"

    run_exit_code_test "invalid option" \
        "$GNU_TOOL --invalid-option 2>&1" \
        "$F_TOOL --invalid-option 2>&1"

    echo ""
    echo "=== Options ==="

    run_exit_code_test "version flag" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    run_exit_code_test "help flag" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    echo ""
    echo "=== Output Format ==="

    # Output should have no trailing spaces
    run_test "no trailing spaces" \
        "$GNU_TOOL 2>/dev/null | sed 's/[[:space:]]*$//' || true" \
        "$F_TOOL 2>/dev/null | sed 's/[[:space:]]*$//' || true"

    # Output should be single line
    run_test "single line output" \
        "$GNU_TOOL 2>/dev/null | wc -l | tr -d ' ' || echo 0" \
        "$F_TOOL 2>/dev/null | wc -l | tr -d ' ' || echo 0"

    # Piped output should be same
    run_stdout_test "piped through cat" \
        "$GNU_TOOL 2>/dev/null | cat || true" \
        "$F_TOOL 2>/dev/null | cat || true"

    # Consistent results across runs
    run_test "consistent output" \
        "out1=\$($GNU_TOOL 2>/dev/null || true); out2=\$($GNU_TOOL 2>/dev/null || true); [ \"\$out1\" = \"\$out2\" ] && echo CONSISTENT || echo INCONSISTENT" \
        "out1=\$($F_TOOL 2>/dev/null || true); out2=\$($F_TOOL 2>/dev/null || true); [ \"\$out1\" = \"\$out2\" ] && echo CONSISTENT || echo INCONSISTENT"

    # No stderr on success
    run_test "stderr clean on success" \
        "$GNU_TOOL 2>/tmp/gnu_logname_err_$$ >/dev/null || true; cat /tmp/gnu_logname_err_$$; rm -f /tmp/gnu_logname_err_$$" \
        "$F_TOOL 2>/tmp/f_logname_err_$$ >/dev/null || true; cat /tmp/f_logname_err_$$; rm -f /tmp/f_logname_err_$$"

    # Output non-empty when successful
    run_test "non-empty output" \
        "$GNU_TOOL 2>/dev/null | wc -c | tr -d ' ' || echo 0" \
        "$F_TOOL 2>/dev/null | wc -c | tr -d ' ' || echo 0"

    finish_test_suite
}

run_logname_tests
