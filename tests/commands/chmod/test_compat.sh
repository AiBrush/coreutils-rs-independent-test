#!/usr/bin/env bash
# Compatibility tests for fchmod vs GNU chmod
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "chmod")
F_TOOL="fchmod"

run_chmod_tests() {
    init_test_suite "chmod"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chmod","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chmod_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU chmod not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_chmod_XXXXXX)
    register_temp "$test_dir"

    # Helper: compare chmod results
    compare_chmod() {
        local test_name="$1"
        local mode="$2"
        local initial_mode="${3:-644}"

        # Create identical files
        local gnu_f="$test_dir/gnu_$$_$(echo "$test_name" | tr ' /' '__')"
        local f_f="$test_dir/f_$$_$(echo "$test_name" | tr ' /' '__')"
        echo "test" > "$gnu_f"
        echo "test" > "$f_f"
        $GNU_TOOL "$initial_mode" "$gnu_f" "$f_f"

        # Apply mode
        $GNU_TOOL $mode "$gnu_f" 2>/dev/null || true
        $F_TOOL $mode "$f_f" 2>/dev/null || true

        TESTS_RUN=$((TESTS_RUN + 1))
        local gnu_perm f_perm
        gnu_perm=$(stat -c '%a' "$gnu_f" 2>/dev/null || stat -f '%Lp' "$gnu_f")
        f_perm=$(stat -c '%a' "$f_f" 2>/dev/null || stat -f '%Lp' "$f_f")
        if [[ "$gnu_perm" == "$f_perm" ]]; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "  ${GREEN}PASS${NC}: $test_name ($gnu_perm)"
            record_result "$test_name" "PASS" "" "$GNU_TOOL $mode" "$F_TOOL $mode"
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: $test_name (GNU=$gnu_perm F=$f_perm)"
            record_result "$test_name" "FAIL" "GNU=$gnu_perm F=$f_perm" "$GNU_TOOL $mode" "$F_TOOL $mode"
        fi
        rm -f "$gnu_f" "$f_f"
    }

    # === Section 1: Octal Modes ===
    echo ""
    echo "=== Octal Modes ==="

    compare_chmod "chmod 755" "755"
    compare_chmod "chmod 644" "644"
    compare_chmod "chmod 000" "000"
    compare_chmod "chmod 777" "777"
    compare_chmod "chmod 600" "600"
    compare_chmod "chmod 700" "700"
    compare_chmod "chmod 400" "400"
    compare_chmod "chmod 555" "555"

    # === Section 2: Symbolic Modes ===
    echo ""
    echo "=== Symbolic Modes ==="

    compare_chmod "chmod u+x" "u+x"
    compare_chmod "chmod u-x" "u-x" "755"
    compare_chmod "chmod go-rwx" "go-rwx" "777"
    compare_chmod "chmod a+r" "a+r" "000"
    compare_chmod "chmod u=rwx,g=rx,o=" "u=rwx,g=rx,o="
    compare_chmod "chmod a+w" "a+w" "444"
    compare_chmod "chmod g+w" "g+w"
    compare_chmod "chmod o+x" "o+x"
    compare_chmod "chmod u=rw" "u=rw"
    compare_chmod "chmod g=r" "g=r"
    compare_chmod "chmod a-w" "a-w" "666"
    compare_chmod "chmod ug+x" "ug+x"

    # === Section 3: Special Bits ===
    echo ""
    echo "=== Special Bits ==="

    compare_chmod "chmod 4755 (setuid)" "4755"
    compare_chmod "chmod 2755 (setgid)" "2755"
    compare_chmod "chmod 1755 (sticky)" "1755"
    compare_chmod "chmod 6755 (setuid+setgid)" "6755"

    # === Section 4: Capital X ===
    echo ""
    echo "=== Capital X ==="

    # X on directory: should add execute
    mkdir -p "$test_dir/gnu_xdir" "$test_dir/f_xdir"
    $GNU_TOOL 644 "$test_dir/gnu_xdir"
    $GNU_TOOL 644 "$test_dir/f_xdir"
    $GNU_TOOL a+X "$test_dir/gnu_xdir"
    $F_TOOL a+X "$test_dir/f_xdir"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_perm f_perm
    gnu_perm=$(stat -c '%a' "$test_dir/gnu_xdir" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_xdir")
    f_perm=$(stat -c '%a' "$test_dir/f_xdir" 2>/dev/null || stat -f '%Lp' "$test_dir/f_xdir")
    if [[ "$gnu_perm" == "$f_perm" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: a+X on directory ($gnu_perm)"
        record_result "a+X on directory" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: a+X on directory (GNU=$gnu_perm F=$f_perm)"
        record_result "a+X on directory" "FAIL" "GNU=$gnu_perm F=$f_perm" "" ""
    fi

    # X on regular file without x: should NOT add execute
    compare_chmod "a+X on regular file (no existing x)" "a+X" "644"

    # X on file that already has some x: should add execute
    compare_chmod "a+X on file with u+x" "a+X" "744"

    # === Section 5: Recursive (-R) ===
    echo ""
    echo "=== Recursive (-R) ==="

    mkdir -p "$test_dir/gnu_rtree/sub1/sub2"
    echo "a" > "$test_dir/gnu_rtree/file1"
    echo "b" > "$test_dir/gnu_rtree/sub1/file2"
    echo "c" > "$test_dir/gnu_rtree/sub1/sub2/file3"
    cp -r "$test_dir/gnu_rtree" "$test_dir/f_rtree"

    $GNU_TOOL -R 755 "$test_dir/gnu_rtree"
    $F_TOOL -R 755 "$test_dir/f_rtree"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_perms f_perms
    gnu_perms=$(find "$test_dir/gnu_rtree" -exec stat -c '%a' {} \; 2>/dev/null | sort)
    f_perms=$(find "$test_dir/f_rtree" -exec stat -c '%a' {} \; 2>/dev/null | sort)
    if [[ "$gnu_perms" == "$f_perms" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: chmod -R 755 (all perms match)"
        record_result "chmod -R 755" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: chmod -R 755 (perms differ)"
        record_result "chmod -R 755" "FAIL" "perms differ" "" ""
    fi

    # Recursive symbolic
    cp -r "$test_dir/gnu_rtree" "$test_dir/gnu_rtree2"
    cp -r "$test_dir/f_rtree" "$test_dir/f_rtree2"

    $GNU_TOOL -R go-rwx "$test_dir/gnu_rtree2"
    $F_TOOL -R go-rwx "$test_dir/f_rtree2"

    TESTS_RUN=$((TESTS_RUN + 1))
    gnu_perms=$(find "$test_dir/gnu_rtree2" -exec stat -c '%a' {} \; 2>/dev/null | sort)
    f_perms=$(find "$test_dir/f_rtree2" -exec stat -c '%a' {} \; 2>/dev/null | sort)
    if [[ "$gnu_perms" == "$f_perms" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: chmod -R go-rwx"
        record_result "chmod -R go-rwx" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: chmod -R go-rwx"
        record_result "chmod -R go-rwx" "FAIL" "perms differ" "" ""
    fi

    # === Section 6: --reference ===
    echo ""
    echo "=== --reference ==="

    echo "ref" > "$test_dir/ref_file"
    $GNU_TOOL 750 "$test_dir/ref_file"

    echo "target" > "$test_dir/gnu_ref_target"
    echo "target" > "$test_dir/f_ref_target"

    $GNU_TOOL --reference="$test_dir/ref_file" "$test_dir/gnu_ref_target"
    $F_TOOL --reference="$test_dir/ref_file" "$test_dir/f_ref_target"

    TESTS_RUN=$((TESTS_RUN + 1))
    gnu_perm=$(stat -c '%a' "$test_dir/gnu_ref_target" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_ref_target")
    f_perm=$(stat -c '%a' "$test_dir/f_ref_target" 2>/dev/null || stat -f '%Lp' "$test_dir/f_ref_target")
    if [[ "$gnu_perm" == "$f_perm" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --reference ($gnu_perm)"
        record_result "--reference" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --reference (GNU=$gnu_perm F=$f_perm)"
        record_result "--reference" "FAIL" "GNU=$gnu_perm F=$f_perm" "" ""
    fi

    # === GNU Upstream: Octal Mode Validation ===
    echo ""
    echo "=== GNU Upstream: Octal Mode Validation ==="

    # From octal.sh: invalid octal-like mode strings should fail
    echo "test" > "$test_dir/gnu_octal_f"
    echo "test" > "$test_dir/f_octal_f"

    run_exit_code_test "GNU: reject '0-anything' mode" \
        "$GNU_TOOL '0-anything' '$test_dir/gnu_octal_f' 2>&1" \
        "$F_TOOL '0-anything' '$test_dir/f_octal_f' 2>&1"

    echo "test" > "$test_dir/gnu_octal_f2"
    echo "test" > "$test_dir/f_octal_f2"

    run_exit_code_test "GNU: reject '7-anything' mode" \
        "$GNU_TOOL '7-anything' '$test_dir/gnu_octal_f2' 2>&1" \
        "$F_TOOL '7-anything' '$test_dir/f_octal_f2' 2>&1"

    echo "test" > "$test_dir/gnu_octal_f3"
    echo "test" > "$test_dir/f_octal_f3"

    run_exit_code_test "GNU: reject '8' as mode" \
        "$GNU_TOOL '8' '$test_dir/gnu_octal_f3' 2>&1" \
        "$F_TOOL '8' '$test_dir/f_octal_f3' 2>&1"

    # === GNU Upstream: Equals Mode (A=B) ===
    echo ""
    echo "=== GNU Upstream: Equals Mode (A=B) ==="

    # From equals.sh: chmod with cross-assignment modes like g=u, o=g
    compare_chmod "GNU: g=u (copy user to group)" "a=,u=rwx,g=u" "000"
    compare_chmod "GNU: o=u (copy user to other)" "a=,u=rwx,o=u" "000"
    compare_chmod "GNU: u=g (copy group to user)" "a=,g=rwx,u=g" "000"
    compare_chmod "GNU: o=g (copy group to other)" "a=,g=rwx,o=g" "000"
    compare_chmod "GNU: u=o (copy other to user)" "a=,o=rwx,u=o" "000"
    compare_chmod "GNU: g=o (copy other to group)" "a=,o=rwx,g=o" "000"

    # === GNU Upstream: c-option (--changes) ===
    echo ""
    echo "=== GNU Upstream: c-option (--changes) ==="

    # From c-option.sh: -c should produce output only when mode actually changes
    echo "test" > "$test_dir/gnu_c_file"
    echo "test" > "$test_dir/f_c_file"
    $GNU_TOOL 444 "$test_dir/gnu_c_file" "$test_dir/f_c_file"

    # First change: should produce output
    run_exit_code_test "GNU: chmod -c reports actual change" \
        "$GNU_TOOL -c u=rwx '$test_dir/gnu_c_file' 2>&1; echo exit=\$?" \
        "$F_TOOL -c u=rwx '$test_dir/f_c_file' 2>&1; echo exit=\$?"

    # Second run (no change): should produce no output
    run_test "GNU: chmod -c silent on no change" \
        "$GNU_TOOL -c u=rwx '$test_dir/gnu_c_file' 2>&1 | wc -l" \
        "$F_TOOL -c u=rwx '$test_dir/f_c_file' 2>&1 | wc -l"

    # === GNU Upstream: Silent Mode (-f) ===
    echo ""
    echo "=== GNU Upstream: Silent Mode (-f) ==="

    # From silent.sh: -f should suppress error messages for nonexistent files
    run_test "GNU: chmod -f suppresses error on nonexistent" \
        "$GNU_TOOL -f 0 no-such-file-$$ 2>&1 | wc -c; echo exit=\$?" \
        "$F_TOOL -f 0 no-such-file-$$ 2>&1 | wc -c; echo exit=\$?"

    # === GNU Upstream: Ignore Symlink ===
    echo ""
    echo "=== GNU Upstream: Ignore Symlink ==="

    # From ignore-symlink.sh: chmod -R with symlinks should succeed without error
    mkdir -p "$test_dir/gnu_igdir" "$test_dir/f_igdir"
    echo "test" > "$test_dir/gnu_igdir/f"
    echo "test" > "$test_dir/f_igdir/f"
    ln -s f "$test_dir/gnu_igdir/l"
    ln -s f "$test_dir/f_igdir/l"

    run_exit_code_test "GNU: chmod u+w -R ignores symlinks" \
        "$GNU_TOOL u+w -R '$test_dir/gnu_igdir' 2>&1" \
        "$F_TOOL u+w -R '$test_dir/f_igdir' 2>&1"

    # === GNU Upstream: Dangling Symlink ===
    echo ""
    echo "=== GNU Upstream: Dangling Symlink ==="

    # From thru-dangling.sh: chmod on dangling symlink should fail
    ln -s non-existent-$$ "$test_dir/gnu_dangle"
    ln -s non-existent-$$ "$test_dir/f_dangle"

    run_exit_code_test "GNU: chmod fails on dangling symlink" \
        "$GNU_TOOL 644 '$test_dir/gnu_dangle' 2>&1" \
        "$F_TOOL 644 '$test_dir/f_dangle' 2>&1"

    # === GNU Upstream: Partial Failure ===
    echo ""
    echo "=== GNU Upstream: Partial Failure ==="

    # From partial-fail.sh: chmod with a mix of valid and invalid files should fail
    echo "test" > "$test_dir/gnu_partial"
    echo "test" > "$test_dir/f_partial"

    run_exit_code_test "GNU: chmod with missing and valid file" \
        "$GNU_TOOL 0 missing_file_$$ '$test_dir/gnu_partial' 2>&1" \
        "$F_TOOL 0 missing_file_$$ '$test_dir/f_partial' 2>&1"

    # === GNU Upstream: Usage Edge Cases ===
    echo ""
    echo "=== GNU Upstream: Usage Edge Cases ==="

    # From usage.sh: various invalid argument combinations
    echo "test" > "$test_dir/gnu_usage_f"
    echo "test" > "$test_dir/f_usage_f"

    run_exit_code_test "GNU: chmod with no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "GNU: chmod -- (missing mode)" \
        "$GNU_TOOL -- 2>&1" \
        "$F_TOOL -- 2>&1"

    run_exit_code_test "GNU: chmod invalid mode 'u+gr'" \
        "$GNU_TOOL 'u+gr' '$test_dir/gnu_usage_f' 2>&1" \
        "$F_TOOL 'u+gr' '$test_dir/f_usage_f' 2>&1"

    # === GNU Upstream: Equal-X Mode (=x with umask) ===
    echo ""
    echo "=== GNU Upstream: Equal-X Mode (=x with umask) ==="

    # From equal-x.sh: test "chmod =x" and similar with umask
    for mode in "=x" "=xX" "=Xx" "=x,=X" "=X,=x"; do
        echo "test" > "$test_dir/gnu_eqx_f"
        echo "test" > "$test_dir/f_eqx_f"
        $GNU_TOOL "a=r" "$test_dir/gnu_eqx_f" 2>/dev/null
        $GNU_TOOL "a=r" "$test_dir/f_eqx_f" 2>/dev/null

        # Apply mode with umask 005
        (umask 005 && $GNU_TOOL "$mode" "$test_dir/gnu_eqx_f" 2>/dev/null)
        (umask 005 && $F_TOOL "$mode" "$test_dir/f_eqx_f" 2>/dev/null)

        TESTS_RUN=$((TESTS_RUN + 1))
        local gnu_p f_p
        gnu_p=$(stat -c '%a' "$test_dir/gnu_eqx_f" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_eqx_f")
        f_p=$(stat -c '%a' "$test_dir/f_eqx_f" 2>/dev/null || stat -f '%Lp' "$test_dir/f_eqx_f")
        if [[ "$gnu_p" == "$f_p" ]]; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "  ${GREEN}PASS${NC}: GNU: chmod $mode with umask 005 ($gnu_p)"
            record_result "GNU: chmod $mode with umask 005" "PASS" "" "" ""
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: GNU: chmod $mode with umask 005 (GNU=$gnu_p F=$f_p)"
            record_result "GNU: chmod $mode with umask 005" "FAIL" "GNU=$gnu_p F=$f_p" "" ""
        fi
        rm -f "$test_dir/gnu_eqx_f" "$test_dir/f_eqx_f"
    done

    # === GNU Upstream: Inaccessible Directory Fix ===
    echo ""
    echo "=== GNU Upstream: Inaccessible Directory Fix ==="

    # From inaccessible.sh: chmod on directories with mode 0, then restore
    mkdir -p "$test_dir/gnu_inac/e" "$test_dir/f_inac/e"
    $GNU_TOOL 0 "$test_dir/gnu_inac/e" "$test_dir/gnu_inac" 2>/dev/null || true
    $GNU_TOOL 0 "$test_dir/f_inac/e" "$test_dir/f_inac" 2>/dev/null || true

    run_exit_code_test "GNU: chmod u+rwx on inaccessible dirs" \
        "$GNU_TOOL u+rwx '$test_dir/gnu_inac' '$test_dir/gnu_inac/e' 2>&1" \
        "$F_TOOL u+rwx '$test_dir/f_inac' '$test_dir/f_inac/e' 2>&1"

    # Restore for cleanup
    $GNU_TOOL -R u+rwx "$test_dir/gnu_inac" 2>/dev/null || true
    $GNU_TOOL -R u+rwx "$test_dir/f_inac" 2>/dev/null || true

    # === GNU Upstream: Setgid on Directories ===
    echo ""
    echo "=== GNU Upstream: Setgid on Directories ==="

    # From setgid.sh: test setgid bit behavior on directories
    mkdir -p "$test_dir/gnu_sgid" "$test_dir/f_sgid"
    $GNU_TOOL 755 "$test_dir/gnu_sgid" "$test_dir/f_sgid" 2>/dev/null

    # Test various setgid-related modes
    for mode in "2755" "=2755" "0755" "00755"; do
        $GNU_TOOL "$mode" "$test_dir/gnu_sgid" 2>/dev/null || true
        $F_TOOL "$mode" "$test_dir/f_sgid" 2>/dev/null || true

        TESTS_RUN=$((TESTS_RUN + 1))
        local gnu_sp f_sp
        gnu_sp=$(stat -c '%a' "$test_dir/gnu_sgid" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_sgid")
        f_sp=$(stat -c '%a' "$test_dir/f_sgid" 2>/dev/null || stat -f '%Lp' "$test_dir/f_sgid")
        if [[ "$gnu_sp" == "$f_sp" ]]; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "  ${GREEN}PASS${NC}: GNU: setgid dir mode $mode ($gnu_sp)"
            record_result "GNU: setgid dir mode $mode" "PASS" "" "" ""
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: GNU: setgid dir mode $mode (GNU=$gnu_sp F=$f_sp)"
            record_result "GNU: setgid dir mode $mode" "FAIL" "GNU=$gnu_sp F=$f_sp" "" ""
        fi
    done

    # === GNU Upstream: Symlink Handling (-R, -LR, -RP, --dereference, --no-dereference) ===
    echo ""
    echo "=== GNU Upstream: Symlink Handling ==="

    # From symlinks.sh: test recursive symlink handling options
    mkdir -p "$test_dir/gnu_sl/b" "$test_dir/gnu_sl/c"
    echo "test" > "$test_dir/gnu_sl/b/file"
    echo "test" > "$test_dir/gnu_sl/c/file"
    ln -s ../b/file "$test_dir/gnu_sl/c/link"
    ln -s b "$test_dir/gnu_sl/dirlink"
    ln -s foo "$test_dir/gnu_sl/dangle"

    mkdir -p "$test_dir/f_sl/b" "$test_dir/f_sl/c"
    echo "test" > "$test_dir/f_sl/b/file"
    echo "test" > "$test_dir/f_sl/c/file"
    ln -s ../b/file "$test_dir/f_sl/c/link"
    ln -s b "$test_dir/f_sl/dirlink"
    ln -s foo "$test_dir/f_sl/dangle"

    # -R (default -H): does not deref traversed symlinks
    $GNU_TOOL 777 "$test_dir/gnu_sl/b" "$test_dir/gnu_sl/c" "$test_dir/gnu_sl/b/file" "$test_dir/gnu_sl/c/file" 2>/dev/null
    $GNU_TOOL 777 "$test_dir/f_sl/b" "$test_dir/f_sl/c" "$test_dir/f_sl/b/file" "$test_dir/f_sl/c/file" 2>/dev/null

    run_exit_code_test "GNU: chmod 755 -R (no deref symlinks)" \
        "$GNU_TOOL 755 -R '$test_dir/gnu_sl/c' 2>&1" \
        "$F_TOOL 755 -R '$test_dir/f_sl/c' 2>&1"

    # Verify b/file was NOT changed through the symlink
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_bf f_bf
    gnu_bf=$(stat -c '%a' "$test_dir/gnu_sl/b/file" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_sl/b/file")
    f_bf=$(stat -c '%a' "$test_dir/f_sl/b/file" 2>/dev/null || stat -f '%Lp' "$test_dir/f_sl/b/file")
    if [[ "$gnu_bf" == "$f_bf" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: GNU: -R does not deref symlinks ($gnu_bf)"
        record_result "GNU: -R does not deref symlinks" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: GNU: -R does not deref symlinks (GNU=$gnu_bf F=$f_bf)"
        record_result "GNU: -R does not deref symlinks" "FAIL" "GNU=$gnu_bf F=$f_bf" "" ""
    fi

    # -LR: follows symlinks during traversal
    $GNU_TOOL 777 "$test_dir/gnu_sl/b" "$test_dir/gnu_sl/c" "$test_dir/gnu_sl/b/file" "$test_dir/gnu_sl/c/file" 2>/dev/null
    $GNU_TOOL 777 "$test_dir/f_sl/b" "$test_dir/f_sl/c" "$test_dir/f_sl/b/file" "$test_dir/f_sl/c/file" 2>/dev/null

    run_exit_code_test "GNU: chmod 755 -LR (follow symlinks)" \
        "$GNU_TOOL 755 -LR '$test_dir/gnu_sl/c' 2>&1" \
        "$F_TOOL 755 -LR '$test_dir/f_sl/c' 2>&1"

    # Verify b/file WAS changed through the symlink with -LR
    TESTS_RUN=$((TESTS_RUN + 1))
    gnu_bf=$(stat -c '%a' "$test_dir/gnu_sl/b/file" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_sl/b/file")
    f_bf=$(stat -c '%a' "$test_dir/f_sl/b/file" 2>/dev/null || stat -f '%Lp' "$test_dir/f_sl/b/file")
    if [[ "$gnu_bf" == "$f_bf" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: GNU: -LR follows symlinks ($gnu_bf)"
        record_result "GNU: -LR follows symlinks" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: GNU: -LR follows symlinks (GNU=$gnu_bf F=$f_bf)"
        record_result "GNU: -LR follows symlinks" "FAIL" "GNU=$gnu_bf F=$f_bf" "" ""
    fi

    # --dereference on symlink to file: should change the target
    $GNU_TOOL 777 "$test_dir/gnu_sl/b/file" "$test_dir/f_sl/b/file" 2>/dev/null
    run_exit_code_test "GNU: chmod --dereference on symlink to file" \
        "$GNU_TOOL 755 --dereference '$test_dir/gnu_sl/c/link' 2>&1" \
        "$F_TOOL 755 --dereference '$test_dir/f_sl/c/link' 2>&1"

    # --no-dereference on symlink: should NOT change the target
    $GNU_TOOL 777 "$test_dir/gnu_sl/b/file" "$test_dir/f_sl/b/file" 2>/dev/null
    run_exit_code_test "GNU: chmod --no-dereference on symlink" \
        "$GNU_TOOL 755 --no-dereference '$test_dir/gnu_sl/c/link' 2>&1" \
        "$F_TOOL 755 --no-dereference '$test_dir/f_sl/c/link' 2>&1"

    # Dangling symlink with --no-dereference should NOT error
    run_exit_code_test "GNU: chmod --no-dereference on dangling symlink" \
        "$GNU_TOOL 755 --no-dereference '$test_dir/gnu_sl/dangle' 2>&1" \
        "$F_TOOL 755 --no-dereference '$test_dir/f_sl/dangle' 2>&1"

    # Dangling symlink without --no-dereference SHOULD error
    run_exit_code_test "GNU: chmod on dangling symlink (should fail)" \
        "$GNU_TOOL 755 '$test_dir/gnu_sl/dangle' 2>&1" \
        "$F_TOOL 755 '$test_dir/f_sl/dangle' 2>&1"

    # === GNU Upstream: Umask-X Interaction ===
    echo ""
    echo "=== GNU Upstream: Umask-X Interaction ==="

    # From umask-x.sh: chmod -x with restrictive umask should fail if result is executable
    # Note: GNU chmod returns 1 when umask prevents full removal of execute
    echo "test" > "$test_dir/gnu_umaskx"
    echo "test" > "$test_dir/f_umaskx"
    $GNU_TOOL 755 "$test_dir/gnu_umaskx" "$test_dir/f_umaskx" 2>/dev/null

    set +e
    local gnu_umask_exit f_umask_exit
    (umask 77 && $GNU_TOOL -x "$test_dir/gnu_umaskx") 2>/dev/null
    gnu_umask_exit=$?
    (umask 77 && $F_TOOL -x "$test_dir/f_umaskx") 2>/dev/null
    f_umask_exit=$?
    set -e

    TESTS_RUN=$((TESTS_RUN + 1))
    if { [[ "$gnu_umask_exit" -eq 0 ]] && [[ "$f_umask_exit" -eq 0 ]]; } || \
       { [[ "$gnu_umask_exit" -ne 0 ]] && [[ "$f_umask_exit" -ne 0 ]]; }; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: GNU: chmod -x with umask 77 (GNU=$gnu_umask_exit F=$f_umask_exit)"
        record_result "GNU: chmod -x with umask 77" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: GNU: chmod -x with umask 77 (GNU=$gnu_umask_exit F=$f_umask_exit)"
        record_result "GNU: chmod -x with umask 77" "FAIL" "GNU=$gnu_umask_exit F=$f_umask_exit" "" ""
    fi

    # === GNU Upstream: No-X (Inaccessible Dir Recursive) ===
    echo ""
    echo "=== GNU Upstream: No-X (Inaccessible Dir Recursive) ==="

    # From no-x.sh: chmod -R on directory with no execute permission
    # Requires getlimits_ and $EACCES variable; skip
    skip_test "GNU: chmod -R on no-x directory diagnostic" "Requires getlimits_ ($EACCES variable)"

    # === Section 7: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL 644 /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL 644 /tmp/nonexistent_$$ 2>&1"

    run_exit_code_test "invalid mode" \
        "$GNU_TOOL xyz '$test_dir/ref_file' 2>&1" \
        "$F_TOOL xyz '$test_dir/ref_file' 2>&1"

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_chmod_tests
