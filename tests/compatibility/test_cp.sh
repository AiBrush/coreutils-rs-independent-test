#!/usr/bin/env bash
# Compatibility tests for fcp vs GNU cp
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="cp"
F_TOOL="fcp"

run_cp_tests() {
    init_test_suite "cp"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cp","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/cp_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU cp not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_cp_XXXXXX)
    register_temp "$test_dir"

    # Create test fixtures
    echo "source content" > "$test_dir/source_file"
    chmod 644 "$test_dir/source_file"
    dd if=/dev/urandom of="$test_dir/binary_file" bs=1024 count=5 2>/dev/null
    mkdir -p "$test_dir/source_dir/sub1/sub2"
    echo "a" > "$test_dir/source_dir/file1"
    echo "b" > "$test_dir/source_dir/sub1/file2"
    echo "c" > "$test_dir/source_dir/sub1/sub2/file3"
    ln -s "$test_dir/source_file" "$test_dir/source_link"

    # === Section 1: Simple Copy ===
    echo ""
    echo "=== Simple Copy ==="

    $GNU_TOOL "$test_dir/source_file" "$test_dir/gnu_dest1"
    $F_TOOL "$test_dir/source_file" "$test_dir/f_dest1"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_dest1" "$test_dir/f_dest1" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: simple copy content"
        record_result "simple copy content" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: simple copy differs"
        record_result "simple copy content" "FAIL" "content differs" "" ""
    fi

    # Binary file
    $GNU_TOOL "$test_dir/binary_file" "$test_dir/gnu_bin_dest"
    $F_TOOL "$test_dir/binary_file" "$test_dir/f_bin_dest"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_bin_dest" "$test_dir/f_bin_dest" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: binary copy matches"
        record_result "binary copy" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: binary copy differs"
        record_result "binary copy" "FAIL" "content differs" "" ""
    fi

    # === Section 2: Recursive (-r) ===
    echo ""
    echo "=== Recursive (-r) ==="

    $GNU_TOOL -r "$test_dir/source_dir" "$test_dir/gnu_dir_copy"
    $F_TOOL -r "$test_dir/source_dir" "$test_dir/f_dir_copy"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff -r "$test_dir/gnu_dir_copy" "$test_dir/f_dir_copy" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: recursive copy matches"
        record_result "recursive copy" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: recursive copy differs"
        record_result "recursive copy" "FAIL" "content differs" "" ""
    fi

    # Roundtrip
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff -r "$test_dir/source_dir" "$test_dir/gnu_dir_copy" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: recursive copy roundtrip"
        record_result "recursive roundtrip" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: recursive roundtrip"
        record_result "recursive roundtrip" "FAIL" "mismatch" "" ""
    fi

    # === Section 3: Preserve (-p) ===
    echo ""
    echo "=== Preserve (-p) ==="

    chmod 751 "$test_dir/source_file"
    $GNU_TOOL -p "$test_dir/source_file" "$test_dir/gnu_preserved"
    $F_TOOL -p "$test_dir/source_file" "$test_dir/f_preserved"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_mode f_mode
    gnu_mode=$(stat -c '%a' "$test_dir/gnu_preserved" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_preserved")
    f_mode=$(stat -c '%a' "$test_dir/f_preserved" 2>/dev/null || stat -f '%Lp' "$test_dir/f_preserved")
    if [[ "$gnu_mode" == "$f_mode" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -p preserves mode ($gnu_mode)"
        record_result "preserve mode" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -p mode mismatch (GNU=$gnu_mode F=$f_mode)"
        record_result "preserve mode" "FAIL" "GNU=$gnu_mode F=$f_mode" "" ""
    fi

    # === Section 4: Archive (-a) ===
    echo ""
    echo "=== Archive (-a) ==="

    $GNU_TOOL -a "$test_dir/source_dir" "$test_dir/gnu_archive"
    $F_TOOL -a "$test_dir/source_dir" "$test_dir/f_archive"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff -r "$test_dir/gnu_archive" "$test_dir/f_archive" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: archive copy content matches"
        record_result "archive copy" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: archive copy differs"
        record_result "archive copy" "FAIL" "content differs" "" ""
    fi

    # === Section 5: Symlink Handling ===
    echo ""
    echo "=== Symlink Handling ==="

    # -P preserves symlink
    $GNU_TOOL -P "$test_dir/source_link" "$test_dir/gnu_symP"
    $F_TOOL -P "$test_dir/source_link" "$test_dir/f_symP"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_is_link=0 f_is_link=0
    [[ -L "$test_dir/gnu_symP" ]] && gnu_is_link=1
    [[ -L "$test_dir/f_symP" ]] && f_is_link=1
    if [[ "$gnu_is_link" == "$f_is_link" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -P preserves symlink (is_link=$gnu_is_link)"
        record_result "-P preserves symlink" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -P symlink mismatch"
        record_result "-P preserves symlink" "FAIL" "mismatch" "" ""
    fi

    # -L dereferences symlink
    $GNU_TOOL -L "$test_dir/source_link" "$test_dir/gnu_symL"
    $F_TOOL -L "$test_dir/source_link" "$test_dir/f_symL"

    TESTS_RUN=$((TESTS_RUN + 1))
    gnu_is_link=0; f_is_link=0
    [[ -L "$test_dir/gnu_symL" ]] && gnu_is_link=1
    [[ -L "$test_dir/f_symL" ]] && f_is_link=1
    if [[ "$gnu_is_link" == "$f_is_link" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -L dereferences symlink (is_link=$gnu_is_link)"
        record_result "-L dereferences symlink" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -L symlink mismatch"
        record_result "-L dereferences symlink" "FAIL" "mismatch" "" ""
    fi

    # === Section 6: Hard Link (-l) ===
    echo ""
    echo "=== Hard Link (-l) ==="

    $GNU_TOOL -l "$test_dir/source_file" "$test_dir/gnu_hardlink"
    $F_TOOL -l "$test_dir/source_file" "$test_dir/f_hardlink"

    TESTS_RUN=$((TESTS_RUN + 1))
    local src_inode gnu_inode f_inode
    src_inode=$(stat -c '%i' "$test_dir/source_file" 2>/dev/null || stat -f '%i' "$test_dir/source_file")
    gnu_inode=$(stat -c '%i' "$test_dir/gnu_hardlink" 2>/dev/null || stat -f '%i' "$test_dir/gnu_hardlink")
    f_inode=$(stat -c '%i' "$test_dir/f_hardlink" 2>/dev/null || stat -f '%i' "$test_dir/f_hardlink")
    if [[ "$src_inode" == "$gnu_inode" ]] && [[ "$src_inode" == "$f_inode" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -l creates hard link (same inode)"
        record_result "hard link" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -l inode mismatch (src=$src_inode gnu=$gnu_inode f=$f_inode)"
        record_result "hard link" "FAIL" "inode mismatch" "" ""
    fi

    # === Section 7: Symbolic Link (-s) ===
    echo ""
    echo "=== Symbolic Link (-s) ==="

    $GNU_TOOL -s "$test_dir/source_file" "$test_dir/gnu_symlink"
    $F_TOOL -s "$test_dir/source_file" "$test_dir/f_symlink"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -L "$test_dir/gnu_symlink" ]] && [[ -L "$test_dir/f_symlink" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -s creates symlink"
        record_result "symbolic link" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -s symlink mismatch"
        record_result "symbolic link" "FAIL" "not a symlink" "" ""
    fi

    # === Section 8: No Clobber (-n) ===
    echo ""
    echo "=== No Clobber (-n) ==="

    echo "existing" > "$test_dir/gnu_existing"
    echo "existing" > "$test_dir/f_existing"
    echo "new content" > "$test_dir/new_source"

    $GNU_TOOL -n "$test_dir/new_source" "$test_dir/gnu_existing"
    $F_TOOL -n "$test_dir/new_source" "$test_dir/f_existing"

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

    # === Section 9: Update (-u) ===
    echo ""
    echo "=== Update (-u) ==="

    echo "older" > "$test_dir/older_file"
    sleep 1
    echo "newer" > "$test_dir/newer_file"
    cp "$test_dir/older_file" "$test_dir/gnu_update_target"
    cp "$test_dir/older_file" "$test_dir/f_update_target"

    $GNU_TOOL -u "$test_dir/newer_file" "$test_dir/gnu_update_target"
    $F_TOOL -u "$test_dir/newer_file" "$test_dir/f_update_target"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_update_target" "$test_dir/f_update_target" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -u updates correctly"
        record_result "update" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -u behavior differs"
        record_result "update" "FAIL" "behavior differs" "" ""
    fi

    # === Section 10: Verbose (-v) ===
    echo ""
    echo "=== Verbose (-v) ==="

    run_exit_code_test "cp -v exit code" \
        "$GNU_TOOL -v '$test_dir/source_file' '$test_dir/gnu_v_dest' 2>&1" \
        "$F_TOOL -v '$test_dir/source_file' '$test_dir/f_v_dest' 2>&1"

    # === Section 11: Force (-f) ===
    echo ""
    echo "=== Force (-f) ==="

    echo "readonly target" > "$test_dir/gnu_readonly"
    echo "readonly target" > "$test_dir/f_readonly"
    chmod 444 "$test_dir/gnu_readonly" "$test_dir/f_readonly"

    run_exit_code_test "cp -f over readonly" \
        "$GNU_TOOL -f '$test_dir/source_file' '$test_dir/gnu_readonly' 2>&1" \
        "$F_TOOL -f '$test_dir/source_file' '$test_dir/f_readonly' 2>&1"

    # === Section 12: Copy to Directory ===
    echo ""
    echo "=== Copy to Directory ==="

    mkdir -p "$test_dir/gnu_target_dir" "$test_dir/f_target_dir"
    $GNU_TOOL "$test_dir/source_file" "$test_dir/gnu_target_dir/"
    $F_TOOL "$test_dir/source_file" "$test_dir/f_target_dir/"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_target_dir/source_file" "$test_dir/f_target_dir/source_file" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: copy to directory"
        record_result "copy to directory" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: copy to directory differs"
        record_result "copy to directory" "FAIL" "differs" "" ""
    fi

    # === Section 13: Error Handling ===
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

run_cp_tests
