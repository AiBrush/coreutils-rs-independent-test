#!/usr/bin/env bash
# Compatibility tests for flink vs GNU link
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "link")
F_TOOL="flink"

run_link_tests() {
    init_test_suite "link"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"link","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/link_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU link not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_link_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic Hard Link ==="

    echo "source content" > "$WORK_DIR/source.txt"

    run_test "create hard link" \
        "$GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/gnu_link.txt' && cat '$WORK_DIR/gnu_link.txt'" \
        "$F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/f_link.txt' && cat '$WORK_DIR/f_link.txt'"

    run_test "hard link same inode" \
        "$GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/gnu_link2.txt' && test \$(stat -c '%i' '$WORK_DIR/source.txt' 2>/dev/null || stat -f '%i' '$WORK_DIR/source.txt') -eq \$(stat -c '%i' '$WORK_DIR/gnu_link2.txt' 2>/dev/null || stat -f '%i' '$WORK_DIR/gnu_link2.txt') && echo 'SAME'" \
        "$F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/f_link2.txt' && test \$(stat -c '%i' '$WORK_DIR/source.txt' 2>/dev/null || stat -f '%i' '$WORK_DIR/source.txt') -eq \$(stat -c '%i' '$WORK_DIR/f_link2.txt' 2>/dev/null || stat -f '%i' '$WORK_DIR/f_link2.txt') && echo 'SAME'"

    # Use separate source files to avoid cumulative nlink count differences
    echo "source content" > "$WORK_DIR/gnu_nlink_src.txt"
    echo "source content" > "$WORK_DIR/f_nlink_src.txt"
    run_test "link increases nlink count" \
        "$GNU_TOOL '$WORK_DIR/gnu_nlink_src.txt' '$WORK_DIR/gnu_link3.txt' && (stat -c '%h' '$WORK_DIR/gnu_nlink_src.txt' 2>/dev/null || stat -f '%l' '$WORK_DIR/gnu_nlink_src.txt')" \
        "$F_TOOL '$WORK_DIR/f_nlink_src.txt' '$WORK_DIR/f_link3.txt' && (stat -c '%h' '$WORK_DIR/f_nlink_src.txt' 2>/dev/null || stat -f '%l' '$WORK_DIR/f_nlink_src.txt')"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "source not found" \
        "$GNU_TOOL '/tmp/nonexistent_$$' '$WORK_DIR/gnu_err.txt' 2>&1" \
        "$F_TOOL '/tmp/nonexistent_$$' '$WORK_DIR/f_err.txt' 2>&1"

    run_exit_code_test "target already exists" \
        "echo 'x' > '$WORK_DIR/gnu_exists.txt' && $GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/gnu_exists.txt' 2>&1" \
        "echo 'x' > '$WORK_DIR/f_exists.txt' && $F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/f_exists.txt' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "one argument" \
        "$GNU_TOOL '$WORK_DIR/source.txt' 2>&1" \
        "$F_TOOL '$WORK_DIR/source.txt' 2>&1"

    run_exit_code_test "too many arguments" \
        "$GNU_TOOL a b c 2>&1" \
        "$F_TOOL a b c 2>&1"

    echo ""
    echo "=== Content & Behavior Verification ==="

    # Verify hard link content matches source
    echo "test content for verification" > "$WORK_DIR/verify_src.txt"
    run_test "verify hard link content matches" \
        "$GNU_TOOL '$WORK_DIR/verify_src.txt' '$WORK_DIR/gnu_verify_dst.txt' && cat '$WORK_DIR/gnu_verify_dst.txt'" \
        "$F_TOOL '$WORK_DIR/verify_src.txt' '$WORK_DIR/f_verify_dst.txt' && cat '$WORK_DIR/f_verify_dst.txt'"

    # Write through hard link updates original
    echo "original" > "$WORK_DIR/gnu_writable_src.txt"
    echo "original" > "$WORK_DIR/f_writable_src.txt"
    run_test "write through hard link updates original" \
        "$GNU_TOOL '$WORK_DIR/gnu_writable_src.txt' '$WORK_DIR/gnu_writable_dst.txt' && echo 'modified' > '$WORK_DIR/gnu_writable_dst.txt' && cat '$WORK_DIR/gnu_writable_src.txt'" \
        "$F_TOOL '$WORK_DIR/f_writable_src.txt' '$WORK_DIR/f_writable_dst.txt' && echo 'modified' > '$WORK_DIR/f_writable_dst.txt' && cat '$WORK_DIR/f_writable_src.txt'"

    # Verify permissions preserved after link
    echo "perm content" > "$WORK_DIR/gnu_perm_src.txt"
    echo "perm content" > "$WORK_DIR/f_perm_src.txt"
    chmod 644 "$WORK_DIR/gnu_perm_src.txt" "$WORK_DIR/f_perm_src.txt"
    run_test "link preserves file permissions" \
        "$GNU_TOOL '$WORK_DIR/gnu_perm_src.txt' '$WORK_DIR/gnu_perm_dst.txt' && (stat -c '%a' '$WORK_DIR/gnu_perm_dst.txt' 2>/dev/null || stat -f '%Lp' '$WORK_DIR/gnu_perm_dst.txt')" \
        "$F_TOOL '$WORK_DIR/f_perm_src.txt' '$WORK_DIR/f_perm_dst.txt' && (stat -c '%a' '$WORK_DIR/f_perm_dst.txt' 2>/dev/null || stat -f '%Lp' '$WORK_DIR/f_perm_dst.txt')"

    # Link readonly source file (should succeed - link needs dir write, not file write)
    echo "readonly content" > "$WORK_DIR/gnu_ro_src.txt"
    echo "readonly content" > "$WORK_DIR/f_ro_src.txt"
    chmod 444 "$WORK_DIR/gnu_ro_src.txt" "$WORK_DIR/f_ro_src.txt"
    run_test "link readonly source file" \
        "$GNU_TOOL '$WORK_DIR/gnu_ro_src.txt' '$WORK_DIR/gnu_ro_dst.txt' && cat '$WORK_DIR/gnu_ro_dst.txt'" \
        "$F_TOOL '$WORK_DIR/f_ro_src.txt' '$WORK_DIR/f_ro_dst.txt' && cat '$WORK_DIR/f_ro_dst.txt'"

    echo ""
    echo "=== Special File Types ==="

    # Link empty file
    > "$WORK_DIR/empty_src.txt"
    run_test "link empty file" \
        "$GNU_TOOL '$WORK_DIR/empty_src.txt' '$WORK_DIR/gnu_empty_dst.txt' && test -e '$WORK_DIR/gnu_empty_dst.txt' && echo 'OK'" \
        "$F_TOOL '$WORK_DIR/empty_src.txt' '$WORK_DIR/f_empty_dst.txt' && test -e '$WORK_DIR/f_empty_dst.txt' && echo 'OK'"

    # Link large file (100KB)
    dd if=/dev/zero of="$WORK_DIR/large_src.bin" bs=1024 count=100 2>/dev/null
    run_test "link large file" \
        "$GNU_TOOL '$WORK_DIR/large_src.bin' '$WORK_DIR/gnu_large_dst.bin' && cmp -s '$WORK_DIR/large_src.bin' '$WORK_DIR/gnu_large_dst.bin' && echo 'MATCH'" \
        "$F_TOOL '$WORK_DIR/large_src.bin' '$WORK_DIR/f_large_dst.bin' && cmp -s '$WORK_DIR/large_src.bin' '$WORK_DIR/f_large_dst.bin' && echo 'MATCH'"

    # Link file with spaces in name
    echo "spaced content" > "$WORK_DIR/file with spaces.txt"
    run_test "link file with spaces in name" \
        "$GNU_TOOL '$WORK_DIR/file with spaces.txt' '$WORK_DIR/gnu link dest.txt' && cat '$WORK_DIR/gnu link dest.txt'" \
        "$F_TOOL '$WORK_DIR/file with spaces.txt' '$WORK_DIR/f link dest.txt' && cat '$WORK_DIR/f link dest.txt'"

    # Link with symlink as source
    echo "symlink target content" > "$WORK_DIR/symlink_target.txt"
    ln -s "$WORK_DIR/symlink_target.txt" "$WORK_DIR/symlink_src"
    run_exit_code_test "link with symlink source" \
        "$GNU_TOOL '$WORK_DIR/symlink_src' '$WORK_DIR/gnu_symlink_dst' 2>&1" \
        "$F_TOOL '$WORK_DIR/symlink_src' '$WORK_DIR/f_symlink_dst' 2>&1"

    echo ""
    echo "=== Error Handling (extended) ==="

    # Link directory should fail
    mkdir -p "$WORK_DIR/gnu_testdir" "$WORK_DIR/f_testdir"
    run_exit_code_test "link directory fails" \
        "$GNU_TOOL '$WORK_DIR/gnu_testdir' '$WORK_DIR/gnu_dir_link' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_testdir' '$WORK_DIR/f_dir_link' 2>&1"

    # Link in unwritable directory should fail
    mkdir -p "$WORK_DIR/readonly_dir"
    chmod 555 "$WORK_DIR/readonly_dir"
    run_exit_code_test "link in unwritable directory" \
        "$GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/readonly_dir/gnu_link.txt' 2>&1" \
        "$F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/readonly_dir/f_link.txt' 2>&1"
    chmod 755 "$WORK_DIR/readonly_dir"

    # --help flag
    run_exit_code_test "help flag" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    # --version flag
    run_exit_code_test "version flag" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    echo ""
    echo "=== Cross-Platform Verification ==="

    # Verify inode match using cross-platform stat
    echo "inode check" > "$WORK_DIR/gnu_inode_src.txt"
    echo "inode check" > "$WORK_DIR/f_inode_src.txt"
    run_test "verify inode match (cross-platform)" \
        "$GNU_TOOL '$WORK_DIR/gnu_inode_src.txt' '$WORK_DIR/gnu_inode_dst.txt' && test \$(stat -c '%i' '$WORK_DIR/gnu_inode_src.txt' 2>/dev/null || stat -f '%i' '$WORK_DIR/gnu_inode_src.txt') -eq \$(stat -c '%i' '$WORK_DIR/gnu_inode_dst.txt' 2>/dev/null || stat -f '%i' '$WORK_DIR/gnu_inode_dst.txt') && echo 'SAME_INODE'" \
        "$F_TOOL '$WORK_DIR/f_inode_src.txt' '$WORK_DIR/f_inode_dst.txt' && test \$(stat -c '%i' '$WORK_DIR/f_inode_src.txt' 2>/dev/null || stat -f '%i' '$WORK_DIR/f_inode_src.txt') -eq \$(stat -c '%i' '$WORK_DIR/f_inode_dst.txt' 2>/dev/null || stat -f '%i' '$WORK_DIR/f_inode_dst.txt') && echo 'SAME_INODE'"

    # Verify content via diff (not just cat)
    echo "diff verify content" > "$WORK_DIR/gnu_diff_src.txt"
    echo "diff verify content" > "$WORK_DIR/f_diff_src.txt"
    run_test "verify content via diff" \
        "$GNU_TOOL '$WORK_DIR/gnu_diff_src.txt' '$WORK_DIR/gnu_diff_dst.txt' && diff '$WORK_DIR/gnu_diff_src.txt' '$WORK_DIR/gnu_diff_dst.txt' && echo 'IDENTICAL'" \
        "$F_TOOL '$WORK_DIR/f_diff_src.txt' '$WORK_DIR/f_diff_dst.txt' && diff '$WORK_DIR/f_diff_src.txt' '$WORK_DIR/f_diff_dst.txt' && echo 'IDENTICAL'"

    # Verify link count reaches 3 with multiple links
    echo "multi link" > "$WORK_DIR/gnu_multi_src.txt"
    echo "multi link" > "$WORK_DIR/f_multi_src.txt"
    run_test "nlink count reaches 3 with two links" \
        "$GNU_TOOL '$WORK_DIR/gnu_multi_src.txt' '$WORK_DIR/gnu_multi_dst1.txt' && $GNU_TOOL '$WORK_DIR/gnu_multi_src.txt' '$WORK_DIR/gnu_multi_dst2.txt' && (stat -c '%h' '$WORK_DIR/gnu_multi_src.txt' 2>/dev/null || stat -f '%l' '$WORK_DIR/gnu_multi_src.txt')" \
        "$F_TOOL '$WORK_DIR/f_multi_src.txt' '$WORK_DIR/f_multi_dst1.txt' && $F_TOOL '$WORK_DIR/f_multi_src.txt' '$WORK_DIR/f_multi_dst2.txt' && (stat -c '%h' '$WORK_DIR/f_multi_src.txt' 2>/dev/null || stat -f '%l' '$WORK_DIR/f_multi_src.txt')"

    # Link FIFO (named pipe)
    mkfifo "$WORK_DIR/gnu_fifo_src"
    mkfifo "$WORK_DIR/f_fifo_src"
    run_exit_code_test "link named pipe (FIFO)" \
        "$GNU_TOOL '$WORK_DIR/gnu_fifo_src' '$WORK_DIR/gnu_fifo_dst' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_fifo_src' '$WORK_DIR/f_fifo_dst' 2>&1"

    # Link preserves file size
    dd if=/dev/urandom of="$WORK_DIR/gnu_size_src.bin" bs=512 count=7 2>/dev/null
    cp "$WORK_DIR/gnu_size_src.bin" "$WORK_DIR/f_size_src.bin"
    run_test "link preserves file size" \
        "$GNU_TOOL '$WORK_DIR/gnu_size_src.bin' '$WORK_DIR/gnu_size_dst.bin' && (stat -c '%s' '$WORK_DIR/gnu_size_dst.bin' 2>/dev/null || stat -f '%z' '$WORK_DIR/gnu_size_dst.bin')" \
        "$F_TOOL '$WORK_DIR/f_size_src.bin' '$WORK_DIR/f_size_dst.bin' && (stat -c '%s' '$WORK_DIR/f_size_dst.bin' 2>/dev/null || stat -f '%z' '$WORK_DIR/f_size_dst.bin')"

    # Link executable file preserves execute permission
    echo '#!/bin/sh' > "$WORK_DIR/gnu_exec_src.sh"
    echo '#!/bin/sh' > "$WORK_DIR/f_exec_src.sh"
    chmod 755 "$WORK_DIR/gnu_exec_src.sh" "$WORK_DIR/f_exec_src.sh"
    run_test "link preserves execute permission" \
        "$GNU_TOOL '$WORK_DIR/gnu_exec_src.sh' '$WORK_DIR/gnu_exec_dst.sh' && test -x '$WORK_DIR/gnu_exec_dst.sh' && echo 'EXECUTABLE'" \
        "$F_TOOL '$WORK_DIR/f_exec_src.sh' '$WORK_DIR/f_exec_dst.sh' && test -x '$WORK_DIR/f_exec_dst.sh' && echo 'EXECUTABLE'"

    # Link with special characters (tabs) in filename
    echo "tab content" > "$WORK_DIR/gnu	tab	file.txt"
    echo "tab content" > "$WORK_DIR/f	tab	file.txt"
    run_test "link file with tabs in name" \
        "$GNU_TOOL '$WORK_DIR/gnu	tab	file.txt' '$WORK_DIR/gnu	tab	dest.txt' && cat '$WORK_DIR/gnu	tab	dest.txt'" \
        "$F_TOOL '$WORK_DIR/f	tab	file.txt' '$WORK_DIR/f	tab	dest.txt' && cat '$WORK_DIR/f	tab	dest.txt'"

    # Link single byte file
    printf 'X' > "$WORK_DIR/gnu_byte_src.txt"
    printf 'X' > "$WORK_DIR/f_byte_src.txt"
    run_test "link single byte file" \
        "$GNU_TOOL '$WORK_DIR/gnu_byte_src.txt' '$WORK_DIR/gnu_byte_dst.txt' && cat '$WORK_DIR/gnu_byte_dst.txt'" \
        "$F_TOOL '$WORK_DIR/f_byte_src.txt' '$WORK_DIR/f_byte_dst.txt' && cat '$WORK_DIR/f_byte_dst.txt'"

    # Removing source after link - dest still readable
    echo "survive delete" > "$WORK_DIR/gnu_del_src.txt"
    echo "survive delete" > "$WORK_DIR/f_del_src.txt"
    run_test "link survives source deletion" \
        "$GNU_TOOL '$WORK_DIR/gnu_del_src.txt' '$WORK_DIR/gnu_del_dst.txt' && rm '$WORK_DIR/gnu_del_src.txt' && cat '$WORK_DIR/gnu_del_dst.txt'" \
        "$F_TOOL '$WORK_DIR/f_del_src.txt' '$WORK_DIR/f_del_dst.txt' && rm '$WORK_DIR/f_del_src.txt' && cat '$WORK_DIR/f_del_dst.txt'"

    # Link to file in subdirectory
    mkdir -p "$WORK_DIR/subdir"
    echo "subdir content" > "$WORK_DIR/subdir/gnu_sub_src.txt"
    echo "subdir content" > "$WORK_DIR/subdir/f_sub_src.txt"
    run_test "link to file in subdirectory" \
        "$GNU_TOOL '$WORK_DIR/subdir/gnu_sub_src.txt' '$WORK_DIR/gnu_sub_dst.txt' && cat '$WORK_DIR/gnu_sub_dst.txt'" \
        "$F_TOOL '$WORK_DIR/subdir/f_sub_src.txt' '$WORK_DIR/f_sub_dst.txt' && cat '$WORK_DIR/f_sub_dst.txt'"

    # Link with no-argument error message check
    run_exit_code_test "no args produces stderr" \
        "$GNU_TOOL 2>&1 | grep -qi 'missing\|operand\|usage\|argument' && echo 'HAS_MSG'" \
        "$F_TOOL 2>&1 | grep -qi 'missing\|operand\|usage\|argument' && echo 'HAS_MSG'"

    # Link to nonexistent path component
    run_exit_code_test "nonexistent parent directory" \
        "$GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/no_such_dir_$$/link.txt' 2>&1" \
        "$F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/no_such_dir_$$/link.txt' 2>&1"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_link_tests
