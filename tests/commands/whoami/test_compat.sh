#!/usr/bin/env bash
# Compatibility tests for fwhoami vs GNU whoami
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "whoami")
F_TOOL="fwhoami"

run_whoami_tests() {
    init_test_suite "whoami"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"whoami","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/whoami_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU whoami not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    run_test "current user" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "matches id -un" \
        "$GNU_TOOL && id -un" \
        "$F_TOOL && id -un"

    echo ""
    echo "=== Exit Code ==="

    run_test "exit code 0" \
        "$GNU_TOOL > /dev/null && echo 'EXIT_OK'" \
        "$F_TOOL > /dev/null && echo 'EXIT_OK'"

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

    # Piped output should be the same
    run_test "piped through cat" \
        "$GNU_TOOL | cat" \
        "$F_TOOL | cat"

    # Output should be single line
    run_test "single line output" \
        "$GNU_TOOL | wc -l | tr -d ' '" \
        "$F_TOOL | wc -l | tr -d ' '"

    # Output should match id -un
    run_test "matches id -un" \
        "$GNU_TOOL" \
        "id -un"

    # No trailing spaces
    run_test "no trailing spaces" \
        "$GNU_TOOL | sed 's/[[:space:]]*$//' " \
        "$F_TOOL | sed 's/[[:space:]]*$//' "

    # No stderr on success
    run_test "stderr clean on success" \
        "$GNU_TOOL 2>/tmp/gnu_whoami_err_$$ >/dev/null; cat /tmp/gnu_whoami_err_$$; rm -f /tmp/gnu_whoami_err_$$" \
        "$F_TOOL 2>/tmp/f_whoami_err_$$ >/dev/null; cat /tmp/f_whoami_err_$$; rm -f /tmp/f_whoami_err_$$"

    # Consistent results across runs
    run_test "consistent output" \
        "out1=\$($GNU_TOOL); out2=\$($GNU_TOOL); [ \"\$out1\" = \"\$out2\" ] && echo CONSISTENT || echo INCONSISTENT" \
        "out1=\$($F_TOOL); out2=\$($F_TOOL); [ \"\$out1\" = \"\$out2\" ] && echo CONSISTENT || echo INCONSISTENT"

    # Output non-empty
    run_test "non-empty output" \
        "$GNU_TOOL | wc -c | tr -d ' '" \
        "$F_TOOL | wc -c | tr -d ' '"

    # Output ends with newline
    run_test "ends with newline" \
        "$GNU_TOOL | xxd | tail -1 | grep -c '0a' | tr -d ' ' || echo 0" \
        "$F_TOOL | xxd | tail -1 | grep -c '0a' | tr -d ' ' || echo 0"

    finish_test_suite
}

run_whoami_tests
