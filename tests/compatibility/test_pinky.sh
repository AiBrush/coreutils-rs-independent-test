#!/usr/bin/env bash
# Compatibility tests for fpinky vs GNU pinky
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="pinky"
F_TOOL="fpinky"

run_pinky_tests() {
    init_test_suite "pinky"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pinky","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/pinky_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU pinky not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: Basic Output ===
    echo ""
    echo "=== Basic Output ==="

    run_stdout_test "default (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    # === Section 2: Short Format ===
    echo ""
    echo "=== Short Format ==="

    run_stdout_test "-s short format" \
        "$GNU_TOOL -s" \
        "$F_TOOL -s"

    # === Section 3: Long Format ===
    echo ""
    echo "=== Long Format ==="

    local current_user
    current_user=$(whoami)

    run_stdout_test "-l long format for current user" \
        "$GNU_TOOL -l $current_user" \
        "$F_TOOL -l $current_user"

    # === Section 4: Specific Flags ===
    echo ""
    echo "=== Specific Flags ==="

    run_stdout_test "-f omit header in short format" \
        "$GNU_TOOL -f" \
        "$F_TOOL -f"

    run_stdout_test "-b omit home dir and shell in long format" \
        "$GNU_TOOL -b -l $current_user" \
        "$F_TOOL -b -l $current_user"

    run_stdout_test "-p omit project file in long format" \
        "$GNU_TOOL -p -l $current_user" \
        "$F_TOOL -p -l $current_user"

    run_stdout_test "-h omit plan file in long format" \
        "$GNU_TOOL -h -l $current_user" \
        "$F_TOOL -h -l $current_user"

    # === Section 5: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "--help exits successfully" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version exits successfully" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    finish_test_suite
}

run_pinky_tests
