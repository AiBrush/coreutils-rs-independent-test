#!/usr/bin/env bash
# Compatibility tests for fchcon vs GNU chcon
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "chcon")
F_TOOL="fchcon"

init_test_suite "chcon"

if ! check_tool_exists "$F_TOOL"; then
    echo '{"tool":"chcon","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chcon_results.json"
    exit 0
fi

# Check if GNU chcon is available for comparison
GNU_AVAILABLE=false
if check_tool_exists "$GNU_TOOL" 2>/dev/null; then
    GNU_AVAILABLE=true
fi

echo ""
echo "=== GNU Upstream: chcon-fail (Argument Validation) ==="

# From chcon-fail.sh: these tests don't use any actual SELinux syscalls
# They just verify argument validation / error handling
if $GNU_AVAILABLE; then
    # chcon with no arguments should fail with exit code 1
    run_exit_code_test "GNU: chcon no args" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # chcon with context but no file should fail
    run_exit_code_test "GNU: chcon context but no file" \
        "$GNU_TOOL CON 2>&1" \
        "$F_TOOL CON 2>&1"

    # chcon --reference with file but no target should fail
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_chcon_XXXXXX)
    register_temp "$test_dir"
    echo "test" > "$test_dir/ref_file"

    run_exit_code_test "GNU: chcon --reference without target file" \
        "$GNU_TOOL --reference='$test_dir/ref_file' 2>&1" \
        "$F_TOOL --reference='$test_dir/ref_file' 2>&1"

    # chcon -u without file should fail
    run_exit_code_test "GNU: chcon -u without file" \
        "$GNU_TOOL -u anyone 2>&1" \
        "$F_TOOL -u anyone 2>&1"

    # --help exit code
    run_exit_code_test "GNU: chcon --help exit code" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    # --version exit code
    run_exit_code_test "GNU: chcon --version exit code" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    rm -rf "$test_dir"
else
    skip_test "chcon no args" "GNU chcon not available for comparison"
    skip_test "chcon context but no file" "GNU chcon not available for comparison"
    skip_test "chcon --reference without file" "GNU chcon not available for comparison"
    skip_test "chcon -u without file" "GNU chcon not available for comparison"
fi

echo ""
echo "=== GNU Upstream: chcon (SELinux Operations) ==="

# From chcon.sh: all tests require require_root_ and require_selinux_
skip_test "chcon set context" "Requires root and SELinux"
skip_test "chcon --reference context copy" "Requires root and SELinux"
skip_test "chcon --user/--role/--type/--range" "Requires root and SELinux"
skip_test "chcon --verbose" "Requires root and SELinux"


finish_test_suite
