#!/usr/bin/env bash
# Compatibility tests for frmdir vs GNU rmdir
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "rmdir")
F_TOOL="frmdir"

run_rmdir_tests() {
    init_test_suite "rmdir"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"rmdir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/rmdir_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU rmdir not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_rmdir_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic Empty Directory Removal ==="

    run_test "remove empty directory" \
        "mkdir '$WORK_DIR/gnu_empty' && $GNU_TOOL '$WORK_DIR/gnu_empty' && test ! -d '$WORK_DIR/gnu_empty' && echo 'REMOVED'" \
        "mkdir '$WORK_DIR/f_empty' && $F_TOOL '$WORK_DIR/f_empty' && test ! -d '$WORK_DIR/f_empty' && echo 'REMOVED'"

    run_test "remove multiple empty directories" \
        "mkdir '$WORK_DIR/gnu_m1' '$WORK_DIR/gnu_m2' '$WORK_DIR/gnu_m3' && $GNU_TOOL '$WORK_DIR/gnu_m1' '$WORK_DIR/gnu_m2' '$WORK_DIR/gnu_m3' && echo 'ALL_REMOVED'" \
        "mkdir '$WORK_DIR/f_m1' '$WORK_DIR/f_m2' '$WORK_DIR/f_m3' && $F_TOOL '$WORK_DIR/f_m1' '$WORK_DIR/f_m2' '$WORK_DIR/f_m3' && echo 'ALL_REMOVED'"

    echo ""
    echo "=== Parents (-p) ==="

    run_test "-p remove parent chain" \
        "mkdir -p '$WORK_DIR/gnu_chain/b/c' && $GNU_TOOL -p '$WORK_DIR/gnu_chain/b/c' && test ! -d '$WORK_DIR/gnu_chain' && echo 'CHAIN_REMOVED'" \
        "mkdir -p '$WORK_DIR/f_chain/b/c' && $F_TOOL -p '$WORK_DIR/f_chain/b/c' && test ! -d '$WORK_DIR/f_chain' && echo 'CHAIN_REMOVED'"

    run_test "-p deep chain" \
        "mkdir -p '$WORK_DIR/gnu_deep/a/b/c/d' && $GNU_TOOL -p '$WORK_DIR/gnu_deep/a/b/c/d' && test ! -d '$WORK_DIR/gnu_deep' && echo 'DEEP_REMOVED'" \
        "mkdir -p '$WORK_DIR/f_deep/a/b/c/d' && $F_TOOL -p '$WORK_DIR/f_deep/a/b/c/d' && test ! -d '$WORK_DIR/f_deep' && echo 'DEEP_REMOVED'"

    echo ""
    echo "=== Verbose (--verbose) ==="

    run_stdout_test "--verbose remove" \
        "mkdir '$WORK_DIR/gnu_verb' && $GNU_TOOL --verbose '$WORK_DIR/gnu_verb'" \
        "mkdir '$WORK_DIR/f_verb' && $F_TOOL --verbose '$WORK_DIR/f_verb'"

    echo ""
    echo "=== Ignore Non-Empty (--ignore-fail-on-non-empty) ==="

    run_test "--ignore-fail-on-non-empty" \
        "mkdir -p '$WORK_DIR/gnu_nonempty' && echo 'x' > '$WORK_DIR/gnu_nonempty/file.txt' && $GNU_TOOL --ignore-fail-on-non-empty '$WORK_DIR/gnu_nonempty' 2>/dev/null; test -d '$WORK_DIR/gnu_nonempty' && echo 'STILL_EXISTS'" \
        "mkdir -p '$WORK_DIR/f_nonempty' && echo 'x' > '$WORK_DIR/f_nonempty/file.txt' && $F_TOOL --ignore-fail-on-non-empty '$WORK_DIR/f_nonempty' 2>/dev/null; test -d '$WORK_DIR/f_nonempty' && echo 'STILL_EXISTS'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "non-empty directory" \
        "mkdir -p '$WORK_DIR/gnu_ne' && echo 'x' > '$WORK_DIR/gnu_ne/f.txt' && $GNU_TOOL '$WORK_DIR/gnu_ne' 2>&1" \
        "mkdir -p '$WORK_DIR/f_ne' && echo 'x' > '$WORK_DIR/f_ne/f.txt' && $F_TOOL '$WORK_DIR/f_ne' 2>&1"

    run_exit_code_test "nonexistent directory" \
        "$GNU_TOOL '$WORK_DIR/nonexistent_$$' 2>&1" \
        "$F_TOOL '$WORK_DIR/nonexistent_$$' 2>&1"

    run_exit_code_test "remove file (not directory)" \
        "echo 'x' > '$WORK_DIR/gnu_file.txt' && $GNU_TOOL '$WORK_DIR/gnu_file.txt' 2>&1" \
        "echo 'x' > '$WORK_DIR/f_file.txt' && $F_TOOL '$WORK_DIR/f_file.txt' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "directory with trailing slash" \
        "mkdir '$WORK_DIR/gnu_trail' && $GNU_TOOL '$WORK_DIR/gnu_trail/' && test ! -d '$WORK_DIR/gnu_trail' && echo 'REMOVED'" \
        "mkdir '$WORK_DIR/f_trail' && $F_TOOL '$WORK_DIR/f_trail/' && test ! -d '$WORK_DIR/f_trail' && echo 'REMOVED'"

    run_test "directory name with spaces" \
        "mkdir '$WORK_DIR/gnu dir space' && $GNU_TOOL '$WORK_DIR/gnu dir space' && test ! -d '$WORK_DIR/gnu dir space' && echo 'REMOVED'" \
        "mkdir '$WORK_DIR/f dir space' && $F_TOOL '$WORK_DIR/f dir space' && test ! -d '$WORK_DIR/f dir space' && echo 'REMOVED'"

    # === GNU Upstream: Trailing Slash with -p ===
    echo ""
    echo "=== GNU Upstream: Trailing Slash with -p ==="

    # From t-slash.sh: rmdir -p with trailing slash
    run_test "-p dir/ with trailing slash" \
        "mkdir -p '$WORK_DIR/gnu_tslash/inner' && $GNU_TOOL -p '$WORK_DIR/gnu_tslash/inner/' && test ! -d '$WORK_DIR/gnu_tslash' && echo 'REMOVED'" \
        "mkdir -p '$WORK_DIR/f_tslash/inner' && $F_TOOL -p '$WORK_DIR/f_tslash/inner/' && test ! -d '$WORK_DIR/f_tslash' && echo 'REMOVED'"

    # === GNU Upstream: Permission Failure with -p ===
    echo ""
    echo "=== GNU Upstream: Permission Failure with -p ==="

    # From fail-perm.sh: rmdir -p on unwritable parent should fail
    if [[ "$(id -u)" -ne 0 ]]; then
        mkdir -p "$WORK_DIR/gnu_perm/e/f" "$WORK_DIR/f_perm/e/f"
        chmod a-w "$WORK_DIR/gnu_perm" "$WORK_DIR/f_perm"

        run_exit_code_test "-p with unwritable parent" \
            "$GNU_TOOL -p '$WORK_DIR/gnu_perm/e/f' 2>&1" \
            "$F_TOOL -p '$WORK_DIR/f_perm/e/f' 2>&1"

        # Restore permissions for cleanup
        chmod a+w "$WORK_DIR/gnu_perm" "$WORK_DIR/f_perm" 2>/dev/null || true
    fi

    # === GNU Upstream: Ignore on Non-Empty with -p ===
    echo ""
    echo "=== GNU Upstream: Ignore on Non-Empty with -p ==="

    # From ignore.sh: -p --ignore-fail-on-non-empty removes what it can
    mkdir -p "$WORK_DIR/gnu_ign/b/c" "$WORK_DIR/gnu_ign/x"
    mkdir -p "$WORK_DIR/f_ign/b/c" "$WORK_DIR/f_ign/x"

    run_test "-p --ignore-fail-on-non-empty stops at non-empty" \
        "$GNU_TOOL -p --ignore-fail-on-non-empty '$WORK_DIR/gnu_ign/b/c' && test -d '$WORK_DIR/gnu_ign/x' && test ! -d '$WORK_DIR/gnu_ign/b' && echo 'PARTIAL_REMOVED'" \
        "$F_TOOL -p --ignore-fail-on-non-empty '$WORK_DIR/f_ign/b/c' && test -d '$WORK_DIR/f_ign/x' && test ! -d '$WORK_DIR/f_ign/b' && echo 'PARTIAL_REMOVED'"

    # === GNU Upstream: Symlink Errors ===
    echo ""
    echo "=== GNU Upstream: Symlink Errors ==="

    # From symlink-errors.sh: rmdir on symlink to file with trailing slash
    mkdir -p "$WORK_DIR/gnu_sldir" "$WORK_DIR/f_sldir"
    touch "$WORK_DIR/gnu_sldir/file" "$WORK_DIR/f_sldir/file"
    ln -sf "$WORK_DIR/gnu_sldir/file" "$WORK_DIR/gnu_sldir/fl"
    ln -sf "$WORK_DIR/f_sldir/file" "$WORK_DIR/f_sldir/fl"

    run_exit_code_test "rmdir on file symlink/" \
        "$GNU_TOOL '$WORK_DIR/gnu_sldir/fl/' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_sldir/fl/' 2>&1"

    # rmdir -p through symlink to dir
    mkdir -p "$WORK_DIR/gnu_sldir/realdir/dir2" "$WORK_DIR/f_sldir/realdir/dir2"
    ln -sf "$WORK_DIR/gnu_sldir/realdir" "$WORK_DIR/gnu_sldir/sl"
    ln -sf "$WORK_DIR/f_sldir/realdir" "$WORK_DIR/f_sldir/sl"

    run_exit_code_test "-p through symlink to dir" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_sldir/sl/dir2' 2>&1" \
        "$F_TOOL -p '$WORK_DIR/f_sldir/sl/dir2' 2>&1"

    # === GNU Upstream: Dangling Symlink Errors ===
    echo ""
    echo "=== GNU Upstream: Dangling Symlink Errors ==="

    # From symlink-errors.sh: rmdir on dangling symlink with trailing slash
    mkdir -p "$WORK_DIR/gnu_dangle" "$WORK_DIR/f_dangle"
    ln -sf "$WORK_DIR/gnu_dangle/missing_target" "$WORK_DIR/gnu_dangle/dl"
    ln -sf "$WORK_DIR/f_dangle/missing_target" "$WORK_DIR/f_dangle/dl"

    run_exit_code_test "rmdir on dangling symlink/" \
        "$GNU_TOOL '$WORK_DIR/gnu_dangle/dl/' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_dangle/dl/' 2>&1"

    # === GNU Upstream: --ignore-fail-on-non-empty with Permission Errors ===
    echo ""
    echo "=== GNU Upstream: --ignore-fail-on-non-empty with Permission Errors ==="

    # From ignore.sh: --ignore-fail-on-non-empty on unwritable parent (EPERM)
    # Should still fail because the error is not "non-empty" but "permission denied"
    if [[ "$(id -u)" -ne 0 ]]; then
        mkdir -p "$WORK_DIR/gnu_ign_perm/y" "$WORK_DIR/f_ign_perm/y"
        chmod a-w "$WORK_DIR/gnu_ign_perm" "$WORK_DIR/f_ign_perm"

        run_exit_code_test "--ignore-fail-on-non-empty with EPERM" \
            "$GNU_TOOL --ignore-fail-on-non-empty '$WORK_DIR/gnu_ign_perm/y' 2>&1" \
            "$F_TOOL --ignore-fail-on-non-empty '$WORK_DIR/f_ign_perm/y' 2>&1"

        # Restore permissions for cleanup
        chmod a+w "$WORK_DIR/gnu_ign_perm" "$WORK_DIR/f_ign_perm" 2>/dev/null || true
    fi

    # From ignore.sh: --ignore-fail-on-non-empty on non-empty dir succeeds silently
    mkdir -p "$WORK_DIR/gnu_ign_ne2" "$WORK_DIR/f_ign_ne2"
    touch "$WORK_DIR/gnu_ign_ne2/z" "$WORK_DIR/f_ign_ne2/z"

    run_test "--ignore-fail-on-non-empty on non-empty succeeds" \
        "$GNU_TOOL --ignore-fail-on-non-empty '$WORK_DIR/gnu_ign_ne2' && test -d '$WORK_DIR/gnu_ign_ne2' && echo STILL_THERE" \
        "$F_TOOL --ignore-fail-on-non-empty '$WORK_DIR/f_ign_ne2' && test -d '$WORK_DIR/f_ign_ne2' && echo STILL_THERE"

    # === GNU Upstream: Multiple Args with -p ===
    echo ""
    echo "=== GNU Upstream: Multiple Args with -p ==="

    # From fail-perm.sh: rmdir -p with multiple args including unwritable
    if [[ "$(id -u)" -ne 0 ]]; then
        mkdir -p "$WORK_DIR/gnu_mp/e/f" "$WORK_DIR/f_mp/e/f"
        chmod a-w "$WORK_DIR/gnu_mp" "$WORK_DIR/f_mp"

        run_exit_code_test "-p d d/e/f with unwritable d" \
            "$GNU_TOOL -p '$WORK_DIR/gnu_mp' '$WORK_DIR/gnu_mp/e/f' 2>&1" \
            "$F_TOOL -p '$WORK_DIR/f_mp' '$WORK_DIR/f_mp/e/f' 2>&1"

        chmod a+w "$WORK_DIR/gnu_mp" "$WORK_DIR/f_mp" 2>/dev/null || true
    fi

    # Clean up
    rm -rf "$WORK_DIR"


    finish_test_suite
}

run_rmdir_tests
