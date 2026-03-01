#!/usr/bin/env bash
# Functional tests for fcsplit (no GNU comparison needed)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

F_TOOL="fcsplit"

run_csplit_functional_tests() {
    init_test_suite "csplit"

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"csplit","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/csplit_results.json"
        return 0
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_csplit_func_$$_XXXXXX)
    register_temp "$test_dir"

    # Create test inputs
    seq 1 20 > "$test_dir/input20"

    cat > "$test_dir/sections.txt" <<'EOF'
SECTION A
line a1
line a2
SECTION B
line b1
line b2
SECTION C
line c1
line c2
EOF

    # ── Error cases (no special input needed) ──

    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1

    run_expected_exit_test "nonexistent file fails" \
        "$F_TOOL /tmp/nonexistent_csplit_func_$$ '/pattern/' 2>/dev/null" 1

    run_expected_exit_test "help exits 0" "$F_TOOL --help >/dev/null 2>&1" 0

    run_expected_exit_test "version exits 0" "$F_TOOL --version >/dev/null 2>&1" 0

    # ── Line splitting ──

    # Split at line 5: should create 2 output files
    local out_dir="$test_dir/out_line5"
    mkdir -p "$out_dir"
    run_expected_exit_test "split at line 5 exits 0" \
        "(cd '$out_dir' && $F_TOOL '$test_dir/input20' 5 >/dev/null 2>&1)" 0

    # Verify output files exist after split
    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$out_dir/xx00" ]] && [[ -f "$out_dir/xx01" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: split creates xx00 and xx01"
        record_result "split creates xx00 and xx01" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: split creates xx00 and xx01"
        record_result "split creates xx00 and xx01" "FAIL" "expected xx00 and xx01" "" ""
    fi

    # Verify roundtrip: concatenating split files == original
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff <(cat "$out_dir"/xx*) "$test_dir/input20" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: roundtrip preserves content"
        record_result "roundtrip preserves content" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: roundtrip preserves content"
        record_result "roundtrip preserves content" "FAIL" "content mismatch" "" ""
    fi

    # ── Regex splitting ──

    local out_dir2="$test_dir/out_regex"
    mkdir -p "$out_dir2"
    run_expected_exit_test "regex split exits 0" \
        "(cd '$out_dir2' && $F_TOOL '$test_dir/sections.txt' '/SECTION/' '{*}' >/dev/null 2>&1)" 0

    # ── Suppress output (-s) ──

    local out_dir3="$test_dir/out_silent"
    mkdir -p "$out_dir3"
    # -s should produce no stdout
    run_expected_test "suppress output with -s" \
        "(cd '$out_dir3' && $F_TOOL -s '$test_dir/input20' 10)" \
        ""

    # ── Custom prefix (-f) ──

    local out_dir4="$test_dir/out_prefix"
    mkdir -p "$out_dir4"
    run_expected_exit_test "custom prefix exits 0" \
        "(cd '$out_dir4' && $F_TOOL -f part '$test_dir/input20' 10 >/dev/null 2>&1)" 0

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$out_dir4/part00" ]] && [[ -f "$out_dir4/part01" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: custom prefix creates part00 and part01"
        record_result "custom prefix creates part00 and part01" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: custom prefix creates part00 and part01"
        record_result "custom prefix creates part00 and part01" "FAIL" "files missing" "" ""
    fi

    # ── Digit count (-n) ──

    local out_dir5="$test_dir/out_digits"
    mkdir -p "$out_dir5"
    run_expected_exit_test "digit count -n 4 exits 0" \
        "(cd '$out_dir5' && $F_TOOL -n 4 '$test_dir/input20' 10 >/dev/null 2>&1)" 0

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ -f "$out_dir5/xx0000" ]] && [[ -f "$out_dir5/xx0001" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: digit count creates xx0000 and xx0001"
        record_result "digit count creates xx0000 and xx0001" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: digit count creates xx0000 and xx0001"
        record_result "digit count creates xx0000 and xx0001" "FAIL" "files missing" "" ""
    fi

    # ── Stdin input ──

    local out_dir6="$test_dir/out_stdin"
    mkdir -p "$out_dir6"
    run_expected_exit_test "stdin input exits 0" \
        "(cd '$out_dir6' && $F_TOOL - 5 < '$test_dir/input20' >/dev/null 2>&1)" 0

    # ── Error: empty file ──

    printf '' > "$test_dir/empty"
    run_expected_exit_test "empty file split fails" \
        "$F_TOOL '$test_dir/empty' 1 2>/dev/null" 1

    # ── Error: line 0 ──

    run_expected_exit_test "line 0 fails" \
        "$F_TOOL '$test_dir/input20' 0 2>/dev/null" 1

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_csplit_functional_tests
