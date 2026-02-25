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

    # --help exit code
    run_exit_code_test "GNU: chroot --help exit code" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    # --version exit code
    run_exit_code_test "GNU: chroot --version exit code" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

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


finish_test_suite
