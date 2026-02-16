#!/usr/bin/env bash
# Compatibility tests for fshred vs GNU shred
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="shred"
F_TOOL="fshred"

run_shred_tests() {
    init_test_suite "shred"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"shred","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/shred_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU shred not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_shred_XXXXXX)
    register_temp "$test_dir"

    # === Section 1: Basic Shred ===
    echo ""
    echo "=== Basic Shred ==="

    echo "This is sensitive data that must be destroyed" > "$test_dir/basic_file"
    local original_md5
    original_md5=$(md5sum "$test_dir/basic_file" | cut -d' ' -f1)

    $F_TOOL "$test_dir/basic_file"

    TESTS_RUN=$((TESTS_RUN + 1))
    local shredded_md5
    shredded_md5=$(md5sum "$test_dir/basic_file" | cut -d' ' -f1)
    if [[ "$original_md5" != "$shredded_md5" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: basic shred changes content"
        record_result "basic shred changes content" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: content unchanged after shred"
        record_result "basic shred changes content" "FAIL" "content unchanged" "" ""
    fi

    # Verify file still exists (no -u)
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$test_dir/basic_file" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: file still exists after shred (no -u)"
        record_result "file exists after shred" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: file was removed without -u"
        record_result "file exists after shred" "FAIL" "file removed" "" ""
    fi

    # === Section 2: Shred with Zero Pass (-z) ===
    echo ""
    echo "=== Zero Final Pass (-z) ==="

    dd if=/dev/urandom of="$test_dir/zero_file" bs=1024 count=1 2>/dev/null
    $F_TOOL -z "$test_dir/zero_file"

    TESTS_RUN=$((TESTS_RUN + 1))
    local zero_check
    zero_check=$(od -A n -t x1 "$test_dir/zero_file" | tr -d ' \n')
    # All zeros would be a string of '00'
    local expected_zeros
    expected_zeros=$(printf '%0*d' $((1024 * 2)) 0 | sed 's/0/00/g' | head -c $((1024 * 2)))
    if [[ "$zero_check" == *"000000000000000000000000"* ]] || [[ $(od -A n -t d1 "$test_dir/zero_file" | tr -s ' ' '\n' | sort -u | tr -d '\n ') == "0" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -z final pass is zeros"
        record_result "-z final pass is zeros" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -z file not zeroed"
        record_result "-z final pass is zeros" "FAIL" "not zeroed" "" ""
    fi

    # === Section 3: Shred and Remove (-u) ===
    echo ""
    echo "=== Shred and Remove (-u) ==="

    echo "delete me" > "$test_dir/remove_file"
    $F_TOOL -u "$test_dir/remove_file"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -f "$test_dir/remove_file" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -u removes file"
        record_result "-u removes file" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -u did not remove file"
        record_result "-u removes file" "FAIL" "file still exists" "" ""
    fi

    # === Section 4: Pass Count (-n) ===
    echo ""
    echo "=== Pass Count (-n) ==="

    echo "one pass" > "$test_dir/onepass"
    local orig_md5_onepass
    orig_md5_onepass=$(md5sum "$test_dir/onepass" | cut -d' ' -f1)

    $F_TOOL -n 1 "$test_dir/onepass"

    TESTS_RUN=$((TESTS_RUN + 1))
    local new_md5_onepass
    new_md5_onepass=$(md5sum "$test_dir/onepass" | cut -d' ' -f1)
    if [[ "$orig_md5_onepass" != "$new_md5_onepass" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -n 1 changes content"
        record_result "-n 1 changes content" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -n 1 did not change content"
        record_result "-n 1 changes content" "FAIL" "unchanged" "" ""
    fi

    # === Section 5: Verbose (-v) ===
    echo ""
    echo "=== Verbose (-v) ==="

    echo "verbose test" > "$test_dir/gnu_verbose"
    echo "verbose test" > "$test_dir/f_verbose"

    # Both should output progress info to stderr
    run_exit_code_test "shred -v exit code" \
        "$GNU_TOOL -v '$test_dir/gnu_verbose' 2>&1" \
        "$F_TOOL -v '$test_dir/f_verbose' 2>&1"

    # === Section 6: Size (-s) ===
    echo ""
    echo "=== Size (-s) ==="

    echo "size test" > "$test_dir/size_file"
    run_exit_code_test "shred -s 100" \
        "$GNU_TOOL -s 100 '$test_dir/size_file'" \
        "$F_TOOL -s 100 '$test_dir/size_file'"

    # === Section 7: Exit Codes ===
    echo ""
    echo "=== Exit Codes ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

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

run_shred_tests
