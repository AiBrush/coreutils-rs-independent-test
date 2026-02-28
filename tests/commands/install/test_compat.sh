#!/usr/bin/env bash
# Compatibility tests for finstall vs GNU install
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "install")
F_TOOL="finstall"

run_install_tests() {
    init_test_suite "install"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"install","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/install_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU install not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_install_XXXXXX)
    register_temp "$test_dir"

    echo "install test content" > "$test_dir/source_file"
    echo "another file" > "$test_dir/source2"

    # === Section 1: Basic Install ===
    echo ""
    echo "=== Basic Install ==="

    $GNU_TOOL "$test_dir/source_file" "$test_dir/gnu_dest1"
    $F_TOOL "$test_dir/source_file" "$test_dir/f_dest1"

    # Compare content
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_dest1" "$test_dir/f_dest1" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: basic install content matches"
        record_result "basic install content" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: basic install content differs"
        record_result "basic install content" "FAIL" "content differs" "" ""
    fi

    # Compare default mode (should be 0755)
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_mode f_mode
    gnu_mode=$(stat -c '%a' "$test_dir/gnu_dest1" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_dest1")
    f_mode=$(stat -c '%a' "$test_dir/f_dest1" 2>/dev/null || stat -f '%Lp' "$test_dir/f_dest1")
    if [[ "$gnu_mode" == "$f_mode" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: basic install mode matches ($gnu_mode)"
        record_result "basic install mode" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: mode mismatch: GNU=$gnu_mode F=$f_mode"
        record_result "basic install mode" "FAIL" "GNU=$gnu_mode F=$f_mode" "" ""
    fi

    # === Section 2: Custom Mode (-m) ===
    echo ""
    echo "=== Custom Mode (-m) ==="

    $GNU_TOOL -m 644 "$test_dir/source_file" "$test_dir/gnu_m644"
    $F_TOOL -m 644 "$test_dir/source_file" "$test_dir/f_m644"

    TESTS_RUN=$((TESTS_RUN + 1))
    gnu_mode=$(stat -c '%a' "$test_dir/gnu_m644" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_m644")
    f_mode=$(stat -c '%a' "$test_dir/f_m644" 2>/dev/null || stat -f '%Lp' "$test_dir/f_m644")
    if [[ "$gnu_mode" == "$f_mode" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: install -m 644 mode matches ($gnu_mode)"
        record_result "install -m 644" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -m 644 mismatch: GNU=$gnu_mode F=$f_mode"
        record_result "install -m 644" "FAIL" "GNU=$gnu_mode F=$f_mode" "" ""
    fi

    $GNU_TOOL -m 0600 "$test_dir/source_file" "$test_dir/gnu_m600"
    $F_TOOL -m 0600 "$test_dir/source_file" "$test_dir/f_m600"

    TESTS_RUN=$((TESTS_RUN + 1))
    gnu_mode=$(stat -c '%a' "$test_dir/gnu_m600" 2>/dev/null || stat -f '%Lp' "$test_dir/gnu_m600")
    f_mode=$(stat -c '%a' "$test_dir/f_m600" 2>/dev/null || stat -f '%Lp' "$test_dir/f_m600")
    if [[ "$gnu_mode" == "$f_mode" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: install -m 0600 mode matches ($gnu_mode)"
        record_result "install -m 0600" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -m 0600 mismatch: GNU=$gnu_mode F=$f_mode"
        record_result "install -m 0600" "FAIL" "GNU=$gnu_mode F=$f_mode" "" ""
    fi

    # === Section 3: Directory Creation (-d) ===
    echo ""
    echo "=== Directory Creation (-d) ==="

    $GNU_TOOL -d "$test_dir/gnu_newdir"
    $F_TOOL -d "$test_dir/f_newdir"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -d "$test_dir/gnu_newdir" ]] && [[ -d "$test_dir/f_newdir" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: install -d creates directory"
        record_result "install -d creates dir" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: directory not created"
        record_result "install -d creates dir" "FAIL" "missing dir" "" ""
    fi

    # === Section 4: With -D (create parent dirs) ===
    echo ""
    echo "=== Create Parent Dirs (-D) ==="

    $GNU_TOOL -D "$test_dir/source_file" "$test_dir/gnu_deep/a/b/c/dest"
    $F_TOOL -D "$test_dir/source_file" "$test_dir/f_deep/a/b/c/dest"

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_deep/a/b/c/dest" "$test_dir/f_deep/a/b/c/dest" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: install -D creates parents and copies"
        record_result "install -D" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: install -D failed"
        record_result "install -D" "FAIL" "content differs or missing" "" ""
    fi

    # === Section 5: Verbose (-v) ===
    echo ""
    echo "=== Verbose (-v) ==="

    run_exit_code_test "install -v exit code" \
        "$GNU_TOOL -v '$test_dir/source_file' '$test_dir/gnu_v_dest' 2>&1" \
        "$F_TOOL -v '$test_dir/source_file' '$test_dir/f_v_dest' 2>&1"

    # === Section 6: Compare (-C) ===
    echo ""
    echo "=== Compare (-C) ==="

    # First install
    $GNU_TOOL "$test_dir/source_file" "$test_dir/gnu_cmp_dest"
    $F_TOOL "$test_dir/source_file" "$test_dir/f_cmp_dest"

    # Second install with -C (should be no-op since file is identical)
    run_exit_code_test "install -C (no change needed)" \
        "$GNU_TOOL -C '$test_dir/source_file' '$test_dir/gnu_cmp_dest'" \
        "$F_TOOL -C '$test_dir/source_file' '$test_dir/f_cmp_dest'"

    # === GNU Upstream: Basic Install Operations ===
    echo ""
    echo "=== GNU Upstream: Basic Install Operations ==="

    # From basic-1.sh: install preserves source file
    echo "foo" > "$test_dir/gnu_basic_src"
    echo "foo" > "$test_dir/f_basic_src"
    mkdir -p "$test_dir/gnu_basic_dir" "$test_dir/f_basic_dir"

    run_test "GNU: install to dir preserves source" \
        "$GNU_TOOL '$test_dir/gnu_basic_src' '$test_dir/gnu_basic_dir/' && test -f '$test_dir/gnu_basic_src' && test -f '$test_dir/gnu_basic_dir/gnu_basic_src' && echo OK" \
        "$F_TOOL '$test_dir/f_basic_src' '$test_dir/f_basic_dir/' && test -f '$test_dir/f_basic_src' && test -f '$test_dir/f_basic_dir/f_basic_src' && echo OK"

    # From basic-1.sh: install -d creates directories
    run_test "GNU: install -d creates single dir" \
        "$GNU_TOOL -d '$test_dir/gnu_newdir1' && test -d '$test_dir/gnu_newdir1' && echo OK" \
        "$F_TOOL -d '$test_dir/f_newdir1' && test -d '$test_dir/f_newdir1' && echo OK"

    run_test "GNU: install -d creates multiple dirs" \
        "$GNU_TOOL -d '$test_dir/gnu_nd1' '$test_dir/gnu_nd2' '$test_dir/gnu_nd3' && test -d '$test_dir/gnu_nd1' && test -d '$test_dir/gnu_nd2' && test -d '$test_dir/gnu_nd3' && echo OK" \
        "$F_TOOL -d '$test_dir/f_nd1' '$test_dir/f_nd2' '$test_dir/f_nd3' && test -d '$test_dir/f_nd1' && test -d '$test_dir/f_nd2' && test -d '$test_dir/f_nd3' && echo OK"

    # From basic-1.sh: install -d . (current directory, should succeed)
    run_exit_code_test "GNU: install -d . succeeds" \
        "$GNU_TOOL -d . 2>&1" \
        "$F_TOOL -d . 2>&1"

    # From basic-1.sh: install with mode -m 555
    echo "test555" > "$test_dir/gnu_m555_src"
    echo "test555" > "$test_dir/f_m555_src"

    run_test "GNU: install -m 555 sets mode" \
        "$GNU_TOOL -c -m 555 '$test_dir/gnu_m555_src' '$test_dir/gnu_m555_dest' && stat -c '%a' '$test_dir/gnu_m555_dest' 2>/dev/null || stat -f '%Lp' '$test_dir/gnu_m555_dest'" \
        "$F_TOOL -c -m 555 '$test_dir/f_m555_src' '$test_dir/f_m555_dest' && stat -c '%a' '$test_dir/f_m555_dest' 2>/dev/null || stat -f '%Lp' '$test_dir/f_m555_dest'"

    # From basic-1.sh: omitting directory as source should fail
    run_exit_code_test "GNU: install omitting directory fails" \
        "$GNU_TOOL . '$test_dir/gnu_dot_dest' 2>&1" \
        "$F_TOOL . '$test_dir/f_dot_dest' 2>&1"

    # === GNU Upstream: Create Leading Directories (-D) ===
    echo ""
    echo "=== GNU Upstream: Create Leading Directories (-D) ==="

    # From create-leading.sh: install -D creates parent dirs
    echo "foo" > "$test_dir/gnu_D_src"
    echo "foo" > "$test_dir/f_D_src"

    run_test "GNU: install -D creates deep path" \
        "$GNU_TOOL -D '$test_dir/gnu_D_src' '$test_dir/gnu_no1/no2/dest' && test -d '$test_dir/gnu_no1/no2' && test -r '$test_dir/gnu_no1/no2/dest' && echo OK" \
        "$F_TOOL -D '$test_dir/f_D_src' '$test_dir/f_no1/no2/dest' && test -d '$test_dir/f_no1/no2' && test -r '$test_dir/f_no1/no2/dest' && echo OK"

    # === GNU Upstream: Directory Slash-Dot (-d) ===
    echo ""
    echo "=== GNU Upstream: Directory Slash-Dot (-d) ==="

    # From d-slashdot.sh: install -d with trailing /. and /..
    run_test "GNU: install -d d1/." \
        "$GNU_TOOL -d '$test_dir/gnu_slashdot1/.' && test -d '$test_dir/gnu_slashdot1' && echo OK" \
        "$F_TOOL -d '$test_dir/f_slashdot1/.' && test -d '$test_dir/f_slashdot1' && echo OK"

    run_test "GNU: install -d d2/.." \
        "$GNU_TOOL -d '$test_dir/gnu_slashdot2/..' && test -d '$test_dir/gnu_slashdot2' && echo OK" \
        "$F_TOOL -d '$test_dir/f_slashdot2/..' && test -d '$test_dir/f_slashdot2' && echo OK"

    # === GNU Upstream: Compare (-C) ===
    echo ""
    echo "=== GNU Upstream: Compare (-C) ==="

    # From install-C.sh: -C avoids reinstall when content and mode match
    echo "test" > "$test_dir/gnu_C_src"
    echo "test" > "$test_dir/f_C_src"

    $GNU_TOOL -m 0644 "$test_dir/gnu_C_src" "$test_dir/gnu_C_dest"
    $F_TOOL -m 0644 "$test_dir/f_C_src" "$test_dir/f_C_dest"

    # Second install with -C: should be a no-op (no reinstall)
    run_exit_code_test "GNU: install -C no-op when identical" \
        "$GNU_TOOL -C -m 0644 '$test_dir/gnu_C_src' '$test_dir/gnu_C_dest' 2>&1" \
        "$F_TOOL -C -m 0644 '$test_dir/f_C_src' '$test_dir/f_C_dest' 2>&1"

    # Change content and verify -C triggers reinstall
    echo "test_changed" > "$test_dir/gnu_C_src"
    echo "test_changed" > "$test_dir/f_C_src"

    run_exit_code_test "GNU: install -C reinstalls on content change" \
        "$GNU_TOOL -C -m 0644 '$test_dir/gnu_C_src' '$test_dir/gnu_C_dest' 2>&1" \
        "$F_TOOL -C -m 0644 '$test_dir/f_C_src' '$test_dir/f_C_dest' 2>&1"

    # -C reinstalls when mode differs
    run_exit_code_test "GNU: install -C reinstalls on mode change" \
        "$GNU_TOOL -C -m 0755 '$test_dir/gnu_C_src' '$test_dir/gnu_C_dest' 2>&1" \
        "$F_TOOL -C -m 0755 '$test_dir/f_C_src' '$test_dir/f_C_dest' 2>&1"

    # From install-C.sh: -C and --preserve-timestamps are mutually exclusive
    run_exit_code_test "GNU: install -C --preserve-timestamps mutually exclusive" \
        "$GNU_TOOL -C --preserve-timestamps '$test_dir/gnu_C_src' '$test_dir/gnu_C_dest' 2>&1" \
        "$F_TOOL -C --preserve-timestamps '$test_dir/f_C_src' '$test_dir/f_C_dest' 2>&1"

    # From install-C.sh: -C and --strip are mutually exclusive
    run_exit_code_test "GNU: install -C --strip mutually exclusive" \
        "$GNU_TOOL -C --strip --strip-program=echo '$test_dir/gnu_C_src' '$test_dir/gnu_C_dest' 2>&1" \
        "$F_TOOL -C --strip --strip-program=echo '$test_dir/f_C_src' '$test_dir/f_C_dest' 2>&1"

    # === GNU Upstream: Relative Mode Install ===
    echo ""
    echo "=== GNU Upstream: Relative Mode Install ==="

    # From basic-1.sh: install with --mode=+w (relative mode)
    echo "relmode_test" > "$test_dir/gnu_relmode_src"
    echo "relmode_test" > "$test_dir/f_relmode_src"

    run_exit_code_test "GNU: install --mode=+w relative mode" \
        "$GNU_TOOL '$test_dir/gnu_relmode_src' '$test_dir/gnu_relmode_dst' --mode=+w 2>&1" \
        "$F_TOOL '$test_dir/f_relmode_src' '$test_dir/f_relmode_dst' --mode=+w 2>&1"

    # From basic-1.sh: install with comma-separated mode 'ug+rw,o+r'
    echo "commamode_test" > "$test_dir/gnu_comma_src"
    echo "commamode_test" > "$test_dir/f_comma_src"

    run_test "GNU: install with comma-separated mode" \
        "$GNU_TOOL '$test_dir/gnu_comma_src' '$test_dir/gnu_comma_dst' --mode='ug+rw,o+r' && stat -c '%a' '$test_dir/gnu_comma_dst' 2>/dev/null || stat -f '%Lp' '$test_dir/gnu_comma_dst'" \
        "$F_TOOL '$test_dir/f_comma_src' '$test_dir/f_comma_dst' --mode='ug+rw,o+r' && stat -c '%a' '$test_dir/f_comma_dst' 2>/dev/null || stat -f '%Lp' '$test_dir/f_comma_dst'"

    # From basic-1.sh: install -d with comma-separated mode
    run_test "GNU: install -d with comma-separated mode" \
        "$GNU_TOOL -d '$test_dir/gnu_dmode_dir' --mode='u+rwx,g+rx,o+r' && stat -c '%a' '$test_dir/gnu_dmode_dir' 2>/dev/null || stat -f '%Lp' '$test_dir/gnu_dmode_dir'" \
        "$F_TOOL -d '$test_dir/f_dmode_dir' --mode='u+rwx,g+rx,o+r' && stat -c '%a' '$test_dir/f_dmode_dir' 2>/dev/null || stat -f '%Lp' '$test_dir/f_dmode_dir'"

    # From basic-1.sh: install -D with -t option creates destination hierarchy
    echo "dt_test" > "$test_dir/gnu_dt_src"
    echo "dt_test" > "$test_dir/f_dt_src"

    run_test "GNU: install -D with -t option" \
        "$GNU_TOOL -t '$test_dir/gnu_dt_dir/a/b/c' -D '$test_dir/gnu_dt_src' && test -f '$test_dir/gnu_dt_dir/a/b/c/gnu_dt_src' && echo OK" \
        "$F_TOOL -t '$test_dir/f_dt_dir/a/b/c' -D '$test_dir/f_dt_src' && test -f '$test_dir/f_dt_dir/a/b/c/f_dt_src' && echo OK"

    # install-C-selinux.sh: skipped (requires SELinux)
    skip_test "install -C SELinux context comparison" "Requires SELinux"

    # install-C-root.sh: skipped (requires root)
    skip_test "install -C owner/group comparison" "Requires root access"

    # install-Z-selinux.sh: skipped (requires SELinux)
    skip_test "install -Z SELinux label restoration" "Requires SELinux"

    # trap.sh: skipped (requires building binary and SIGCHLD trap)
    skip_test "install -s with SIGCHLD trap" "Requires building binary (SIGCHLD trap test)"

    # strip-program.sh: skipped (requires custom strip program and working umask)
    skip_test "install -s --strip-program" "Requires custom strip program setup"

    # === Section 7: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent source" \
        "$GNU_TOOL /tmp/nonexistent_$$ '$test_dir/dest' 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ '$test_dir/dest' 2>&1"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_install_tests
