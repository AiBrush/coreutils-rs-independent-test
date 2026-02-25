#!/usr/bin/env bash
# Compatibility tests for ftouch vs GNU touch
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "touch")
F_TOOL="ftouch"

run_touch_tests() {
    init_test_suite "touch"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"touch","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/touch_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU touch not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_touch_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic File Creation ==="

    run_test "create new file" \
        "$GNU_TOOL '$WORK_DIR/gnu_new.txt' && test -e '$WORK_DIR/gnu_new.txt' && echo 'EXISTS'" \
        "$F_TOOL '$WORK_DIR/f_new.txt' && test -e '$WORK_DIR/f_new.txt' && echo 'EXISTS'"

    run_test "create multiple files" \
        "$GNU_TOOL '$WORK_DIR/gnu_a.txt' '$WORK_DIR/gnu_b.txt' '$WORK_DIR/gnu_c.txt' && ls '$WORK_DIR'/gnu_*.txt | wc -l" \
        "$F_TOOL '$WORK_DIR/f_a.txt' '$WORK_DIR/f_b.txt' '$WORK_DIR/f_c.txt' && ls '$WORK_DIR'/f_*.txt | wc -l"

    run_test "touch existing file (no error)" \
        "echo 'data' > '$WORK_DIR/gnu_exist.txt' && $GNU_TOOL '$WORK_DIR/gnu_exist.txt' && echo 'OK'" \
        "echo 'data' > '$WORK_DIR/f_exist.txt' && $F_TOOL '$WORK_DIR/f_exist.txt' && echo 'OK'"

    run_test "existing file content unchanged" \
        "echo 'preserve me' > '$WORK_DIR/gnu_content.txt' && $GNU_TOOL '$WORK_DIR/gnu_content.txt' && cat '$WORK_DIR/gnu_content.txt'" \
        "echo 'preserve me' > '$WORK_DIR/f_content.txt' && $F_TOOL '$WORK_DIR/f_content.txt' && cat '$WORK_DIR/f_content.txt'"

    echo ""
    echo "=== No Create (-c) ==="

    run_test "-c nonexistent (no create)" \
        "$GNU_TOOL -c '$WORK_DIR/gnu_nocreate.txt'; test -e '$WORK_DIR/gnu_nocreate.txt' && echo 'EXISTS' || echo 'NOT_EXISTS'" \
        "$F_TOOL -c '$WORK_DIR/f_nocreate.txt'; test -e '$WORK_DIR/f_nocreate.txt' && echo 'EXISTS' || echo 'NOT_EXISTS'"

    run_test "-c existing file (updates time)" \
        "echo 'x' > '$WORK_DIR/gnu_c_exist.txt' && $GNU_TOOL -c '$WORK_DIR/gnu_c_exist.txt' && echo 'OK'" \
        "echo 'x' > '$WORK_DIR/f_c_exist.txt' && $F_TOOL -c '$WORK_DIR/f_c_exist.txt' && echo 'OK'"

    echo ""
    echo "=== Specific Timestamp (-t) ==="

    run_test "-t set specific time" \
        "$GNU_TOOL -t 202301011200.00 '$WORK_DIR/gnu_t1.txt' && stat -c '%Y' '$WORK_DIR/gnu_t1.txt'" \
        "$F_TOOL -t 202301011200.00 '$WORK_DIR/f_t1.txt' && stat -c '%Y' '$WORK_DIR/f_t1.txt'"

    run_test "-t set another time" \
        "$GNU_TOOL -t 199912312359.59 '$WORK_DIR/gnu_t2.txt' && stat -c '%Y' '$WORK_DIR/gnu_t2.txt'" \
        "$F_TOOL -t 199912312359.59 '$WORK_DIR/f_t2.txt' && stat -c '%Y' '$WORK_DIR/f_t2.txt'"

    run_test "-t epoch time" \
        "$GNU_TOOL -t 197001010000.00 '$WORK_DIR/gnu_epoch.txt' && stat -c '%Y' '$WORK_DIR/gnu_epoch.txt'" \
        "$F_TOOL -t 197001010000.00 '$WORK_DIR/f_epoch.txt' && stat -c '%Y' '$WORK_DIR/f_epoch.txt'"

    echo ""
    echo "=== Date String (-d) ==="

    run_test "-d ISO date" \
        "$GNU_TOOL -d '2023-06-15 10:30:00' '$WORK_DIR/gnu_d1.txt' && stat -c '%Y' '$WORK_DIR/gnu_d1.txt'" \
        "$F_TOOL -d '2023-06-15 10:30:00' '$WORK_DIR/f_d1.txt' && stat -c '%Y' '$WORK_DIR/f_d1.txt'"

    run_test "-d relative date (yesterday)" \
        "$GNU_TOOL -d 'yesterday' '$WORK_DIR/gnu_d2.txt' && stat -c '%Y' '$WORK_DIR/gnu_d2.txt'" \
        "$F_TOOL -d 'yesterday' '$WORK_DIR/f_d2.txt' && stat -c '%Y' '$WORK_DIR/f_d2.txt'"

    run_test "-d epoch" \
        "$GNU_TOOL -d '@0' '$WORK_DIR/gnu_d_epoch.txt' && stat -c '%Y' '$WORK_DIR/gnu_d_epoch.txt'" \
        "$F_TOOL -d '@0' '$WORK_DIR/f_d_epoch.txt' && stat -c '%Y' '$WORK_DIR/f_d_epoch.txt'"

    run_test "-d epoch with value" \
        "$GNU_TOOL -d '@1000000' '$WORK_DIR/gnu_d_epoch2.txt' && stat -c '%Y' '$WORK_DIR/gnu_d_epoch2.txt'" \
        "$F_TOOL -d '@1000000' '$WORK_DIR/f_d_epoch2.txt' && stat -c '%Y' '$WORK_DIR/f_d_epoch2.txt'"

    echo ""
    echo "=== Access Time Only (-a) ==="

    # Use a specific timestamp with -t to avoid timing differences between the two runs
    run_test "-a only access time" \
        "echo 'x' > '$WORK_DIR/gnu_a.txt' && $GNU_TOOL -a -t 202306150000.00 '$WORK_DIR/gnu_a.txt' && stat -c '%X' '$WORK_DIR/gnu_a.txt'" \
        "echo 'x' > '$WORK_DIR/f_a.txt' && $F_TOOL -a -t 202306150000.00 '$WORK_DIR/f_a.txt' && stat -c '%X' '$WORK_DIR/f_a.txt'"

    echo ""
    echo "=== Modification Time Only (-m) ==="

    run_test "-m only modification time" \
        "$GNU_TOOL -m -t 202306150000.00 '$WORK_DIR/gnu_m.txt' && stat -c '%Y' '$WORK_DIR/gnu_m.txt'" \
        "$F_TOOL -m -t 202306150000.00 '$WORK_DIR/f_m.txt' && stat -c '%Y' '$WORK_DIR/f_m.txt'"

    echo ""
    echo "=== Reference File (-r) ==="

    $GNU_TOOL -t 202001010000.00 "$WORK_DIR/ref_file.txt"

    run_test "-r reference file" \
        "$GNU_TOOL -r '$WORK_DIR/ref_file.txt' '$WORK_DIR/gnu_ref.txt' && stat -c '%Y' '$WORK_DIR/gnu_ref.txt'" \
        "$F_TOOL -r '$WORK_DIR/ref_file.txt' '$WORK_DIR/f_ref.txt' && stat -c '%Y' '$WORK_DIR/f_ref.txt'"

    # === GNU Upstream: Empty File (empty-file.sh) ===
    echo ""
    echo "=== GNU Upstream: Empty File ==="

    # From empty-file.sh: touch on an empty file updates mtime
    run_test "GNU: touch on empty file succeeds" \
        "> '$WORK_DIR/gnu_empty1.txt' && $GNU_TOOL '$WORK_DIR/gnu_empty1.txt' && echo OK" \
        "> '$WORK_DIR/f_empty1.txt' && $F_TOOL '$WORK_DIR/f_empty1.txt' && echo OK"

    # === GNU Upstream: Directory (dir-1.sh) ===
    echo ""
    echo "=== GNU Upstream: Directory ==="

    # From dir-1.sh: touch can operate on a directory
    mkdir -p "$WORK_DIR/gnu_touchdir" "$WORK_DIR/f_touchdir"

    run_exit_code_test "GNU: touch on directory succeeds" \
        "$GNU_TOOL '$WORK_DIR/gnu_touchdir' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_touchdir' 2>&1"

    # From dir-1.sh: touch . succeeds
    run_exit_code_test "GNU: touch . succeeds" \
        "$GNU_TOOL . 2>&1" \
        "$F_TOOL . 2>&1"

    # === GNU Upstream: Relative Date (relative.sh) ===
    echo ""
    echo "=== GNU Upstream: Relative Date ==="

    # From relative.sh: touch --ref --date with relative offset
    run_test "GNU: touch --ref --date '-5 days'" \
        "$GNU_TOOL --date='2004-01-16 12:00 +0000' '$WORK_DIR/gnu_rel_f' && $GNU_TOOL --ref '$WORK_DIR/gnu_rel_f' --date='-5 days' '$WORK_DIR/gnu_rel_f' && stat -c '%Y' '$WORK_DIR/gnu_rel_f'" \
        "$F_TOOL --date='2004-01-16 12:00 +0000' '$WORK_DIR/f_rel_f' && $F_TOOL --ref '$WORK_DIR/f_rel_f' --date='-5 days' '$WORK_DIR/f_rel_f' && stat -c '%Y' '$WORK_DIR/f_rel_f'"

    # === GNU Upstream: Trailing Slash (trailing-slash.sh) ===
    echo ""
    echo "=== GNU Upstream: Trailing Slash ==="

    # From trailing-slash.sh: touch on nonexistent file with trailing slash should fail
    run_exit_code_test "GNU: touch no-file/ fails" \
        "$GNU_TOOL '$WORK_DIR/gnu_no_file_slash/' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_no_file_slash/' 2>&1"

    # From trailing-slash.sh: touch on regular file with trailing slash should fail
    echo "test" > "$WORK_DIR/gnu_regular_slash"
    echo "test" > "$WORK_DIR/f_regular_slash"

    run_exit_code_test "GNU: touch file/ (regular file with slash) fails" \
        "$GNU_TOOL '$WORK_DIR/gnu_regular_slash/' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_regular_slash/' 2>&1"

    # From trailing-slash.sh: touch on dir/ (directory with slash) should succeed
    mkdir -p "$WORK_DIR/gnu_dirslash" "$WORK_DIR/f_dirslash"

    run_exit_code_test "GNU: touch dir/ succeeds" \
        "$GNU_TOOL '$WORK_DIR/gnu_dirslash/' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_dirslash/' 2>&1"

    # From trailing-slash.sh: -c silences ENOENT with trailing slash
    run_exit_code_test "GNU: touch -c no-file/ (silent ENOENT)" \
        "$GNU_TOOL -c '$WORK_DIR/gnu_nc_slash/' 2>&1" \
        "$F_TOOL -c '$WORK_DIR/f_nc_slash/' 2>&1"

    # === GNU Upstream: No Create Missing (no-create-missing.sh) ===
    echo ""
    echo "=== GNU Upstream: No Create Missing ==="

    # From no-create-missing.sh: touch -c no-file should succeed without creating
    run_test "GNU: touch -c nonexistent (no create)" \
        "$GNU_TOOL -c '$WORK_DIR/gnu_nocreate_$$' 2>&1; test -e '$WORK_DIR/gnu_nocreate_$$' && echo EXISTS || echo NOT_EXISTS" \
        "$F_TOOL -c '$WORK_DIR/f_nocreate_$$' 2>&1; test -e '$WORK_DIR/f_nocreate_$$' && echo EXISTS || echo NOT_EXISTS"

    # From no-create-missing.sh: touch -cm and -ca should also succeed
    run_exit_code_test "GNU: touch -cm nonexistent succeeds" \
        "$GNU_TOOL -cm '$WORK_DIR/gnu_nocreate_m_$$' 2>&1" \
        "$F_TOOL -cm '$WORK_DIR/f_nocreate_m_$$' 2>&1"

    run_exit_code_test "GNU: touch -ca nonexistent succeeds" \
        "$GNU_TOOL -ca '$WORK_DIR/gnu_nocreate_a_$$' 2>&1" \
        "$F_TOOL -ca '$WORK_DIR/f_nocreate_a_$$' 2>&1"

    # === GNU Upstream: Dangling Symlink (dangling-symlink.sh) ===
    echo ""
    echo "=== GNU Upstream: Dangling Symlink ==="

    # From dangling-symlink.sh: touch creates file through dangling symlink
    ln -s "$WORK_DIR/gnu_dangle_target" "$WORK_DIR/gnu_dangle_link"
    ln -s "$WORK_DIR/f_dangle_target" "$WORK_DIR/f_dangle_link"

    run_test "GNU: touch through dangling symlink creates target" \
        "$GNU_TOOL '$WORK_DIR/gnu_dangle_link' && test -f '$WORK_DIR/gnu_dangle_target' && echo OK" \
        "$F_TOOL '$WORK_DIR/f_dangle_link' && test -f '$WORK_DIR/f_dangle_target' && echo OK"

    # === GNU Upstream: Fail Diagnostics (fail-diag.sh) ===
    echo ""
    echo "=== GNU Upstream: Fail Diagnostics ==="

    # From fail-diag.sh: touch on file in nonexistent dir should fail
    run_exit_code_test "GNU: touch /no-such-dir/file fails" \
        "$GNU_TOOL '/no-such-dir-$$/file' 2>&1" \
        "$F_TOOL '/no-such-dir-$$/file' 2>&1"

    # === GNU Upstream: Read-Only File (read-only.sh) ===
    echo ""
    echo "=== GNU Upstream: Read-Only File ==="

    # From read-only.sh: touch can operate on read-only file
    > "$WORK_DIR/gnu_readonly"
    > "$WORK_DIR/f_readonly"
    chmod 444 "$WORK_DIR/gnu_readonly" "$WORK_DIR/f_readonly"

    run_exit_code_test "GNU: touch read-only file succeeds" \
        "$GNU_TOOL '$WORK_DIR/gnu_readonly' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_readonly' 2>&1"

    # Restore permissions for cleanup
    chmod 644 "$WORK_DIR/gnu_readonly" "$WORK_DIR/f_readonly" 2>/dev/null

    # === GNU Upstream: No-Dereference (no-dereference.sh) ===
    echo ""
    echo "=== GNU Upstream: No-Dereference ==="

    # From no-dereference.sh: -h does not create files but warns
    run_exit_code_test "GNU: touch -h nonexistent fails" \
        "$GNU_TOOL -h '$WORK_DIR/gnu_noderef_nofile' 2>&1" \
        "$F_TOOL -h '$WORK_DIR/f_noderef_nofile' 2>&1"

    # From no-dereference.sh: -h -c silences warning for nonexistent
    run_exit_code_test "GNU: touch -h -c nonexistent succeeds silently" \
        "$GNU_TOOL -h -c '$WORK_DIR/gnu_noderef_nc' 2>&1" \
        "$F_TOOL -h -c '$WORK_DIR/f_noderef_nc' 2>&1"

    # From no-dereference.sh: -h works on regular files
    echo "test" > "$WORK_DIR/gnu_noderef_reg"
    echo "test" > "$WORK_DIR/f_noderef_reg"

    run_exit_code_test "GNU: touch -h on regular file succeeds" \
        "$GNU_TOOL -h '$WORK_DIR/gnu_noderef_reg' 2>&1" \
        "$F_TOOL -h '$WORK_DIR/f_noderef_reg' 2>&1"

    # === GNU Upstream: 60 Seconds (60-seconds.sh) ===
    echo ""
    echo "=== GNU Upstream: 60 Seconds ==="

    # From 60-seconds.sh: touch -t with 60 seconds should be valid (leap second)
    # Before coreutils-7.7, specifying 60 seconds was rejected
    run_exit_code_test "GNU: touch -t with 60 seconds is valid" \
        "TZ=UTC0 $GNU_TOOL -t 197001010000.60 '$WORK_DIR/gnu_60sec' 2>&1" \
        "TZ=UTC0 $F_TOOL -t 197001010000.60 '$WORK_DIR/f_60sec' 2>&1"

    # === GNU Upstream: Obsolescent Timestamps (obsolescent.sh) ===
    echo ""
    echo "=== GNU Upstream: Obsolescent Timestamps ==="

    # From obsolescent.sh: obsolescent 8-digit timestamp creates a file, not used as timestamp
    # With POSIX2 mode, '01010000' is treated as a file argument, not a timestamp
    run_test "GNU: obsolescent 8-digit arg creates file" \
        "_POSIX2_VERSION=199209 POSIXLY_CORRECT=1 $GNU_TOOL -- 01010000 '$WORK_DIR/gnu_obs8_target' 2>/dev/null; test -e '$WORK_DIR/gnu_obs8_target' && echo FILE_EXISTS || echo NO_FILE" \
        "_POSIX2_VERSION=199209 POSIXLY_CORRECT=1 $F_TOOL -- 01010000 '$WORK_DIR/f_obs8_target' 2>/dev/null; test -e '$WORK_DIR/f_obs8_target' && echo FILE_EXISTS || echo NO_FILE"

    # === GNU Upstream: No Rights (no-rights.sh) ===
    echo ""
    echo "=== GNU Upstream: No Rights ==="

    # From no-rights.sh: touch can update times on file with no read/write permissions (owned by us)
    > "$WORK_DIR/gnu_norights"
    > "$WORK_DIR/f_norights"
    $GNU_TOOL -d '2000-01-01 00:00' "$WORK_DIR/gnu_norights"
    $F_TOOL -d '2000-01-01 00:00' "$WORK_DIR/f_norights" 2>/dev/null || $GNU_TOOL -d '2000-01-01 00:00' "$WORK_DIR/f_norights"
    chmod 0 "$WORK_DIR/gnu_norights" "$WORK_DIR/f_norights"

    run_exit_code_test "GNU: touch -c on file with no permissions (owned)" \
        "$GNU_TOOL -d '2000-01-03 00:00' -c '$WORK_DIR/gnu_norights' 2>&1" \
        "$F_TOOL -d '2000-01-03 00:00' -c '$WORK_DIR/f_norights' 2>&1"

    # Restore permissions for cleanup
    chmod 644 "$WORK_DIR/gnu_norights" "$WORK_DIR/f_norights" 2>/dev/null

    # From no-rights.sh: touch -a --no-create on file with no perms (owned)
    > "$WORK_DIR/gnu_norights2"
    > "$WORK_DIR/f_norights2"
    chmod 0 "$WORK_DIR/gnu_norights2" "$WORK_DIR/f_norights2"

    run_exit_code_test "GNU: touch -a --no-create on no-perms file (owned)" \
        "$GNU_TOOL -a --no-create '$WORK_DIR/gnu_norights2' 2>&1" \
        "$F_TOOL -a --no-create '$WORK_DIR/f_norights2' 2>&1"

    chmod 644 "$WORK_DIR/gnu_norights2" "$WORK_DIR/f_norights2" 2>/dev/null

    # === GNU Upstream: Dangling Symlink -h (no-dereference.sh extended) ===
    echo ""
    echo "=== GNU Upstream: Symlink -h with -r ==="

    # From no-dereference.sh: -h coupled with -r uses timestamp of the symlink, not referent
    ln -s nowhere "$WORK_DIR/gnu_hrdangle"
    ln -s nowhere "$WORK_DIR/f_hrdangle"
    echo "test" > "$WORK_DIR/gnu_hrfile"
    echo "test" > "$WORK_DIR/f_hrfile"

    run_exit_code_test "GNU: touch -h -r dangling-symlink file (no create target)" \
        "$GNU_TOOL -h -r '$WORK_DIR/gnu_hrdangle' '$WORK_DIR/gnu_hrfile' 2>&1; test ! -f '$WORK_DIR/gnu_nowhere' && echo NO_TARGET" \
        "$F_TOOL -h -r '$WORK_DIR/f_hrdangle' '$WORK_DIR/f_hrfile' 2>&1; test ! -f '$WORK_DIR/f_nowhere' && echo NO_TARGET"

    # === GNU Upstream: Trailing Slash Symlink Deref (trailing-slash.sh extended) ===
    echo ""
    echo "=== GNU Upstream: Trailing Slash Extended ==="

    # From trailing-slash.sh: touch on dangling symlink with trailing slash should fail
    ln -s nowhere "$WORK_DIR/gnu_dangle_slash"
    ln -s nowhere "$WORK_DIR/f_dangle_slash"

    run_exit_code_test "GNU: touch dangling-symlink/ fails" \
        "$GNU_TOOL '$WORK_DIR/gnu_dangle_slash/' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_dangle_slash/' 2>&1"

    # From trailing-slash.sh: -c silences dangling symlink with slash
    run_exit_code_test "GNU: touch -c dangling-symlink/ (silent)" \
        "$GNU_TOOL -c '$WORK_DIR/gnu_dangle_slash/' 2>&1" \
        "$F_TOOL -c '$WORK_DIR/f_dangle_slash/' 2>&1"

    # fifo.sh: SKIP (requires mkfifo)
    skip_test "GNU: touch on FIFO" "Requires mkfifo"

    # not-owner.sh: SKIP (requires root and non-root user switching)
    skip_test "GNU: touch on file not owned by user" "Requires root access"

    # now-owned-by-other.sh: SKIP (requires root access)
    skip_test "GNU: touch -d now on writable-but-owned-by-other" "Requires root access"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent directory" \
        "$GNU_TOOL '/nonexistent_dir_$$/file.txt' 2>&1" \
        "$F_TOOL '/nonexistent_dir_$$/file.txt' 2>&1"

    run_exit_code_test "invalid timestamp" \
        "$GNU_TOOL -t 'notadate' '$WORK_DIR/gnu_invalid.txt' 2>&1" \
        "$F_TOOL -t 'notadate' '$WORK_DIR/f_invalid.txt' 2>&1"

    run_exit_code_test "nonexistent reference file" \
        "$GNU_TOOL -r '/tmp/nonexistent_$$' '$WORK_DIR/gnu_badref.txt' 2>&1" \
        "$F_TOOL -r '/tmp/nonexistent_$$' '$WORK_DIR/f_badref.txt' 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "file with spaces in name" \
        "$GNU_TOOL '$WORK_DIR/gnu file with spaces.txt' && test -e '$WORK_DIR/gnu file with spaces.txt' && echo 'EXISTS'" \
        "$F_TOOL '$WORK_DIR/f file with spaces.txt' && test -e '$WORK_DIR/f file with spaces.txt' && echo 'EXISTS'"

    run_test "touch empty file preserves zero size" \
        "> '$WORK_DIR/gnu_zero.txt' && $GNU_TOOL '$WORK_DIR/gnu_zero.txt' && stat -c '%s' '$WORK_DIR/gnu_zero.txt'" \
        "> '$WORK_DIR/f_zero.txt' && $F_TOOL '$WORK_DIR/f_zero.txt' && stat -c '%s' '$WORK_DIR/f_zero.txt'"

    # Clean up
    rm -rf "$WORK_DIR"


    finish_test_suite
}

run_touch_tests
