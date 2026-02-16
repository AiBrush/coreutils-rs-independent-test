#!/usr/bin/env bash
# Compatibility tests for ftty vs GNU tty
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tty"
F_TOOL="ftty"

run_tty_tests() {
    init_test_suite "tty"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tty","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tty_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU tty not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    # In CI, stdin is not a terminal, so both should say "not a tty"
    run_test "default (not a tty in pipe)" \
        "echo '' | $GNU_TOOL 2>&1 || true" \
        "echo '' | $F_TOOL 2>&1 || true"

    run_exit_code_test "exit code when not a tty" \
        "echo '' | $GNU_TOOL 2>&1" \
        "echo '' | $F_TOOL 2>&1"

    echo ""
    echo "=== Silent Mode (-s) ==="

    run_test "-s silent (no output)" \
        "echo '' | $GNU_TOOL -s 2>&1; echo \$?" \
        "echo '' | $F_TOOL -s 2>&1; echo \$?"

    run_test "--silent" \
        "echo '' | $GNU_TOOL --silent 2>&1; echo \$?" \
        "echo '' | $F_TOOL --silent 2>&1; echo \$?"

    run_test "--quiet" \
        "echo '' | $GNU_TOOL --quiet 2>&1; echo \$?" \
        "echo '' | $F_TOOL --quiet 2>&1; echo \$?"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "invalid option" \
        "$GNU_TOOL --invalid-option 2>&1" \
        "$F_TOOL --invalid-option 2>&1"

    finish_test_suite
}

run_tty_tests
