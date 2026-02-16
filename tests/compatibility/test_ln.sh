#!/usr/bin/env bash
# Compatibility tests for fln vs GNU ln
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="ln"
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

    run_stdout_test "verbose output" \
        "$GNU_TOOL -sv '$WORK_DIR/source.txt' '$WORK_DIR/gnu_verbose_link'" \
        "$F_TOOL -sv '$WORK_DIR/source.txt' '$WORK_DIR/f_verbose_link'"

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
