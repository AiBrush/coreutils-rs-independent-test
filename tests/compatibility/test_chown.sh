#!/usr/bin/env bash
# Compatibility tests for fchown vs GNU chown
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="chown"
F_TOOL="fchown"

run_chown_tests() {
    init_test_suite "chown"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chown","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chown_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU chown not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_chown_XXXXXX)
    register_temp "$test_dir"

    local current_user current_group
    current_user=$(id -un)
    current_group=$(id -gn)

    # === Section 1: Basic chown (own user) ===
    echo ""
    echo "=== Basic chown (Own User) ==="

    # We can always chown to ourselves
    echo "test" > "$test_dir/gnu_file1"
    echo "test" > "$test_dir/f_file1"

    run_exit_code_test "chown to self" \
        "$GNU_TOOL $current_user '$test_dir/gnu_file1'" \
        "$F_TOOL $current_user '$test_dir/f_file1'"

    # Verify permissions match
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_owner f_owner
    gnu_owner=$(stat -c '%U' "$test_dir/gnu_file1" 2>/dev/null || stat -f '%Su' "$test_dir/gnu_file1")
    f_owner=$(stat -c '%U' "$test_dir/f_file1" 2>/dev/null || stat -f '%Su' "$test_dir/f_file1")
    if [[ "$gnu_owner" == "$f_owner" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: owner matches after chown"
        record_result "owner matches after chown" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: owner mismatch: GNU=$gnu_owner F=$f_owner"
        record_result "owner matches after chown" "FAIL" "GNU=$gnu_owner F=$f_owner" "" ""
    fi

    # === Section 2: chown user:group ===
    echo ""
    echo "=== chown user:group ==="

    echo "test" > "$test_dir/gnu_file2"
    echo "test" > "$test_dir/f_file2"

    run_exit_code_test "chown user:group to self" \
        "$GNU_TOOL $current_user:$current_group '$test_dir/gnu_file2'" \
        "$F_TOOL $current_user:$current_group '$test_dir/f_file2'"

    # === Section 3: Error Handling (Not Root) ===
    echo ""
    echo "=== Error Handling ==="

    if [[ "$(id -u)" -ne 0 ]]; then
        echo "test" > "$test_dir/perm_file"
        run_exit_code_test "chown to root (permission denied)" \
            "$GNU_TOOL root '$test_dir/perm_file' 2>&1" \
            "$F_TOOL root '$test_dir/perm_file' 2>&1"

        run_exit_code_test "chown nonexistent user" \
            "$GNU_TOOL nonexistent_user_$$ '$test_dir/perm_file' 2>&1" \
            "$F_TOOL nonexistent_user_$$ '$test_dir/perm_file' 2>&1"
    fi

    run_exit_code_test "chown nonexistent file" \
        "$GNU_TOOL $current_user /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL $current_user /tmp/nonexistent_$$ 2>&1"

    # === Section 4: Recursive (-R) ===
    echo ""
    echo "=== Recursive (-R) ==="

    mkdir -p "$test_dir/gnu_dir/subdir"
    echo "a" > "$test_dir/gnu_dir/file1"
    echo "b" > "$test_dir/gnu_dir/subdir/file2"
    cp -r "$test_dir/gnu_dir" "$test_dir/f_dir"

    run_exit_code_test "chown -R to self" \
        "$GNU_TOOL -R $current_user '$test_dir/gnu_dir'" \
        "$F_TOOL -R $current_user '$test_dir/f_dir'"

    # === Section 5: Verbose (-v) ===
    echo ""
    echo "=== Verbose (-v) ==="

    echo "test" > "$test_dir/gnu_vfile"
    echo "test" > "$test_dir/f_vfile"

    # Just check exit code, verbose messages may differ in paths
    run_exit_code_test "chown -v" \
        "$GNU_TOOL -v $current_user '$test_dir/gnu_vfile' 2>&1" \
        "$F_TOOL -v $current_user '$test_dir/f_vfile' 2>&1"

    # === Section 6: --reference ===
    echo ""
    echo "=== --reference ==="

    echo "ref" > "$test_dir/ref_file"
    echo "target" > "$test_dir/gnu_target"
    echo "target" > "$test_dir/f_target"

    run_exit_code_test "chown --reference" \
        "$GNU_TOOL --reference='$test_dir/ref_file' '$test_dir/gnu_target'" \
        "$F_TOOL --reference='$test_dir/ref_file' '$test_dir/f_target'"

    # === Section 7: Help/Version ===
    echo ""
    echo "=== Help/Version ==="

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_chown_tests
