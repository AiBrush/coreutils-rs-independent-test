#!/usr/bin/env bash
# Compatibility tests for fuptime vs GNU uptime
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "uptime")
F_TOOL="fuptime"

run_uptime_tests() {
    init_test_suite "uptime"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"uptime","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/uptime_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU uptime not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    # uptime output changes every second, so we can only test format/exit codes
    run_test "exit code 0" \
        "$GNU_TOOL > /dev/null && echo 'EXIT_OK'" \
        "$F_TOOL > /dev/null && echo 'EXIT_OK'"

    run_test "produces output" \
        "$GNU_TOOL | wc -l" \
        "$F_TOOL | wc -l"

    echo ""
    echo "=== Pretty Print (-p) ==="

    if $GNU_TOOL -p >/dev/null 2>&1; then
        run_test "-p exit code" \
            "$GNU_TOOL -p > /dev/null && echo 'EXIT_OK'" \
            "$F_TOOL -p > /dev/null && echo 'EXIT_OK'"
    else
        skip_test "-p pretty print" "not supported on this platform"
    fi

    echo ""
    echo "=== Since (-s) ==="

    if $GNU_TOOL -s >/dev/null 2>&1; then
        run_test "-s since format" \
            "$GNU_TOOL -s" \
            "$F_TOOL -s"
    else
        skip_test "-s since" "not supported on this platform"
    fi

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "invalid option" \
        "$GNU_TOOL --invalid-option 2>&1" \
        "$F_TOOL --invalid-option 2>&1"

    run_exit_code_test "multiple invalid options" \
        "$GNU_TOOL --bad --worse 2>&1" \
        "$F_TOOL --bad --worse 2>&1"

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

    # Output should be single line (basic uptime)
    run_test "single line output" \
        "$GNU_TOOL | wc -l | tr -d ' '" \
        "$F_TOOL | wc -l | tr -d ' '"

    # Piped output works
    run_test "piped through cat" \
        "$GNU_TOOL > /dev/null | cat && echo PIPE_OK" \
        "$F_TOOL > /dev/null | cat && echo PIPE_OK"

    # Output is non-empty
    run_test "non-empty output" \
        "[ -n \"\$($GNU_TOOL)\" ] && echo YES || echo NO" \
        "[ -n \"\$($F_TOOL)\" ] && echo YES || echo NO"

    # No stderr on success
    run_test "stderr clean on success" \
        "$GNU_TOOL 2>/tmp/gnu_uptime_err_$$ >/dev/null; wc -c < /tmp/gnu_uptime_err_$$ | tr -d ' '; rm -f /tmp/gnu_uptime_err_$$" \
        "$F_TOOL 2>/tmp/f_uptime_err_$$ >/dev/null; wc -c < /tmp/f_uptime_err_$$ | tr -d ' '; rm -f /tmp/f_uptime_err_$$"

    echo ""
    echo "=== Pretty Print Format ==="

    if $GNU_TOOL -p >/dev/null 2>&1; then
        # -p output should start with "up"
        run_test "-p starts with up" \
            "$GNU_TOOL -p | head -c 2" \
            "$F_TOOL -p | head -c 2"

        # -p should produce single line
        run_test "-p single line" \
            "$GNU_TOOL -p | wc -l | tr -d ' '" \
            "$F_TOOL -p | wc -l | tr -d ' '"
    else
        skip_test "-p starts with up" "not supported on this platform"
        skip_test "-p single line" "not supported on this platform"
    fi

    echo ""
    echo "=== Since Format ==="

    if $GNU_TOOL -s >/dev/null 2>&1; then
        # -s should produce single line
        run_test "-s single line" \
            "$GNU_TOOL -s | wc -l | tr -d ' '" \
            "$F_TOOL -s | wc -l | tr -d ' '"

        # -s output contains a date (has dashes like 2024-01-01)
        run_test "-s contains date" \
            "$GNU_TOOL -s | grep -c '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}' | tr -d ' '" \
            "$F_TOOL -s | grep -c '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}' | tr -d ' '"
    else
        skip_test "-s single line" "not supported on this platform"
        skip_test "-s contains date" "not supported on this platform"
    fi

    finish_test_suite
}

run_uptime_tests
