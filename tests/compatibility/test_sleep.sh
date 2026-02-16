#!/usr/bin/env bash
# Compatibility tests for fsleep vs GNU sleep
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sleep"
F_TOOL="fsleep"

run_sleep_tests() {
    init_test_suite "sleep"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sleep","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sleep_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU sleep not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Sleep ==="

    run_test "sleep 0 (instant)" \
        "$GNU_TOOL 0 && echo 'OK'" \
        "$F_TOOL 0 && echo 'OK'"

    run_test "sleep 0.01 (fractional)" \
        "$GNU_TOOL 0.01 && echo 'OK'" \
        "$F_TOOL 0.01 && echo 'OK'"

    run_test "exit code 0" \
        "$GNU_TOOL 0; echo \$?" \
        "$F_TOOL 0; echo \$?"

    echo ""
    echo "=== Duration Suffixes ==="

    run_test "suffix s (seconds)" \
        "$GNU_TOOL 0s && echo 'OK'" \
        "$F_TOOL 0s && echo 'OK'"

    run_test "suffix 0.01s" \
        "$GNU_TOOL 0.01s && echo 'OK'" \
        "$F_TOOL 0.01s && echo 'OK'"

    echo ""
    echo "=== Multiple Durations ==="

    run_test "multiple args (sum)" \
        "$GNU_TOOL 0 0 0 && echo 'OK'" \
        "$F_TOOL 0 0 0 && echo 'OK'"

    run_test "multiple small values" \
        "$GNU_TOOL 0.01 0.01 && echo 'OK'" \
        "$F_TOOL 0.01 0.01 && echo 'OK'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "invalid argument" \
        "$GNU_TOOL abc 2>&1" \
        "$F_TOOL abc 2>&1"

    run_exit_code_test "negative duration" \
        "$GNU_TOOL -- -1 2>&1" \
        "$F_TOOL -- -1 2>&1"

    finish_test_suite
}

run_sleep_tests
