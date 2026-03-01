#!/usr/bin/env bash
# Compatibility tests for fcp vs GNU cp
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "cp")
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

    # === GNU Upstream: Backup Numbering ===
    echo ""
    echo "=== GNU Upstream: Backup Numbering ==="

    # From backup-1.sh: cp --backup=simple --suffix creates backup when src==dst
    local bkdir
    bkdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$bkdir"
    mkdir -p "$bkdir/gnu" "$bkdir/f"
    echo "test" > "$bkdir/gnu/F"
    echo "test" > "$bkdir/f/F"

    run_exit_code_test "GNU backup-1: --backup=simple --suffix on self-copy" \
        "$GNU_TOOL --force --backup=simple --suffix=.b '$bkdir/gnu/F' '$bkdir/gnu/F'" \
        "$F_TOOL --force --backup=simple --suffix=.b '$bkdir/f/F' '$bkdir/f/F'"

    # Verify backup file was created for both
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_bk_exists=0 f_bk_exists=0
    [[ -f "$bkdir/gnu/F.b" ]] && gnu_bk_exists=1
    [[ -f "$bkdir/f/F.b" ]] && f_bk_exists=1
    if [[ "$gnu_bk_exists" == "$f_bk_exists" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: backup file created (exists=$gnu_bk_exists)"
        record_result "GNU backup-1: backup file created" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: backup file mismatch (GNU=$gnu_bk_exists F=$f_bk_exists)"
        record_result "GNU backup-1: backup file created" "FAIL" "GNU=$gnu_bk_exists F=$f_bk_exists" "" ""
    fi

    # From backup-1.sh: cp -T --backup=simple --suffix on self-copy
    echo "test2" > "$bkdir/gnu/G"
    echo "test2" > "$bkdir/f/G"

    run_exit_code_test "GNU backup-1: -T --backup=simple self-copy" \
        "$GNU_TOOL -T --force --backup=simple --suffix=.b '$bkdir/gnu/G' '$bkdir/gnu/G'" \
        "$F_TOOL -T --force --backup=simple --suffix=.b '$bkdir/f/G' '$bkdir/f/G'"

    # === GNU Upstream: Backup Directory ===
    echo ""
    echo "=== GNU Upstream: Backup Directory ==="

    # From backup-dir.sh: cp -ab should not create spurious backup of dirs
    local bkdirdir
    bkdirdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$bkdirdir"
    mkdir -p "$bkdirdir/gnu/x" "$bkdirdir/gnu/y"
    mkdir -p "$bkdirdir/f/x" "$bkdirdir/f/y"

    # First copy dir into target
    $GNU_TOOL -a "$bkdirdir/gnu/x" "$bkdirdir/gnu/y" 2>/dev/null || true
    $F_TOOL -a "$bkdirdir/f/x" "$bkdirdir/f/y" 2>/dev/null || true

    # Second copy with -ab should not create y/x~ backup
    $GNU_TOOL -ab "$bkdirdir/gnu/x" "$bkdirdir/gnu/y" 2>/dev/null || true
    $F_TOOL -ab "$bkdirdir/f/x" "$bkdirdir/f/y" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_no_bk=1 f_no_bk=1
    [[ -d "$bkdirdir/gnu/y/x~" ]] && gnu_no_bk=0
    [[ -d "$bkdirdir/f/y/x~" ]] && f_no_bk=0
    if [[ "$gnu_no_bk" == "$f_no_bk" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -ab dir no spurious backup (no_backup=$gnu_no_bk)"
        record_result "GNU backup-dir: no spurious dir backup" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -ab dir backup mismatch (GNU no_bk=$gnu_no_bk F no_bk=$f_no_bk)"
        record_result "GNU backup-dir: no spurious dir backup" "FAIL" "GNU=$gnu_no_bk F=$f_no_bk" "" ""
    fi

    # === GNU Upstream: Hard Link with Force ===
    echo ""
    echo "=== GNU Upstream: Hard Link with Force ==="

    # From link.sh: cp -f --link works when target already exists
    local lndir
    lndir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$lndir"
    mkdir -p "$lndir/gnu" "$lndir/f"
    touch "$lndir/gnu/src" "$lndir/gnu/dest"
    touch "$lndir/f/src" "$lndir/f/dest"

    run_exit_code_test "GNU link: cp -f --link over existing" \
        "$GNU_TOOL -f --link '$lndir/gnu/src' '$lndir/gnu/dest'" \
        "$F_TOOL -f --link '$lndir/f/src' '$lndir/f/dest'"

    # Verify they are now hard links (same inode)
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_src_ino gnu_dst_ino f_src_ino f_dst_ino
    gnu_src_ino=$(stat -c '%i' "$lndir/gnu/src" 2>/dev/null || stat -f '%i' "$lndir/gnu/src")
    gnu_dst_ino=$(stat -c '%i' "$lndir/gnu/dest" 2>/dev/null || stat -f '%i' "$lndir/gnu/dest")
    f_src_ino=$(stat -c '%i' "$lndir/f/src" 2>/dev/null || stat -f '%i' "$lndir/f/src")
    f_dst_ino=$(stat -c '%i' "$lndir/f/dest" 2>/dev/null || stat -f '%i' "$lndir/f/dest")
    local gnu_linked=0 f_linked=0
    [[ "$gnu_src_ino" == "$gnu_dst_ino" ]] && gnu_linked=1
    [[ "$f_src_ino" == "$f_dst_ino" ]] && f_linked=1
    if [[ "$gnu_linked" == "$f_linked" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -f --link creates hard link (linked=$gnu_linked)"
        record_result "GNU link: hard link after force" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -f --link mismatch (GNU=$gnu_linked F=$f_linked)"
        record_result "GNU link: hard link after force" "FAIL" "GNU=$gnu_linked F=$f_linked" "" ""
    fi

    # From link.sh: cp -f --symbolic-link over existing
    touch "$lndir/gnu/dest2" "$lndir/f/dest2"

    run_exit_code_test "GNU link: cp -f --symbolic-link over existing" \
        "$GNU_TOOL -f --symbolic-link '$lndir/gnu/src' '$lndir/gnu/dest2'" \
        "$F_TOOL -f --symbolic-link '$lndir/f/src' '$lndir/f/dest2'"

    # === GNU Upstream: Same File Detection ===
    echo ""
    echo "=== GNU Upstream: Same File Detection ==="

    # From same-file.sh: cp file file should fail (same file)
    local sfdir
    sfdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$sfdir"
    mkdir -p "$sfdir/gnu" "$sfdir/f"
    echo "XYZ" > "$sfdir/gnu/foo"
    echo "XYZ" > "$sfdir/f/foo"

    run_exit_code_test "GNU same-file: cp file to itself fails" \
        "$GNU_TOOL '$sfdir/gnu/foo' '$sfdir/gnu/foo' 2>&1" \
        "$F_TOOL '$sfdir/f/foo' '$sfdir/f/foo' 2>&1"

    # Verify the file content is preserved (not truncated)
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_content f_content
    gnu_content=$(cat "$sfdir/gnu/foo")
    f_content=$(cat "$sfdir/f/foo")
    if [[ "$gnu_content" == "$f_content" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: same-file content preserved"
        record_result "GNU same-file: content preserved" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: same-file content mismatch"
        record_result "GNU same-file: content preserved" "FAIL" "GNU='$gnu_content' F='$f_content'" "" ""
    fi

    # same-file with symlink: cp foo symlink should fail when symlink -> foo
    ln -s "$sfdir/gnu/foo" "$sfdir/gnu/symlink"
    ln -s "$sfdir/f/foo" "$sfdir/f/symlink"

    run_exit_code_test "GNU same-file: cp file to its symlink fails" \
        "$GNU_TOOL '$sfdir/gnu/foo' '$sfdir/gnu/symlink' 2>&1" \
        "$F_TOOL '$sfdir/f/foo' '$sfdir/f/symlink' 2>&1"

    # same-file with hardlink: cp foo hardlink should fail
    ln "$sfdir/gnu/foo" "$sfdir/gnu/hardlink"
    ln "$sfdir/f/foo" "$sfdir/f/hardlink"

    run_exit_code_test "GNU same-file: cp file to its hardlink fails" \
        "$GNU_TOOL '$sfdir/gnu/foo' '$sfdir/gnu/hardlink' 2>&1" \
        "$F_TOOL '$sfdir/f/foo' '$sfdir/f/hardlink' 2>&1"

    # === GNU Upstream: Copy Dir Into Self ===
    echo ""
    echo "=== GNU Upstream: Copy Dir Into Self ==="

    # From into-self.sh: cp -R dir dir should fail
    local isdir
    isdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$isdir"
    mkdir -p "$isdir/gnu/dir" "$isdir/f/dir"

    run_exit_code_test "GNU into-self: cp -R dir dir fails" \
        "$GNU_TOOL -R '$isdir/gnu/dir' '$isdir/gnu/dir' 2>&1" \
        "$F_TOOL -R '$isdir/f/dir' '$isdir/f/dir' 2>&1"

    # cp -rl dir dir should also fail
    run_exit_code_test "GNU into-self: cp -rl dir dir fails" \
        "$GNU_TOOL -rl '$isdir/gnu/dir' '$isdir/gnu/dir' 2>&1" \
        "$F_TOOL -rl '$isdir/f/dir' '$isdir/f/dir' 2>&1"

    # === GNU Upstream: Directory Trailing Slash ===
    echo ""
    echo "=== GNU Upstream: Directory Trailing Slash ==="

    # From dir-slash.sh: cp -R dir1/ dir2 should copy dir1 as subdir
    local dsdir
    dsdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$dsdir"
    mkdir -p "$dsdir/gnu/dir1" "$dsdir/gnu/dir2"
    mkdir -p "$dsdir/f/dir1" "$dsdir/f/dir2"
    echo "file content" > "$dsdir/gnu/dir1/file"
    echo "file content" > "$dsdir/f/dir1/file"

    $GNU_TOOL -R "$dsdir/gnu/dir1/" "$dsdir/gnu/dir2" 2>/dev/null || true
    $F_TOOL -R "$dsdir/f/dir1/" "$dsdir/f/dir2" 2>/dev/null || true

    # dir2/file should NOT exist (file goes into dir2/dir1/file)
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_flat=0 f_flat=0
    [[ -r "$dsdir/gnu/dir2/file" ]] && gnu_flat=1
    [[ -r "$dsdir/f/dir2/file" ]] && f_flat=1
    if [[ "$gnu_flat" == "$f_flat" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: trailing slash no flat copy (flat=$gnu_flat)"
        record_result "GNU dir-slash: no flat copy" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: trailing slash flat mismatch (GNU=$gnu_flat F=$f_flat)"
        record_result "GNU dir-slash: no flat copy" "FAIL" "GNU=$gnu_flat F=$f_flat" "" ""
    fi

    # dir2/dir1/file should exist
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_sub=0 f_sub=0
    [[ -r "$dsdir/gnu/dir2/dir1/file" ]] && gnu_sub=1
    [[ -r "$dsdir/f/dir2/dir1/file" ]] && f_sub=1
    if [[ "$gnu_sub" == "$f_sub" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: trailing slash subdir copy (exists=$gnu_sub)"
        record_result "GNU dir-slash: subdir copy" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: trailing slash subdir mismatch (GNU=$gnu_sub F=$f_sub)"
        record_result "GNU dir-slash: subdir copy" "FAIL" "GNU=$gnu_sub F=$f_sub" "" ""
    fi

    # === GNU Upstream: Dir vs File Conflict ===
    echo ""
    echo "=== GNU Upstream: Dir vs File Conflict ==="

    # From dir-vs-file.sh: cp -R dir file should fail
    local dvfdir
    dvfdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$dvfdir"
    mkdir -p "$dvfdir/gnu/dir" "$dvfdir/f/dir"
    touch "$dvfdir/gnu/file" "$dvfdir/f/file"

    run_exit_code_test "GNU dir-vs-file: cp -R dir file fails" \
        "$GNU_TOOL -R '$dvfdir/gnu/dir' '$dvfdir/gnu/file' 2>&1" \
        "$F_TOOL -R '$dvfdir/f/dir' '$dvfdir/f/file' 2>&1"

    # Verify file is still a file, not replaced by dir
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_is_file=0 f_is_file=0
    [[ -f "$dvfdir/gnu/file" ]] && gnu_is_file=1
    [[ -f "$dvfdir/f/file" ]] && f_is_file=1
    if [[ "$gnu_is_file" == "$f_is_file" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: file not replaced by dir (is_file=$gnu_is_file)"
        record_result "GNU dir-vs-file: file preserved" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: file replacement mismatch (GNU=$gnu_is_file F=$f_is_file)"
        record_result "GNU dir-vs-file: file preserved" "FAIL" "GNU=$gnu_is_file F=$f_is_file" "" ""
    fi

    # === GNU Upstream: Preserve Mode ===
    echo ""
    echo "=== GNU Upstream: Preserve Mode ==="

    # From preserve-mode.sh: --no-preserve=mode gives default mode
    local pmdir
    pmdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$pmdir"
    mkdir -p "$pmdir/gnu" "$pmdir/f"

    # Create reference file with default perms, and a 600 source
    touch "$pmdir/gnu/ref" "$pmdir/f/ref"
    touch "$pmdir/gnu/src" "$pmdir/f/src"
    chmod 600 "$pmdir/gnu/src" "$pmdir/f/src"

    $GNU_TOOL --no-preserve=mode "$pmdir/gnu/src" "$pmdir/gnu/dst" 2>/dev/null || true
    $F_TOOL --no-preserve=mode "$pmdir/f/src" "$pmdir/f/dst" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_dst_mode f_dst_mode
    gnu_dst_mode=$(stat -c '%a' "$pmdir/gnu/dst" 2>/dev/null || stat -f '%Lp' "$pmdir/gnu/dst" 2>/dev/null || echo "MISSING")
    f_dst_mode=$(stat -c '%a' "$pmdir/f/dst" 2>/dev/null || stat -f '%Lp' "$pmdir/f/dst" 2>/dev/null || echo "MISSING")
    if [[ "$gnu_dst_mode" == "$f_dst_mode" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --no-preserve=mode gives default mode ($gnu_dst_mode)"
        record_result "GNU preserve-mode: no-preserve default" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --no-preserve=mode mismatch (GNU=$gnu_dst_mode F=$f_dst_mode)"
        record_result "GNU preserve-mode: no-preserve default" "FAIL" "GNU=$gnu_dst_mode F=$f_dst_mode" "" ""
    fi

    # From preserve-mode.sh: --no-preserve=mode --preserve=all (last wins)
    rm -f "$pmdir/gnu/dst2" "$pmdir/f/dst2"
    $GNU_TOOL --no-preserve=mode --preserve=all "$pmdir/gnu/src" "$pmdir/gnu/dst2" 2>/dev/null || true
    $F_TOOL --no-preserve=mode --preserve=all "$pmdir/f/src" "$pmdir/f/dst2" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_dst2_mode f_dst2_mode
    gnu_dst2_mode=$(stat -c '%a' "$pmdir/gnu/dst2" 2>/dev/null || stat -f '%Lp' "$pmdir/gnu/dst2" 2>/dev/null || echo "MISSING")
    f_dst2_mode=$(stat -c '%a' "$pmdir/f/dst2" 2>/dev/null || stat -f '%Lp' "$pmdir/f/dst2" 2>/dev/null || echo "MISSING")
    if [[ "$gnu_dst2_mode" == "$f_dst2_mode" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --no-preserve then --preserve=all mode ($gnu_dst2_mode)"
        record_result "GNU preserve-mode: last option wins" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: contradicting options mode mismatch (GNU=$gnu_dst2_mode F=$f_dst2_mode)"
        record_result "GNU preserve-mode: last option wins" "FAIL" "GNU=$gnu_dst2_mode F=$f_dst2_mode" "" ""
    fi

    # From preserve-mode.sh: --preserve=ownership should not affect mode
    rm -f "$pmdir/gnu/oa" "$pmdir/gnu/ob" "$pmdir/f/oa" "$pmdir/f/ob"
    touch "$pmdir/gnu/osrc" "$pmdir/f/osrc"
    chmod 660 "$pmdir/gnu/osrc" "$pmdir/f/osrc"
    $GNU_TOOL "$pmdir/gnu/osrc" "$pmdir/gnu/oa" 2>/dev/null || true
    $GNU_TOOL --preserve=ownership "$pmdir/gnu/osrc" "$pmdir/gnu/ob" 2>/dev/null || true
    $F_TOOL "$pmdir/f/osrc" "$pmdir/f/oa" 2>/dev/null || true
    $F_TOOL --preserve=ownership "$pmdir/f/osrc" "$pmdir/f/ob" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_oa_mode gnu_ob_mode f_oa_mode f_ob_mode
    gnu_oa_mode=$(stat -c '%a' "$pmdir/gnu/oa" 2>/dev/null || stat -f '%Lp' "$pmdir/gnu/oa")
    gnu_ob_mode=$(stat -c '%a' "$pmdir/gnu/ob" 2>/dev/null || stat -f '%Lp' "$pmdir/gnu/ob")
    f_oa_mode=$(stat -c '%a' "$pmdir/f/oa" 2>/dev/null || stat -f '%Lp' "$pmdir/f/oa")
    f_ob_mode=$(stat -c '%a' "$pmdir/f/ob" 2>/dev/null || stat -f '%Lp' "$pmdir/f/ob")
    local gnu_own_eq=0 f_own_eq=0
    [[ "$gnu_oa_mode" == "$gnu_ob_mode" ]] && gnu_own_eq=1
    [[ "$f_oa_mode" == "$f_ob_mode" ]] && f_own_eq=1
    if [[ "$gnu_own_eq" == "$f_own_eq" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --preserve=ownership no mode change (eq=$gnu_own_eq)"
        record_result "GNU preserve-mode: ownership no mode change" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --preserve=ownership mode mismatch"
        record_result "GNU preserve-mode: ownership no mode change" "FAIL" "GNU eq=$gnu_own_eq F eq=$f_own_eq" "" ""
    fi

    # === GNU Upstream: Source Base Dot ===
    echo ""
    echo "=== GNU Upstream: Source Base Dot ==="

    # From src-base-dot.sh: cp -ab ../x/. . should be a silent no-op
    local sbdir
    sbdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$sbdir"
    mkdir -p "$sbdir/gnu/x" "$sbdir/gnu/y"
    mkdir -p "$sbdir/f/x" "$sbdir/f/y"

    run_exit_code_test "GNU src-base-dot: cp -ab ../x/. . succeeds" \
        "cd '$sbdir/gnu/y' && $GNU_TOOL --verbose -ab ../x/. . 2>&1" \
        "cd '$sbdir/f/y' && $F_TOOL --verbose -ab ../x/. . 2>&1"

    # === Section 13: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent source" \
        "$GNU_TOOL /tmp/nonexistent_$$ '$test_dir/dest' 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ '$test_dir/dest' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # === Section 14: Multiple Files to Directory ===
    echo ""
    echo "=== Multiple Files to Directory ==="

    mkdir -p "$test_dir/gnu_multi_dir" "$test_dir/f_multi_dir"
    echo "file_a" > "$test_dir/multi_a"
    echo "file_b" > "$test_dir/multi_b"
    echo "file_c" > "$test_dir/multi_c"

    $GNU_TOOL "$test_dir/multi_a" "$test_dir/multi_b" "$test_dir/multi_c" "$test_dir/gnu_multi_dir/"
    $F_TOOL "$test_dir/multi_a" "$test_dir/multi_b" "$test_dir/multi_c" "$test_dir/f_multi_dir/"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_multi_dir/multi_a" "$test_dir/f_multi_dir/multi_a" >/dev/null 2>&1 && \
       diff "$test_dir/gnu_multi_dir/multi_b" "$test_dir/f_multi_dir/multi_b" >/dev/null 2>&1 && \
       diff "$test_dir/gnu_multi_dir/multi_c" "$test_dir/f_multi_dir/multi_c" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: multiple files to directory"
        record_result "multiple files to directory" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: multiple files to directory"
        record_result "multiple files to directory" "FAIL" "content differs" "" ""
    fi

    # === Section 15: Interactive Overwrite (-i) ===
    echo ""
    echo "=== Interactive Overwrite (-i) ==="

    echo "existing_i" > "$test_dir/gnu_i_target"
    echo "existing_i" > "$test_dir/f_i_target"
    echo "new_i_content" > "$test_dir/i_source"

    # Pipe "n" (no) to -i, target should not change
    echo "n" | $GNU_TOOL -i "$test_dir/i_source" "$test_dir/gnu_i_target" 2>/dev/null || true
    echo "n" | $F_TOOL -i "$test_dir/i_source" "$test_dir/f_i_target" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_i_target" "$test_dir/f_i_target" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: cp -i with 'n' preserves target"
        record_result "interactive overwrite no" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: cp -i with 'n' behavior differs"
        record_result "interactive overwrite no" "FAIL" "content differs" "" ""
    fi

    # Pipe "y" (yes) to -i, target should be overwritten
    echo "existing_i" > "$test_dir/gnu_i_target2"
    echo "existing_i" > "$test_dir/f_i_target2"

    echo "y" | $GNU_TOOL -i "$test_dir/i_source" "$test_dir/gnu_i_target2" 2>/dev/null || true
    echo "y" | $F_TOOL -i "$test_dir/i_source" "$test_dir/f_i_target2" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_i_target2" "$test_dir/f_i_target2" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: cp -i with 'y' overwrites target"
        record_result "interactive overwrite yes" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: cp -i with 'y' behavior differs"
        record_result "interactive overwrite yes" "FAIL" "content differs" "" ""
    fi

    # === Section 16: Backup Numbered ===
    echo ""
    echo "=== Backup Numbered ==="

    local bndir
    bndir=$(mktemp -d /tmp/fcoreutils_cp_bn_XXXXXX)
    register_temp "$bndir"
    mkdir -p "$bndir/gnu" "$bndir/f"
    echo "original" > "$bndir/gnu/file"
    echo "original" > "$bndir/f/file"
    echo "update1" > "$bndir/gnu/src"
    echo "update1" > "$bndir/f/src"

    $GNU_TOOL --backup=numbered "$bndir/gnu/src" "$bndir/gnu/file" 2>/dev/null || true
    $F_TOOL --backup=numbered "$bndir/f/src" "$bndir/f/file" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_bn_exists=0 f_bn_exists=0
    [[ -f "$bndir/gnu/file.~1~" ]] && gnu_bn_exists=1
    [[ -f "$bndir/f/file.~1~" ]] && f_bn_exists=1
    if [[ "$gnu_bn_exists" == "$f_bn_exists" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --backup=numbered creates .~1~ (exists=$gnu_bn_exists)"
        record_result "backup numbered" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --backup=numbered mismatch (GNU=$gnu_bn_exists F=$f_bn_exists)"
        record_result "backup numbered" "FAIL" "GNU=$gnu_bn_exists F=$f_bn_exists" "" ""
    fi

    # === Section 17: Suffix (--suffix) ===
    echo ""
    echo "=== Suffix (--suffix) ==="

    local sfxdir
    sfxdir=$(mktemp -d /tmp/fcoreutils_cp_sfx_XXXXXX)
    register_temp "$sfxdir"
    mkdir -p "$sfxdir/gnu" "$sfxdir/f"
    echo "original" > "$sfxdir/gnu/file"
    echo "original" > "$sfxdir/f/file"
    echo "replacement" > "$sfxdir/gnu/src"
    echo "replacement" > "$sfxdir/f/src"

    $GNU_TOOL --backup=simple --suffix=.bak "$sfxdir/gnu/src" "$sfxdir/gnu/file" 2>/dev/null || true
    $F_TOOL --backup=simple --suffix=.bak "$sfxdir/f/src" "$sfxdir/f/file" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_sfx=0 f_sfx=0
    [[ -f "$sfxdir/gnu/file.bak" ]] && gnu_sfx=1
    [[ -f "$sfxdir/f/file.bak" ]] && f_sfx=1
    if [[ "$gnu_sfx" == "$f_sfx" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --suffix=.bak creates backup (exists=$gnu_sfx)"
        record_result "suffix .bak" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --suffix=.bak mismatch (GNU=$gnu_sfx F=$f_sfx)"
        record_result "suffix .bak" "FAIL" "GNU=$gnu_sfx F=$f_sfx" "" ""
    fi

    # === Section 18: Verbose Output Format ===
    echo ""
    echo "=== Verbose Output Format ==="

    # Custom comparison: cp -v includes the destination path in output,
    # so we normalize it before comparing (both use "DEST" as placeholder).
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_v_out f_v_out
    gnu_v_out=$($GNU_TOOL -v "$test_dir/source_file" "$test_dir/gnu_v_fmt" 2>&1 | sed "s|$test_dir/gnu_v_fmt|DEST|g")
    f_v_out=$($F_TOOL -v "$test_dir/source_file" "$test_dir/f_v_fmt" 2>&1 | sed "s|$test_dir/f_v_fmt|DEST|g")
    if [[ "$gnu_v_out" == "$f_v_out" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: cp -v output format"
        record_result "cp -v output format" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: cp -v output format"
        echo -e "    GNU (normalized): $gnu_v_out"
        echo -e "    F (normalized):   $f_v_out"
        record_result "cp -v output format" "FAIL" "GNU='$gnu_v_out' F='$f_v_out'" "" ""
    fi

    # === Section 19: Target Directory (-t) ===
    echo ""
    echo "=== Target Directory (-t) ==="

    mkdir -p "$test_dir/gnu_tdir" "$test_dir/f_tdir"
    echo "tdir_src1" > "$test_dir/tdir_s1"
    echo "tdir_src2" > "$test_dir/tdir_s2"

    run_exit_code_test "cp -t dir src1 src2" \
        "$GNU_TOOL -t '$test_dir/gnu_tdir' '$test_dir/tdir_s1' '$test_dir/tdir_s2'" \
        "$F_TOOL -t '$test_dir/f_tdir' '$test_dir/tdir_s1' '$test_dir/tdir_s2'"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$test_dir/gnu_tdir/tdir_s1" ]] && [[ -f "$test_dir/f_tdir/tdir_s1" ]] && \
       diff "$test_dir/gnu_tdir/tdir_s1" "$test_dir/f_tdir/tdir_s1" >/dev/null 2>&1 && \
       diff "$test_dir/gnu_tdir/tdir_s2" "$test_dir/f_tdir/tdir_s2" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -t copies files to target directory"
        record_result "target directory content" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -t content mismatch"
        record_result "target directory content" "FAIL" "content differs" "" ""
    fi

    # === Section 20: No Target Directory (-T) ===
    echo ""
    echo "=== No Target Directory (-T) ==="

    run_exit_code_test "cp -T src dst" \
        "$GNU_TOOL -T '$test_dir/source_file' '$test_dir/gnu_T_dest'" \
        "$F_TOOL -T '$test_dir/source_file' '$test_dir/f_T_dest'"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_T_dest" "$test_dir/f_T_dest" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -T copy content matches"
        record_result "no target directory content" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -T copy content differs"
        record_result "no target directory content" "FAIL" "content differs" "" ""
    fi

    # === Section 21: Dangling Symlink ===
    echo ""
    echo "=== Dangling Symlink ==="

    ln -s "/tmp/nonexistent_target_$$" "$test_dir/dangling_link"

    run_exit_code_test "cp dangling symlink" \
        "$GNU_TOOL '$test_dir/dangling_link' '$test_dir/gnu_dangling_dest' 2>&1" \
        "$F_TOOL '$test_dir/dangling_link' '$test_dir/f_dangling_dest' 2>&1"

    # === Section 22: Sparse Auto ===
    echo ""
    echo "=== Sparse Auto ==="

    if is_linux; then
        run_exit_code_test "cp --sparse=auto" \
            "$GNU_TOOL --sparse=auto '$test_dir/source_file' '$test_dir/gnu_sparse'" \
            "$F_TOOL --sparse=auto '$test_dir/source_file' '$test_dir/f_sparse'"
    else
        skip_test "cp --sparse=auto" "sparse files only supported on Linux"
    fi

    # === Section 23: Reflink Auto ===
    echo ""
    echo "=== Reflink Auto ==="

    run_exit_code_test "cp --reflink=auto" \
        "$GNU_TOOL --reflink=auto '$test_dir/source_file' '$test_dir/gnu_reflink'" \
        "$F_TOOL --reflink=auto '$test_dir/source_file' '$test_dir/f_reflink'"

    # === Section 24: Preserve Timestamps ===
    echo ""
    echo "=== Preserve Timestamps ==="

    $GNU_TOOL --preserve=timestamps "$test_dir/source_file" "$test_dir/gnu_ts"
    $F_TOOL --preserve=timestamps "$test_dir/source_file" "$test_dir/f_ts"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_mtime f_mtime
    gnu_mtime=$(stat -c '%Y' "$test_dir/gnu_ts" 2>/dev/null || stat -f '%m' "$test_dir/gnu_ts")
    f_mtime=$(stat -c '%Y' "$test_dir/f_ts" 2>/dev/null || stat -f '%m' "$test_dir/f_ts")
    if [[ "$gnu_mtime" == "$f_mtime" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --preserve=timestamps (mtime=$gnu_mtime)"
        record_result "preserve timestamps" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --preserve=timestamps mtime mismatch (GNU=$gnu_mtime F=$f_mtime)"
        record_result "preserve timestamps" "FAIL" "GNU=$gnu_mtime F=$f_mtime" "" ""
    fi

    # === Section 25: Preserve Xattr ===
    echo ""
    echo "=== Preserve Xattr ==="

    if is_linux; then
        run_exit_code_test "cp --preserve=xattr" \
            "$GNU_TOOL --preserve=xattr '$test_dir/source_file' '$test_dir/gnu_xattr'" \
            "$F_TOOL --preserve=xattr '$test_dir/source_file' '$test_dir/f_xattr'"
    else
        skip_test "cp --preserve=xattr" "xattr preserve test only on Linux"
    fi

    # === Section 26: Source is Directory Without -r ===
    echo ""
    echo "=== Source is Directory Without -r ==="

    run_exit_code_test "cp dir without -r fails" \
        "$GNU_TOOL '$test_dir/source_dir' '$test_dir/gnu_no_r' 2>&1" \
        "$F_TOOL '$test_dir/source_dir' '$test_dir/f_no_r' 2>&1"

    # === Section 27: Empty File ===
    echo ""
    echo "=== Empty File ==="

    touch "$test_dir/empty_file"

    $GNU_TOOL "$test_dir/empty_file" "$test_dir/gnu_empty_copy"
    $F_TOOL "$test_dir/empty_file" "$test_dir/f_empty_copy"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_empty_size f_empty_size
    gnu_empty_size=$(stat -c '%s' "$test_dir/gnu_empty_copy" 2>/dev/null || stat -f '%z' "$test_dir/gnu_empty_copy")
    f_empty_size=$(stat -c '%s' "$test_dir/f_empty_copy" 2>/dev/null || stat -f '%z' "$test_dir/f_empty_copy")
    if [[ "$gnu_empty_size" == "0" ]] && [[ "$f_empty_size" == "0" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: empty file copy (size=0)"
        record_result "empty file copy" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: empty file copy size mismatch (GNU=$gnu_empty_size F=$f_empty_size)"
        record_result "empty file copy" "FAIL" "GNU=$gnu_empty_size F=$f_empty_size" "" ""
    fi

    # === Section 28: Special Characters in Filename ===
    echo ""
    echo "=== Special Characters in Filename ==="

    echo "space content" > "$test_dir/file with spaces"

    $GNU_TOOL "$test_dir/file with spaces" "$test_dir/gnu_space_copy" 2>/dev/null || true
    $F_TOOL "$test_dir/file with spaces" "$test_dir/f_space_copy" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_space_copy" "$test_dir/f_space_copy" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: filename with spaces"
        record_result "special chars spaces" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: filename with spaces differs"
        record_result "special chars spaces" "FAIL" "content differs" "" ""
    fi

    echo "unicode content" > "$test_dir/file_unicode_test"

    $GNU_TOOL "$test_dir/file_unicode_test" "$test_dir/gnu_unicode_copy" 2>/dev/null || true
    $F_TOOL "$test_dir/file_unicode_test" "$test_dir/f_unicode_copy" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_unicode_copy" "$test_dir/f_unicode_copy" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: unicode filename"
        record_result "special chars unicode" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: unicode filename differs"
        record_result "special chars unicode" "FAIL" "content differs" "" ""
    fi

    # === Section 29: Recursive Symlinks -rL ===
    echo ""
    echo "=== Recursive Symlinks (-rL) ==="

    local rldir
    rldir=$(mktemp -d /tmp/fcoreutils_cp_rL_XXXXXX)
    register_temp "$rldir"
    mkdir -p "$rldir/src/sub"
    echo "real_file" > "$rldir/src/real"
    ln -s "$rldir/src/real" "$rldir/src/sub/link_to_real"

    $GNU_TOOL -rL "$rldir/src" "$rldir/gnu_copy" 2>/dev/null || true
    $F_TOOL -rL "$rldir/src" "$rldir/f_copy" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_rL_is_link=0 f_rL_is_link=0
    [[ -L "$rldir/gnu_copy/sub/link_to_real" ]] && gnu_rL_is_link=1
    [[ -L "$rldir/f_copy/sub/link_to_real" ]] && f_rL_is_link=1
    if [[ "$gnu_rL_is_link" == "$f_rL_is_link" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -rL dereferences symlinks (is_link=$gnu_rL_is_link)"
        record_result "recursive symlinks -rL" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -rL symlink mismatch (GNU=$gnu_rL_is_link F=$f_rL_is_link)"
        record_result "recursive symlinks -rL" "FAIL" "GNU=$gnu_rL_is_link F=$f_rL_is_link" "" ""
    fi

    # === Section 30: Recursive Symlinks -rP ===
    echo ""
    echo "=== Recursive Symlinks (-rP) ==="

    local rpdir
    rpdir=$(mktemp -d /tmp/fcoreutils_cp_rP_XXXXXX)
    register_temp "$rpdir"
    mkdir -p "$rpdir/src/sub"
    echo "real_file" > "$rpdir/src/real"
    ln -s "$rpdir/src/real" "$rpdir/src/sub/link_to_real"

    $GNU_TOOL -rP "$rpdir/src" "$rpdir/gnu_copy" 2>/dev/null || true
    $F_TOOL -rP "$rpdir/src" "$rpdir/f_copy" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_rP_is_link=0 f_rP_is_link=0
    [[ -L "$rpdir/gnu_copy/sub/link_to_real" ]] && gnu_rP_is_link=1
    [[ -L "$rpdir/f_copy/sub/link_to_real" ]] && f_rP_is_link=1
    if [[ "$gnu_rP_is_link" == "$f_rP_is_link" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -rP preserves symlinks (is_link=$gnu_rP_is_link)"
        record_result "recursive symlinks -rP" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -rP symlink mismatch (GNU=$gnu_rP_is_link F=$f_rP_is_link)"
        record_result "recursive symlinks -rP" "FAIL" "GNU=$gnu_rP_is_link F=$f_rP_is_link" "" ""
    fi

    # === Section 31: No Clobber Source Preserved ===
    echo ""
    echo "=== No Clobber Source Preserved ==="

    echo "source_content_nc" > "$test_dir/nc_source"
    echo "target_content_nc" > "$test_dir/nc_target"

    $F_TOOL -n "$test_dir/nc_source" "$test_dir/nc_target" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local nc_src_content
    nc_src_content=$(cat "$test_dir/nc_source")
    if [[ "$nc_src_content" == "source_content_nc" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -n preserves source file"
        record_result "no clobber source preserved" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -n source file modified"
        record_result "no clobber source preserved" "FAIL" "source was modified" "" ""
    fi

    # === Section 32: Multiple Preserve Options ===
    echo ""
    echo "=== Multiple Preserve Options ==="

    chmod 755 "$test_dir/source_file"
    $GNU_TOOL --preserve=timestamps,mode "$test_dir/source_file" "$test_dir/gnu_multi_preserve"
    $F_TOOL --preserve=timestamps,mode "$test_dir/source_file" "$test_dir/f_multi_preserve"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_mp_mode f_mp_mode gnu_mp_mtime f_mp_mtime
    gnu_mp_mode=$(stat -c '%a' "$test_dir/gnu_multi_preserve" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_multi_preserve")
    f_mp_mode=$(stat -c '%a' "$test_dir/f_multi_preserve" 2>/dev/null || stat -f '%Lp' "$test_dir/f_multi_preserve")
    gnu_mp_mtime=$(stat -c '%Y' "$test_dir/gnu_multi_preserve" 2>/dev/null || stat -f '%m' "$test_dir/gnu_multi_preserve")
    f_mp_mtime=$(stat -c '%Y' "$test_dir/f_multi_preserve" 2>/dev/null || stat -f '%m' "$test_dir/f_multi_preserve")
    if [[ "$gnu_mp_mode" == "$f_mp_mode" ]] && [[ "$gnu_mp_mtime" == "$f_mp_mtime" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --preserve=timestamps,mode (mode=$gnu_mp_mode)"
        record_result "multiple preserve options" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --preserve=timestamps,mode mismatch (mode: GNU=$gnu_mp_mode F=$f_mp_mode, mtime: GNU=$gnu_mp_mtime F=$f_mp_mtime)"
        record_result "multiple preserve options" "FAIL" "mode or mtime mismatch" "" ""
    fi

    # === Section 33: Parents Flag (--parents) ===
    echo ""
    echo "=== Parents Flag (--parents) ==="

    local pardir
    pardir=$(mktemp -d /tmp/fcoreutils_cp_par_XXXXXX)
    register_temp "$pardir"
    mkdir -p "$pardir/src/a/b"
    echo "parents_content" > "$pardir/src/a/b/file"
    mkdir -p "$pardir/gnu_dest" "$pardir/f_dest"

    $GNU_TOOL --parents "$pardir/src/a/b/file" "$pardir/gnu_dest" 2>/dev/null || true
    $F_TOOL --parents "$pardir/src/a/b/file" "$pardir/f_dest" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_par_exists=0 f_par_exists=0
    [[ -f "$pardir/gnu_dest/$pardir/src/a/b/file" ]] && gnu_par_exists=1
    [[ -f "$pardir/f_dest/$pardir/src/a/b/file" ]] && f_par_exists=1
    if [[ "$gnu_par_exists" == "$f_par_exists" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --parents preserves path structure (exists=$gnu_par_exists)"
        record_result "parents flag" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --parents mismatch (GNU=$gnu_par_exists F=$f_par_exists)"
        record_result "parents flag" "FAIL" "GNU=$gnu_par_exists F=$f_par_exists" "" ""
    fi

    # === Section 34: One File System (-x) ===
    echo ""
    echo "=== One File System (-x) ==="

    run_exit_code_test "cp -rx within same filesystem" \
        "$GNU_TOOL -rx '$test_dir/source_dir' '$test_dir/gnu_x_copy'" \
        "$F_TOOL -rx '$test_dir/source_dir' '$test_dir/f_x_copy'"

    # === Section 35: Strip Trailing Slashes ===
    echo ""
    echo "=== Strip Trailing Slashes ==="

    run_exit_code_test "cp --strip-trailing-slashes" \
        "$GNU_TOOL --strip-trailing-slashes '$test_dir/source_file' '$test_dir/gnu_strip_dest'" \
        "$F_TOOL --strip-trailing-slashes '$test_dir/source_file' '$test_dir/f_strip_dest'"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_strip_dest" "$test_dir/f_strip_dest" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --strip-trailing-slashes content matches"
        record_result "strip trailing slashes content" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --strip-trailing-slashes content differs"
        record_result "strip trailing slashes content" "FAIL" "content differs" "" ""
    fi

    # === Section 36: Attributes Only ===
    echo ""
    echo "=== Attributes Only ==="

    echo "attr_source" > "$test_dir/attr_src"
    echo "attr_existing" > "$test_dir/gnu_attr_dst"
    echo "attr_existing" > "$test_dir/f_attr_dst"
    chmod 755 "$test_dir/attr_src"

    run_exit_code_test "cp --attributes-only" \
        "$GNU_TOOL --attributes-only --preserve=mode '$test_dir/attr_src' '$test_dir/gnu_attr_dst'" \
        "$F_TOOL --attributes-only --preserve=mode '$test_dir/attr_src' '$test_dir/f_attr_dst'"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_attr_content f_attr_content
    gnu_attr_content=$(cat "$test_dir/gnu_attr_dst" 2>/dev/null || echo "")
    f_attr_content=$(cat "$test_dir/f_attr_dst" 2>/dev/null || echo "")
    if [[ "$gnu_attr_content" == "$f_attr_content" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --attributes-only content behavior matches"
        record_result "attributes only content" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --attributes-only content mismatch"
        record_result "attributes only content" "FAIL" "GNU='$gnu_attr_content' F='$f_attr_content'" "" ""
    fi

    # === Section 37: Help (--help) ===
    echo ""
    echo "=== Help (--help) ==="

    run_exit_code_test "cp --help" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    # === Section 38: Version (--version) ===
    echo ""
    echo "=== Version (--version) ==="

    run_exit_code_test "cp --version" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_cp_tests
