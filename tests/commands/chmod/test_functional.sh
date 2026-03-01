#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fchmod"

# Cross-platform stat helper
get_perm() {
    stat -c '%a' "$1" 2>/dev/null || stat -f '%Lp' "$1"
}

run_chmod_functional_tests() {
    init_test_suite "chmod"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chmod","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chmod_results.json"
        return 0
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_chmod_func_$$_XXXXXX)
    register_temp "$test_dir"

    # Helper: test a mode and verify the resulting permission
    check_mode() {
        local test_name="$1"
        local mode="$2"
        local expected_perm="$3"
        local initial_mode="${4:-644}"

        local tf="$test_dir/$(echo "$test_name" | tr ' /:' '___')_$$"
        echo "test" > "$tf"
        $F_TOOL "$initial_mode" "$tf" 2>/dev/null || true
        $F_TOOL $mode "$tf" 2>/dev/null || true

        TESTS_RUN=$((TESTS_RUN + 1))
        local actual
        actual=$(get_perm "$tf")
        if [[ "$actual" == "$expected_perm" ]]; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "  ${GREEN}PASS${NC}: $test_name (perm=$actual)"
            record_result "$test_name" "PASS" "" "" "$F_TOOL $mode"
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: $test_name (expected=$expected_perm got=$actual)"
            record_result "$test_name" "FAIL" "expected=$expected_perm got=$actual" "" "$F_TOOL $mode"
        fi
        rm -f "$tf"
    }

    # === Error Cases ===
    echo ""
    echo "=== Error Cases ==="

    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent file fails" "$F_TOOL 755 /tmp/nonexistent_file_$$_func 2>/dev/null" 1
    run_expected_exit_test "invalid mode fails" "$F_TOOL xyz '$test_dir' 2>/dev/null" 1
    run_expected_exit_test "--help exits 0" "$F_TOOL --help >/dev/null 2>&1" 0
    run_expected_exit_test "--version exits 0" "$F_TOOL --version >/dev/null 2>&1" 0

    # === Basic Numeric Modes ===
    echo ""
    echo "=== Basic Numeric Modes ==="

    check_mode "chmod 644" "644" "644" "000"
    check_mode "chmod 755" "755" "755" "000"
    check_mode "chmod 777" "777" "777" "000"
    check_mode "chmod 000" "000" "0" "755"
    check_mode "chmod 600" "600" "600" "000"
    check_mode "chmod 700" "700" "700" "000"
    check_mode "chmod 400" "400" "400" "000"
    check_mode "chmod 555" "555" "555" "000"
    check_mode "chmod 444" "444" "444" "000"
    check_mode "chmod 666" "666" "666" "000"
    check_mode "chmod 111" "111" "111" "000"

    # === Leading Zero Modes ===
    echo ""
    echo "=== Leading Zero Modes ==="

    check_mode "chmod 0644" "0644" "644" "000"
    check_mode "chmod 00755" "00755" "755" "000"
    check_mode "chmod 0777" "0777" "777" "000"

    # === Symbolic Modes ===
    echo ""
    echo "=== Symbolic Modes ==="

    check_mode "chmod u+x" "u+x" "744" "644"
    check_mode "chmod u-x" "u-x" "644" "755"
    check_mode "chmod g+w" "g+w" "664" "644"
    check_mode "chmod g-w" "g-w" "644" "664"
    check_mode "chmod o+r" "o+r" "644" "640"
    check_mode "chmod o-r" "o-r" "640" "644"
    check_mode "chmod a+x" "a+x" "755" "644"
    check_mode "chmod a-x" "a-x" "644" "755"
    check_mode "chmod a+w" "a+w" "666" "444"
    check_mode "chmod a-w" "a-w" "444" "666"
    check_mode "chmod u=rwx" "u=rwx" "744" "644"
    check_mode "chmod g=rx" "g=rx" "654" "644"
    check_mode "chmod o=" "o=" "640" "644"
    check_mode "chmod u=rw" "u=rw" "644" "755"
    check_mode "chmod g=r" "g=r" "644" "664"
    check_mode "chmod ug+x" "ug+x" "754" "644"
    check_mode "chmod go-rwx" "go-rwx" "700" "777"
    check_mode "chmod u=rwx,g=rx,o=" "u=rwx,g=rx,o=" "750" "644"

    # === Special Bits ===
    echo ""
    echo "=== Special Bits ==="

    check_mode "chmod 4755 (setuid)" "4755" "4755" "644"
    check_mode "chmod 2755 (setgid)" "2755" "2755" "644"
    check_mode "chmod 1755 (sticky)" "1755" "1755" "644"
    check_mode "chmod 6755 (setuid+setgid)" "6755" "6755" "644"
    check_mode "chmod 7777 (all special)" "7777" "7777" "644"

    # === Capital X ===
    echo ""
    echo "=== Capital X ==="

    # +X on directory: should add execute
    local xdir="$test_dir/xdir_$$"
    mkdir -p "$xdir"
    $F_TOOL 644 "$xdir"
    $F_TOOL a+X "$xdir"
    TESTS_RUN=$((TESTS_RUN + 1))
    local xdir_perm
    xdir_perm=$(get_perm "$xdir")
    if [[ "$xdir_perm" == "755" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: a+X on directory ($xdir_perm)"
        record_result "a+X on directory" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: a+X on directory (expected=755 got=$xdir_perm)"
        record_result "a+X on directory" "FAIL" "expected=755 got=$xdir_perm" "" ""
    fi
    rm -rf "$xdir"

    # +X on regular file without execute: should NOT add execute
    check_mode "a+X on file (no existing x)" "a+X" "644" "644"

    # +X on file with existing user execute: should add execute for all
    check_mode "a+X on file (with u+x)" "a+X" "755" "744"

    # === Recursive (-R) ===
    echo ""
    echo "=== Recursive (-R) ==="

    local rtree="$test_dir/rtree_$$"
    mkdir -p "$rtree/sub1/sub2"
    echo "a" > "$rtree/file1"
    echo "b" > "$rtree/sub1/file2"
    echo "c" > "$rtree/sub1/sub2/file3"
    $F_TOOL 644 "$rtree/file1" "$rtree/sub1/file2" "$rtree/sub1/sub2/file3"
    $F_TOOL 755 "$rtree" "$rtree/sub1" "$rtree/sub1/sub2"

    $F_TOOL -R 700 "$rtree"

    TESTS_RUN=$((TESTS_RUN + 1))
    local all_700=true
    for item in "$rtree/file1" "$rtree/sub1/file2" "$rtree/sub1/sub2/file3"; do
        local p
        p=$(get_perm "$item")
        if [[ "$p" != "700" ]]; then
            all_700=false
            break
        fi
    done
    if $all_700; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: chmod -R 700 on tree"
        record_result "chmod -R 700" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: chmod -R 700 on tree"
        record_result "chmod -R 700" "FAIL" "not all files became 700" "" ""
    fi
    rm -rf "$rtree"

    # Recursive with symbolic mode
    local rtree2="$test_dir/rtree2_$$"
    mkdir -p "$rtree2/sub"
    echo "a" > "$rtree2/f1"
    echo "b" > "$rtree2/sub/f2"
    $F_TOOL 777 "$rtree2/f1" "$rtree2/sub/f2"
    $F_TOOL 777 "$rtree2" "$rtree2/sub"

    $F_TOOL -R go-rwx "$rtree2"

    TESTS_RUN=$((TESTS_RUN + 1))
    local f1_p f2_p
    f1_p=$(get_perm "$rtree2/f1")
    f2_p=$(get_perm "$rtree2/sub/f2")
    if [[ "$f1_p" == "700" ]] && [[ "$f2_p" == "700" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: chmod -R go-rwx ($f1_p, $f2_p)"
        record_result "chmod -R go-rwx" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: chmod -R go-rwx (expected 700,700 got $f1_p,$f2_p)"
        record_result "chmod -R go-rwx" "FAIL" "expected 700,700 got $f1_p,$f2_p" "" ""
    fi
    rm -rf "$rtree2"

    # === Multiple Files ===
    echo ""
    echo "=== Multiple Files ==="

    local mf1="$test_dir/mf1_$$"
    local mf2="$test_dir/mf2_$$"
    local mf3="$test_dir/mf3_$$"
    echo "a" > "$mf1"
    echo "b" > "$mf2"
    echo "c" > "$mf3"
    $F_TOOL 644 "$mf1" "$mf2" "$mf3"

    TESTS_RUN=$((TESTS_RUN + 1))
    local p1 p2 p3
    p1=$(get_perm "$mf1")
    p2=$(get_perm "$mf2")
    p3=$(get_perm "$mf3")
    if [[ "$p1" == "644" ]] && [[ "$p2" == "644" ]] && [[ "$p3" == "644" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: chmod 644 on multiple files"
        record_result "chmod multiple files" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: chmod 644 on multiple files ($p1,$p2,$p3)"
        record_result "chmod multiple files" "FAIL" "got $p1,$p2,$p3" "" ""
    fi
    rm -f "$mf1" "$mf2" "$mf3"

    # === Idempotent (no change) ===
    echo ""
    echo "=== Idempotent ==="

    local idf="$test_dir/idem_$$"
    echo "test" > "$idf"
    $F_TOOL 644 "$idf"

    # Apply same mode again — result should still be 644
    $F_TOOL 644 "$idf"

    TESTS_RUN=$((TESTS_RUN + 1))
    local idem_p
    idem_p=$(get_perm "$idf")
    if [[ "$idem_p" == "644" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: idempotent chmod 644 ($idem_p)"
        record_result "idempotent chmod" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: idempotent chmod 644 (expected=644 got=$idem_p)"
        record_result "idempotent chmod" "FAIL" "expected=644 got=$idem_p" "" ""
    fi
    rm -f "$idf"

    # === Dangling Symlink ===
    echo ""
    echo "=== Symlink Error Cases ==="

    ln -s "/tmp/nonexistent_target_$$" "$test_dir/dangle_$$"
    run_expected_exit_test "chmod on dangling symlink fails" \
        "$F_TOOL 644 '$test_dir/dangle_$$' 2>/dev/null" 1
    rm -f "$test_dir/dangle_$$"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}
run_chmod_functional_tests
