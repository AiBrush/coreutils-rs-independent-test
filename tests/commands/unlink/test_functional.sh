#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="funlink"
run_unlink_functional_tests() {
    init_test_suite "unlink"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"unlink","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/unlink_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    local tmp="/tmp/fcoreutils_unlink_$$"
    printf "hello" > "$tmp"
    run_expected_exit_test "unlink file" "$F_TOOL $tmp" 0

    # Test unlink directory fails
    local tmpdir="/tmp/fcoreutils_unlinkdir_$$"
    mkdir -p "$tmpdir"
    run_expected_exit_test "unlink directory fails" "$F_TOOL '$tmpdir' 2>/dev/null" 1
    rm -rf "$tmpdir"

    # Test too many args fails
    run_expected_exit_test "too many args fails" "$F_TOOL a b 2>/dev/null" 1

    # Test unlink symlink succeeds
    local sym_target="/tmp/fcoreutils_unlinksym_target_$$"
    local sym_link="/tmp/fcoreutils_unlinksym_link_$$"
    echo "target" > "$sym_target"
    ln -s "$sym_target" "$sym_link"
    run_expected_exit_test "unlink symlink" "$F_TOOL '$sym_link'" 0
    rm -f "$sym_target" "$sym_link"

    # Test unlink preserves other hard links
    local hl_src="/tmp/fcoreutils_unlinkhl_src_$$"
    local hl_link="/tmp/fcoreutils_unlinkhl_link_$$"
    echo "hardlink" > "$hl_src"
    ln "$hl_src" "$hl_link"
    run_expected_exit_test "unlink preserves other hard links" "$F_TOOL '$hl_src' && test -e '$hl_link'" 0
    rm -f "$hl_src" "$hl_link"

    # Test hard link content preserved after unlink of one link
    local hl_src2="/tmp/fcoreutils_unlinkhl_src2_$$"
    local hl_link2="/tmp/fcoreutils_unlinkhl_link2_$$"
    echo "preserved content" > "$hl_src2"
    ln "$hl_src2" "$hl_link2"
    run_expected_test "hard link content preserved after unlink" \
        "$F_TOOL '$hl_src2' && cat '$hl_link2'" \
        "preserved content"
    rm -f "$hl_src2" "$hl_link2"

    # Test unlink broken symlink succeeds
    local broken_target="/tmp/fcoreutils_unlink_broken_target_$$"
    local broken_link="/tmp/fcoreutils_unlink_broken_link_$$"
    ln -sf "$broken_target" "$broken_link"
    run_expected_exit_test "unlink broken symlink" "$F_TOOL '$broken_link'" 0
    rm -f "$broken_link"

    # Test unlink readonly file succeeds (depends on dir perms, not file perms)
    local ro_file="/tmp/fcoreutils_unlink_ro_$$"
    echo "readonly" > "$ro_file"
    chmod 444 "$ro_file"
    run_expected_exit_test "unlink readonly file" "$F_TOOL '$ro_file'" 0
    rm -f "$ro_file"

    # Test --help exits successfully
    run_expected_exit_test "help flag" "$F_TOOL --help 2>/dev/null" 0

    # Test --version exits successfully
    run_expected_exit_test "version flag" "$F_TOOL --version 2>/dev/null" 0

    finish_test_suite
}
run_unlink_functional_tests
