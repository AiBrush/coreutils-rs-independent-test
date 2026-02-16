#!/usr/bin/env bash
# Compatibility tests for fuptime vs GNU uptime
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="uptime"
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

    finish_test_suite
}

run_uptime_tests
