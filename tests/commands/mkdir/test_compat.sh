#!/usr/bin/env bash
# Compatibility tests for fmkdir vs GNU mkdir
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "mkdir")
F_TOOL="fmkdir"

run_mkdir_tests() {
    init_test_suite "mkdir"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mkdir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mkdir_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU mkdir not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_mkdir_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic Directory Creation ==="

    run_test "create single directory" \
        "$GNU_TOOL '$WORK_DIR/gnu_dir1' && test -d '$WORK_DIR/gnu_dir1' && echo 'IS_DIR'" \
        "$F_TOOL '$WORK_DIR/f_dir1' && test -d '$WORK_DIR/f_dir1' && echo 'IS_DIR'"

    run_test "create multiple directories" \
        "$GNU_TOOL '$WORK_DIR/gnu_d1' '$WORK_DIR/gnu_d2' '$WORK_DIR/gnu_d3' && ls -d '$WORK_DIR'/gnu_d* | wc -l" \
        "$F_TOOL '$WORK_DIR/f_d1' '$WORK_DIR/f_d2' '$WORK_DIR/f_d3' && ls -d '$WORK_DIR'/f_d* | wc -l"

    echo ""
    echo "=== Parent Directories (-p) ==="

    run_test "-p create parent chain" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_deep/level2/level3' && test -d '$WORK_DIR/gnu_deep/level2/level3' && echo 'DEEP_OK'" \
        "$F_TOOL -p '$WORK_DIR/f_deep/level2/level3' && test -d '$WORK_DIR/f_deep/level2/level3' && echo 'DEEP_OK'"

    run_test "-p existing directory (no error)" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_dir1' && echo 'OK'" \
        "$F_TOOL -p '$WORK_DIR/f_dir1' && echo 'OK'"

    run_test "-p deeply nested" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_nest/a/b/c/d/e/f' && test -d '$WORK_DIR/gnu_nest/a/b/c/d/e/f' && echo 'NESTED_OK'" \
        "$F_TOOL -p '$WORK_DIR/f_nest/a/b/c/d/e/f' && test -d '$WORK_DIR/f_nest/a/b/c/d/e/f' && echo 'NESTED_OK'"

    echo ""
    echo "=== Mode (-m) ==="

    run_test "-m 755" \
        "$GNU_TOOL -m 755 '$WORK_DIR/gnu_m755' && stat -c '%a' '$WORK_DIR/gnu_m755'" \
        "$F_TOOL -m 755 '$WORK_DIR/f_m755' && stat -c '%a' '$WORK_DIR/f_m755'"

    run_test "-m 700" \
        "$GNU_TOOL -m 700 '$WORK_DIR/gnu_m700' && stat -c '%a' '$WORK_DIR/gnu_m700'" \
        "$F_TOOL -m 700 '$WORK_DIR/f_m700' && stat -c '%a' '$WORK_DIR/f_m700'"

    run_test "-m 777" \
        "$GNU_TOOL -m 777 '$WORK_DIR/gnu_m777' && stat -c '%a' '$WORK_DIR/gnu_m777'" \
        "$F_TOOL -m 777 '$WORK_DIR/f_m777' && stat -c '%a' '$WORK_DIR/f_m777'"

    run_test "-m 000" \
        "$GNU_TOOL -m 000 '$WORK_DIR/gnu_m000' && stat -c '%a' '$WORK_DIR/gnu_m000'" \
        "$F_TOOL -m 000 '$WORK_DIR/f_m000' && stat -c '%a' '$WORK_DIR/f_m000'"

    echo ""
    echo "=== Verbose (-v) ==="

    # Normalize directory names in verbose output to avoid false diff on gnu_/f_ prefix
    run_test "-v create directory" \
        "$GNU_TOOL -v '$WORK_DIR/gnu_verbose_dir' 2>&1 | sed 's|gnu_verbose_dir|_verbose_dir|g'" \
        "$F_TOOL -v '$WORK_DIR/f_verbose_dir' 2>&1 | sed 's|f_verbose_dir|_verbose_dir|g'"

    run_test "-pv create nested" \
        "$GNU_TOOL -pv '$WORK_DIR/gnu_vp/sub1/sub2' 2>&1 | sed 's|gnu_vp|_vp|g'" \
        "$F_TOOL -pv '$WORK_DIR/f_vp/sub1/sub2' 2>&1 | sed 's|f_vp|_vp|g'"

    # === GNU Upstream: Basic -p (p-1.sh) ===
    echo ""
    echo "=== GNU Upstream: Basic -p ==="

    # From p-1.sh: mkdir --parents with absolute path
    run_test "GNU: mkdir --parents with absolute path" \
        "$GNU_TOOL --parents '$WORK_DIR/gnu_p1_t' && test -d '$WORK_DIR/gnu_p1_t' && echo OK" \
        "$F_TOOL --parents '$WORK_DIR/f_p1_t' && test -d '$WORK_DIR/f_p1_t' && echo OK"

    # From p-2.sh: mkdir --parents with deeper absolute path
    run_test "GNU: mkdir --parents with nested absolute path" \
        "$GNU_TOOL --parents '$WORK_DIR/gnu_p2_t/u' && test -d '$WORK_DIR/gnu_p2_t/u' && echo OK" \
        "$F_TOOL --parents '$WORK_DIR/f_p2_t/u' && test -d '$WORK_DIR/f_p2_t/u' && echo OK"

    # === GNU Upstream: Verbose -pv (p-v.sh) ===
    echo ""
    echo "=== GNU Upstream: Verbose -pv ==="

    # From p-v.sh: mkdir -pv outputs created directory messages
    run_test "GNU: mkdir -pv outputs messages for each dir" \
        "$GNU_TOOL -pv '$WORK_DIR/gnu_pv/a/b/c/d' 2>&1 | wc -l" \
        "$F_TOOL -pv '$WORK_DIR/f_pv/a/b/c/d' 2>&1 | wc -l"

    # === GNU Upstream: Trailing Slash (t-slash.sh) ===
    echo ""
    echo "=== GNU Upstream: Trailing Slash ==="

    # From t-slash.sh: mkdir -p dir/ works
    run_test "GNU: mkdir -p with trailing slash" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_tslash/' && test -d '$WORK_DIR/gnu_tslash' && echo OK" \
        "$F_TOOL -p '$WORK_DIR/f_tslash/' && test -d '$WORK_DIR/f_tslash' && echo OK"

    # From t-slash.sh: mkdir d2/ (without -p)
    run_test "GNU: mkdir with trailing slash (no -p)" \
        "$GNU_TOOL '$WORK_DIR/gnu_tslash2/' && test -d '$WORK_DIR/gnu_tslash2' && echo OK" \
        "$F_TOOL '$WORK_DIR/f_tslash2/' && test -d '$WORK_DIR/f_tslash2' && echo OK"

    # === GNU Upstream: Special Bits (special-1.sh) ===
    echo ""
    echo "=== GNU Upstream: Special Bits ==="

    # From special-1.sh: mkdir with sticky bit mode
    run_test "GNU: mkdir -m with sticky bit" \
        "$GNU_TOOL -m 'u=rwx,g=rx,o=w,-s,+t' '$WORK_DIR/gnu_sticky' && stat -c '%a' '$WORK_DIR/gnu_sticky'" \
        "$F_TOOL -m 'u=rwx,g=rx,o=w,-s,+t' '$WORK_DIR/f_sticky' && stat -c '%a' '$WORK_DIR/f_sticky'"

    # From special-1.sh: mkdir without parent should fail for nested path
    run_exit_code_test "GNU: mkdir fails for nested without -p" \
        "$GNU_TOOL -m 'u=rwx,g=rx,o=w,-s,+t' '$WORK_DIR/gnu_noparent_sp/sub' 2>&1" \
        "$F_TOOL -m 'u=rwx,g=rx,o=w,-s,+t' '$WORK_DIR/f_noparent_sp/sub' 2>&1"

    # From special-1.sh: mkdir --parents with mode creates leaf with specified mode
    run_test "GNU: mkdir --parents -m creates leaf with mode" \
        "$GNU_TOOL --parents -m 'u=rwx,g=rx,o=w,-s,+t' '$WORK_DIR/gnu_sp_parent/sub' && stat -c '%a' '$WORK_DIR/gnu_sp_parent/sub'" \
        "$F_TOOL --parents -m 'u=rwx,g=rx,o=w,-s,+t' '$WORK_DIR/f_sp_parent/sub' && stat -c '%a' '$WORK_DIR/f_sp_parent/sub'"

    # === GNU Upstream: Slash-Dot (p-slashdot.sh) ===
    echo ""
    echo "=== GNU Upstream: Slash-Dot ==="

    # From p-slashdot.sh: mkdir -p d1/.
    run_test "GNU: mkdir -p d1/." \
        "$GNU_TOOL -p '$WORK_DIR/gnu_sd1/.' && test -d '$WORK_DIR/gnu_sd1' && echo OK" \
        "$F_TOOL -p '$WORK_DIR/f_sd1/.' && test -d '$WORK_DIR/f_sd1' && echo OK"

    # From p-slashdot.sh: mkdir -p d2/..
    run_test "GNU: mkdir -p d2/.." \
        "$GNU_TOOL -p '$WORK_DIR/gnu_sd2/..' && test -d '$WORK_DIR/gnu_sd2' && echo OK" \
        "$F_TOOL -p '$WORK_DIR/f_sd2/..' && test -d '$WORK_DIR/f_sd2' && echo OK"

    # === GNU Upstream: Through Symlink (p-thru-slink.sh) ===
    echo ""
    echo "=== GNU Upstream: Through Symlink ==="

    # From p-thru-slink.sh: mkdir -p through symlink to directory
    mkdir -p "$WORK_DIR/gnu_slink_real" "$WORK_DIR/f_slink_real"
    ln -s "$WORK_DIR/gnu_slink_real" "$WORK_DIR/gnu_slink_link"
    ln -s "$WORK_DIR/f_slink_real" "$WORK_DIR/f_slink_link"

    run_test "GNU: mkdir -p through symlink to dir" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_slink_link/child' && test -d '$WORK_DIR/gnu_slink_real/child' && echo OK" \
        "$F_TOOL -p '$WORK_DIR/f_slink_link/child' && test -d '$WORK_DIR/f_slink_real/child' && echo OK"

    # === GNU Upstream: Parents Existing Dir (parents.sh) ===
    echo ""
    echo "=== GNU Upstream: Parents Existing Dir ==="

    # From parents.sh: mkdir -p on existing dir succeeds
    $GNU_TOOL -m 700 "$WORK_DIR/gnu_edir" 2>/dev/null
    $F_TOOL -m 700 "$WORK_DIR/f_edir" 2>/dev/null

    run_test "GNU: mkdir -p existing dir succeeds" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_edir' && echo OK" \
        "$F_TOOL -p '$WORK_DIR/f_edir' && echo OK"

    # From parents.sh: mkdir (no -p) on existing dir fails
    run_exit_code_test "GNU: mkdir existing dir without -p fails" \
        "$GNU_TOOL '$WORK_DIR/gnu_edir' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_edir' 2>&1"

    # === GNU Upstream: Permission with -p -m (parents.sh) ===
    echo ""
    echo "=== GNU Upstream: Permission with -p -m ==="

    # From parents.sh: mkdir -p -m does not change permissions of existing parent
    # Create parent dir with mode 755 first, then mkdir -p -m 700 parent/child
    # parent should keep 755, child should get 700
    run_test "GNU: mkdir -p -m does not change existing parent perms" \
        "$GNU_TOOL -m 755 '$WORK_DIR/gnu_perm_parent' && $GNU_TOOL -p -m 700 '$WORK_DIR/gnu_perm_parent/child' && stat -c '%a' '$WORK_DIR/gnu_perm_parent'" \
        "$F_TOOL -m 755 '$WORK_DIR/f_perm_parent' && $F_TOOL -p -m 700 '$WORK_DIR/f_perm_parent/child' && stat -c '%a' '$WORK_DIR/f_perm_parent'"

    run_test "GNU: mkdir -p -m leaf dir gets specified mode" \
        "stat -c '%a' '$WORK_DIR/gnu_perm_parent/child'" \
        "stat -c '%a' '$WORK_DIR/f_perm_parent/child'"

    # === GNU Upstream: Mode with Umask (perm.sh) ===
    echo ""
    echo "=== GNU Upstream: Mode with Umask ==="

    # From perm.sh: mkdir -m with specific mode under various umasks
    run_test "GNU: mkdir -m 016 under umask 000" \
        "(umask 000 && $GNU_TOOL -m 016 '$WORK_DIR/gnu_perm016' && stat -c '%a' '$WORK_DIR/gnu_perm016')" \
        "(umask 000 && $F_TOOL -m 016 '$WORK_DIR/f_perm016' && stat -c '%a' '$WORK_DIR/f_perm016')"

    run_test "GNU: mkdir -m 312 under umask 050" \
        "(umask 050 && $GNU_TOOL -m 312 '$WORK_DIR/gnu_perm312' && stat -c '%a' '$WORK_DIR/gnu_perm312')" \
        "(umask 050 && $F_TOOL -m 312 '$WORK_DIR/f_perm312' && stat -c '%a' '$WORK_DIR/f_perm312')"

    run_test "GNU: mkdir -m 743 under umask 160" \
        "(umask 160 && $GNU_TOOL -m 743 '$WORK_DIR/gnu_perm743' && stat -c '%a' '$WORK_DIR/gnu_perm743')" \
        "(umask 160 && $F_TOOL -m 743 '$WORK_DIR/f_perm743' && stat -c '%a' '$WORK_DIR/f_perm743')"

    # From perm.sh: mkdir -p -m with parent chain under umask
    # intermediate dirs should get umask-based perms, leaf gets -m perms
    run_test "GNU: mkdir -p -m 700 intermediate dirs respect umask" \
        "(umask 077 && $GNU_TOOL -p -m 700 '$WORK_DIR/gnu_pumask/sub/leaf' && stat -c '%a' '$WORK_DIR/gnu_pumask/sub/leaf')" \
        "(umask 077 && $F_TOOL -p -m 700 '$WORK_DIR/f_pumask/sub/leaf' && stat -c '%a' '$WORK_DIR/f_pumask/sub/leaf')"

    # From perm.sh: relative mode 'o-w' under umask 022
    run_test "GNU: mkdir -m o-w relative mode" \
        "(umask 022 && $GNU_TOOL -m 'o-w' '$WORK_DIR/gnu_relmode' && stat -c '%a' '$WORK_DIR/gnu_relmode')" \
        "(umask 022 && $F_TOOL -m 'o-w' '$WORK_DIR/f_relmode' && stat -c '%a' '$WORK_DIR/f_relmode')"

    # === GNU Upstream: Skipped Tests ===
    echo ""
    echo "=== GNU Upstream: Skipped Tests ==="

    # p-acl.sh: skipped (requires setfacl)
    skip_test "mkdir -p with default ACLs" "Requires setfacl"

    # selinux.sh: skipped (requires SELinux)
    skip_test "mkdir -Z with SELinux" "Requires SELinux"

    # restorecon.sh: skipped (requires SELinux restorecon)
    skip_test "mkdir -Z restorecon" "Requires SELinux restorecon"

    # smack-root.sh: skipped (requires SMACK and root)
    skip_test "mkdir --context with SMACK" "Requires SMACK and root access"

    # smack-no-root.sh: skipped (requires SMACK)
    skip_test "mkdir --context SMACK no-root" "Requires SMACK"

    # writable-under-readonly.sh: skipped (requires root and loopback mounts)
    skip_test "mkdir -p under read-only mount" "Requires root and loopback mounts"

    # p-3.sh: skipped (requires root for chmod 0 tests)
    skip_test "mkdir -p with inaccessible parent" "Requires root for chmod 0 directory tests"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "existing directory (no -p)" \
        "$GNU_TOOL '$WORK_DIR/gnu_dir1' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_dir1' 2>&1"

    run_exit_code_test "no parent without -p" \
        "$GNU_TOOL '$WORK_DIR/gnu_noparent/child' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_noparent/child' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "directory name with spaces" \
        "$GNU_TOOL '$WORK_DIR/gnu dir with spaces' && test -d '$WORK_DIR/gnu dir with spaces' && echo 'SPACE_OK'" \
        "$F_TOOL '$WORK_DIR/f dir with spaces' && test -d '$WORK_DIR/f dir with spaces' && echo 'SPACE_OK'"

    run_test "-p with trailing slash" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_trailing/' && test -d '$WORK_DIR/gnu_trailing' && echo 'TRAIL_OK'" \
        "$F_TOOL -p '$WORK_DIR/f_trailing/' && test -d '$WORK_DIR/f_trailing' && echo 'TRAIL_OK'"

    run_test "-p with multiple slashes" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_multi///slashes' && test -d '$WORK_DIR/gnu_multi/slashes' && echo 'MULTI_OK'" \
        "$F_TOOL -p '$WORK_DIR/f_multi///slashes' && test -d '$WORK_DIR/f_multi/slashes' && echo 'MULTI_OK'"

    # Clean up
    rm -rf "$WORK_DIR"


    finish_test_suite
}

run_mkdir_tests
