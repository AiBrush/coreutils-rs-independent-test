#!/usr/bin/env bash
# Compatibility tests for fstty vs GNU stty
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="stty"
F_TOOL="fstty"

run_stty_tests() {
    init_test_suite "stty"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"stty","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/stty_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU stty not found, cannot compare" >&2
        return 1
    fi

    # stty needs a terminal. In CI, we skip most tests.
    echo ""
    echo "=== Terminal Requirement Check ==="

    if ! test -t 0; then
        echo "Not running in a terminal — skipping most stty tests"

        skip_test "stty -a (no terminal)" "not a tty"
        skip_test "stty size (no terminal)" "not a tty"
        skip_test "stty -g (no terminal)" "not a tty"

        # Test error behavior when not a tty — both should fail similarly
        run_exit_code_test "stty -a without tty (error)" \
            "$GNU_TOOL -a 2>&1" \
            "$F_TOOL -a 2>&1"

        run_exit_code_test "stty size without tty (error)" \
            "$GNU_TOOL size 2>&1" \
            "$F_TOOL size 2>&1"
    else
        echo ""
        echo "=== All Settings (-a) ==="

        run_stdout_test "stty -a" \
            "$GNU_TOOL -a" \
            "$F_TOOL -a"

        echo ""
        echo "=== Terminal Size ==="

        run_stdout_test "stty size" \
            "$GNU_TOOL size" \
            "$F_TOOL size"

        echo ""
        echo "=== Machine-Readable (-g) ==="

        run_stdout_test "stty -g" \
            "$GNU_TOOL -g" \
            "$F_TOOL -g"
    fi

    # === Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    finish_test_suite
}

run_stty_tests
