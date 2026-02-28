#!/usr/bin/env bash
# Compatibility tests for fchgrp vs GNU chgrp
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "chgrp")
F_TOOL="fchgrp"

run_chgrp_tests() {
    init_test_suite "chgrp"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chgrp","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chgrp_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU chgrp not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_chgrp_XXXXXX)
    register_temp "$test_dir"

    local current_group
    current_group=$(id -gn)

    # === Section 1: Basic chgrp (own group) ===
    echo ""
    echo "=== Basic chgrp (Own Group) ==="

    echo "test" > "$test_dir/gnu_file1"
    echo "test" > "$test_dir/f_file1"

    run_exit_code_test "chgrp to own group" \
        "$GNU_TOOL $current_group '$test_dir/gnu_file1'" \
        "$F_TOOL $current_group '$test_dir/f_file1'"

    # Verify group match
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_grp f_grp
    gnu_grp=$(stat -c '%G' "$test_dir/gnu_file1" 2>/dev/null || stat -f '%Sg' "$test_dir/gnu_file1")
    f_grp=$(stat -c '%G' "$test_dir/f_file1" 2>/dev/null || stat -f '%Sg' "$test_dir/f_file1")
    if [[ "$gnu_grp" == "$f_grp" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: group matches after chgrp"
        record_result "group matches after chgrp" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: group mismatch: GNU=$gnu_grp F=$f_grp"
        record_result "group matches after chgrp" "FAIL" "GNU=$gnu_grp F=$f_grp" "" ""
    fi

    # === Section 2: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    if [[ "$(id -u)" -ne 0 ]]; then
        echo "test" > "$test_dir/perm_file"
        run_exit_code_test "chgrp to root group (permission denied)" \
            "$GNU_TOOL root '$test_dir/perm_file' 2>&1" \
            "$F_TOOL root '$test_dir/perm_file' 2>&1"

        run_exit_code_test "chgrp nonexistent group" \
            "$GNU_TOOL nonexistent_group_$$ '$test_dir/perm_file' 2>&1" \
            "$F_TOOL nonexistent_group_$$ '$test_dir/perm_file' 2>&1"
    fi

    run_exit_code_test "chgrp nonexistent file" \
        "$GNU_TOOL $current_group /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL $current_group /tmp/nonexistent_$$ 2>&1"

    # === Section 3: Recursive (-R) ===
    echo ""
    echo "=== Recursive (-R) ==="

    mkdir -p "$test_dir/gnu_dir/subdir"
    echo "a" > "$test_dir/gnu_dir/file1"
    echo "b" > "$test_dir/gnu_dir/subdir/file2"
    cp -r "$test_dir/gnu_dir" "$test_dir/f_dir"

    run_exit_code_test "chgrp -R to own group" \
        "$GNU_TOOL -R $current_group '$test_dir/gnu_dir'" \
        "$F_TOOL -R $current_group '$test_dir/f_dir'"

    # === Section 4: Verbose (-v) ===
    echo ""
    echo "=== Verbose (-v) ==="

    echo "test" > "$test_dir/gnu_vfile"
    echo "test" > "$test_dir/f_vfile"

    run_exit_code_test "chgrp -v" \
        "$GNU_TOOL -v $current_group '$test_dir/gnu_vfile' 2>&1" \
        "$F_TOOL -v $current_group '$test_dir/f_vfile' 2>&1"

    # === Section 5: --reference ===
    echo ""
    echo "=== --reference ==="

    echo "ref" > "$test_dir/ref_file"
    echo "target" > "$test_dir/gnu_target"
    echo "target" > "$test_dir/f_target"

    run_exit_code_test "chgrp --reference" \
        "$GNU_TOOL --reference='$test_dir/ref_file' '$test_dir/gnu_target'" \
        "$F_TOOL --reference='$test_dir/ref_file' '$test_dir/f_target'"

    # === Section 6: Changes only (-c) ===
    echo ""
    echo "=== Changes Only (-c) ==="

    echo "test" > "$test_dir/gnu_cfile"
    echo "test" > "$test_dir/f_cfile"

    run_exit_code_test "chgrp -c (no change)" \
        "$GNU_TOOL -c $current_group '$test_dir/gnu_cfile' 2>&1" \
        "$F_TOOL -c $current_group '$test_dir/f_cfile' 2>&1"

    # === GNU Upstream: Basic Error Cases ===
    echo ""
    echo "=== GNU Upstream: Basic Error Cases ==="

    # From basic.sh: chgrp with empty group string (no change)
    echo "test" > "$test_dir/gnu_empty_grp"
    echo "test" > "$test_dir/f_empty_grp"
    $GNU_TOOL "$current_group" "$test_dir/gnu_empty_grp" 2>/dev/null
    $F_TOOL "$current_group" "$test_dir/f_empty_grp" 2>/dev/null

    run_exit_code_test "GNU: chgrp with empty group (no-op)" \
        "$GNU_TOOL '' '$test_dir/gnu_empty_grp' 2>&1" \
        "$F_TOOL '' '$test_dir/f_empty_grp' 2>&1"

    # From no-x.sh: chgrp -R on inaccessible directory (non-root only)
    if [[ "$(id -u)" -ne 0 ]]; then
        mkdir -p "$test_dir/gnu_nox/no-x/y" "$test_dir/f_nox/no-x/y"
        chmod u=rw "$test_dir/gnu_nox/no-x"
        chmod u=rw "$test_dir/f_nox/no-x"

        run_exit_code_test "GNU: chgrp -R on inaccessible dir" \
            "$GNU_TOOL -R $current_group '$test_dir/gnu_nox' 2>&1; echo \$?" \
            "$F_TOOL -R $current_group '$test_dir/f_nox' 2>&1; echo \$?"

        # Restore permissions for cleanup
        chmod u=rwx "$test_dir/gnu_nox/no-x" 2>/dev/null
        chmod u=rwx "$test_dir/f_nox/no-x" 2>/dev/null
    fi

    # From basic.sh: chgrp -h on symlink (should not change target)
    echo "test" > "$test_dir/gnu_target_h"
    echo "test" > "$test_dir/f_target_h"
    ln -s "$test_dir/gnu_target_h" "$test_dir/gnu_slink_h"
    ln -s "$test_dir/f_target_h" "$test_dir/f_slink_h"
    $GNU_TOOL "$current_group" "$test_dir/gnu_target_h" 2>/dev/null
    $F_TOOL "$current_group" "$test_dir/f_target_h" 2>/dev/null

    run_exit_code_test "GNU: chgrp -h on symlink exit code" \
        "$GNU_TOOL -h $current_group '$test_dir/gnu_slink_h' 2>&1" \
        "$F_TOOL -h $current_group '$test_dir/f_slink_h' 2>&1"

    # From recurse.sh: chgrp -R should not traverse symlinks to directories
    echo ""
    echo "=== GNU Upstream: Recursive Symlink Handling ==="

    mkdir -p "$test_dir/gnu_rec_d" "$test_dir/gnu_rec_e"
    echo "test" > "$test_dir/gnu_rec_d/dd"
    echo "test" > "$test_dir/gnu_rec_e/ee"
    ln -s "$test_dir/gnu_rec_e" "$test_dir/gnu_rec_d/s"
    mkdir -p "$test_dir/f_rec_d" "$test_dir/f_rec_e"
    echo "test" > "$test_dir/f_rec_d/dd"
    echo "test" > "$test_dir/f_rec_e/ee"
    ln -s "$test_dir/f_rec_e" "$test_dir/f_rec_d/s"

    # chgrp -R should NOT follow symlinks (default behavior)
    run_exit_code_test "GNU: chgrp -R does not traverse symlinks" \
        "$GNU_TOOL -R $current_group '$test_dir/gnu_rec_d' 2>&1" \
        "$F_TOOL -R $current_group '$test_dir/f_rec_d' 2>&1"

    # From default-no-deref.sh: Verify -R does not dereference symlinks
    mkdir -p "$test_dir/gnu_dnd" "$test_dir/f_dnd"
    echo "test" > "$test_dir/gnu_dnd_target"
    echo "test" > "$test_dir/f_dnd_target"
    ln -s "$test_dir/gnu_dnd_target" "$test_dir/gnu_dnd/s"
    ln -s "$test_dir/f_dnd_target" "$test_dir/f_dnd/s"

    run_exit_code_test "GNU: chgrp -R default no-deref" \
        "$GNU_TOOL -R $current_group '$test_dir/gnu_dnd' 2>&1" \
        "$F_TOOL -R $current_group '$test_dir/f_dnd' 2>&1"

    # From deref.sh: chgrp --dereference on symlink changes target
    echo ""
    echo "=== GNU Upstream: Dereference Options ==="

    echo "test" > "$test_dir/gnu_deref_f"
    echo "test" > "$test_dir/f_deref_f"
    ln -s "$test_dir/gnu_deref_f" "$test_dir/gnu_deref_sl"
    ln -s "$test_dir/f_deref_f" "$test_dir/f_deref_sl"

    run_exit_code_test "GNU: chgrp --dereference on symlink" \
        "$GNU_TOOL --dereference $current_group '$test_dir/gnu_deref_sl' 2>&1" \
        "$F_TOOL --dereference $current_group '$test_dir/f_deref_sl' 2>&1"

    # === GNU Upstream: POSIX -H Flag ===
    echo ""
    echo "=== GNU Upstream: POSIX -H Flag ==="

    # From posix-H.sh: -H with -R dereferences symlinks given as command-line args only
    # Requires membership in two groups for full verification; test basic -H -R behavior
    mkdir -p "$test_dir/gnu_posixh/sub" "$test_dir/f_posixh/sub"
    echo "test" > "$test_dir/gnu_posixh/sub/f1"
    echo "test" > "$test_dir/f_posixh/sub/f1"
    ln -s "$test_dir/gnu_posixh/sub" "$test_dir/gnu_posixh_link"
    ln -s "$test_dir/f_posixh/sub" "$test_dir/f_posixh_link"

    run_exit_code_test "GNU: chgrp -H -R on symlink to dir" \
        "$GNU_TOOL -H -R $current_group '$test_dir/gnu_posixh_link' 2>&1" \
        "$F_TOOL -H -R $current_group '$test_dir/f_posixh_link' 2>&1"

    # From posix-H.sh: -H -R on a regular directory (no symlink)
    run_exit_code_test "GNU: chgrp -H -R on regular dir" \
        "$GNU_TOOL -H -R $current_group '$test_dir/gnu_posixh' 2>&1" \
        "$F_TOOL -H -R $current_group '$test_dir/f_posixh' 2>&1"

    # === GNU Upstream: --from Filter ===
    echo ""
    echo "=== GNU Upstream: --from Filter ==="

    # From from.sh: --from requires root for meaningful ownership changes
    skip_test "GNU: chgrp --from filter" "Requires root"
    skip_test "GNU: chgrp --no-dereference with --from" "Requires root"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_chgrp_tests
