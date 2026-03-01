#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fcp"
run_cp_functional_tests() {
    init_test_suite "cp"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cp","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/cp_results.json"
        return 0
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_cp_func_XXXXXX)
    register_temp "$test_dir"

    echo ""
    echo "=== Basic Exit Codes ==="

    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent source fails" "$F_TOOL /tmp/nonexistent_file_functional_test_$$ /tmp/dest_$$ 2>/dev/null" 1

    echo ""
    echo "=== Basic Copy ==="

    printf "hello world" > "$test_dir/src_basic"
    run_expected_exit_test "basic copy exits 0" "$F_TOOL '$test_dir/src_basic' '$test_dir/dst_basic'" 0

    # Verify content after copy
    $F_TOOL "$test_dir/src_basic" "$test_dir/dst_verify" 2>/dev/null || true
    TESTS_RUN=$((TESTS_RUN + 1))
    local copied_content
    copied_content=$(cat "$test_dir/dst_verify" 2>/dev/null || echo "")
    if [[ "$copied_content" == "hello world" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: basic copy content correct"
        record_result "basic copy content" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: basic copy content mismatch"
        record_result "basic copy content" "FAIL" "expected 'hello world', got '$copied_content'" "" ""
    fi

    echo ""
    echo "=== Recursive Copy ==="

    mkdir -p "$test_dir/rdir/sub1/sub2"
    echo "f1" > "$test_dir/rdir/file1"
    echo "f2" > "$test_dir/rdir/sub1/file2"
    echo "f3" > "$test_dir/rdir/sub1/sub2/file3"

    run_expected_exit_test "recursive copy exits 0" "$F_TOOL -r '$test_dir/rdir' '$test_dir/rdir_copy'" 0

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$test_dir/rdir_copy/file1" ]] && \
       [[ -f "$test_dir/rdir_copy/sub1/file2" ]] && \
       [[ -f "$test_dir/rdir_copy/sub1/sub2/file3" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: recursive copy preserves structure"
        record_result "recursive copy structure" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: recursive copy missing files"
        record_result "recursive copy structure" "FAIL" "expected files not found" "" ""
    fi

    echo ""
    echo "=== Preserve Mode (-p) ==="

    echo "preserve_test" > "$test_dir/pmode_src"
    chmod 751 "$test_dir/pmode_src"

    run_expected_exit_test "preserve copy exits 0" "$F_TOOL -p '$test_dir/pmode_src' '$test_dir/pmode_dst'" 0

    TESTS_RUN=$((TESTS_RUN + 1))
    local pmode
    pmode=$(stat -c '%a' "$test_dir/pmode_dst" 2>/dev/null || stat -f '%Lp' "$test_dir/pmode_dst")
    if [[ "$pmode" == "751" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -p preserves mode 751"
        record_result "preserve mode 751" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -p mode is $pmode, expected 751"
        record_result "preserve mode 751" "FAIL" "got $pmode" "" ""
    fi

    echo ""
    echo "=== No Clobber (-n) ==="

    echo "original" > "$test_dir/nc_target"
    echo "replacement" > "$test_dir/nc_source"

    run_expected_exit_test "no clobber exits 0" "$F_TOOL -n '$test_dir/nc_source' '$test_dir/nc_target'" 0

    TESTS_RUN=$((TESTS_RUN + 1))
    local nc_content
    nc_content=$(cat "$test_dir/nc_target")
    if [[ "$nc_content" == "original" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -n did not overwrite existing file"
        record_result "no clobber preserves" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -n overwrote existing file"
        record_result "no clobber preserves" "FAIL" "file was overwritten" "" ""
    fi

    echo ""
    echo "=== Symlink Creation (-s) ==="

    echo "symlink_target" > "$test_dir/sym_src"
    run_expected_exit_test "symlink copy exits 0" "$F_TOOL -s '$test_dir/sym_src' '$test_dir/sym_dst'" 0

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -L "$test_dir/sym_dst" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -s creates symlink"
        record_result "symlink creation" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -s did not create symlink"
        record_result "symlink creation" "FAIL" "not a symlink" "" ""
    fi

    echo ""
    echo "=== Hard Link (-l) ==="

    echo "hardlink_target" > "$test_dir/hl_src"
    run_expected_exit_test "hard link exits 0" "$F_TOOL -l '$test_dir/hl_src' '$test_dir/hl_dst'" 0

    TESTS_RUN=$((TESTS_RUN + 1))
    local hl_src_ino hl_dst_ino
    hl_src_ino=$(stat -c '%i' "$test_dir/hl_src" 2>/dev/null || stat -f '%i' "$test_dir/hl_src")
    hl_dst_ino=$(stat -c '%i' "$test_dir/hl_dst" 2>/dev/null || stat -f '%i' "$test_dir/hl_dst")
    if [[ "$hl_src_ino" == "$hl_dst_ino" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -l creates hard link (same inode)"
        record_result "hard link inode" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -l different inodes (src=$hl_src_ino dst=$hl_dst_ino)"
        record_result "hard link inode" "FAIL" "inode mismatch" "" ""
    fi

    echo ""
    echo "=== Empty File ==="

    touch "$test_dir/empty_src"
    run_expected_exit_test "copy empty file exits 0" "$F_TOOL '$test_dir/empty_src' '$test_dir/empty_dst'" 0

    TESTS_RUN=$((TESTS_RUN + 1))
    local empty_size
    empty_size=$(stat -c '%s' "$test_dir/empty_dst" 2>/dev/null || stat -f '%z' "$test_dir/empty_dst")
    if [[ "$empty_size" == "0" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: empty file copy is size 0"
        record_result "empty file size" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: empty file copy has size $empty_size"
        record_result "empty file size" "FAIL" "size=$empty_size" "" ""
    fi

    echo ""
    echo "=== Copy to Directory ==="

    mkdir -p "$test_dir/target_dir"
    echo "copy_to_dir" > "$test_dir/dir_src"
    run_expected_exit_test "copy to directory exits 0" "$F_TOOL '$test_dir/dir_src' '$test_dir/target_dir/'" 0

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$test_dir/target_dir/dir_src" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: file copied into directory"
        record_result "copy to directory" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: file not found in target directory"
        record_result "copy to directory" "FAIL" "file missing" "" ""
    fi

    echo ""
    echo "=== Error Cases ==="

    run_expected_exit_test "copy dir without -r fails" "$F_TOOL '$test_dir/rdir' '$test_dir/should_fail' 2>/dev/null" 1
    run_expected_exit_test "copy to nonexistent dir fails" "$F_TOOL '$test_dir/dir_src' '/tmp/nonexistent_dir_$$/file' 2>/dev/null" 1

    echo ""
    echo "=== Verbose (-v) ==="

    run_expected_exit_test "verbose copy exits 0" "$F_TOOL -v '$test_dir/dir_src' '$test_dir/verbose_dst' 2>/dev/null" 0

    echo ""
    echo "=== Help and Version ==="

    run_expected_exit_test "help exits 0" "$F_TOOL --help 2>/dev/null" 0
    run_expected_exit_test "version exits 0" "$F_TOOL --version 2>/dev/null" 0

    rm -rf "$test_dir"
    finish_test_suite
}
run_cp_functional_tests
