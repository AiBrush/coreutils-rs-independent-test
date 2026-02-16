#!/usr/bin/env bash
# Compatibility tests for finstall vs GNU install
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="install"
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

    # === Section 7: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent source" \
        "$GNU_TOOL /tmp/nonexistent_$$ '$test_dir/dest' 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ '$test_dir/dest' 2>&1"

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

run_install_tests
