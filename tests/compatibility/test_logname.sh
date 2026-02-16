#!/usr/bin/env bash
# Compatibility tests for flogname vs GNU logname
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="logname"
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

    finish_test_suite
}

run_logname_tests
