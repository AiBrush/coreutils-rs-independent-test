#!/usr/bin/env bash
# Compatibility tests for frm vs GNU rm
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="rm"
F_TOOL="frm"

run_rm_tests() {
    init_test_suite "rm"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"rm","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/rm_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU rm not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_rm_XXXXXX)
    register_temp "$test_dir"

    # === Section 1: Simple Remove ===
    echo ""
    echo "=== Simple Remove ==="

    echo "delete me" > "$test_dir/gnu_file1"
    echo "delete me" > "$test_dir/f_file1"

    $GNU_TOOL "$test_dir/gnu_file1"
    $F_TOOL "$test_dir/f_file1"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -f "$test_dir/gnu_file1" ]] && [[ ! -f "$test_dir/f_file1" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: simple remove"
        record_result "simple remove" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: file not removed"
        record_result "simple remove" "FAIL" "file still exists" "" ""
    fi

    # === Section 2: Force (-f) ===
    echo ""
    echo "=== Force (-f) ==="

    run_exit_code_test "rm -f nonexistent (no error)" \
        "$GNU_TOOL -f /tmp/nonexistent_$$" \
        "$F_TOOL -f /tmp/nonexistent_$$"

    # Verify exit 0
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_exit=0 f_exit=0
    $GNU_TOOL -f /tmp/nonexistent_$$ 2>/dev/null || gnu_exit=$?
    $F_TOOL -f /tmp/nonexistent_$$ 2>/dev/null || f_exit=$?
    if [[ "$gnu_exit" -eq 0 ]] && [[ "$f_exit" -eq 0 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: rm -f nonexistent exits 0"
        record_result "rm -f exit 0" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: rm -f exit codes (GNU=$gnu_exit F=$f_exit)"
        record_result "rm -f exit 0" "FAIL" "GNU=$gnu_exit F=$f_exit" "" ""
    fi

    # === Section 3: Directory Error ===
    echo ""
    echo "=== Directory Error ==="

    mkdir -p "$test_dir/a_dir_gnu" "$test_dir/a_dir_f"

    run_exit_code_test "rm dir without -r (error)" \
        "$GNU_TOOL '$test_dir/a_dir_gnu' 2>&1" \
        "$F_TOOL '$test_dir/a_dir_f' 2>&1"

    # === Section 4: Remove Empty Dir (-d) ===
    echo ""
    echo "=== Remove Empty Dir (-d) ==="

    mkdir "$test_dir/gnu_emptydir"
    mkdir "$test_dir/f_emptydir"

    $GNU_TOOL -d "$test_dir/gnu_emptydir" 2>/dev/null || true
    $F_TOOL -d "$test_dir/f_emptydir" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_exists=0 f_exists=0
    [[ -d "$test_dir/gnu_emptydir" ]] && gnu_exists=1
    [[ -d "$test_dir/f_emptydir" ]] && f_exists=1
    if [[ "$gnu_exists" == "$f_exists" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: rm -d empty dir"
        record_result "rm -d empty dir" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: rm -d mismatch"
        record_result "rm -d empty dir" "FAIL" "mismatch" "" ""
    fi

    # === Section 5: Recursive (-r) ===
    echo ""
    echo "=== Recursive (-r) ==="

    mkdir -p "$test_dir/gnu_tree/sub1/sub2"
    echo "a" > "$test_dir/gnu_tree/file1"
    echo "b" > "$test_dir/gnu_tree/sub1/file2"
    echo "c" > "$test_dir/gnu_tree/sub1/sub2/file3"
    cp -r "$test_dir/gnu_tree" "$test_dir/f_tree"

    $GNU_TOOL -rf "$test_dir/gnu_tree"
    $F_TOOL -rf "$test_dir/f_tree"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -d "$test_dir/gnu_tree" ]] && [[ ! -d "$test_dir/f_tree" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: rm -rf removes tree"
        record_result "rm -rf tree" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: rm -rf did not remove tree"
        record_result "rm -rf tree" "FAIL" "tree still exists" "" ""
    fi

    # === Section 6: Verbose (-v) ===
    echo ""
    echo "=== Verbose (-v) ==="

    echo "verbose" > "$test_dir/gnu_vfile"
    echo "verbose" > "$test_dir/f_vfile"

    run_exit_code_test "rm -v" \
        "$GNU_TOOL -v '$test_dir/gnu_vfile' 2>&1" \
        "$F_TOOL -v '$test_dir/f_vfile' 2>&1"

    # === Section 7: Multiple Files ===
    echo ""
    echo "=== Multiple Files ==="

    echo "a" > "$test_dir/gnu_m1"
    echo "b" > "$test_dir/gnu_m2"
    echo "c" > "$test_dir/gnu_m3"
    echo "a" > "$test_dir/f_m1"
    echo "b" > "$test_dir/f_m2"
    echo "c" > "$test_dir/f_m3"

    $GNU_TOOL "$test_dir/gnu_m1" "$test_dir/gnu_m2" "$test_dir/gnu_m3"
    $F_TOOL "$test_dir/f_m1" "$test_dir/f_m2" "$test_dir/f_m3"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -f "$test_dir/gnu_m1" ]] && [[ ! -f "$test_dir/f_m1" ]] && \
       [[ ! -f "$test_dir/gnu_m2" ]] && [[ ! -f "$test_dir/f_m2" ]] && \
       [[ ! -f "$test_dir/gnu_m3" ]] && [[ ! -f "$test_dir/f_m3" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: multiple files removed"
        record_result "multiple files" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: not all files removed"
        record_result "multiple files" "FAIL" "files remain" "" ""
    fi

    # === Section 8: Preserve Root ===
    echo ""
    echo "=== Preserve Root ==="

    run_exit_code_test "rm --preserve-root=all -rf /" \
        "$GNU_TOOL --preserve-root=all -rf / 2>&1" \
        "$F_TOOL --preserve-root=all -rf / 2>&1"

    # === Section 9: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "rm nonexistent (error)" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_rm_tests
