#!/usr/bin/env bash
# Compatibility tests for fchmod vs GNU chmod
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="chmod"
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
