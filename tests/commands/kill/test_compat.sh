#!/usr/bin/env bash
# Compatibility tests for fkill vs GNU kill
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "kill")
F_TOOL="fkill"

run_kill_tests() {
    init_test_suite "kill"

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"kill","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/kill_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU kill not found, cannot compare" >&2
        return 1
    fi

    # === GNU Upstream: Parameter Validation ===
    echo ""
    echo "=== GNU Upstream: Parameter Validation ==="

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "-TERM without pid" \
        "$GNU_TOOL -TERM 2>&1" \
        "$F_TOOL -TERM 2>&1"

    # === GNU Upstream: Invalid Option Combinations ===
    echo ""
    echo "=== GNU Upstream: Invalid Option Combinations ==="

    run_exit_code_test "-l -l duplicate" \
        "$GNU_TOOL -l -l 2>&1" \
        "$F_TOOL -l -l 2>&1"

    run_exit_code_test "-l -t conflict" \
        "$GNU_TOOL -l -t 2>&1" \
        "$F_TOOL -l -t 2>&1"

    run_exit_code_test "-l -s 1 conflict" \
        "$GNU_TOOL -l -s 1 2>&1" \
        "$F_TOOL -l -s 1 2>&1"

    run_exit_code_test "-t -s 1 conflict" \
        "$GNU_TOOL -t -s 1 2>&1" \
        "$F_TOOL -t -s 1 2>&1"

    # === GNU Upstream: Signal Sending ===
    echo ""
    echo "=== GNU Upstream: Signal Sending ==="

    run_exit_code_test "-0 invalid pid" \
        "$GNU_TOOL -0 no_pid 2>&1" \
        "$F_TOOL -0 no_pid 2>&1"

    run_exit_code_test "-0 to own process" \
        "$GNU_TOOL -0 $$ 2>&1" \
        "$F_TOOL -0 $$ 2>&1"

    run_exit_code_test "-s0 to own process" \
        "$GNU_TOOL -s0 $$ 2>&1" \
        "$F_TOOL -s0 $$ 2>&1"

    run_exit_code_test "-CONT to own process" \
        "$GNU_TOOL -CONT $$ 2>&1" \
        "$F_TOOL -CONT $$ 2>&1"

    run_exit_code_test "-Cont to own process (mixed case)" \
        "$GNU_TOOL -Cont $$ 2>&1" \
        "$F_TOOL -Cont $$ 2>&1"

    run_exit_code_test "-cont lowercase rejected" \
        "$GNU_TOOL -cont $$ 2>&1" \
        "$F_TOOL -cont $$ 2>&1"

    # === GNU Upstream: Signal Table Listing ===
    echo ""
    echo "=== GNU Upstream: Signal Table Listing ==="

    run_exit_code_test "-l lists signals" \
        "$GNU_TOOL -l 2>&1" \
        "$F_TOOL -l 2>&1"

    run_exit_code_test "-t lists signals with numbers" \
        "$GNU_TOOL -t 2>&1" \
        "$F_TOOL -t 2>&1"

    run_exit_code_test "-t TERM HUP" \
        "$GNU_TOOL -t TERM HUP 2>&1" \
        "$F_TOOL -t TERM HUP 2>&1"

    # === GNU Upstream: Signal Name/Number Conversion ===
    echo ""
    echo "=== GNU Upstream: Signal Name/Number Conversion ==="

    run_stdout_test "-l TERM shows signal number" \
        "$GNU_TOOL -l TERM" \
        "$F_TOOL -l TERM"

    run_stdout_test "-l HUP shows signal number" \
        "$GNU_TOOL -l HUP" \
        "$F_TOOL -l HUP"

    # === GNU Upstream: Invalid Signal Specs ===
    echo ""
    echo "=== GNU Upstream: Invalid Signal Specs ==="

    run_exit_code_test "-l -1 invalid signal" \
        "$GNU_TOOL -l -- -1 2>&1" \
        "$F_TOOL -l -- -1 2>&1"

    run_exit_code_test "-l INVALID signal name" \
        "$GNU_TOOL -l INVALID 2>&1" \
        "$F_TOOL -l INVALID 2>&1"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent pid" \
        "$GNU_TOOL -0 99999999 2>&1" \
        "$F_TOOL -0 99999999 2>&1"


    finish_test_suite
}

run_kill_tests
