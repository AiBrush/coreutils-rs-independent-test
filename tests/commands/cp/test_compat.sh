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
    gnu_dst_mode=$(stat -c '%a' "$pmdir/gnu/dst" 2>/dev/null || stat -f '%Lp' "$pmdir/gnu/dst")
    f_dst_mode=$(stat -c '%a' "$pmdir/f/dst" 2>/dev/null || stat -f '%Lp' "$pmdir/f/dst")
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
    gnu_dst2_mode=$(stat -c '%a' "$pmdir/gnu/dst2" 2>/dev/null || stat -f '%Lp' "$pmdir/gnu/dst2")
    f_dst2_mode=$(stat -c '%a' "$pmdir/f/dst2" 2>/dev/null || stat -f '%Lp' "$pmdir/f/dst2")
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
