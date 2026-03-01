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

    echo ""
    echo "=== Save/Restore (-g) ==="

    if test -t 0; then
        # Save settings with -g and verify both produce output
        local gnu_saved f_saved
        gnu_saved=$($GNU_TOOL -g 2>/dev/null || echo "")
        f_saved=$($F_TOOL -g 2>/dev/null || echo "")

        TESTS_RUN=$((TESTS_RUN + 1))
        if [[ -n "$gnu_saved" ]] && [[ -n "$f_saved" ]]; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "  ${GREEN}PASS${NC}: stty -g produces save string"
            record_result "stty save restore" "PASS" "" "" ""
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: stty -g save string"
            record_result "stty save restore" "FAIL" "gnu='$gnu_saved' f='$f_saved'" "" ""
        fi
    else
        skip_test "stty save restore" "not a tty"
    fi

    echo ""
    echo "=== Speed ==="

    if test -t 0; then
        run_stdout_test "stty speed" \
            "$GNU_TOOL speed" \
            "$F_TOOL speed"
    else
        run_exit_code_test "stty speed without tty (error)" \
            "$GNU_TOOL speed 2>&1" \
            "$F_TOOL speed 2>&1"
    fi

    echo ""
    echo "=== Echo/No-Echo ==="

    if test -t 0; then
        # Test setting echo mode (save/restore around it)
        local saved_settings
        saved_settings=$($GNU_TOOL -g 2>/dev/null || echo "")

        run_exit_code_test "stty echo" \
            "$GNU_TOOL echo 2>&1" \
            "$F_TOOL echo 2>&1"

        run_exit_code_test "stty -echo" \
            "$GNU_TOOL -echo 2>&1" \
            "$F_TOOL -echo 2>&1"

        # Restore saved settings
        if [[ -n "$saved_settings" ]]; then
            $GNU_TOOL "$saved_settings" 2>/dev/null || true
        fi
    else
        skip_test "stty echo" "not a tty"
        skip_test "stty -echo" "not a tty"
    fi

    echo ""
    echo "=== Raw/Cooked ==="

    if test -t 0; then
        local saved_raw
        saved_raw=$($GNU_TOOL -g 2>/dev/null || echo "")

        run_exit_code_test "stty raw exit code" \
            "$GNU_TOOL raw 2>&1" \
            "$F_TOOL raw 2>&1"

        # Restore before testing cooked
        if [[ -n "$saved_raw" ]]; then
            $GNU_TOOL "$saved_raw" 2>/dev/null || true
        fi

        run_exit_code_test "stty cooked exit code" \
            "$GNU_TOOL cooked 2>&1" \
            "$F_TOOL cooked 2>&1"

        if [[ -n "$saved_raw" ]]; then
            $GNU_TOOL "$saved_raw" 2>/dev/null || true
        fi
    else
        skip_test "stty raw" "not a tty"
        skip_test "stty cooked" "not a tty"
    fi

    echo ""
    echo "=== Sane ==="

    if test -t 0; then
        run_exit_code_test "stty sane exit code" \
            "$GNU_TOOL sane 2>&1" \
            "$F_TOOL sane 2>&1"
    else
        skip_test "stty sane" "not a tty"
    fi

    echo ""
    echo "=== Special Characters ==="

    if test -t 0; then
        # Test reading eof char
        run_stdout_test "stty -a shows eof" \
            "$GNU_TOOL -a | grep -o 'eof'" \
            "$F_TOOL -a | grep -o 'eof'"

        # Test reading erase char
        run_stdout_test "stty -a shows erase" \
            "$GNU_TOOL -a | grep -o 'erase'" \
            "$F_TOOL -a | grep -o 'erase'"

        # Test reading kill char
        run_stdout_test "stty -a shows kill" \
            "$GNU_TOOL -a | grep -o 'kill'" \
            "$F_TOOL -a | grep -o 'kill'"

        # Test reading intr char
        run_stdout_test "stty -a shows intr" \
            "$GNU_TOOL -a | grep -o 'intr'" \
            "$F_TOOL -a | grep -o 'intr'"
    else
        skip_test "stty eof" "not a tty"
        skip_test "stty erase" "not a tty"
        skip_test "stty kill" "not a tty"
        skip_test "stty intr" "not a tty"
    fi

    echo ""
    echo "=== Rows and Columns ==="

    if test -t 0; then
        run_stdout_test "stty rows" \
            "$GNU_TOOL -a | grep -o 'rows [0-9]*'" \
            "$F_TOOL -a | grep -o 'rows [0-9]*'"

        run_stdout_test "stty columns" \
            "$GNU_TOOL -a | grep -o 'columns [0-9]*'" \
            "$F_TOOL -a | grep -o 'columns [0-9]*'"
    else
        skip_test "stty rows" "not a tty"
        skip_test "stty columns" "not a tty"
    fi

    echo ""
    echo "=== Invalid Option ==="

    run_exit_code_test "stty --invalid-option" \
        "$GNU_TOOL --invalid-option-xyz 2>&1" \
        "$F_TOOL --invalid-option-xyz 2>&1"

    run_exit_code_test "stty invalid setting name" \
        "$GNU_TOOL nosuchsetting_xyz 2>&1" \
        "$F_TOOL nosuchsetting_xyz 2>&1"

    echo ""
    echo "=== Help and Version ==="

    run_exit_code_test "stty --help exits 0" \
        "$GNU_TOOL --help >/dev/null 2>&1" \
        "$F_TOOL --help >/dev/null 2>&1"

    run_exit_code_test "stty --version exits 0" \
        "$GNU_TOOL --version >/dev/null 2>&1" \
        "$F_TOOL --version >/dev/null 2>&1"

    # Both should produce non-empty --help output
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_help f_help
    gnu_help=$($GNU_TOOL --help 2>&1 || true)
    f_help=$($F_TOOL --help 2>&1 || true)
    if [[ -n "$gnu_help" ]] && [[ -n "$f_help" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: stty --help produces output"
        record_result "stty --help produces output" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: stty --help produces output"
        record_result "stty --help produces output" "FAIL" "missing output" "" ""
    fi

    # Both should produce non-empty --version output
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_ver f_ver
    gnu_ver=$($GNU_TOOL --version 2>&1 || true)
    f_ver=$($F_TOOL --version 2>&1 || true)
    if [[ -n "$gnu_ver" ]] && [[ -n "$f_ver" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: stty --version produces output"
        record_result "stty --version produces output" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: stty --version produces output"
        record_result "stty --version produces output" "FAIL" "missing output" "" ""
    fi

    echo ""
    echo "=== Device File Options ==="

    run_exit_code_test "stty -F /dev/null" \
        "$GNU_TOOL -F /dev/null 2>&1" \
        "$F_TOOL -F /dev/null 2>&1"

    run_exit_code_test "stty -F nonexistent device" \
        "$GNU_TOOL -F /no/such/device 2>&1" \
        "$F_TOOL -F /no/such/device 2>&1"

    run_exit_code_test "stty --file=/dev/null" \
        "$GNU_TOOL --file=/dev/null 2>&1" \
        "$F_TOOL --file=/dev/null 2>&1"

    echo ""
    echo "=== Long-Form Options ==="

    if test -t 0; then
        run_stdout_test "stty --all (long form of -a)" \
            "$GNU_TOOL --all" \
            "$F_TOOL --all"

        run_stdout_test "stty --save (long form of -g)" \
            "$GNU_TOOL --save" \
            "$F_TOOL --save"
    else
        skip_test "stty --all" "not a tty"
        skip_test "stty --save" "not a tty"
    fi

    echo ""
    echo "=== Conflicting Options ==="

    run_exit_code_test "stty -a -g conflict" \
        "$GNU_TOOL -a -g 2>&1" \
        "$F_TOOL -a -g 2>&1"

    run_exit_code_test "stty -g -a conflict" \
        "$GNU_TOOL -g -a 2>&1" \
        "$F_TOOL -g -a 2>&1"

    run_exit_code_test "stty size -a conflict" \
        "$GNU_TOOL size -a 2>&1" \
        "$F_TOOL size -a 2>&1"

    finish_test_suite
}

run_stty_tests
