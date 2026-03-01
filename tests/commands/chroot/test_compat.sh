#!/usr/bin/env bash
# Compatibility tests for fchroot vs GNU chroot
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "chroot")
F_TOOL="fchroot"

init_test_suite "chroot"

if ! check_tool_exists "$F_TOOL"; then
    echo '{"tool":"chroot","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chroot_results.json"
    exit 0
fi

# Check if GNU chroot is available for comparison
GNU_AVAILABLE=false
if check_tool_exists "$GNU_TOOL" 2>/dev/null; then
    GNU_AVAILABLE=true
fi

echo ""
echo "=== GNU Upstream: chroot-fail (Exit Status) ==="

# From chroot-fail.sh: tests that verify exact exit status of internal failures
# Some of these don't actually execute chroot(2), just test argument parsing
if $GNU_AVAILABLE; then
    # Missing argument should exit 125
    run_exit_code_test "GNU: chroot missing argument" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # Unknown option should exit 125
    run_exit_code_test "GNU: chroot unknown option" \
        "$GNU_TOOL --- / true 2>&1" \
        "$F_TOOL --- / true 2>&1"

    # --skip-chdir with non-"/" argument should fail
    run_exit_code_test "GNU: chroot --skip-chdir with non-root dir" \
        "$GNU_TOOL --skip-chdir . env pwd 2>&1" \
        "$F_TOOL --skip-chdir . env pwd 2>&1"
else
    skip_test "chroot missing argument" "GNU chroot not available for comparison"
    skip_test "chroot unknown option" "GNU chroot not available for comparison"
    skip_test "chroot --skip-chdir with non-root dir" "GNU chroot not available for comparison"
fi

# Tests requiring chroot(2) to / -- may or may not work without root
skip_test "chroot exit status propagation" "Requires root to chroot /"
skip_test "chroot invalid command exits 126" "Requires root to chroot /"
skip_test "chroot no such command exits 127" "Requires root to chroot /"
skip_test "chroot chdir(/) after chroot" "Requires root to chroot /"
skip_test "chroot --skip-chdir with /" "Requires root to chroot /"

echo ""
echo "=== GNU Upstream: chroot-credentials ==="

# From chroot-credentials.sh: all tests require require_root_
skip_test "chroot --userspec credentials" "Requires root"
skip_test "chroot --groups validation" "Requires root"
skip_test "chroot root credentials kept" "Requires root"
skip_test "chroot supplemental groups" "Requires root"
skip_test "chroot --userspec with UID: syntax" "Requires root"
skip_test "chroot supplemental group clearing" "Requires root"

echo ""
echo "=== Nonexistent Root Directory ==="

if $GNU_AVAILABLE; then
    run_exit_code_test "chroot nonexistent root" \
        "$GNU_TOOL /nonexistent_dir_$$ true 2>&1" \
        "$F_TOOL /nonexistent_dir_$$ true 2>&1"
else
    skip_test "chroot nonexistent root" "GNU chroot not available"
fi

echo ""
echo "=== Not a Directory ==="

if $GNU_AVAILABLE; then
    tmp_notdir="/tmp/chroot_notdir_$$"
    touch "$tmp_notdir"
    run_exit_code_test "chroot with file instead of directory" \
        "$GNU_TOOL '$tmp_notdir' true 2>&1" \
        "$F_TOOL '$tmp_notdir' true 2>&1"
    rm -f "$tmp_notdir"
else
    skip_test "chroot with file instead of directory" "GNU chroot not available"
fi

echo ""
echo "=== Permission Denied (non-root) ==="

# chroot(2) requires root - both should fail the same way when run as non-root
if [[ "$(id -u)" -ne 0 ]]; then
    if $GNU_AVAILABLE; then
        run_exit_code_test "chroot / as non-root fails" \
            "$GNU_TOOL / true 2>&1" \
            "$F_TOOL / true 2>&1"

        run_exit_code_test "chroot /tmp as non-root fails" \
            "$GNU_TOOL /tmp true 2>&1" \
            "$F_TOOL /tmp true 2>&1"
    else
        skip_test "chroot / as non-root fails" "GNU chroot not available"
        skip_test "chroot /tmp as non-root fails" "GNU chroot not available"
    fi
else
    skip_test "chroot / as non-root fails" "running as root"
    skip_test "chroot /tmp as non-root fails" "running as root"
fi

echo ""
echo "=== Help and Version ==="

if $GNU_AVAILABLE; then
    run_exit_code_test "chroot --help exits 0" \
        "$GNU_TOOL --help >/dev/null 2>&1" \
        "$F_TOOL --help >/dev/null 2>&1"

    run_exit_code_test "chroot --version exits 0" \
        "$GNU_TOOL --version >/dev/null 2>&1" \
        "$F_TOOL --version >/dev/null 2>&1"
else
    skip_test "chroot --help" "GNU chroot not available"
    skip_test "chroot --version" "GNU chroot not available"
fi

echo ""
echo "=== Error Messages on Stderr ==="

if $GNU_AVAILABLE; then
    # Both should produce stderr output for errors
    TESTS_RUN=$((TESTS_RUN + 1))
    gnu_stderr=""
    f_stderr=""
    gnu_stderr=$($GNU_TOOL /nonexistent_$$ 2>&1 >/dev/null || true)
    f_stderr=$($F_TOOL /nonexistent_$$ 2>&1 >/dev/null || true)

    if [[ -n "$gnu_stderr" ]] && [[ -n "$f_stderr" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: chroot error on stderr"
        record_result "chroot stderr on error" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: chroot error on stderr (gnu='$gnu_stderr' f='$f_stderr')"
        record_result "chroot stderr on error" "FAIL" "stderr output differs" "" ""
    fi
else
    skip_test "chroot stderr on error" "GNU chroot not available"
fi

echo ""
echo "=== Extra Arguments ==="

if $GNU_AVAILABLE; then
    run_exit_code_test "chroot too many args style" \
        "$GNU_TOOL /nonexistent_$$ /bin/sh -c 'echo hello' 2>&1" \
        "$F_TOOL /nonexistent_$$ /bin/sh -c 'echo hello' 2>&1"
else
    skip_test "chroot too many args style" "GNU chroot not available"
fi

echo ""
echo "=== Root-Only Tests ==="

if [[ "$(id -u)" -eq 0 ]]; then
    if $GNU_AVAILABLE; then
        # Basic chroot to / running true
        run_exit_code_test "chroot / true (as root)" \
            "$GNU_TOOL / true 2>&1" \
            "$F_TOOL / true 2>&1"

        # chroot / with a command
        run_test "chroot / echo hello (as root)" \
            "$GNU_TOOL / /bin/echo hello" \
            "$F_TOOL / /bin/echo hello"

        # chroot / with shell command
        run_test "chroot / sh -c 'echo ok' (as root)" \
            "$GNU_TOOL / /bin/sh -c 'echo ok'" \
            "$F_TOOL / /bin/sh -c 'echo ok'"

        # Exit code propagation
        run_exit_code_test "chroot exit code propagation (as root)" \
            "$GNU_TOOL / /bin/sh -c 'exit 42' 2>&1" \
            "$F_TOOL / /bin/sh -c 'exit 42' 2>&1"

        # Invalid command exits 126/127
        run_exit_code_test "chroot invalid command (as root)" \
            "$GNU_TOOL / /nonexistent_cmd_$$ 2>&1" \
            "$F_TOOL / /nonexistent_cmd_$$ 2>&1"

        # --skip-chdir with /
        run_exit_code_test "chroot --skip-chdir / (as root)" \
            "$GNU_TOOL --skip-chdir / true 2>&1" \
            "$F_TOOL --skip-chdir / true 2>&1"

        # chroot with env
        run_test "chroot / env output (as root)" \
            "$GNU_TOOL / /usr/bin/env | sort | head -5" \
            "$F_TOOL / /usr/bin/env | sort | head -5"

        # --userspec
        run_exit_code_test "chroot --userspec=root:root (as root)" \
            "$GNU_TOOL --userspec=root:root / true 2>&1" \
            "$F_TOOL --userspec=root:root / true 2>&1"

        # --groups
        run_exit_code_test "chroot --groups=root (as root)" \
            "$GNU_TOOL --userspec=root --groups=root / true 2>&1" \
            "$F_TOOL --userspec=root --groups=root / true 2>&1"
    else
        skip_test "chroot / true (as root)" "GNU chroot not available"
        skip_test "chroot / echo hello (as root)" "GNU chroot not available"
        skip_test "chroot / sh -c (as root)" "GNU chroot not available"
        skip_test "chroot exit code propagation (as root)" "GNU chroot not available"
        skip_test "chroot invalid command (as root)" "GNU chroot not available"
        skip_test "chroot --skip-chdir / (as root)" "GNU chroot not available"
        skip_test "chroot / env output (as root)" "GNU chroot not available"
        skip_test "chroot --userspec (as root)" "GNU chroot not available"
        skip_test "chroot --groups (as root)" "GNU chroot not available"
    fi
else
    skip_test "chroot / true" "requires root"
    skip_test "chroot / echo hello" "requires root"
    skip_test "chroot / sh -c" "requires root"
    skip_test "chroot exit code propagation" "requires root"
    skip_test "chroot invalid command" "requires root"
    skip_test "chroot --skip-chdir /" "requires root"
    skip_test "chroot / env output" "requires root"
    skip_test "chroot --userspec" "requires root"
    skip_test "chroot --groups" "requires root"
fi

echo ""
echo "=== Help/Version Output Validation ==="

if $GNU_AVAILABLE; then
    # Both should produce non-empty --help output
    TESTS_RUN=$((TESTS_RUN + 1))
    gnu_help=$($GNU_TOOL --help 2>&1 || true)
    f_help=$($F_TOOL --help 2>&1 || true)
    if [[ -n "$gnu_help" ]] && [[ -n "$f_help" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: chroot --help produces output"
        record_result "chroot --help produces output" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: chroot --help produces output"
        record_result "chroot --help produces output" "FAIL" "missing output" "" ""
    fi

    # Both should produce non-empty --version output
    TESTS_RUN=$((TESTS_RUN + 1))
    gnu_ver=$($GNU_TOOL --version 2>&1 || true)
    f_ver=$($F_TOOL --version 2>&1 || true)
    if [[ -n "$gnu_ver" ]] && [[ -n "$f_ver" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: chroot --version produces output"
        record_result "chroot --version produces output" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: chroot --version produces output"
        record_result "chroot --version produces output" "FAIL" "missing output" "" ""
    fi
else
    skip_test "chroot --help produces output" "GNU chroot not available"
    skip_test "chroot --version produces output" "GNU chroot not available"
fi

echo ""
echo "=== Additional Error Cases ==="

if $GNU_AVAILABLE; then
    # Empty string as root directory
    run_exit_code_test "chroot empty root arg" \
        "$GNU_TOOL '' true 2>&1" \
        "$F_TOOL '' true 2>&1"

    # Another invalid option style
    run_exit_code_test "chroot --invalid-option-xyz" \
        "$GNU_TOOL --invalid-option-xyz 2>&1" \
        "$F_TOOL --invalid-option-xyz 2>&1"

    # Single dash invalid
    run_exit_code_test "chroot -Z invalid short option" \
        "$GNU_TOOL -Z 2>&1" \
        "$F_TOOL -Z 2>&1"

    # Permission denied on restricted directory (non-root only)
    if [[ "$(id -u)" -ne 0 ]]; then
        restricted_dir="/tmp/chroot_restricted_$$"
        mkdir -p "$restricted_dir"
        chmod 000 "$restricted_dir"
        register_temp "$restricted_dir"
        run_exit_code_test "chroot permission denied on restricted dir" \
            "$GNU_TOOL '$restricted_dir' true 2>&1" \
            "$F_TOOL '$restricted_dir' true 2>&1"
        chmod 755 "$restricted_dir"
        rmdir "$restricted_dir" 2>/dev/null || true
    else
        skip_test "chroot permission denied on restricted dir" "running as root"
    fi

    # Command not found pattern (non-root — both fail on chroot(2) before reaching command)
    if [[ "$(id -u)" -ne 0 ]]; then
        run_exit_code_test "chroot / nonexistent cmd (non-root)" \
            "$GNU_TOOL / /nonexistent_cmd_$$ 2>&1" \
            "$F_TOOL / /nonexistent_cmd_$$ 2>&1"
    else
        skip_test "chroot / nonexistent cmd (non-root)" "running as root"
    fi
else
    skip_test "chroot empty root arg" "GNU chroot not available"
    skip_test "chroot --invalid-option-xyz" "GNU chroot not available"
    skip_test "chroot -Z invalid short option" "GNU chroot not available"
    skip_test "chroot permission denied on restricted dir" "GNU chroot not available"
    skip_test "chroot / nonexistent cmd (non-root)" "GNU chroot not available"
fi

finish_test_suite
