#!/usr/bin/env bash
# Compatibility tests for fln vs GNU ln
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "ln")
F_TOOL="fln"

run_ln_tests() {
    init_test_suite "ln"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"ln","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/ln_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU ln not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_ln_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Hard Links ==="

    # Setup
    echo "source file content" > "$WORK_DIR/source.txt"

    run_test "create hard link" \
        "$GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/gnu_hardlink.txt' && stat -c '%i' '$WORK_DIR/gnu_hardlink.txt' && cat '$WORK_DIR/gnu_hardlink.txt'" \
        "$F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/f_hardlink.txt' && stat -c '%i' '$WORK_DIR/f_hardlink.txt' && cat '$WORK_DIR/f_hardlink.txt'"

    run_test "hard link shares inode" \
        "$GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/gnu_hlink2.txt' && test \$(stat -c '%i' '$WORK_DIR/source.txt') -eq \$(stat -c '%i' '$WORK_DIR/gnu_hlink2.txt') && echo 'SAME_INODE'" \
        "$F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/f_hlink2.txt' && test \$(stat -c '%i' '$WORK_DIR/source.txt') -eq \$(stat -c '%i' '$WORK_DIR/f_hlink2.txt') && echo 'SAME_INODE'"

    echo ""
    echo "=== Symbolic Links (-s) ==="

    run_test "create symlink" \
        "$GNU_TOOL -s '$WORK_DIR/source.txt' '$WORK_DIR/gnu_symlink.txt' && readlink '$WORK_DIR/gnu_symlink.txt'" \
        "$F_TOOL -s '$WORK_DIR/source.txt' '$WORK_DIR/f_symlink.txt' && readlink '$WORK_DIR/f_symlink.txt'"

    run_test "symlink to directory" \
        "mkdir -p '$WORK_DIR/gnu_target_dir' && $GNU_TOOL -s '$WORK_DIR/gnu_target_dir' '$WORK_DIR/gnu_dirlink' && test -L '$WORK_DIR/gnu_dirlink' && echo 'IS_SYMLINK'" \
        "mkdir -p '$WORK_DIR/f_target_dir' && $F_TOOL -s '$WORK_DIR/f_target_dir' '$WORK_DIR/f_dirlink' && test -L '$WORK_DIR/f_dirlink' && echo 'IS_SYMLINK'"

    run_test "symlink with relative path" \
        "cd '$WORK_DIR' && $GNU_TOOL -s source.txt gnu_rellink && readlink gnu_rellink && cd -" \
        "cd '$WORK_DIR' && $F_TOOL -s source.txt f_rellink && readlink f_rellink && cd -"

    run_test "symlink to nonexistent target (dangling)" \
        "$GNU_TOOL -s '/nonexistent/path_$$' '$WORK_DIR/gnu_dangling' && test -L '$WORK_DIR/gnu_dangling' && echo 'DANGLING_OK'" \
        "$F_TOOL -s '/nonexistent/path_$$' '$WORK_DIR/f_dangling' && test -L '$WORK_DIR/f_dangling' && echo 'DANGLING_OK'"

    echo ""
    echo "=== Force (-f) ==="

    echo "original" > "$WORK_DIR/force_target.txt"
    echo "new content" > "$WORK_DIR/force_new.txt"

    run_test "force overwrite existing link" \
        "$GNU_TOOL -s '$WORK_DIR/force_target.txt' '$WORK_DIR/gnu_forcelink' && $GNU_TOOL -sf '$WORK_DIR/force_new.txt' '$WORK_DIR/gnu_forcelink' && readlink '$WORK_DIR/gnu_forcelink'" \
        "$F_TOOL -s '$WORK_DIR/force_target.txt' '$WORK_DIR/f_forcelink' && $F_TOOL -sf '$WORK_DIR/force_new.txt' '$WORK_DIR/f_forcelink' && readlink '$WORK_DIR/f_forcelink'"

    echo ""
    echo "=== No Dereference (-n) ==="

    run_test "no-dereference with symlink target" \
        "$GNU_TOOL -s '$WORK_DIR/source.txt' '$WORK_DIR/gnu_noderef_step1' && $GNU_TOOL -sfn '$WORK_DIR/force_new.txt' '$WORK_DIR/gnu_noderef_step1' && readlink '$WORK_DIR/gnu_noderef_step1'" \
        "$F_TOOL -s '$WORK_DIR/source.txt' '$WORK_DIR/f_noderef_step1' && $F_TOOL -sfn '$WORK_DIR/force_new.txt' '$WORK_DIR/f_noderef_step1' && readlink '$WORK_DIR/f_noderef_step1'"

    echo ""
    echo "=== Verbose (-v) ==="

    # Normalize filenames in verbose output to avoid false diff on gnu_/f_ prefix
    run_test "verbose output" \
        "$GNU_TOOL -sv '$WORK_DIR/source.txt' '$WORK_DIR/gnu_verbose_link' 2>&1 | sed 's|gnu_verbose_link|_verbose_link|g'" \
        "$F_TOOL -sv '$WORK_DIR/source.txt' '$WORK_DIR/f_verbose_link' 2>&1 | sed 's|f_verbose_link|_verbose_link|g'"

    echo ""
    echo "=== Link into Directory ==="

    mkdir -p "$WORK_DIR/gnu_linkdir" "$WORK_DIR/f_linkdir"

    run_test "link file into directory" \
        "$GNU_TOOL -s '$WORK_DIR/source.txt' '$WORK_DIR/gnu_linkdir/' && readlink '$WORK_DIR/gnu_linkdir/source.txt'" \
        "$F_TOOL -s '$WORK_DIR/source.txt' '$WORK_DIR/f_linkdir/' && readlink '$WORK_DIR/f_linkdir/source.txt'"

    echo ""
    echo "=== Backup Options ==="

    echo "backup target" > "$WORK_DIR/backup_target.txt"

    run_test "backup with -b" \
        "$GNU_TOOL -s '$WORK_DIR/source.txt' '$WORK_DIR/gnu_backup_link' && $GNU_TOOL -sb '$WORK_DIR/backup_target.txt' '$WORK_DIR/gnu_backup_link' && test -e '$WORK_DIR/gnu_backup_link~' && echo 'BACKUP_EXISTS'" \
        "$F_TOOL -s '$WORK_DIR/source.txt' '$WORK_DIR/f_backup_link' && $F_TOOL -sb '$WORK_DIR/backup_target.txt' '$WORK_DIR/f_backup_link' && test -e '$WORK_DIR/f_backup_link~' && echo 'BACKUP_EXISTS'"

    echo ""
    echo "=== GNU Upstream: Misc Operations ==="

    # From misc.sh: basic symlink in current directory
    local GNU_WORK=$(mktemp -d /tmp/fcoreutils_ln_gnu_XXXXXX)
    register_temp "$GNU_WORK"
    local F_GNU_WORK=$(mktemp -d /tmp/fcoreutils_ln_fgnu_XXXXXX)
    register_temp "$F_GNU_WORK"

    # Create symlink with source and dest in same directory
    touch "$GNU_WORK/misc_file" "$F_GNU_WORK/misc_file"
    run_test "gnu: symlink in same dir" \
        "$GNU_TOOL -s '$GNU_WORK/misc_file' '$GNU_WORK/misc_link' && test -L '$GNU_WORK/misc_link' && echo OK" \
        "$F_TOOL -s '$F_GNU_WORK/misc_file' '$F_GNU_WORK/misc_link' && test -L '$F_GNU_WORK/misc_link' && echo OK"

    # Symlink with explicit subdirectory destination
    mkdir -p "$GNU_WORK/sub1" "$F_GNU_WORK/sub1"
    touch "$GNU_WORK/srcf" "$F_GNU_WORK/srcf"
    run_test "gnu: symlink into subdir" \
        "$GNU_TOOL -s '../srcf' '$GNU_WORK/sub1/link1' && test -L '$GNU_WORK/sub1/link1' && echo OK" \
        "$F_TOOL -s '../srcf' '$F_GNU_WORK/sub1/link1' && test -L '$F_GNU_WORK/sub1/link1' && echo OK"

    # From misc.sh: trailing slash detection
    mkdir -p "$GNU_WORK/tdir" "$GNU_WORK/tdir/srcf2" "$F_GNU_WORK/tdir" "$F_GNU_WORK/tdir/srcf2"
    touch "$GNU_WORK/srcf2" "$F_GNU_WORK/srcf2"
    run_exit_code_test "gnu: trailing slash blocked" \
        "$GNU_TOOL '$GNU_WORK/srcf2' '$GNU_WORK/tdir/' 2>&1" \
        "$F_TOOL '$F_GNU_WORK/srcf2' '$F_GNU_WORK/tdir/' 2>&1"

    # From misc.sh: -sf same file should fail
    touch "$GNU_WORK/sametest" "$F_GNU_WORK/sametest"
    run_exit_code_test "gnu: -sf same src and dest" \
        "$GNU_TOOL -sf '$GNU_WORK/sametest' '$GNU_WORK/sametest' 2>&1" \
        "$F_TOOL -sf '$F_GNU_WORK/sametest' '$F_GNU_WORK/sametest' 2>&1"

    # From misc.sh: -f on existing hard link should succeed
    touch "$GNU_WORK/hf1" "$F_GNU_WORK/hf1"
    mkdir -p "$GNU_WORK/hdir" "$F_GNU_WORK/hdir"
    run_test "gnu: -f overwrite hard link into dir" \
        "$GNU_TOOL '$GNU_WORK/hf1' '$GNU_WORK/hdir' && $GNU_TOOL -f '$GNU_WORK/hf1' '$GNU_WORK/hdir' && test -d '$GNU_WORK/hdir' && echo OK" \
        "$F_TOOL '$F_GNU_WORK/hf1' '$F_GNU_WORK/hdir' && $F_TOOL -f '$F_GNU_WORK/hf1' '$F_GNU_WORK/hdir' && test -d '$F_GNU_WORK/hdir' && echo OK"

    echo ""
    echo "=== GNU Upstream: Symlink Force Replace ==="

    # From sf-1.sh: ln -sf replacing symlinks to various targets
    echo "foo" > "$GNU_WORK/sf_a"
    echo "foo" > "$F_GNU_WORK/sf_a"

    # Replace symlink pointing to missing target
    run_test "gnu: -sf replace ENOENT link" \
        "$GNU_TOOL -sf missing '$GNU_WORK/enoent_link' && $GNU_TOOL -sf '$GNU_WORK/sf_a' '$GNU_WORK/enoent_link' && readlink '$GNU_WORK/enoent_link'" \
        "$F_TOOL -sf missing '$F_GNU_WORK/enoent_link' && $F_TOOL -sf '$F_GNU_WORK/sf_a' '$F_GNU_WORK/enoent_link' && readlink '$F_GNU_WORK/enoent_link'"

    # Replace symlink pointing to a/b (ENOTDIR)
    run_test "gnu: -sf replace ENOTDIR link" \
        "$GNU_TOOL -sf a/b '$GNU_WORK/enotdir_link' && $GNU_TOOL -sf '$GNU_WORK/sf_a' '$GNU_WORK/enotdir_link' && readlink '$GNU_WORK/enotdir_link'" \
        "$F_TOOL -sf a/b '$F_GNU_WORK/enotdir_link' && $F_TOOL -sf '$F_GNU_WORK/sf_a' '$F_GNU_WORK/enotdir_link' && readlink '$F_GNU_WORK/enotdir_link'"

    echo ""
    echo "=== GNU Upstream: Target Directory ==="

    # From target-1.sh: --target-dir with one file
    mkdir -p "$GNU_WORK/tgt_d" "$F_GNU_WORK/tgt_d"
    run_test "gnu: -s --target-dir" \
        "$GNU_TOOL -s --target-dir='$GNU_WORK/tgt_d' ../targetfile && readlink '$GNU_WORK/tgt_d/targetfile'" \
        "$F_TOOL -s --target-dir='$F_GNU_WORK/tgt_d' ../targetfile && readlink '$F_GNU_WORK/tgt_d/targetfile'"

    echo ""
    echo "=== GNU Upstream: Backup Operations ==="

    # From backup-1.sh: symlink with backup where backup is hard link to dest
    touch "$GNU_WORK/bk_a" "$GNU_WORK/bk_b" "$F_GNU_WORK/bk_a" "$F_GNU_WORK/bk_b"
    $GNU_TOOL "$GNU_WORK/bk_b" "$GNU_WORK/bk_b~" 2>/dev/null || true
    $F_TOOL "$F_GNU_WORK/bk_b" "$F_GNU_WORK/bk_b~" 2>/dev/null || true
    run_test "gnu: backup with hard link dest" \
        "$GNU_TOOL -f --b=simple '$GNU_WORK/bk_a' '$GNU_WORK/bk_b' && echo OK" \
        "$F_TOOL -f --b=simple '$F_GNU_WORK/bk_a' '$F_GNU_WORK/bk_b' && echo OK"

    # From hard-backup.sh: --backup same file should fail
    touch "$GNU_WORK/hb_f" "$F_GNU_WORK/hb_f"
    run_exit_code_test "gnu: --backup same file" \
        "$GNU_TOOL --backup '$GNU_WORK/hb_f' '$GNU_WORK/hb_f' 2>&1" \
        "$F_TOOL --backup '$F_GNU_WORK/hb_f' '$F_GNU_WORK/hb_f' 2>&1"

    # From misc.sh: simple backup via --backup=simple --suffix
    touch "$GNU_WORK/bk_x" "$GNU_WORK/bk_ax" "$F_GNU_WORK/bk_x" "$F_GNU_WORK/bk_ax"
    run_test "gnu: --backup=simple --suffix" \
        "$GNU_TOOL --backup=simple --suffix=.orig '$GNU_WORK/bk_x' '$GNU_WORK/bk_ax' && test -f '$GNU_WORK/bk_ax.orig' && echo OK" \
        "$F_TOOL --backup=simple --suffix=.orig '$F_GNU_WORK/bk_x' '$F_GNU_WORK/bk_ax' && test -f '$F_GNU_WORK/bk_ax.orig' && echo OK"

    echo ""
    echo "=== GNU Upstream: Slash-Decorated Dest ==="

    # From slash-decorated-nonexistent-dest.sh: ln -T f no-such-file/ should fail
    touch "$GNU_WORK/sd_f" "$F_GNU_WORK/sd_f"
    run_exit_code_test "gnu: -T with trailing slash" \
        "$GNU_TOOL -T '$GNU_WORK/sd_f' '$GNU_WORK/no-such-file/' 2>&1" \
        "$F_TOOL -T '$F_GNU_WORK/sd_f' '$F_GNU_WORK/no-such-file/' 2>&1"

    echo ""
    echo "=== GNU Upstream: -L and -P Flags ==="

    # From hard-to-sym.sh: -s silently overrides -L and -P
    touch "$GNU_WORK/lp_a" "$F_GNU_WORK/lp_a"
    run_test "gnu: -L -s creates symlink" \
        "$GNU_TOOL -L -s '$GNU_WORK/lp_a' '$GNU_WORK/lp_sym1' && test -L '$GNU_WORK/lp_sym1' && echo OK" \
        "$F_TOOL -L -s '$F_GNU_WORK/lp_a' '$F_GNU_WORK/lp_sym1' && test -L '$F_GNU_WORK/lp_sym1' && echo OK"

    run_test "gnu: -P -s creates symlink" \
        "$GNU_TOOL -P -s '$GNU_WORK/lp_sym1' '$GNU_WORK/lp_sym2' && test -L '$GNU_WORK/lp_sym2' && echo OK" \
        "$F_TOOL -P -s '$F_GNU_WORK/lp_sym1' '$F_GNU_WORK/lp_sym2' && test -L '$F_GNU_WORK/lp_sym2' && echo OK"

    # -L creates hard link following symlinks
    run_test "gnu: -L hard link follows symlink" \
        "$GNU_TOOL -L '$GNU_WORK/lp_sym1' '$GNU_WORK/lp_hard_a' && test ! -L '$GNU_WORK/lp_hard_a' && echo OK" \
        "$F_TOOL -L '$F_GNU_WORK/lp_sym1' '$F_GNU_WORK/lp_hard_a' && test ! -L '$F_GNU_WORK/lp_hard_a' && echo OK"

    # -L on dangling symlink should fail
    $GNU_TOOL -s /no-such-dir-$$ "$GNU_WORK/dangle" 2>/dev/null || true
    $F_TOOL -s /no-such-dir-$$ "$F_GNU_WORK/dangle" 2>/dev/null || true
    run_exit_code_test "gnu: -L on dangling symlink" \
        "$GNU_TOOL -L '$GNU_WORK/dangle' '$GNU_WORK/hard_to_dangle' 2>&1" \
        "$F_TOOL -L '$F_GNU_WORK/dangle' '$F_GNU_WORK/hard_to_dangle' 2>&1"

    # -P creates hard link to symlink itself
    run_test "gnu: -P hard link to dangling symlink" \
        "$GNU_TOOL -P '$GNU_WORK/dangle' '$GNU_WORK/hard_dangle' && test -L '$GNU_WORK/hard_dangle' && echo OK" \
        "$F_TOOL -P '$F_GNU_WORK/dangle' '$F_GNU_WORK/hard_dangle' && test -L '$F_GNU_WORK/hard_dangle' && echo OK"

    rm -rf "$GNU_WORK" "$F_GNU_WORK"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "link to nonexistent source (hard link)" \
        "$GNU_TOOL '/tmp/nonexistent_$$' '$WORK_DIR/gnu_err1' 2>&1" \
        "$F_TOOL '/tmp/nonexistent_$$' '$WORK_DIR/f_err1' 2>&1"

    run_exit_code_test "existing target without -f" \
        "echo x > '$WORK_DIR/gnu_existing' && $GNU_TOOL -s '$WORK_DIR/source.txt' '$WORK_DIR/gnu_existing' 2>&1" \
        "echo x > '$WORK_DIR/f_existing' && $F_TOOL -s '$WORK_DIR/source.txt' '$WORK_DIR/f_existing' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "symlink to self (create)" \
        "$GNU_TOOL -sf '$WORK_DIR/gnu_selflink' '$WORK_DIR/gnu_selflink' 2>&1; echo \$?" \
        "$F_TOOL -sf '$WORK_DIR/f_selflink' '$WORK_DIR/f_selflink' 2>&1; echo \$?"

    # Multiple source files
    echo "file_a" > "$WORK_DIR/multi_a.txt"
    echo "file_b" > "$WORK_DIR/multi_b.txt"
    mkdir -p "$WORK_DIR/gnu_multi_dest" "$WORK_DIR/f_multi_dest"

    run_test "multiple source files into directory" \
        "$GNU_TOOL -s '$WORK_DIR/multi_a.txt' '$WORK_DIR/multi_b.txt' '$WORK_DIR/gnu_multi_dest/' && ls '$WORK_DIR/gnu_multi_dest/'" \
        "$F_TOOL -s '$WORK_DIR/multi_a.txt' '$WORK_DIR/multi_b.txt' '$WORK_DIR/f_multi_dest/' && ls '$WORK_DIR/f_multi_dest/'"

    # Clean up
    rm -rf "$WORK_DIR"


    finish_test_suite
}

run_ln_tests
