#!/usr/bin/env bash
# Compatibility tests for fmv vs GNU mv
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mv"
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

    # === Section 8: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent source" \
        "$GNU_TOOL /tmp/nonexistent_$$ '$test_dir/dest' 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ '$test_dir/dest' 2>&1"

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_mv_tests
