#!/usr/bin/env bash
# Compatibility tests for fshred vs GNU shred
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "shred")
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

    # === GNU Upstream: --exact and --zero Options ===
    echo ""
    echo "=== GNU Upstream: --exact and --zero ==="

    # From shred-exact.sh: --exact should not gobble next argument
    echo "a" > "$test_dir/gnu_exact_a"
    echo "bb" > "$test_dir/gnu_exact_b"
    echo "a" > "$test_dir/f_exact_a"
    echo "bb" > "$test_dir/f_exact_b"

    run_test "--exact removes multiple files" \
        "$GNU_TOOL --remove --exact '$test_dir/gnu_exact_a' '$test_dir/gnu_exact_b' && test ! -f '$test_dir/gnu_exact_a' && test ! -f '$test_dir/gnu_exact_b' && echo 'BOTH_REMOVED'" \
        "$F_TOOL --remove --exact '$test_dir/f_exact_a' '$test_dir/f_exact_b' && test ! -f '$test_dir/f_exact_a' && test ! -f '$test_dir/f_exact_b' && echo 'BOTH_REMOVED'"

    # --zero should not gobble next argument
    echo "c" > "$test_dir/gnu_zero_c"
    echo "dd" > "$test_dir/gnu_zero_d"
    echo "c" > "$test_dir/f_zero_c"
    echo "dd" > "$test_dir/f_zero_d"

    run_test "--zero removes multiple files" \
        "$GNU_TOOL --remove --zero '$test_dir/gnu_zero_c' '$test_dir/gnu_zero_d' && test ! -f '$test_dir/gnu_zero_c' && test ! -f '$test_dir/gnu_zero_d' && echo 'BOTH_REMOVED'" \
        "$F_TOOL --remove --zero '$test_dir/f_zero_c' '$test_dir/f_zero_d' && test ! -f '$test_dir/f_zero_c' && test ! -f '$test_dir/f_zero_d' && echo 'BOTH_REMOVED'"

    # === GNU Upstream: --remove Modes ===
    echo ""
    echo "=== GNU Upstream: --remove Modes ==="

    # From shred-remove.sh: various --remove modes should unlink
    for mode in '' '=unlink' '=wipe' '=wipesync'; do
        echo "rm_test" > "$test_dir/gnu_rm_${mode:-default}"
        echo "rm_test" > "$test_dir/f_rm_${mode:-default}"

        run_test "--remove${mode} unlinks file" \
            "$GNU_TOOL -n0 --remove${mode} '$test_dir/gnu_rm_${mode:-default}' && test ! -e '$test_dir/gnu_rm_${mode:-default}' && echo 'REMOVED'" \
            "$F_TOOL -n0 --remove${mode} '$test_dir/f_rm_${mode:-default}' && test ! -e '$test_dir/f_rm_${mode:-default}' && echo 'REMOVED'"
    done

    # Invalid --remove mode should fail
    echo "bad_rm" > "$test_dir/gnu_badmode"
    echo "bad_rm" > "$test_dir/f_badmode"

    run_exit_code_test "--remove=none invalid mode" \
        "$GNU_TOOL -n0 --remove=none '$test_dir/gnu_badmode' 2>&1" \
        "$F_TOOL -n0 --remove=none '$test_dir/f_badmode' 2>&1"

    # === GNU Upstream: --size Option ===
    echo ""
    echo "=== GNU Upstream: --size ==="

    # From shred-size.sh: negative size should fail
    echo "1234" > "$test_dir/gnu_negsize"
    echo "1234" > "$test_dir/f_negsize"

    run_exit_code_test "-s -2 negative size" \
        "$GNU_TOOL -s-2 '$test_dir/gnu_negsize' 2>&1" \
        "$F_TOOL -s-2 '$test_dir/f_negsize' 2>&1"

    # === GNU Upstream: Pattern Sizes ===
    echo ""
    echo "=== GNU Upstream: Pattern Sizes ==="

    # From shred-passes.sh: shred various pattern sizes
    for size in 1 2 6 7 8; do
        echo "pattern" > "$test_dir/gnu_pat_$size"
        echo "pattern" > "$test_dir/f_pat_$size"

        run_exit_code_test "-n4 -s$size pattern size" \
            "$GNU_TOOL -n4 -s$size '$test_dir/gnu_pat_$size'" \
            "$F_TOOL -n4 -s$size '$test_dir/f_pat_$size'"
    done

    # === GNU Upstream: Direct I/O with --exact ===
    echo ""
    echo "=== GNU Upstream: Direct I/O with --exact ==="

    # From shred-exact.sh: --exact with file slightly larger than 1MiB block
    truncate -s1048576 "$test_dir/gnu_slop1" 2>/dev/null && truncate -s+1 "$test_dir/gnu_slop1" 2>/dev/null
    if [[ -f "$test_dir/gnu_slop1" ]]; then
        truncate -s1048576 "$test_dir/f_slop1" && truncate -s+1 "$test_dir/f_slop1"
        run_exit_code_test "--exact -n2 with 1MiB+1 file" \
            "$GNU_TOOL --exact -n2 '$test_dir/gnu_slop1'" \
            "$F_TOOL --exact -n2 '$test_dir/f_slop1'"

        # From shred-exact.sh: --exact with 1-byte file
        echo "x" > "$test_dir/gnu_slop2"
        echo "x" > "$test_dir/f_slop2"
        truncate -s1 "$test_dir/gnu_slop2"
        truncate -s1 "$test_dir/f_slop2"
        run_exit_code_test "--exact -n2 with 1-byte file" \
            "$GNU_TOOL --exact -n2 '$test_dir/gnu_slop2'" \
            "$F_TOOL --exact -n2 '$test_dir/f_slop2'"
    else
        skip_test "--exact direct I/O tests" "truncate not available"
    fi

    # === GNU Upstream: Octal and Hex Size Values ===
    echo ""
    echo "=== GNU Upstream: Octal and Hex Size Values ==="

    # From shred-size.sh: octal size (010 = 8 bytes)
    echo "12345678" > "$test_dir/gnu_oct"
    echo "12345678" > "$test_dir/f_oct"
    run_exit_code_test "-s 010 octal size" \
        "$GNU_TOOL -s010 '$test_dir/gnu_oct'" \
        "$F_TOOL -s010 '$test_dir/f_oct'"

    # From shred-size.sh: hex size (0x10 = 16 bytes)
    echo "12345678" > "$test_dir/gnu_hex"
    echo "12345678" > "$test_dir/f_hex"
    run_exit_code_test "-s 0x10 hex size" \
        "$GNU_TOOL -s0x10 '$test_dir/gnu_hex'" \
        "$F_TOOL -s0x10 '$test_dir/f_hex'"

    # === GNU Upstream: Verbose Pass Output ===
    echo ""
    echo "=== GNU Upstream: Verbose Pass Output ==="

    # From shred-passes.sh: verify zero-length file skip data passes
    touch "$test_dir/gnu_empty_v"
    touch "$test_dir/f_empty_v"
    run_exit_code_test "-v -u on empty file" \
        "$GNU_TOOL -v -u '$test_dir/gnu_empty_v' 2>&1" \
        "$F_TOOL -v -u '$test_dir/f_empty_v' 2>&1"

    # From shred-passes.sh: -n1 single-byte file
    printf '1' > "$test_dir/gnu_singlebyte"
    printf '1' > "$test_dir/f_singlebyte"
    run_exit_code_test "-v -u single-byte file" \
        "$GNU_TOOL -v -u '$test_dir/gnu_singlebyte' 2>&1" \
        "$F_TOOL -v -u '$test_dir/f_singlebyte' 2>&1"

    # === Section 7: Exit Codes ===
    echo ""
    echo "=== Exit Codes ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_shred_tests
