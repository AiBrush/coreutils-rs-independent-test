#!/usr/bin/env bash
# Compatibility tests for fstty vs GNU stty
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "stty")
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

    echo ""
    echo "=== GNU Upstream: Invalid Input Handling ==="

    # From stty-invalid.sh: reject invalid speed formats
    run_exit_code_test "gnu: invalid speed 9599.." \
        "$GNU_TOOL ispeed '9599..' 2>&1" \
        "$F_TOOL ispeed '9599..' 2>&1"

    run_exit_code_test "gnu: invalid speed 9600.." \
        "$GNU_TOOL ispeed '9600..' 2>&1" \
        "$F_TOOL ispeed '9600..' 2>&1"

    run_exit_code_test "gnu: invalid speed 9600.5." \
        "$GNU_TOOL ispeed '9600.5.' 2>&1" \
        "$F_TOOL ispeed '9600.5.' 2>&1"

    run_exit_code_test "gnu: invalid speed 0x2580" \
        "$GNU_TOOL ispeed '0x2580' 2>&1" \
        "$F_TOOL ispeed '0x2580' 2>&1"

    run_exit_code_test "gnu: invalid speed 96E2" \
        "$GNU_TOOL ispeed '96E2' 2>&1" \
        "$F_TOOL ispeed '96E2' 2>&1"

    run_exit_code_test "gnu: invalid speed 9600,0" \
        "$GNU_TOOL ispeed '9600,0' 2>&1" \
        "$F_TOOL ispeed '9600,0' 2>&1"

    run_exit_code_test "gnu: invalid speed ++9600" \
        "$GNU_TOOL ispeed '++9600' 2>&1" \
        "$F_TOOL ispeed '++9600' 2>&1"

    # From stty.sh: reject invalid option combinations
    run_exit_code_test "gnu: -F without argument" \
        "$GNU_TOOL -F 2>&1" \
        "$F_TOOL -F 2>&1"

    run_exit_code_test "gnu: -raw -F no/such/file" \
        "$GNU_TOOL -raw -F no/such/file 2>&1" \
        "$F_TOOL -raw -F no/such/file 2>&1"

    run_exit_code_test "gnu: -raw -a conflict" \
        "$GNU_TOOL -raw -a 2>&1" \
        "$F_TOOL -raw -a 2>&1"



    finish_test_suite
}

run_stty_tests
