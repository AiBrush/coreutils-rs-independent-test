#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fmv"
run_mv_functional_tests() {
    init_test_suite "mv"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mv","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mv_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent source fails" "$F_TOOL /tmp/nonexistent_file_functional_test /tmp/dest_$$ 2>/dev/null" 1

    local tdir="/tmp/fcoreutils_mv_func_$$"
    mkdir -p "$tdir"

    # Basic move
    printf "hello" > "$tdir/src1"
    run_expected_exit_test "basic move" "$F_TOOL $tdir/src1 $tdir/dst1" 0

    # Move to directory
    mkdir -p "$tdir/destdir"
    printf "todir" > "$tdir/src2"
    run_expected_exit_test "move to directory" "$F_TOOL $tdir/src2 $tdir/destdir/" 0

    # Rename
    printf "rename" > "$tdir/oldname"
    run_expected_exit_test "rename file" "$F_TOOL $tdir/oldname $tdir/newname" 0

    # No clobber
    printf "existing" > "$tdir/noclobber_dst"
    printf "new" > "$tdir/noclobber_src"
    run_expected_exit_test "no clobber -n" "$F_TOOL -n $tdir/noclobber_src $tdir/noclobber_dst" 0

    # Verbose
    printf "vdata" > "$tdir/vsrc"
    run_expected_exit_test "verbose -v" "$F_TOOL -v $tdir/vsrc $tdir/vdst 2>/dev/null" 0

    # Force
    printf "fdata" > "$tdir/fsrc"
    printf "fexist" > "$tdir/fdst"
    run_expected_exit_test "force -f" "$F_TOOL -f $tdir/fsrc $tdir/fdst" 0

    # Move directory
    mkdir -p "$tdir/srcdir/sub"
    printf "x" > "$tdir/srcdir/sub/file"
    run_expected_exit_test "move directory" "$F_TOOL $tdir/srcdir $tdir/moveddir" 0

    # Move empty directory
    mkdir -p "$tdir/emptydir"
    run_expected_exit_test "move empty directory" "$F_TOOL $tdir/emptydir $tdir/emptydir_moved" 0

    # Backup
    printf "orig" > "$tdir/backup_dst"
    printf "new" > "$tdir/backup_src"
    run_expected_exit_test "backup -b" "$F_TOOL -b $tdir/backup_src $tdir/backup_dst" 0

    # Target directory -t
    mkdir -p "$tdir/targetdir"
    printf "td" > "$tdir/tdsrc"
    run_expected_exit_test "target directory -t" "$F_TOOL -t $tdir/targetdir $tdir/tdsrc" 0

    # No target directory -T
    mkdir -p "$tdir/notsrc"
    run_expected_exit_test "no target directory -T" "$F_TOOL -T $tdir/notsrc $tdir/notrenamed" 0

    # Hidden files
    printf "hidden" > "$tdir/.hidden_src"
    run_expected_exit_test "move hidden file" "$F_TOOL $tdir/.hidden_src $tdir/.hidden_dst" 0

    # Special chars in filename
    printf "sp" > "$tdir/file with spaces"
    run_expected_exit_test "special chars in filename" "$F_TOOL '$tdir/file with spaces' '$tdir/moved spaces'" 0

    # Multiple files to non-dir should fail
    printf "a" > "$tdir/multi_a"
    printf "b" > "$tdir/multi_b"
    printf "c" > "$tdir/multi_c"
    run_expected_exit_test "multiple files to non-dir fails" "$F_TOOL $tdir/multi_a $tdir/multi_b $tdir/multi_c 2>/dev/null" 1

    # --help should succeed
    run_expected_exit_test "--help exits 0" "$F_TOOL --help >/dev/null 2>&1" 0

    # --version should succeed
    run_expected_exit_test "--version exits 0" "$F_TOOL --version >/dev/null 2>&1" 0

    rm -rf "$tdir"
    finish_test_suite
}
run_mv_functional_tests
