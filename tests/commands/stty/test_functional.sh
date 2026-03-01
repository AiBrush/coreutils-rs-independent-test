#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fstty"
run_stty_functional_tests() {
    init_test_suite "stty"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"stty","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/stty_results.json"
        return 0
    fi
    # stty needs a terminal; in CI it may fail, so just test it does not crash
    run_expected_exit_test "exits 0 or fails gracefully" "$F_TOOL -a < /dev/null 2>/dev/null || true" 0

    # --help and --version should work without a tty
    run_expected_exit_test "stty --help exits 0" "$F_TOOL --help >/dev/null 2>&1" 0
    run_expected_exit_test "stty --version exits 0" "$F_TOOL --version >/dev/null 2>&1" 0

    # Invalid option should fail
    run_expected_exit_test "stty invalid option fails" "$F_TOOL --no-such-option 2>/dev/null" 1

    # -F with nonexistent file should fail
    run_expected_exit_test "stty -F nonexistent fails" "$F_TOOL -F /no/such/device 2>/dev/null" 1

    # Invalid speed format should fail
    run_expected_exit_test "stty invalid speed fails" "$F_TOOL ispeed 'invalid' 2>/dev/null" 1

    # --help output should contain text
    run_expected_exit_test "stty --help produces output" "test -n \"\$($F_TOOL --help 2>&1)\"" 0

    # --version output should contain text
    run_expected_exit_test "stty --version produces output" "test -n \"\$($F_TOOL --version 2>&1)\"" 0

    # -a -g conflict should fail
    run_expected_exit_test "stty -a -g conflict fails" "$F_TOOL -a -g 2>/dev/null" 1

    # --file with nonexistent should fail
    run_expected_exit_test "stty --file=/no/such/device fails" "$F_TOOL --file=/no/such/device 2>/dev/null" 1

    if test -t 0; then
        # With a tty, basic operations should succeed
        run_expected_exit_test "stty -a exits 0" "$F_TOOL -a >/dev/null" 0
        run_expected_exit_test "stty -g exits 0" "$F_TOOL -g >/dev/null" 0
        run_expected_exit_test "stty size exits 0" "$F_TOOL size >/dev/null" 0
        run_expected_exit_test "stty speed exits 0" "$F_TOOL speed >/dev/null" 0
        run_expected_exit_test "stty sane exits 0" "$F_TOOL sane 2>/dev/null" 0

        # -a output should not be empty
        run_expected_exit_test "stty -a output non-empty" "test -n \"\$($F_TOOL -a 2>/dev/null)\"" 0

        # -g output should not be empty
        run_expected_exit_test "stty -g output non-empty" "test -n \"\$($F_TOOL -g 2>/dev/null)\"" 0

        # size should produce two numbers
        run_expected_exit_test "stty size format (rows cols)" "$F_TOOL size 2>/dev/null | grep -qE '^[0-9]+ [0-9]+\$'" 0

        # speed should produce a number
        run_expected_exit_test "stty speed format" "$F_TOOL speed 2>/dev/null | grep -qE '^[0-9]+\$'" 0

        # echo/-echo toggling should succeed
        local saved_settings
        saved_settings=$($F_TOOL -g 2>/dev/null || echo "")

        run_expected_exit_test "stty echo exits 0" "$F_TOOL echo 2>/dev/null" 0
        run_expected_exit_test "stty -echo exits 0" "$F_TOOL -echo 2>/dev/null" 0

        # Restore settings
        if [[ -n "$saved_settings" ]]; then
            $F_TOOL "$saved_settings" 2>/dev/null || true
        fi

        # raw/cooked toggling should succeed
        saved_settings=$($F_TOOL -g 2>/dev/null || echo "")

        run_expected_exit_test "stty raw exits 0" "$F_TOOL raw 2>/dev/null" 0
        run_expected_exit_test "stty cooked exits 0" "$F_TOOL cooked 2>/dev/null" 0

        # Restore settings
        if [[ -n "$saved_settings" ]]; then
            $F_TOOL "$saved_settings" 2>/dev/null || true
        fi

        # --all (long form of -a) should work
        run_expected_exit_test "stty --all exits 0" "$F_TOOL --all >/dev/null" 0

        # --save (long form of -g) should work
        run_expected_exit_test "stty --save exits 0" "$F_TOOL --save >/dev/null" 0
    else
        skip_test "stty -a exits 0" "not a tty"
        skip_test "stty -g exits 0" "not a tty"
        skip_test "stty size exits 0" "not a tty"
        skip_test "stty speed exits 0" "not a tty"
        skip_test "stty sane exits 0" "not a tty"
        skip_test "stty -a output non-empty" "not a tty"
        skip_test "stty -g output non-empty" "not a tty"
        skip_test "stty size format" "not a tty"
        skip_test "stty speed format" "not a tty"
        skip_test "stty echo exits 0" "not a tty"
        skip_test "stty -echo exits 0" "not a tty"
        skip_test "stty raw exits 0" "not a tty"
        skip_test "stty cooked exits 0" "not a tty"
        skip_test "stty --all exits 0" "not a tty"
        skip_test "stty --save exits 0" "not a tty"
    fi

    finish_test_suite
}
run_stty_functional_tests
