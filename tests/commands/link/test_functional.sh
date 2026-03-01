#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="flink"
run_link_functional_tests() {
    init_test_suite "link"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"link","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/link_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent source fails" "$F_TOOL /tmp/nonexistent_file_functional_test /tmp/link_dest_$$ 2>/dev/null" 1
    # Test creating a hard link
    local src="/tmp/fcoreutils_linksrc_$$"
    local dst="/tmp/fcoreutils_linkdst_$$"
    printf "hello" > "$src"
    run_expected_exit_test "create hard link" "$F_TOOL $src $dst" 0
    rm -f "$src" "$dst"

    # Test too many args
    run_expected_exit_test "too many args fails" "$F_TOOL a b c 2>/dev/null" 1

    # Test one arg only (too few)
    run_expected_exit_test "one arg only fails" "$F_TOOL /tmp/single_arg_$$ 2>/dev/null" 1

    # Test link on directory fails
    local tmpdir="/tmp/fcoreutils_linkdir_$$"
    mkdir -p "$tmpdir"
    run_expected_exit_test "link directory fails" "$F_TOOL '$tmpdir' '${tmpdir}_link' 2>/dev/null" 1
    rm -rf "$tmpdir"

    # Test hard link content matches source
    local src2="/tmp/fcoreutils_linksrc2_$$"
    local dst2="/tmp/fcoreutils_linkdst2_$$"
    echo "verify content" > "$src2"
    run_expected_test "hard link content matches" "$F_TOOL '$src2' '$dst2' 2>/dev/null && cat '$dst2'" "verify content"
    rm -f "$src2" "$dst2"

    # Test hard link has same inode
    local src3="/tmp/fcoreutils_linksrc3_$$"
    local dst3="/tmp/fcoreutils_linkdst3_$$"
    echo "inode test" > "$src3"
    run_expected_test "hard link same inode" \
        "$F_TOOL '$src3' '$dst3' && test \$(stat -c '%i' '$src3' 2>/dev/null || stat -f '%i' '$src3') -eq \$(stat -c '%i' '$dst3' 2>/dev/null || stat -f '%i' '$dst3') && echo 'SAME'" \
        "SAME"
    rm -f "$src3" "$dst3"

    # Test link survives source removal
    local src4="/tmp/fcoreutils_linksrc4_$$"
    local dst4="/tmp/fcoreutils_linkdst4_$$"
    echo "survive" > "$src4"
    run_expected_test "link survives source deletion" \
        "$F_TOOL '$src4' '$dst4' && rm '$src4' && cat '$dst4'" \
        "survive"
    rm -f "$src4" "$dst4"

    # Test --help exits successfully
    run_expected_exit_test "help flag" "$F_TOOL --help 2>/dev/null" 0

    # Test --version exits successfully
    run_expected_exit_test "version flag" "$F_TOOL --version 2>/dev/null" 0

    finish_test_suite
}
run_link_functional_tests
