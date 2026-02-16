#!/usr/bin/env bash
# Compatibility tests for fchgrp vs GNU chgrp
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="chgrp"
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

run_chgrp_tests
