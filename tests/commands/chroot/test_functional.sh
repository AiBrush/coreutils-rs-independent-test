#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fchroot"
run_chroot_functional_tests() {
    init_test_suite "chroot"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chroot","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chroot_results.json"
        return 0
    fi
    # --help and --version should work without root
    run_expected_exit_test "chroot --help exits 0" "$F_TOOL --help >/dev/null 2>&1" 0
    run_expected_exit_test "chroot --version exits 0" "$F_TOOL --version >/dev/null 2>&1" 0

    # Invalid arguments should fail
    run_expected_exit_test "chroot no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "chroot unknown option fails" "$F_TOOL --no-such-option 2>/dev/null" 1

    # Nonexistent root directory should fail
    run_expected_exit_test "chroot nonexistent root fails" "$F_TOOL /nonexistent_dir_$$ true 2>/dev/null" 1

    # File instead of directory should fail
    local tmp_notdir="/tmp/fchroot_func_notdir_$$"
    touch "$tmp_notdir"
    run_expected_exit_test "chroot with file fails" "$F_TOOL '$tmp_notdir' true 2>/dev/null" 1
    rm -f "$tmp_notdir"

    # Non-root should fail to chroot (permission denied)
    if [[ "$(id -u)" -ne 0 ]]; then
        run_expected_exit_test "chroot / as non-root fails" "$F_TOOL / true 2>/dev/null" 1
        run_expected_exit_test "chroot /tmp as non-root fails" "$F_TOOL /tmp true 2>/dev/null" 1
    else
        skip_test "chroot / as non-root fails" "running as root"
        skip_test "chroot /tmp as non-root fails" "running as root"
    fi

    # --skip-chdir with non-/ should fail
    run_expected_exit_test "chroot --skip-chdir non-root fails" "$F_TOOL --skip-chdir /tmp true 2>/dev/null" 1

    # Error message on stderr for no args
    run_expected_exit_test "chroot no args produces stderr" "test -n \"\$($F_TOOL 2>&1 >/dev/null)\"" 0

    # --help output should contain text
    run_expected_exit_test "chroot --help has content" "test -n \"\$($F_TOOL --help 2>&1)\"" 0

    # --version output should contain text
    run_expected_exit_test "chroot --version has content" "test -n \"\$($F_TOOL --version 2>&1)\"" 0

    # Invalid short option should fail
    run_expected_exit_test "chroot -Z invalid option fails" "$F_TOOL -Z 2>/dev/null" 1

    # Empty root arg should fail
    run_expected_exit_test "chroot empty root arg fails" "$F_TOOL '' true 2>/dev/null" 1

    # Root-only tests
    if [[ "$(id -u)" -eq 0 ]]; then
        run_expected_exit_test "chroot / true (as root)" "$F_TOOL / true" 0
        run_expected_test "chroot / echo hello (as root)" "$F_TOOL / /bin/echo hello" "hello"
        run_expected_exit_test "chroot / false (as root)" "$F_TOOL / false 2>/dev/null" 1
        run_expected_exit_test "chroot --skip-chdir / (as root)" "$F_TOOL --skip-chdir / true" 0

        # sh -c command execution
        run_expected_test "chroot / sh -c echo (as root)" "$F_TOOL / /bin/sh -c 'echo ok'" "ok"

        # Exit code propagation
        run_expected_exit_test "chroot exit code 42 (as root)" "$F_TOOL / /bin/sh -c 'exit 42' 2>/dev/null" 42

        # Command not found should exit 127
        run_expected_exit_test "chroot cmd not found exits 127 (as root)" "$F_TOOL / /nonexistent_cmd_$$ 2>/dev/null" 127

        # env should succeed
        run_expected_exit_test "chroot / env exits 0 (as root)" "$F_TOOL / /usr/bin/env >/dev/null" 0

        # --userspec
        run_expected_exit_test "chroot --userspec=root:root (as root)" "$F_TOOL --userspec=root:root / true" 0

        # --groups
        run_expected_exit_test "chroot --groups=root (as root)" "$F_TOOL --userspec=root --groups=root / true" 0
    else
        skip_test "chroot / true" "requires root"
        skip_test "chroot / echo hello" "requires root"
        skip_test "chroot / false" "requires root"
        skip_test "chroot --skip-chdir /" "requires root"
        skip_test "chroot / sh -c echo" "requires root"
        skip_test "chroot exit code 42" "requires root"
        skip_test "chroot cmd not found exits 127" "requires root"
        skip_test "chroot / env exits 0" "requires root"
        skip_test "chroot --userspec" "requires root"
        skip_test "chroot --groups" "requires root"
    fi

    finish_test_suite
}
run_chroot_functional_tests
