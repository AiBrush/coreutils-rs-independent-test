#!/usr/bin/env bash
# Compatibility tests for fmv vs GNU mv
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "mv")
F_TOOL="fmv"

run_mv_tests() {
    init_test_suite "mv"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mv","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mv_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU mv not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_mv_XXXXXX)
    register_temp "$test_dir"

    # === Section 1: Simple Move ===
    echo ""
    echo "=== Simple Move ==="

    echo "move me" > "$test_dir/gnu_src1"
    echo "move me" > "$test_dir/f_src1"

    $GNU_TOOL "$test_dir/gnu_src1" "$test_dir/gnu_dest1"
    $F_TOOL "$test_dir/f_src1" "$test_dir/f_dest1"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -f "$test_dir/gnu_src1" ]] && [[ ! -f "$test_dir/f_src1" ]] && \
       diff "$test_dir/gnu_dest1" "$test_dir/f_dest1" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: simple move (source gone, dest matches)"
        record_result "simple move" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: simple move failed"
        record_result "simple move" "FAIL" "source still exists or dest differs" "" ""
    fi

    # === Section 2: Rename ===
    echo ""
    echo "=== Rename ==="

    echo "rename me" > "$test_dir/gnu_oldname"
    echo "rename me" > "$test_dir/f_oldname"

    $GNU_TOOL "$test_dir/gnu_oldname" "$test_dir/gnu_newname"
    $F_TOOL "$test_dir/f_oldname" "$test_dir/f_newname"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -f "$test_dir/gnu_oldname" ]] && [[ ! -f "$test_dir/f_oldname" ]] && \
       [[ -f "$test_dir/gnu_newname" ]] && [[ -f "$test_dir/f_newname" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: rename (old gone, new exists)"
        record_result "rename" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: rename failed"
        record_result "rename" "FAIL" "rename behavior differs" "" ""
    fi

    # === Section 3: Move to Directory ===
    echo ""
    echo "=== Move to Directory ==="

    mkdir -p "$test_dir/gnu_target_dir" "$test_dir/f_target_dir"
    echo "to dir" > "$test_dir/gnu_todir"
    echo "to dir" > "$test_dir/f_todir"

    $GNU_TOOL "$test_dir/gnu_todir" "$test_dir/gnu_target_dir/"
    $F_TOOL "$test_dir/f_todir" "$test_dir/f_target_dir/"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$test_dir/gnu_target_dir/gnu_todir" ]] && [[ -f "$test_dir/f_target_dir/f_todir" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: move to directory"
        record_result "move to directory" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: move to directory failed"
        record_result "move to directory" "FAIL" "file not in target dir" "" ""
    fi

    # === Section 4: No Clobber (-n) ===
    echo ""
    echo "=== No Clobber (-n) ==="

    echo "existing" > "$test_dir/gnu_existing"
    echo "existing" > "$test_dir/f_existing"
    echo "new src" > "$test_dir/gnu_nc_src"
    echo "new src" > "$test_dir/f_nc_src"

    $GNU_TOOL -n "$test_dir/gnu_nc_src" "$test_dir/gnu_existing"
    $F_TOOL -n "$test_dir/f_nc_src" "$test_dir/f_existing"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_existing" "$test_dir/f_existing" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -n doesn't overwrite"
        record_result "no clobber" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -n behavior differs"
        record_result "no clobber" "FAIL" "overwrite behavior differs" "" ""
    fi

    # === Section 5: Verbose (-v) ===
    echo ""
    echo "=== Verbose (-v) ==="

    echo "verbose" > "$test_dir/gnu_v_src"
    echo "verbose" > "$test_dir/f_v_src"

    run_exit_code_test "mv -v exit code" \
        "$GNU_TOOL -v '$test_dir/gnu_v_src' '$test_dir/gnu_v_dest' 2>&1" \
        "$F_TOOL -v '$test_dir/f_v_src' '$test_dir/f_v_dest' 2>&1"

    # === Section 6: Backup (--backup) ===
    echo ""
    echo "=== Backup ==="

    echo "original" > "$test_dir/gnu_backup_target"
    echo "original" > "$test_dir/f_backup_target"
    echo "new content" > "$test_dir/gnu_backup_src"
    echo "new content" > "$test_dir/f_backup_src"

    $GNU_TOOL --backup=numbered "$test_dir/gnu_backup_src" "$test_dir/gnu_backup_target"
    $F_TOOL --backup=numbered "$test_dir/f_backup_src" "$test_dir/f_backup_target"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_backup f_backup
    gnu_backup=$(ls "$test_dir"/gnu_backup_target.~*~ 2>/dev/null | head -1)
    f_backup=$(ls "$test_dir"/f_backup_target.~*~ 2>/dev/null | head -1)
    if [[ -n "$gnu_backup" ]] && [[ -n "$f_backup" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --backup=numbered creates backup"
        record_result "backup numbered" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: backup not created (gnu=$gnu_backup f=$f_backup)"
        record_result "backup numbered" "FAIL" "backup missing" "" ""
    fi

    # Simple backup
    echo "orig2" > "$test_dir/gnu_sbackup_target"
    echo "orig2" > "$test_dir/f_sbackup_target"
    echo "new2" > "$test_dir/gnu_sbackup_src"
    echo "new2" > "$test_dir/f_sbackup_src"

    $GNU_TOOL -b "$test_dir/gnu_sbackup_src" "$test_dir/gnu_sbackup_target"
    $F_TOOL -b "$test_dir/f_sbackup_src" "$test_dir/f_sbackup_target"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$test_dir/gnu_sbackup_target~" ]] && [[ -f "$test_dir/f_sbackup_target~" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -b creates simple backup"
        record_result "simple backup" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: simple backup not created"
        record_result "simple backup" "FAIL" "backup missing" "" ""
    fi

    # === Section 7: Move Directory ===
    echo ""
    echo "=== Move Directory ==="

    mkdir -p "$test_dir/gnu_movedir/sub"
    echo "x" > "$test_dir/gnu_movedir/sub/file"
    cp -r "$test_dir/gnu_movedir" "$test_dir/f_movedir"

    $GNU_TOOL "$test_dir/gnu_movedir" "$test_dir/gnu_moved_result"
    $F_TOOL "$test_dir/f_movedir" "$test_dir/f_moved_result"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -d "$test_dir/gnu_movedir" ]] && [[ ! -d "$test_dir/f_movedir" ]] && \
       diff -r "$test_dir/gnu_moved_result" "$test_dir/f_moved_result" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: move directory"
        record_result "move directory" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: move directory failed"
        record_result "move directory" "FAIL" "move behavior differs" "" ""
    fi

    # ── GNU Upstream Test Scenarios ──────────────────────────────────────────

    echo ""
    echo "=== GNU Upstream: No-Clobber (-n) Flag Combinations ==="

    # From mv-n.sh: -n wins as the last option (overrides -f)
    local tmpn=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$tmpn"

    echo "existing" > "$tmpn/gnu_a"
    echo "existing" > "$tmpn/gnu_b"
    echo "existing" > "$tmpn/f_a"
    echo "existing" > "$tmpn/f_b"

    run_test "mv -fn does not overwrite (n wins)" \
        "$GNU_TOOL -fn '$tmpn/gnu_a' '$tmpn/gnu_b' && cat '$tmpn/gnu_b'" \
        "$F_TOOL -fn '$tmpn/f_a' '$tmpn/f_b' && cat '$tmpn/f_b'"

    # From mv-n.sh: -n wins as the last option (overrides -i -f)
    echo "existing2" > "$tmpn/gnu_c"
    echo "existing2" > "$tmpn/gnu_d"
    echo "existing2" > "$tmpn/f_c"
    echo "existing2" > "$tmpn/f_d"

    run_test "mv -ifn does not overwrite (n wins)" \
        "echo y | $GNU_TOOL -fn '$tmpn/gnu_c' '$tmpn/gnu_d' && cat '$tmpn/gnu_d'" \
        "echo y | $F_TOOL -fn '$tmpn/f_c' '$tmpn/f_d' && cat '$tmpn/f_d'"

    # From mv-n.sh: --backup and --no-clobber are mutually exclusive
    touch "$tmpn/gnu_excl" "$tmpn/f_excl"
    run_exit_code_test "mv -bn is mutually exclusive" \
        "$GNU_TOOL -bn '$tmpn/gnu_excl' '$tmpn/gnu_excl_dst' 2>&1" \
        "$F_TOOL -bn '$tmpn/f_excl' '$tmpn/f_excl_dst' 2>&1"

    echo ""
    echo "=== GNU Upstream: Update Flag ==="

    # From update.sh: --update does not overwrite newer file with older
    local tmpu=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$tmpu"

    echo "new content" > "$tmpu/gnu_new"
    echo "new content" > "$tmpu/f_new"
    echo "old content" > "$tmpu/gnu_old"
    echo "old content" > "$tmpu/f_old"
    # Make "old" files older
    touch -t 202301010000 "$tmpu/gnu_old" 2>/dev/null || true
    touch -t 202301010000 "$tmpu/f_old" 2>/dev/null || true

    run_test "mv --update skips older onto newer" \
        "$GNU_TOOL --update '$tmpu/gnu_old' '$tmpu/gnu_new' && cat '$tmpu/gnu_new'" \
        "$F_TOOL --update '$tmpu/f_old' '$tmpu/f_new' && cat '$tmpu/f_new'"

    # From update.sh: --update moves newer onto older
    echo "newer" > "$tmpu/gnu_newer"
    echo "newer" > "$tmpu/f_newer"
    echo "older" > "$tmpu/gnu_older"
    echo "older" > "$tmpu/f_older"
    touch -t 202301010000 "$tmpu/gnu_older" 2>/dev/null || true
    touch -t 202301010000 "$tmpu/f_older" 2>/dev/null || true

    run_test "mv --update moves newer onto older" \
        "$GNU_TOOL --update '$tmpu/gnu_newer' '$tmpu/gnu_older' && cat '$tmpu/gnu_older'" \
        "$F_TOOL --update '$tmpu/f_newer' '$tmpu/f_older' && cat '$tmpu/f_older'"

    # From update.sh: --update=all always moves regardless of timestamps
    echo "src_all" > "$tmpu/gnu_src_all"
    echo "src_all" > "$tmpu/f_src_all"
    echo "dst_all" > "$tmpu/gnu_dst_all"
    echo "dst_all" > "$tmpu/f_dst_all"

    run_test "mv --update=all always overwrites" \
        "$GNU_TOOL --update=all '$tmpu/gnu_src_all' '$tmpu/gnu_dst_all' && cat '$tmpu/gnu_dst_all'" \
        "$F_TOOL --update=all '$tmpu/f_src_all' '$tmpu/f_dst_all' && cat '$tmpu/f_dst_all'"

    # From update.sh: --update=none does not move
    echo "src_none" > "$tmpu/gnu_src_none"
    echo "src_none" > "$tmpu/f_src_none"
    echo "dst_none" > "$tmpu/gnu_dst_none"
    echo "dst_none" > "$tmpu/f_dst_none"

    run_test "mv --update=none does not overwrite" \
        "$GNU_TOOL --update=none '$tmpu/gnu_src_none' '$tmpu/gnu_dst_none' 2>/dev/null; cat '$tmpu/gnu_dst_none'" \
        "$F_TOOL --update=none '$tmpu/f_src_none' '$tmpu/f_dst_none' 2>/dev/null; cat '$tmpu/f_dst_none'"

    # From update.sh: --update moves to nonexistent target
    echo "moveme" > "$tmpu/gnu_upd_new"
    echo "moveme" > "$tmpu/f_upd_new"

    run_test "mv --update to nonexistent target" \
        "$GNU_TOOL --update '$tmpu/gnu_upd_new' '$tmpu/gnu_upd_dst' && cat '$tmpu/gnu_upd_dst'" \
        "$F_TOOL --update '$tmpu/f_upd_new' '$tmpu/f_upd_dst' && cat '$tmpu/f_upd_dst'"

    echo ""
    echo "=== GNU Upstream: Force Flag ==="

    # From force.sh: mv file onto itself should fail
    local tmpf=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$tmpf"

    echo "force-contents" > "$tmpf/gnu_self"
    echo "force-contents" > "$tmpf/f_self"

    run_exit_code_test "mv file onto itself fails" \
        "$GNU_TOOL '$tmpf/gnu_self' '$tmpf/gnu_self' 2>&1" \
        "$F_TOOL '$tmpf/f_self' '$tmpf/f_self' 2>&1"

    echo ""
    echo "=== GNU Upstream: Diagnostic Messages ==="

    # From diag.sh: missing file operand with --target
    local tmpd=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$tmpd"

    run_exit_code_test "mv --target=. with no files" \
        "$GNU_TOOL --target='$tmpd' 2>&1" \
        "$F_TOOL --target='$tmpd' 2>&1"

    # From diag.sh: missing destination after single arg
    run_exit_code_test "mv single nonexistent arg" \
        "$GNU_TOOL /tmp/no_such_file_$$ 2>&1" \
        "$F_TOOL /tmp/no_such_file_$$ 2>&1"

    # From diag.sh: target is not a directory (multi-source)
    touch "$tmpd/gnu_f1" "$tmpd/gnu_f2" "$tmpd/gnu_f3"
    touch "$tmpd/f_f1" "$tmpd/f_f2" "$tmpd/f_f3"

    run_exit_code_test "mv multi-source to non-dir target" \
        "$GNU_TOOL '$tmpd/gnu_f1' '$tmpd/gnu_f2' '$tmpd/gnu_f3' 2>&1" \
        "$F_TOOL '$tmpd/f_f1' '$tmpd/f_f2' '$tmpd/f_f3' 2>&1"

    echo ""
    echo "=== GNU Upstream: Backup with Directory ==="

    # From backup-dir.sh: mv --backup=numbered -T dir dir creates numbered backup
    local tmpb=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$tmpb"

    mkdir -p "$tmpb/gnu_A" "$tmpb/gnu_B"
    mkdir -p "$tmpb/f_A" "$tmpb/f_B"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_bdir_ok=0
    $GNU_TOOL --backup=numbered -T "$tmpb/gnu_A" "$tmpb/gnu_B" 2>/dev/null || gnu_bdir_ok=$?
    local f_bdir_ok=0
    $F_TOOL --backup=numbered -T "$tmpb/f_A" "$tmpb/f_B" 2>/dev/null || f_bdir_ok=$?

    local gnu_bdir_backup=$(ls -d "$tmpb"/gnu_B.~*~ 2>/dev/null | head -1)
    local f_bdir_backup=$(ls -d "$tmpb"/f_B.~*~ 2>/dev/null | head -1)

    if [[ "$gnu_bdir_ok" -eq 0 && "$f_bdir_ok" -eq 0 ]] && \
       [[ -n "$gnu_bdir_backup" ]] && [[ -n "$f_bdir_backup" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv --backup=numbered -T with dirs"
        record_result "gnu: backup dir numbered" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv --backup=numbered -T with dirs"
        record_result "gnu: backup dir numbered" "FAIL" "gnu_exit=$gnu_bdir_ok f_exit=$f_bdir_ok gnu_bak=$gnu_bdir_backup f_bak=$f_bdir_backup" "" ""
    fi

    # From backup-dir.sh: mv --backup=simple creates ~ backup for file into dir
    mkdir -p "$tmpb/gnu_F" "$tmpb/f_F"
    echo "1" > "$tmpb/gnu_F/X"
    echo "1" > "$tmpb/f_F/X"
    echo "2" > "$tmpb/gnu_X"
    echo "2" > "$tmpb/f_X"

    TESTS_RUN=$((TESTS_RUN + 1))
    $GNU_TOOL --backup=simple "$tmpb/gnu_X" "$tmpb/gnu_F/" 2>/dev/null
    $F_TOOL --backup=simple "$tmpb/f_X" "$tmpb/f_F/" 2>/dev/null

    if [[ -f "$tmpb/gnu_F/X~" ]] && [[ -f "$tmpb/f_F/X~" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv --backup=simple into dir"
        record_result "gnu: backup simple into dir" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv --backup=simple into dir"
        record_result "gnu: backup simple into dir" "FAIL" "backup file missing" "" ""
    fi

    echo ""
    echo "=== GNU Upstream: Dir/File Mismatch ==="

    # From dir-file.sh: mv dir onto file (where file has same name as subdir) should fail
    local tmpdf=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$tmpdf"

    mkdir -p "$tmpdf/gnu_dir/file"
    touch "$tmpdf/gnu_file"
    mkdir -p "$tmpdf/f_dir/file"
    touch "$tmpdf/f_file"

    run_exit_code_test "mv dir to file fails" \
        "$GNU_TOOL '$tmpdf/gnu_dir' '$tmpdf/gnu_file' 2>&1" \
        "$F_TOOL '$tmpdf/f_dir' '$tmpdf/f_file' 2>&1"

    run_exit_code_test "mv file to dir/file fails" \
        "$GNU_TOOL '$tmpdf/gnu_file' '$tmpdf/gnu_dir' 2>&1" \
        "$F_TOOL '$tmpdf/f_file' '$tmpdf/f_dir' 2>&1"

    echo ""
    echo "=== GNU Upstream: Move Into Self ==="

    # From into-self.sh: mv dir into itself should fail
    local tmps=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$tmps"

    mkdir -p "$tmps/gnu_selfdir/a/b"
    mkdir -p "$tmps/f_selfdir/a/b"

    run_exit_code_test "mv dir into itself fails" \
        "$GNU_TOOL '$tmps/gnu_selfdir' '$tmps/gnu_selfdir' 2>&1" \
        "$F_TOOL '$tmps/f_selfdir' '$tmps/f_selfdir' 2>&1"

    # From into-self.sh: mv dir file dir should move file but fail on dir
    touch "$tmps/gnu_file_is" "$tmps/f_file_is"

    TESTS_RUN=$((TESTS_RUN + 1))
    $GNU_TOOL "$tmps/gnu_file_is" "$tmps/gnu_selfdir" 2>/dev/null || true
    $F_TOOL "$tmps/f_file_is" "$tmps/f_selfdir" 2>/dev/null || true

    if [[ -f "$tmps/gnu_selfdir/gnu_file_is" ]] && [[ -f "$tmps/f_selfdir/f_file_is" ]] && \
       [[ ! -f "$tmps/gnu_file_is" ]] && [[ ! -f "$tmps/f_file_is" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv file into dir succeeds"
        record_result "gnu: mv file into dir" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv file into dir"
        record_result "gnu: mv file into dir" "FAIL" "file not moved correctly" "" ""
    fi

    echo ""
    echo "=== GNU Upstream: Trailing Slash ==="

    # From trailing-slash.sh: mv dir/ bar renames dir to bar
    local tmpt=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$tmpt"

    mkdir "$tmpt/gnu_foo" "$tmpt/f_foo"

    TESTS_RUN=$((TESTS_RUN + 1))
    $GNU_TOOL "$tmpt/gnu_foo/" "$tmpt/gnu_bar" 2>/dev/null
    $F_TOOL "$tmpt/f_foo/" "$tmpt/f_bar" 2>/dev/null

    if [[ -d "$tmpt/gnu_bar" ]] && [[ -d "$tmpt/f_bar" ]] && \
       [[ ! -d "$tmpt/gnu_foo" ]] && [[ ! -d "$tmpt/f_foo" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv dir/ bar renames directory"
        record_result "gnu: trailing slash rename" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv dir/ bar"
        record_result "gnu: trailing slash rename" "FAIL" "trailing slash rename mismatch" "" ""
    fi

    # From trailing-slash.sh: mv dir to non-existent with trailing slash
    mkdir "$tmpt/gnu_d2" "$tmpt/f_d2"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_ts_exit=0
    $GNU_TOOL "$tmpt/gnu_d2" "$tmpt/gnu_e2/" 2>/dev/null || gnu_ts_exit=$?
    local f_ts_exit=0
    $F_TOOL "$tmpt/f_d2" "$tmpt/f_e2/" 2>/dev/null || f_ts_exit=$?

    if [[ -d "$tmpt/gnu_e2" ]] && [[ -d "$tmpt/f_e2" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv dir non-exist-dir/ works"
        record_result "gnu: trailing slash nonexist" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv dir non-exist-dir/"
        record_result "gnu: trailing slash nonexist" "FAIL" "gnu_exit=$gnu_ts_exit f_exit=$f_ts_exit" "" ""
    fi

    echo ""
    echo "=== GNU Upstream: Exchange Flag ==="

    # From mv-exchange.sh: --exchange swaps two files (if supported)
    local tmpx=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$tmpx"

    echo "file_a" > "$tmpx/gnu_a"
    mkdir "$tmpx/gnu_b"
    echo "file_a" > "$tmpx/f_a"
    mkdir "$tmpx/f_b"

    # Check if --exchange is supported by GNU mv
    if $GNU_TOOL -T --exchange "$tmpx/gnu_a" "$tmpx/gnu_b" 2>/dev/null; then
        # GNU supports it, test fcoreutils
        TESTS_RUN=$((TESTS_RUN + 1))
        if $F_TOOL -T --exchange "$tmpx/f_a" "$tmpx/f_b" 2>/dev/null; then
            if [[ -d "$tmpx/f_a" ]] && [[ -f "$tmpx/f_b" ]]; then
                TESTS_PASSED=$((TESTS_PASSED + 1))
                echo -e "  ${GREEN}PASS${NC}: mv --exchange swaps file and dir"
                record_result "gnu: exchange file and dir" "PASS" "" "" ""
            else
                TESTS_FAILED=$((TESTS_FAILED + 1))
                echo -e "  ${RED}FAIL${NC}: mv --exchange result mismatch"
                record_result "gnu: exchange file and dir" "FAIL" "swap result incorrect" "" ""
            fi
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: mv --exchange not supported by fcoreutils"
            record_result "gnu: exchange file and dir" "FAIL" "not supported by fcoreutils" "" ""
        fi
    else
        skip_test "mv --exchange" "not supported on this platform"
    fi

    # From mv-exchange.sh: --exchange with wrong number of args
    run_exit_code_test "mv --exchange with 1 arg" \
        "$GNU_TOOL --exchange '$tmpx/gnu_a' 2>&1" \
        "$F_TOOL --exchange '$tmpx/f_a' 2>&1"

    # From mv-exchange.sh: --exchange with nonexistent file
    run_exit_code_test "mv --exchange nonexistent" \
        "$GNU_TOOL --exchange '$tmpx/gnu_a' '$tmpx/no_such_$$' 2>&1" \
        "$F_TOOL --exchange '$tmpx/f_a' '$tmpx/no_such_$$' 2>&1"

    # === Section 8: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent source" \
        "$GNU_TOOL /tmp/nonexistent_$$ '$test_dir/dest' 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ '$test_dir/dest' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # === Section 9: Multiple Files to Directory ===
    echo ""
    echo "=== Multiple Files to Directory ==="

    local tmpmulti=$(mktemp -d /tmp/fcoreutils_mv_multi_$$_XXXXXX)
    register_temp "$tmpmulti"

    mkdir -p "$tmpmulti/gnu_dest" "$tmpmulti/f_dest"
    echo "a" > "$tmpmulti/gnu_a"
    echo "b" > "$tmpmulti/gnu_b"
    echo "c" > "$tmpmulti/gnu_c"
    echo "a" > "$tmpmulti/f_a"
    echo "b" > "$tmpmulti/f_b"
    echo "c" > "$tmpmulti/f_c"

    $GNU_TOOL "$tmpmulti/gnu_a" "$tmpmulti/gnu_b" "$tmpmulti/gnu_c" "$tmpmulti/gnu_dest/"
    $F_TOOL "$tmpmulti/f_a" "$tmpmulti/f_b" "$tmpmulti/f_c" "$tmpmulti/f_dest/"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$tmpmulti/gnu_dest/gnu_a" ]] && [[ -f "$tmpmulti/f_dest/f_a" ]] && \
       [[ -f "$tmpmulti/gnu_dest/gnu_b" ]] && [[ -f "$tmpmulti/f_dest/f_b" ]] && \
       [[ -f "$tmpmulti/gnu_dest/gnu_c" ]] && [[ -f "$tmpmulti/f_dest/f_c" ]] && \
       [[ ! -f "$tmpmulti/gnu_a" ]] && [[ ! -f "$tmpmulti/f_a" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv multiple files to directory"
        record_result "mv multiple to dir" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv multiple files to directory"
        record_result "mv multiple to dir" "FAIL" "files not moved correctly" "" ""
    fi

    # === Section 10: Suffix (--suffix) ===
    echo ""
    echo "=== Suffix ==="

    local tmpsuf=$(mktemp -d /tmp/fcoreutils_mv_suffix_$$_XXXXXX)
    register_temp "$tmpsuf"

    echo "original" > "$tmpsuf/gnu_target"
    echo "original" > "$tmpsuf/f_target"
    echo "new" > "$tmpsuf/gnu_src"
    echo "new" > "$tmpsuf/f_src"

    $GNU_TOOL -b --suffix=.bak "$tmpsuf/gnu_src" "$tmpsuf/gnu_target"
    $F_TOOL -b --suffix=.bak "$tmpsuf/f_src" "$tmpsuf/f_target"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$tmpsuf/gnu_target.bak" ]] && [[ -f "$tmpsuf/f_target.bak" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv --suffix=.bak creates backup with custom suffix"
        record_result "mv suffix" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv --suffix=.bak"
        record_result "mv suffix" "FAIL" "backup with custom suffix missing" "" ""
    fi

    # === Section 11: --target-directory (-t) ===
    echo ""
    echo "=== Target Directory (-t) ==="

    local tmptd=$(mktemp -d /tmp/fcoreutils_mv_td_$$_XXXXXX)
    register_temp "$tmptd"

    mkdir -p "$tmptd/gnu_dest" "$tmptd/f_dest"
    echo "td" > "$tmptd/gnu_src"
    echo "td" > "$tmptd/f_src"

    $GNU_TOOL -t "$tmptd/gnu_dest" "$tmptd/gnu_src"
    $F_TOOL -t "$tmptd/f_dest" "$tmptd/f_src"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$tmptd/gnu_dest/gnu_src" ]] && [[ -f "$tmptd/f_dest/f_src" ]] && \
       [[ ! -f "$tmptd/gnu_src" ]] && [[ ! -f "$tmptd/f_src" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv -t target_directory"
        record_result "mv target directory" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv -t target_directory"
        record_result "mv target directory" "FAIL" "target directory move failed" "" ""
    fi

    # === Section 12: --no-target-directory (-T) ===
    echo ""
    echo "=== No Target Directory (-T) ==="

    local tmpnt=$(mktemp -d /tmp/fcoreutils_mv_nt_$$_XXXXXX)
    register_temp "$tmpnt"

    mkdir -p "$tmpnt/gnu_src" "$tmpnt/f_src"

    $GNU_TOOL -T "$tmpnt/gnu_src" "$tmpnt/gnu_renamed"
    $F_TOOL -T "$tmpnt/f_src" "$tmpnt/f_renamed"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -d "$tmpnt/gnu_renamed" ]] && [[ -d "$tmpnt/f_renamed" ]] && \
       [[ ! -d "$tmpnt/gnu_src" ]] && [[ ! -d "$tmpnt/f_src" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv -T renames dir instead of moving into"
        record_result "mv no target directory" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv -T"
        record_result "mv no target directory" "FAIL" "-T behavior differs" "" ""
    fi

    # === Section 13: Symlink Rename ===
    echo ""
    echo "=== Symlink Rename ==="

    local tmpsym=$(mktemp -d /tmp/fcoreutils_mv_sym_$$_XXXXXX)
    register_temp "$tmpsym"

    echo "target" > "$tmpsym/real_file"
    ln -s "$tmpsym/real_file" "$tmpsym/gnu_link"
    ln -s "$tmpsym/real_file" "$tmpsym/f_link"

    $GNU_TOOL "$tmpsym/gnu_link" "$tmpsym/gnu_link_renamed"
    $F_TOOL "$tmpsym/f_link" "$tmpsym/f_link_renamed"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -L "$tmpsym/gnu_link_renamed" ]] && [[ -L "$tmpsym/f_link_renamed" ]] && \
       [[ ! -L "$tmpsym/gnu_link" ]] && [[ ! -L "$tmpsym/f_link" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv symlink renames the link"
        record_result "mv symlink rename" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv symlink rename"
        record_result "mv symlink rename" "FAIL" "symlink rename behavior differs" "" ""
    fi

    # === Section 14: Symlink Target Preserved ===
    echo ""
    echo "=== Symlink Target Preserved ==="

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_target f_target
    gnu_target=$(readlink "$tmpsym/gnu_link_renamed" 2>/dev/null || echo "")
    f_target=$(readlink "$tmpsym/f_link_renamed" 2>/dev/null || echo "")

    if [[ "$gnu_target" == "$f_target" ]] && [[ -n "$gnu_target" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv symlink preserves target"
        record_result "mv symlink target" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv symlink target (gnu=$gnu_target f=$f_target)"
        record_result "mv symlink target" "FAIL" "symlink target differs: gnu=$gnu_target f=$f_target" "" ""
    fi

    # === Section 15: Permission Denied ===
    echo ""
    echo "=== Permission Denied ==="

    local tmpperm=$(mktemp -d /tmp/fcoreutils_mv_perm_$$_XXXXXX)
    register_temp "$tmpperm"

    mkdir -p "$tmpperm/readonly_dir"
    echo "locked" > "$tmpperm/readonly_dir/file"
    chmod 444 "$tmpperm/readonly_dir"

    run_exit_code_test "mv into read-only dir fails" \
        "$GNU_TOOL '$tmpperm/readonly_dir/file' '$tmpperm/moved_out' 2>&1" \
        "$F_TOOL '$tmpperm/readonly_dir/file' '$tmpperm/moved_out' 2>&1"

    chmod 755 "$tmpperm/readonly_dir"

    # === Section 16: Dir Into Itself ===
    echo ""
    echo "=== Dir Into Itself ==="

    local tmpself=$(mktemp -d /tmp/fcoreutils_mv_self_$$_XXXXXX)
    register_temp "$tmpself"

    mkdir -p "$tmpself/gnu_dir/sub" "$tmpself/f_dir/sub"

    run_exit_code_test "mv dir into itself fails" \
        "$GNU_TOOL '$tmpself/gnu_dir' '$tmpself/gnu_dir/sub' 2>&1" \
        "$F_TOOL '$tmpself/f_dir' '$tmpself/f_dir/sub' 2>&1"

    # === Section 17: Special Characters in Filenames ===
    echo ""
    echo "=== Special Characters ==="

    local tmpsc=$(mktemp -d /tmp/fcoreutils_mv_sc_$$_XXXXXX)
    register_temp "$tmpsc"

    echo "special" > "$tmpsc/gnu file with spaces"
    echo "special" > "$tmpsc/f file with spaces"

    $GNU_TOOL "$tmpsc/gnu file with spaces" "$tmpsc/gnu moved spaces"
    $F_TOOL "$tmpsc/f file with spaces" "$tmpsc/f moved spaces"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$tmpsc/gnu moved spaces" ]] && [[ -f "$tmpsc/f moved spaces" ]] && \
       [[ ! -f "$tmpsc/gnu file with spaces" ]] && [[ ! -f "$tmpsc/f file with spaces" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv files with spaces"
        record_result "mv special chars" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv files with spaces"
        record_result "mv special chars" "FAIL" "special chars handling differs" "" ""
    fi

    # === Section 18: Empty Directory ===
    echo ""
    echo "=== Empty Directory ==="

    local tmped=$(mktemp -d /tmp/fcoreutils_mv_ed_$$_XXXXXX)
    register_temp "$tmped"

    mkdir -p "$tmped/gnu_empty" "$tmped/f_empty"

    $GNU_TOOL "$tmped/gnu_empty" "$tmped/gnu_empty_moved"
    $F_TOOL "$tmped/f_empty" "$tmped/f_empty_moved"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -d "$tmped/gnu_empty_moved" ]] && [[ -d "$tmped/f_empty_moved" ]] && \
       [[ ! -d "$tmped/gnu_empty" ]] && [[ ! -d "$tmped/f_empty" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv empty directory"
        record_result "mv empty dir" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv empty directory"
        record_result "mv empty dir" "FAIL" "empty dir move differs" "" ""
    fi

    # === Section 19: Hidden Files ===
    echo ""
    echo "=== Hidden Files ==="

    local tmphid=$(mktemp -d /tmp/fcoreutils_mv_hid_$$_XXXXXX)
    register_temp "$tmphid"

    echo "hidden" > "$tmphid/.gnu_hidden"
    echo "hidden" > "$tmphid/.f_hidden"

    $GNU_TOOL "$tmphid/.gnu_hidden" "$tmphid/.gnu_hidden_moved"
    $F_TOOL "$tmphid/.f_hidden" "$tmphid/.f_hidden_moved"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$tmphid/.gnu_hidden_moved" ]] && [[ -f "$tmphid/.f_hidden_moved" ]] && \
       [[ ! -f "$tmphid/.gnu_hidden" ]] && [[ ! -f "$tmphid/.f_hidden" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv hidden files"
        record_result "mv hidden files" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv hidden files"
        record_result "mv hidden files" "FAIL" "hidden file move differs" "" ""
    fi

    # === Section 20: Strip Trailing Slashes (--strip-trailing-slashes) ===
    echo ""
    echo "=== Strip Trailing Slashes ==="

    local tmpsts=$(mktemp -d /tmp/fcoreutils_mv_sts_$$_XXXXXX)
    register_temp "$tmpsts"

    mkdir -p "$tmpsts/gnu_slashdir" "$tmpsts/f_slashdir"

    run_exit_code_test "mv --strip-trailing-slashes" \
        "$GNU_TOOL --strip-trailing-slashes '$tmpsts/gnu_slashdir/' '$tmpsts/gnu_stripped' 2>&1" \
        "$F_TOOL --strip-trailing-slashes '$tmpsts/f_slashdir/' '$tmpsts/f_stripped' 2>&1"

    # === Section 21: Verbose Output Format ===
    echo ""
    echo "=== Verbose Output Format ==="

    local tmpvf=$(mktemp -d /tmp/fcoreutils_mv_vf_$$_XXXXXX)
    register_temp "$tmpvf"

    echo "vf" > "$tmpvf/gnu_vf_src"
    echo "vf" > "$tmpvf/f_vf_src"

    local gnu_vf_out f_vf_out
    gnu_vf_out=$($GNU_TOOL -v "$tmpvf/gnu_vf_src" "$tmpvf/gnu_vf_dst" 2>&1 || true)
    f_vf_out=$($F_TOOL -v "$tmpvf/f_vf_src" "$tmpvf/f_vf_dst" 2>&1 || true)

    TESTS_RUN=$((TESTS_RUN + 1))
    # Both should contain an arrow indicator (-> or ')
    if echo "$gnu_vf_out" | grep -q "->"; then
        if echo "$f_vf_out" | grep -q "->"; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "  ${GREEN}PASS${NC}: mv -v output contains -> indicator"
            record_result "mv verbose output format" "PASS" "" "" ""
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: mv -v output format (f missing ->)"
            record_result "mv verbose output format" "FAIL" "f output: $f_vf_out" "" ""
        fi
    else
        # GNU doesn't use -> on this platform, just check both produce output
        if [[ -n "$gnu_vf_out" ]] && [[ -n "$f_vf_out" ]]; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "  ${GREEN}PASS${NC}: mv -v produces output"
            record_result "mv verbose output format" "PASS" "" "" ""
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: mv -v output missing"
            record_result "mv verbose output format" "FAIL" "gnu='$gnu_vf_out' f='$f_vf_out'" "" ""
        fi
    fi

    # === Section 22: Interactive Yes ===
    echo ""
    echo "=== Interactive ==="

    local tmpint=$(mktemp -d /tmp/fcoreutils_mv_int_$$_XXXXXX)
    register_temp "$tmpint"

    echo "exists" > "$tmpint/gnu_int_dst"
    echo "exists" > "$tmpint/f_int_dst"
    echo "new_y" > "$tmpint/gnu_int_src_y"
    echo "new_y" > "$tmpint/f_int_src_y"

    run_exit_code_test "mv -i with yes response" \
        "echo y | $GNU_TOOL -i '$tmpint/gnu_int_src_y' '$tmpint/gnu_int_dst' 2>&1" \
        "echo y | $F_TOOL -i '$tmpint/f_int_src_y' '$tmpint/f_int_dst' 2>&1"

    # === Section 23: Interactive No ===

    echo "exists_n" > "$tmpint/gnu_int_dst_n"
    echo "exists_n" > "$tmpint/f_int_dst_n"
    echo "new_n" > "$tmpint/gnu_int_src_n"
    echo "new_n" > "$tmpint/f_int_src_n"

    TESTS_RUN=$((TESTS_RUN + 1))
    echo n | $GNU_TOOL -i "$tmpint/gnu_int_src_n" "$tmpint/gnu_int_dst_n" 2>/dev/null || true
    echo n | $F_TOOL -i "$tmpint/f_int_src_n" "$tmpint/f_int_dst_n" 2>/dev/null || true

    local gnu_int_content f_int_content
    gnu_int_content=$(cat "$tmpint/gnu_int_dst_n" 2>/dev/null || echo "")
    f_int_content=$(cat "$tmpint/f_int_dst_n" 2>/dev/null || echo "")

    if [[ "$gnu_int_content" == "exists_n" ]] && [[ "$f_int_content" == "exists_n" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: mv -i with no response preserves target"
        record_result "mv interactive no" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mv -i with no response (gnu='$gnu_int_content' f='$f_int_content')"
        record_result "mv interactive no" "FAIL" "interactive no behavior differs" "" ""
    fi

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_mv_tests
