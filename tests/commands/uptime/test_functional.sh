#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fuptime"
run_uptime_functional_tests() {
    init_test_suite "uptime"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"uptime","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/uptime_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0

    # Output should be non-empty
    run_expected_test "non-empty output" \
        "[ -n \"\$($F_TOOL)\" ] && echo YES || echo NO" \
        "YES"

    # Single line output
    run_expected_test "single line output" \
        "$F_TOOL | wc -l | tr -d ' '" \
        "1"

    # Piped output works
    run_expected_exit_test "piped through cat" "$F_TOOL | cat" 0

    # No trailing whitespace
    run_expected_test "no trailing whitespace" \
        "$F_TOOL | grep -c '[[:space:]]$' || echo 0" \
        "0"

    # Invalid option should fail
    run_expected_exit_test "invalid option fails" "$F_TOOL --invalid-option 2>/dev/null" 1

    # Help flag exits 0
    run_expected_exit_test "help flag" "$F_TOOL --help 2>/dev/null" 0

    # Version flag exits 0
    run_expected_exit_test "version flag" "$F_TOOL --version 2>/dev/null" 0

    # -p flag (if supported)
    if $F_TOOL -p >/dev/null 2>&1; then
        run_expected_exit_test "-p exits 0" "$F_TOOL -p" 0

        # -p output starts with "up"
        run_expected_test "-p starts with up" \
            "$F_TOOL -p | head -c 2" \
            "up"
    else
        skip_test "-p flag" "not supported"
        skip_test "-p starts with up" "not supported"
    fi

    # -s flag (if supported)
    if $F_TOOL -s >/dev/null 2>&1; then
        run_expected_exit_test "-s exits 0" "$F_TOOL -s" 0

        # -s output contains a date pattern
        run_expected_test "-s contains date" \
            "$F_TOOL -s | grep -c '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}' | tr -d ' '" \
            "1"
    else
        skip_test "-s flag" "not supported"
        skip_test "-s contains date" "not supported"
    fi

    finish_test_suite
}
run_uptime_functional_tests
