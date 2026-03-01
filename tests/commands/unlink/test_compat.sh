#!/usr/bin/env bash
# Compatibility tests for funlink vs GNU unlink
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "unlink")
F_TOOL="funlink"

run_unlink_tests() {
    init_test_suite "unlink"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"unlink","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/unlink_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU unlink not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_unlink_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic File Removal ==="

    run_test "remove regular file" \
        "echo 'x' > '$WORK_DIR/gnu_file.txt' && $GNU_TOOL '$WORK_DIR/gnu_file.txt' && test ! -e '$WORK_DIR/gnu_file.txt' && echo 'REMOVED'" \
        "echo 'x' > '$WORK_DIR/f_file.txt' && $F_TOOL '$WORK_DIR/f_file.txt' && test ! -e '$WORK_DIR/f_file.txt' && echo 'REMOVED'"

    run_test "remove symlink" \
        "ln -sf '$WORK_DIR' '$WORK_DIR/gnu_symlink' && $GNU_TOOL '$WORK_DIR/gnu_symlink' && test ! -L '$WORK_DIR/gnu_symlink' && echo 'REMOVED'" \
        "ln -sf '$WORK_DIR' '$WORK_DIR/f_symlink' && $F_TOOL '$WORK_DIR/f_symlink' && test ! -L '$WORK_DIR/f_symlink' && echo 'REMOVED'"

    run_test "remove empty file" \
        "> '$WORK_DIR/gnu_empty.txt' && $GNU_TOOL '$WORK_DIR/gnu_empty.txt' && test ! -e '$WORK_DIR/gnu_empty.txt' && echo 'REMOVED'" \
        "> '$WORK_DIR/f_empty.txt' && $F_TOOL '$WORK_DIR/f_empty.txt' && test ! -e '$WORK_DIR/f_empty.txt' && echo 'REMOVED'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL '/tmp/nonexistent_$$' 2>&1" \
        "$F_TOOL '/tmp/nonexistent_$$' 2>&1"

    run_exit_code_test "directory (cannot unlink)" \
        "mkdir -p '$WORK_DIR/gnu_dir' && $GNU_TOOL '$WORK_DIR/gnu_dir' 2>&1" \
        "mkdir -p '$WORK_DIR/f_dir' && $F_TOOL '$WORK_DIR/f_dir' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "too many arguments" \
        "$GNU_TOOL a b 2>&1" \
        "$F_TOOL a b 2>&1"

    echo ""
    echo "=== Hard Link Behavior ==="

    # Unlink one hard link - other remains
    echo "link content" > "$WORK_DIR/gnu_hl_orig.txt"
    ln "$WORK_DIR/gnu_hl_orig.txt" "$WORK_DIR/gnu_hl_link.txt"
    echo "link content" > "$WORK_DIR/f_hl_orig.txt"
    ln "$WORK_DIR/f_hl_orig.txt" "$WORK_DIR/f_hl_link.txt"
    run_test "unlink hard link - other remains" \
        "$GNU_TOOL '$WORK_DIR/gnu_hl_orig.txt' && test -e '$WORK_DIR/gnu_hl_link.txt' && echo 'REMAINS'" \
        "$F_TOOL '$WORK_DIR/f_hl_orig.txt' && test -e '$WORK_DIR/f_hl_link.txt' && echo 'REMAINS'"

    # Unlink hard link - content preserved in remaining link
    echo "preserved content" > "$WORK_DIR/gnu_cp_orig.txt"
    ln "$WORK_DIR/gnu_cp_orig.txt" "$WORK_DIR/gnu_cp_link.txt"
    echo "preserved content" > "$WORK_DIR/f_cp_orig.txt"
    ln "$WORK_DIR/f_cp_orig.txt" "$WORK_DIR/f_cp_link.txt"
    run_test "unlink hard link - content preserved" \
        "$GNU_TOOL '$WORK_DIR/gnu_cp_orig.txt' && cat '$WORK_DIR/gnu_cp_link.txt'" \
        "$F_TOOL '$WORK_DIR/f_cp_orig.txt' && cat '$WORK_DIR/f_cp_link.txt'"

    echo ""
    echo "=== Special Cases ==="

    # Unlink file with spaces in name
    echo "spaced" > "$WORK_DIR/gnu file with spaces.txt"
    echo "spaced" > "$WORK_DIR/f file with spaces.txt"
    run_test "unlink file with spaces" \
        "$GNU_TOOL '$WORK_DIR/gnu file with spaces.txt' && test ! -e '$WORK_DIR/gnu file with spaces.txt' && echo 'REMOVED'" \
        "$F_TOOL '$WORK_DIR/f file with spaces.txt' && test ! -e '$WORK_DIR/f file with spaces.txt' && echo 'REMOVED'"

    # Unlink large file
    dd if=/dev/zero of="$WORK_DIR/gnu_large.bin" bs=1024 count=100 2>/dev/null
    dd if=/dev/zero of="$WORK_DIR/f_large.bin" bs=1024 count=100 2>/dev/null
    run_test "unlink large file" \
        "$GNU_TOOL '$WORK_DIR/gnu_large.bin' && test ! -e '$WORK_DIR/gnu_large.bin' && echo 'REMOVED'" \
        "$F_TOOL '$WORK_DIR/f_large.bin' && test ! -e '$WORK_DIR/f_large.bin' && echo 'REMOVED'"

    # Unlink readonly file (should succeed - depends on directory permissions, not file)
    echo "readonly" > "$WORK_DIR/gnu_ro.txt"
    echo "readonly" > "$WORK_DIR/f_ro.txt"
    chmod 444 "$WORK_DIR/gnu_ro.txt" "$WORK_DIR/f_ro.txt"
    run_test "unlink readonly file" \
        "$GNU_TOOL '$WORK_DIR/gnu_ro.txt' && test ! -e '$WORK_DIR/gnu_ro.txt' && echo 'REMOVED'" \
        "$F_TOOL '$WORK_DIR/f_ro.txt' && test ! -e '$WORK_DIR/f_ro.txt' && echo 'REMOVED'"

    # Verify no unexpected stderr on success
    run_test "stderr clean on success" \
        "echo 'x' > '$WORK_DIR/gnu_clean.txt' && $GNU_TOOL '$WORK_DIR/gnu_clean.txt' 2>&1 && echo 'DONE'" \
        "echo 'x' > '$WORK_DIR/f_clean.txt' && $F_TOOL '$WORK_DIR/f_clean.txt' 2>&1 && echo 'DONE'"

    # Unlink named pipe (FIFO)
    mkfifo "$WORK_DIR/gnu_fifo"
    mkfifo "$WORK_DIR/f_fifo"
    run_test "unlink named pipe" \
        "$GNU_TOOL '$WORK_DIR/gnu_fifo' && test ! -e '$WORK_DIR/gnu_fifo' && echo 'REMOVED'" \
        "$F_TOOL '$WORK_DIR/f_fifo' && test ! -e '$WORK_DIR/f_fifo' && echo 'REMOVED'"

    # Unlink symlink - target file remains intact
    echo "target" > "$WORK_DIR/gnu_sym_target.txt"
    ln -s "$WORK_DIR/gnu_sym_target.txt" "$WORK_DIR/gnu_sym_link"
    echo "target" > "$WORK_DIR/f_sym_target.txt"
    ln -s "$WORK_DIR/f_sym_target.txt" "$WORK_DIR/f_sym_link"
    run_test "unlink symlink - target intact" \
        "$GNU_TOOL '$WORK_DIR/gnu_sym_link' && cat '$WORK_DIR/gnu_sym_target.txt'" \
        "$F_TOOL '$WORK_DIR/f_sym_link' && cat '$WORK_DIR/f_sym_target.txt'"

    echo ""
    echo "=== Error Handling (extended) ==="

    # Unlink in unwritable directory should fail
    mkdir -p "$WORK_DIR/readonly_dir"
    echo "content" > "$WORK_DIR/readonly_dir/gnu_test.txt"
    echo "content" > "$WORK_DIR/readonly_dir/f_test.txt"
    chmod 555 "$WORK_DIR/readonly_dir"
    run_exit_code_test "unlink in unwritable directory" \
        "$GNU_TOOL '$WORK_DIR/readonly_dir/gnu_test.txt' 2>&1" \
        "$F_TOOL '$WORK_DIR/readonly_dir/f_test.txt' 2>&1"
    chmod 755 "$WORK_DIR/readonly_dir"

    # Unlink empty filename should fail
    run_exit_code_test "unlink empty name" \
        "$GNU_TOOL '' 2>&1" \
        "$F_TOOL '' 2>&1"

    # Unlink dot should fail
    run_exit_code_test "unlink dot" \
        "$GNU_TOOL . 2>&1" \
        "$F_TOOL . 2>&1"

    # Unlink dotdot should fail
    run_exit_code_test "unlink dotdot" \
        "$GNU_TOOL .. 2>&1" \
        "$F_TOOL .. 2>&1"

    # --help flag
    run_exit_code_test "help flag" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    # --version flag
    run_exit_code_test "version flag" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    echo ""
    echo "=== Extended Edge Cases ==="

    # Unlink broken symlink (target does not exist)
    ln -sf "/tmp/nonexistent_target_$$" "$WORK_DIR/gnu_broken_sym"
    ln -sf "/tmp/nonexistent_target_$$" "$WORK_DIR/f_broken_sym"
    run_test "unlink broken symlink" \
        "$GNU_TOOL '$WORK_DIR/gnu_broken_sym' && test ! -L '$WORK_DIR/gnu_broken_sym' && echo 'REMOVED'" \
        "$F_TOOL '$WORK_DIR/f_broken_sym' && test ! -L '$WORK_DIR/f_broken_sym' && echo 'REMOVED'"

    # Unlink hard link - verify nlink count decreases
    echo "nlink test" > "$WORK_DIR/gnu_nlink_src.txt"
    ln "$WORK_DIR/gnu_nlink_src.txt" "$WORK_DIR/gnu_nlink_link.txt"
    echo "nlink test" > "$WORK_DIR/f_nlink_src.txt"
    ln "$WORK_DIR/f_nlink_src.txt" "$WORK_DIR/f_nlink_link.txt"
    run_test "unlink decreases nlink count" \
        "$GNU_TOOL '$WORK_DIR/gnu_nlink_link.txt' && (stat -c '%h' '$WORK_DIR/gnu_nlink_src.txt' 2>/dev/null || stat -f '%l' '$WORK_DIR/gnu_nlink_src.txt')" \
        "$F_TOOL '$WORK_DIR/f_nlink_link.txt' && (stat -c '%h' '$WORK_DIR/f_nlink_src.txt' 2>/dev/null || stat -f '%l' '$WORK_DIR/f_nlink_src.txt')"

    # Unlink file with no read permission (should succeed - depends on dir perms)
    echo "noread" > "$WORK_DIR/gnu_noread.txt"
    echo "noread" > "$WORK_DIR/f_noread.txt"
    chmod 000 "$WORK_DIR/gnu_noread.txt" "$WORK_DIR/f_noread.txt"
    run_test "unlink file with no permissions" \
        "$GNU_TOOL '$WORK_DIR/gnu_noread.txt' && test ! -e '$WORK_DIR/gnu_noread.txt' && echo 'REMOVED'" \
        "$F_TOOL '$WORK_DIR/f_noread.txt' && test ! -e '$WORK_DIR/f_noread.txt' && echo 'REMOVED'"

    # Unlink executable file
    echo '#!/bin/sh' > "$WORK_DIR/gnu_exec.sh"
    echo '#!/bin/sh' > "$WORK_DIR/f_exec.sh"
    chmod 755 "$WORK_DIR/gnu_exec.sh" "$WORK_DIR/f_exec.sh"
    run_test "unlink executable file" \
        "$GNU_TOOL '$WORK_DIR/gnu_exec.sh' && test ! -e '$WORK_DIR/gnu_exec.sh' && echo 'REMOVED'" \
        "$F_TOOL '$WORK_DIR/f_exec.sh' && test ! -e '$WORK_DIR/f_exec.sh' && echo 'REMOVED'"

    # Unlink single byte file
    printf 'X' > "$WORK_DIR/gnu_byte.txt"
    printf 'X' > "$WORK_DIR/f_byte.txt"
    run_test "unlink single byte file" \
        "$GNU_TOOL '$WORK_DIR/gnu_byte.txt' && test ! -e '$WORK_DIR/gnu_byte.txt' && echo 'REMOVED'" \
        "$F_TOOL '$WORK_DIR/f_byte.txt' && test ! -e '$WORK_DIR/f_byte.txt' && echo 'REMOVED'"

    # Unlink file in subdirectory
    mkdir -p "$WORK_DIR/sub"
    echo "sub" > "$WORK_DIR/sub/gnu_sub.txt"
    echo "sub" > "$WORK_DIR/sub/f_sub.txt"
    run_test "unlink file in subdirectory" \
        "$GNU_TOOL '$WORK_DIR/sub/gnu_sub.txt' && test ! -e '$WORK_DIR/sub/gnu_sub.txt' && echo 'REMOVED'" \
        "$F_TOOL '$WORK_DIR/sub/f_sub.txt' && test ! -e '$WORK_DIR/sub/f_sub.txt' && echo 'REMOVED'"

    # Unlink with trailing slash should fail (not a directory)
    echo "trailing" > "$WORK_DIR/gnu_trailing.txt"
    echo "trailing" > "$WORK_DIR/f_trailing.txt"
    run_exit_code_test "unlink with trailing slash" \
        "$GNU_TOOL '$WORK_DIR/gnu_trailing.txt/' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_trailing.txt/' 2>&1"

    # Unlink nonexistent path component
    run_exit_code_test "unlink nonexistent parent directory" \
        "$GNU_TOOL '$WORK_DIR/no_such_dir_$$/file.txt' 2>&1" \
        "$F_TOOL '$WORK_DIR/no_such_dir_$$/file.txt' 2>&1"

    # Unlink with no-argument error message check
    run_exit_code_test "no args produces stderr" \
        "$GNU_TOOL 2>&1 | grep -qi 'missing\|operand\|usage\|argument' && echo 'HAS_MSG'" \
        "$F_TOOL 2>&1 | grep -qi 'missing\|operand\|usage\|argument' && echo 'HAS_MSG'"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_unlink_tests
