#!/usr/bin/env bash
# Compatibility tests for fdd vs GNU dd
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "dd")
F_TOOL="fdd"

run_dd_tests() {
    init_test_suite "dd"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dd","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/dd_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU dd not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_dd_XXXXXX)
    register_temp "$test_dir"

    # Create test input
    dd if=/dev/urandom of="$test_dir/random_input" bs=1024 count=10 2>/dev/null
    echo "Hello, World!" > "$test_dir/hello.txt"
    dd if=/dev/zero of="$test_dir/zeros_10k" bs=1024 count=10 2>/dev/null

    # === Section 1: Simple Copy ===
    echo ""
    echo "=== Simple Copy ==="

    $GNU_TOOL if="$test_dir/random_input" of="$test_dir/gnu_copy" 2>/dev/null
    $F_TOOL if="$test_dir/random_input" of="$test_dir/f_copy" 2>/dev/null

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_copy" "$test_dir/f_copy" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: simple copy matches"
        record_result "simple copy" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: simple copy differs"
        record_result "simple copy" "FAIL" "content differs" "" ""
    fi

    # Roundtrip verification
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/random_input" "$test_dir/gnu_copy" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: roundtrip simple copy"
        record_result "roundtrip simple copy" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: roundtrip simple copy"
        record_result "roundtrip simple copy" "FAIL" "mismatch" "" ""
    fi

    # === Section 2: Block Size ===
    echo ""
    echo "=== Block Size ==="

    $GNU_TOOL if="$test_dir/random_input" of="$test_dir/gnu_bs512" bs=512 2>/dev/null
    $F_TOOL if="$test_dir/random_input" of="$test_dir/f_bs512" bs=512 2>/dev/null

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_bs512" "$test_dir/f_bs512" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: bs=512 copy matches"
        record_result "bs=512 copy" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: bs=512 copy differs"
        record_result "bs=512 copy" "FAIL" "content differs" "" ""
    fi

    $GNU_TOOL if="$test_dir/random_input" of="$test_dir/gnu_bs4096" bs=4096 2>/dev/null
    $F_TOOL if="$test_dir/random_input" of="$test_dir/f_bs4096" bs=4096 2>/dev/null

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_bs4096" "$test_dir/f_bs4096" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: bs=4096 copy matches"
        record_result "bs=4096 copy" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: bs=4096 copy differs"
        record_result "bs=4096 copy" "FAIL" "content differs" "" ""
    fi

    # === Section 3: Count ===
    echo ""
    echo "=== Count ==="

    $GNU_TOOL if=/dev/zero of="$test_dir/gnu_count" bs=1024 count=10 2>/dev/null
    $F_TOOL if=/dev/zero of="$test_dir/f_count" bs=1024 count=10 2>/dev/null

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_size f_size
    gnu_size=$(stat -c '%s' "$test_dir/gnu_count" 2>/dev/null || stat -f '%z' "$test_dir/gnu_count")
    f_size=$(stat -c '%s' "$test_dir/f_count" 2>/dev/null || stat -f '%z' "$test_dir/f_count")
    if [[ "$gnu_size" == "$f_size" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: count=10 size matches ($gnu_size bytes)"
        record_result "count=10 size" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: count=10 size mismatch (GNU=$gnu_size F=$f_size)"
        record_result "count=10 size" "FAIL" "GNU=$gnu_size F=$f_size" "" ""
    fi

    # Small count
    $GNU_TOOL if=/dev/zero of="$test_dir/gnu_count1" bs=1 count=100 2>/dev/null
    $F_TOOL if=/dev/zero of="$test_dir/f_count1" bs=1 count=100 2>/dev/null

    TESTS_RUN=$((TESTS_RUN + 1))
    gnu_size=$(stat -c '%s' "$test_dir/gnu_count1" 2>/dev/null || stat -f '%z' "$test_dir/gnu_count1")
    f_size=$(stat -c '%s' "$test_dir/f_count1" 2>/dev/null || stat -f '%z' "$test_dir/f_count1")
    if [[ "$gnu_size" == "$f_size" ]] && [[ "$gnu_size" == "100" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: bs=1 count=100 = 100 bytes"
        record_result "bs=1 count=100" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: bs=1 count=100 (GNU=$gnu_size F=$f_size)"
        record_result "bs=1 count=100" "FAIL" "GNU=$gnu_size F=$f_size" "" ""
    fi

    # === Section 4: Skip/Seek ===
    echo ""
    echo "=== Skip/Seek ==="

    $GNU_TOOL if="$test_dir/random_input" of="$test_dir/gnu_skip" bs=512 skip=1 count=1 2>/dev/null
    $F_TOOL if="$test_dir/random_input" of="$test_dir/f_skip" bs=512 skip=1 count=1 2>/dev/null

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_skip" "$test_dir/f_skip" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: skip=1 count=1 matches"
        record_result "skip=1 count=1" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: skip=1 count=1 differs"
        record_result "skip=1 count=1" "FAIL" "content differs" "" ""
    fi

    $GNU_TOOL if="$test_dir/random_input" of="$test_dir/gnu_skip3" bs=256 skip=3 count=2 2>/dev/null
    $F_TOOL if="$test_dir/random_input" of="$test_dir/f_skip3" bs=256 skip=3 count=2 2>/dev/null

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/gnu_skip3" "$test_dir/f_skip3" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: skip=3 count=2 bs=256 matches"
        record_result "skip=3 count=2 bs=256" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: skip=3 count=2 bs=256 differs"
        record_result "skip=3 count=2 bs=256" "FAIL" "content differs" "" ""
    fi

    # === Section 5: Conversions ===
    echo ""
    echo "=== Conversions ==="

    run_stdout_test "conv=ucase" \
        "echo 'hello world' | $GNU_TOOL conv=ucase 2>/dev/null" \
        "echo 'hello world' | $F_TOOL conv=ucase 2>/dev/null"

    run_stdout_test "conv=lcase" \
        "echo 'HELLO WORLD' | $GNU_TOOL conv=lcase 2>/dev/null" \
        "echo 'HELLO WORLD' | $F_TOOL conv=lcase 2>/dev/null"

    run_stdout_test "conv=ucase with mixed" \
        "echo 'Hello World 123' | $GNU_TOOL conv=ucase 2>/dev/null" \
        "echo 'Hello World 123' | $F_TOOL conv=ucase 2>/dev/null"

    # === Section 6: Stdin/Stdout ===
    echo ""
    echo "=== Stdin/Stdout ==="

    run_stdout_test "stdin to stdout" \
        "echo 'test input' | $GNU_TOOL 2>/dev/null" \
        "echo 'test input' | $F_TOOL 2>/dev/null"

    run_stdout_test "stdin to stdout with bs" \
        "echo 'test data line' | $GNU_TOOL bs=5 2>/dev/null" \
        "echo 'test data line' | $F_TOOL bs=5 2>/dev/null"

    # === Section 7: Byte-Exact Roundtrip ===
    echo ""
    echo "=== Byte-Exact Roundtrip ==="

    $GNU_TOOL if="$test_dir/random_input" of="$test_dir/roundtrip_copy" bs=4096 2>/dev/null

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$test_dir/random_input" "$test_dir/roundtrip_copy" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: byte-exact roundtrip"
        record_result "byte-exact roundtrip" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: byte-exact roundtrip"
        record_result "byte-exact roundtrip" "FAIL" "mismatch" "" ""
    fi

    # === Section 8: Status Output ===
    echo ""
    echo "=== Status Output ==="

    # status=none should suppress stderr
    run_stdout_test "status=none" \
        "echo test | $GNU_TOOL status=none" \
        "echo test | $F_TOOL status=none"

    # === GNU Upstream: Byte Counting (bytes.sh) ===
    echo ""
    echo "=== GNU Upstream: Byte Counting ==="

    # From bytes.sh: count bytes with conv=swab
    local bytes_in
    bytes_in=$(mktemp /tmp/fcoreutils_test_XXXXXX)
    register_temp "$bytes_in"
    echo '0123456789abcdefghijklm' > "$bytes_in"

    run_stdout_test "GNU bytes: count=14 conv=swab" \
        "$GNU_TOOL count=14 iflag=count_bytes conv=swab < '$bytes_in' 2>/dev/null" \
        "$F_TOOL count=14 iflag=count_bytes conv=swab < '$bytes_in' 2>/dev/null"

    # From bytes.sh: skip bytes
    run_stdout_test "GNU bytes: skip 10 bytes" \
        "$GNU_TOOL skip=10 iflag=skip_bytes < '$bytes_in' 2>/dev/null" \
        "$F_TOOL skip=10 iflag=skip_bytes < '$bytes_in' 2>/dev/null"

    # From bytes.sh: skip bytes from pipe with bs=2
    run_stdout_test "GNU bytes: skip 10 bytes from pipe bs=2" \
        "echo '0123456789abcdefghijklm' | $GNU_TOOL skip=10 iflag=skip_bytes bs=2 2>/dev/null" \
        "echo '0123456789abcdefghijklm' | $F_TOOL skip=10 iflag=skip_bytes bs=2 2>/dev/null"

    # === GNU Upstream: Case Conversion (conv-case.sh) ===
    echo ""
    echo "=== GNU Upstream: Case Conversion ==="

    # From conv-case.sh: lowercase already lowercase (identity)
    run_stdout_test "GNU conv-case: lcase on lowercase input" \
        "printf 'abcdefghijklmnopqrstuvwxyz\n' | $GNU_TOOL conv=lcase 2>/dev/null" \
        "printf 'abcdefghijklmnopqrstuvwxyz\n' | $F_TOOL conv=lcase 2>/dev/null"

    # From conv-case.sh: uppercase already uppercase (identity)
    run_stdout_test "GNU conv-case: ucase on uppercase input" \
        "printf 'ABCDEFGHIJKLMNOPQRSTUVWXYZ\n' | $GNU_TOOL conv=ucase 2>/dev/null" \
        "printf 'ABCDEFGHIJKLMNOPQRSTUVWXYZ\n' | $F_TOOL conv=ucase 2>/dev/null"

    # From conv-case.sh: convert uppercase to lowercase
    run_stdout_test "GNU conv-case: lcase on uppercase input" \
        "printf 'ABCDEFGHIJKLMNOPQRSTUVWXYZ\n' | $GNU_TOOL conv=lcase 2>/dev/null" \
        "printf 'ABCDEFGHIJKLMNOPQRSTUVWXYZ\n' | $F_TOOL conv=lcase 2>/dev/null"

    # From conv-case.sh: convert lowercase to uppercase
    run_stdout_test "GNU conv-case: ucase on lowercase input" \
        "printf 'abcdefghijklmnopqrstuvwxyz\n' | $GNU_TOOL conv=ucase 2>/dev/null" \
        "printf 'abcdefghijklmnopqrstuvwxyz\n' | $F_TOOL conv=ucase 2>/dev/null"

    # === GNU Upstream: Unblock Sync (unblock-sync.sh) ===
    echo ""
    echo "=== GNU Upstream: Unblock Sync ==="

    # From unblock-sync.sh: conv=unblock,sync with cbs=4
    local unblock_in
    unblock_in=$(mktemp /tmp/fcoreutils_test_XXXXXX)
    register_temp "$unblock_in"
    printf '000100020003xx' > "$unblock_in"

    run_stdout_test "GNU unblock-sync: cbs=4 conv=unblock,sync" \
        "$GNU_TOOL cbs=4 ibs=4 conv=unblock,sync < '$unblock_in' 2>/dev/null" \
        "$F_TOOL cbs=4 ibs=4 conv=unblock,sync < '$unblock_in' 2>/dev/null"

    # === GNU Upstream: Misc (misc.sh) ===
    echo ""
    echo "=== GNU Upstream: Misc ==="

    # From misc.sh: status=none should suppress all stderr output
    local misc_in
    misc_in=$(mktemp /tmp/fcoreutils_test_XXXXXX)
    register_temp "$misc_in"
    echo 'data' > "$misc_in"

    run_stdout_test "GNU misc: status=none suppresses stderr" \
        "$GNU_TOOL status=none if='$misc_in' 2>&1" \
        "$F_TOOL status=none if='$misc_in' 2>&1"

    # From misc.sh: basic copy with -- separator
    local misc_out_gnu misc_out_f
    misc_out_gnu=$(mktemp /tmp/fcoreutils_test_XXXXXX)
    misc_out_f=$(mktemp /tmp/fcoreutils_test_XXXXXX)
    register_temp "$misc_out_gnu"
    register_temp "$misc_out_f"

    $GNU_TOOL -- if="$misc_in" of="$misc_out_gnu" 2>/dev/null
    $F_TOOL -- if="$misc_in" of="$misc_out_f" 2>/dev/null

    TESTS_RUN=$((TESTS_RUN + 1))
    if diff "$misc_out_gnu" "$misc_out_f" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: GNU misc: dd -- copy with separator"
        record_result "GNU misc: dd -- copy with separator" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: GNU misc: dd -- copy with separator"
        record_result "GNU misc: dd -- copy with separator" "FAIL" "content differs" "" ""
    fi

    # From misc.sh: conv=sync with bs and obs
    run_stdout_test "GNU misc: conv=sync bs=3 ibs=10 obs=10 byte count" \
        "echo x | $GNU_TOOL bs=3 ibs=10 obs=10 conv=sync 2>/dev/null | wc -c | tr -d ' '" \
        "echo x | $F_TOOL bs=3 ibs=10 obs=10 conv=sync 2>/dev/null | wc -c | tr -d ' '"

    # From misc.sh: status=noxfer after status=none should produce output
    # (later option overrides earlier)
    run_stdout_test "GNU misc: status=none then status=noxfer" \
        "echo test | $GNU_TOOL status=none status=noxfer 2>&1 | head -1" \
        "echo test | $F_TOOL status=none status=noxfer 2>&1 | head -1"

    # === GNU Upstream: Status Output (stats.sh) ===
    echo ""
    echo "=== GNU Upstream: Status Output ==="

    # From stats.sh: status=progress should include 'byte copied' for in-progress
    # We test the basic status output format by checking stderr record counts
    run_stdout_test "GNU stats: stderr record count format" \
        "echo test | $GNU_TOOL 2>&1 >/dev/null | head -2" \
        "echo test | $F_TOOL 2>&1 >/dev/null | head -2"

    # === Section 9: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent input" \
        "$GNU_TOOL if=/tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL if=/tmp/nonexistent_$$ 2>&1"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_dd_tests
