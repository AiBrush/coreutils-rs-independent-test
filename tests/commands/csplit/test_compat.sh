#!/usr/bin/env bash
# Compatibility tests for fcsplit vs GNU csplit
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "csplit")
F_TOOL="fcsplit"

run_csplit_tests() {
    init_test_suite "csplit"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"csplit","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/csplit_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU csplit not found, cannot compare" >&2
        return 1
    fi

    # Helper: compare csplit output files in two dirs
    compare_csplit_dirs() {
        local test_name="$1"
        local gnu_dir="$2"
        local f_dir="$3"
        TESTS_RUN=$((TESTS_RUN + 1))
        local passed=true
        local diff_output=""

        local gnu_files f_files
        gnu_files=$(cd "$gnu_dir" && ls xx* 2>/dev/null || true)
        f_files=$(cd "$f_dir" && ls xx* 2>/dev/null || true)

        if [[ "$gnu_files" != "$f_files" ]]; then
            passed=false
            diff_output="File names differ:\nGNU: $gnu_files\nF: $f_files"
        fi

        if $passed; then
            for file in $gnu_files; do
                if [[ -f "$f_dir/$file" ]]; then
                    if ! diff "$gnu_dir/$file" "$f_dir/$file" >/dev/null 2>&1; then
                        passed=false
                        diff_output="Contents differ in: $file"
                        break
                    fi
                else
                    passed=false
                    diff_output="File $file missing in fcoreutils output"
                    break
                fi
            done
        fi

        if $passed; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "  ${GREEN}PASS${NC}: $test_name"
            record_result "$test_name" "PASS" "" "" ""
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: $test_name"
            echo -e "    $diff_output"
            record_result "$test_name" "FAIL" "$diff_output" "" ""
        fi
    }

    # Helper: compare csplit output files with custom prefix
    compare_csplit_prefix_dirs() {
        local test_name="$1"
        local gnu_dir="$2"
        local f_dir="$3"
        local prefix="$4"
        TESTS_RUN=$((TESTS_RUN + 1))
        local passed=true
        local diff_output=""

        local gnu_files f_files
        gnu_files=$(cd "$gnu_dir" && ls ${prefix}* 2>/dev/null || true)
        f_files=$(cd "$f_dir" && ls ${prefix}* 2>/dev/null || true)

        if [[ "$gnu_files" != "$f_files" ]]; then
            passed=false
            diff_output="File names differ:\nGNU: $gnu_files\nF: $f_files"
        fi

        if $passed; then
            for file in $gnu_files; do
                if [[ -f "$f_dir/$file" ]]; then
                    if ! diff "$gnu_dir/$file" "$f_dir/$file" >/dev/null 2>&1; then
                        passed=false
                        diff_output="Contents differ in: $file"
                        break
                    fi
                else
                    passed=false
                    diff_output="File $file missing in fcoreutils output"
                    break
                fi
            done
        fi

        if $passed; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "  ${GREEN}PASS${NC}: $test_name"
            record_result "$test_name" "PASS" "" "" ""
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: $test_name"
            echo -e "    $diff_output"
            record_result "$test_name" "FAIL" "$diff_output" "" ""
        fi
    }

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_csplit_$$_XXXXXX)
    register_temp "$test_dir"

    # Create test input files
    seq 1 20 > "$test_dir/input20"
    seq 1 100 > "$test_dir/input100"

    cat > "$test_dir/pattern_input.txt" <<'EOF'
Header section
More header
---
Body section one
More body
---
Body section two
---
Footer
EOF

    cat > "$test_dir/chapters.txt" <<'EOF'
Chapter 1
Once upon a time
in a land far away
Chapter 2
There lived a brave
hero who fought
Chapter 3
And they all lived
happily ever after
EOF

    printf '' > "$test_dir/empty_file"
    printf 'only one line\n' > "$test_dir/single_line"

    # Generate a large file for testing
    seq 1 10000 > "$test_dir/large_input"

    cat > "$test_dir/words.txt" <<'EOF'
apple
banana
cherry
apple
date
elderberry
apple
fig
grape
apple
EOF

    # ════════════════════════════════════════════════════════════════════════
    # Section 1: Line Number Splitting
    # ════════════════════════════════════════════════════════════════════════
    echo ""
    echo "=== Line Number Splitting ==="

    local gnu_dir f_dir

    # Test 1: csplit_by_line_number — split at line 5
    gnu_dir="$test_dir/gnu_line5"; f_dir="$test_dir/f_line5"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/input20" 5 2>/dev/null) || true
    (cd "$f_dir" && $F_TOOL "$test_dir/input20" 5 2>/dev/null) || true
    compare_csplit_dirs "csplit_by_line_number" "$gnu_dir" "$f_dir"

    # Test 2: csplit_multiple_line_numbers — split at lines 3 6 9
    gnu_dir="$test_dir/gnu_multi"; f_dir="$test_dir/f_multi"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/input20" 3 6 9 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/input20" 3 6 9 2>/dev/null)
    compare_csplit_dirs "csplit_multiple_line_numbers" "$gnu_dir" "$f_dir"

    # Test 3: csplit_repeat_pattern — split every 5 lines with repeat
    gnu_dir="$test_dir/gnu_repeat"; f_dir="$test_dir/f_repeat"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/input20" 5 '{3}' 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/input20" 5 '{3}' 2>/dev/null)
    compare_csplit_dirs "csplit_repeat_pattern" "$gnu_dir" "$f_dir"

    # Test 4: csplit_at_line_10 — single split at line 10
    gnu_dir="$test_dir/gnu_line10"; f_dir="$test_dir/f_line10"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/input20" 10 2>/dev/null) || true
    (cd "$f_dir" && $F_TOOL "$test_dir/input20" 10 2>/dev/null) || true
    compare_csplit_dirs "csplit_at_line_10" "$gnu_dir" "$f_dir"

    # Test 5: csplit_at_lines_5_10_15 — triple split
    gnu_dir="$test_dir/gnu_515"; f_dir="$test_dir/f_515"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/input20" 5 10 15 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/input20" 5 10 15 2>/dev/null)
    compare_csplit_dirs "csplit_at_lines_5_10_15" "$gnu_dir" "$f_dir"

    # Test 6: roundtrip — concatenating split files reproduces original
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff <(cat "$gnu_dir"/xx*) "$test_dir/input20" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: csplit_roundtrip_line_split"
        record_result "csplit_roundtrip_line_split" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: csplit_roundtrip_line_split"
        record_result "csplit_roundtrip_line_split" "FAIL" "mismatch" "" ""
    fi

    # ════════════════════════════════════════════════════════════════════════
    # Section 2: Regex-based Splitting
    # ════════════════════════════════════════════════════════════════════════
    echo ""
    echo "=== Regex Splitting ==="

    # Test 7: csplit_regex_basic — split on pattern
    gnu_dir="$test_dir/gnu_regex"; f_dir="$test_dir/f_regex"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/pattern_input.txt" '/---/' 2>/dev/null) || true
    (cd "$f_dir" && $F_TOOL "$test_dir/pattern_input.txt" '/---/' 2>/dev/null) || true
    compare_csplit_dirs "csplit_regex_basic" "$gnu_dir" "$f_dir"

    # Test 8: csplit_regex_repeat — split on pattern with {*}
    gnu_dir="$test_dir/gnu_regrepeat"; f_dir="$test_dir/f_regrepeat"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/pattern_input.txt" '/---/' '{*}' 2>/dev/null) || true
    (cd "$f_dir" && $F_TOOL "$test_dir/pattern_input.txt" '/---/' '{*}' 2>/dev/null) || true
    compare_csplit_dirs "csplit_regex_repeat" "$gnu_dir" "$f_dir"

    # Test 9: csplit_regex_repeat_count — split on pattern with {3}
    gnu_dir="$test_dir/gnu_regrep3"; f_dir="$test_dir/f_regrep3"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/pattern_input.txt" '/---/' '{3}' 2>/dev/null || true)
    (cd "$f_dir" && $F_TOOL "$test_dir/pattern_input.txt" '/---/' '{3}' 2>/dev/null || true)
    compare_csplit_dirs "csplit_regex_repeat_count" "$gnu_dir" "$f_dir"

    # Test 10: csplit_regex_offset — split on pattern with +2 offset
    gnu_dir="$test_dir/gnu_offset"; f_dir="$test_dir/f_offset"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/chapters.txt" '/Chapter/+1' '{*}' 2>/dev/null) || true
    (cd "$f_dir" && $F_TOOL "$test_dir/chapters.txt" '/Chapter/+1' '{*}' 2>/dev/null) || true
    compare_csplit_dirs "csplit_regex_offset" "$gnu_dir" "$f_dir"

    # Test 11: csplit_regex_positive_offset_2 — split on pattern with +2
    gnu_dir="$test_dir/gnu_off2"; f_dir="$test_dir/f_off2"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/chapters.txt" '/Chapter/+2' '{*}' 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/chapters.txt" '/Chapter/+2' '{*}' 2>/dev/null)
    compare_csplit_dirs "csplit_regex_positive_offset_2" "$gnu_dir" "$f_dir"

    # Test 12: csplit_regex_negative_offset — split with -1 offset
    gnu_dir="$test_dir/gnu_negoff"; f_dir="$test_dir/f_negoff"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/chapters.txt" '/Chapter/-1' '{*}' 2>/dev/null || true)
    (cd "$f_dir" && $F_TOOL "$test_dir/chapters.txt" '/Chapter/-1' '{*}' 2>/dev/null || true)
    compare_csplit_dirs "csplit_regex_negative_offset" "$gnu_dir" "$f_dir"

    # Test 13: csplit_regex_chapter — split chapters
    gnu_dir="$test_dir/gnu_chapter"; f_dir="$test_dir/f_chapter"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/chapters.txt" '/Chapter/' '{*}' 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/chapters.txt" '/Chapter/' '{*}' 2>/dev/null)
    compare_csplit_dirs "csplit_regex_chapter" "$gnu_dir" "$f_dir"

    # Test 14: csplit_regex_repeated_word — split on repeated word
    gnu_dir="$test_dir/gnu_word"; f_dir="$test_dir/f_word"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/words.txt" '/apple/' '{*}' 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/words.txt" '/apple/' '{*}' 2>/dev/null)
    compare_csplit_dirs "csplit_regex_repeated_word" "$gnu_dir" "$f_dir"

    # ════════════════════════════════════════════════════════════════════════
    # Section 3: Output Control Options
    # ════════════════════════════════════════════════════════════════════════
    echo ""
    echo "=== Output Control ==="

    # Test 15: csplit_prefix — custom prefix with -f
    gnu_dir="$test_dir/gnu_prefix"; f_dir="$test_dir/f_prefix"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -f chunk "$test_dir/input20" 10 2>/dev/null)
    (cd "$f_dir" && $F_TOOL -f chunk "$test_dir/input20" 10 2>/dev/null)
    compare_csplit_prefix_dirs "csplit_prefix" "$gnu_dir" "$f_dir" "chunk"

    # Test 16: csplit_suffix_format — custom suffix format
    gnu_dir="$test_dir/gnu_suffix"; f_dir="$test_dir/f_suffix"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL --suffix-format='%03d.txt' "$test_dir/input20" 10 2>/dev/null)
    (cd "$f_dir" && $F_TOOL --suffix-format='%03d.txt' "$test_dir/input20" 10 2>/dev/null)
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_sfiles f_sfiles
    gnu_sfiles=$(cd "$gnu_dir" && ls xx* 2>/dev/null || true)
    f_sfiles=$(cd "$f_dir" && ls xx* 2>/dev/null || true)
    if [[ "$gnu_sfiles" == "$f_sfiles" ]] && [[ -n "$gnu_sfiles" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: csplit_suffix_format"
        record_result "csplit_suffix_format" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: csplit_suffix_format"
        record_result "csplit_suffix_format" "FAIL" "GNU: $gnu_sfiles F: $f_sfiles" "" ""
    fi

    # Test 17: csplit_digits — custom digit count with -n 4
    gnu_dir="$test_dir/gnu_n4"; f_dir="$test_dir/f_n4"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n 4 "$test_dir/input20" 10 2>/dev/null)
    (cd "$f_dir" && $F_TOOL -n 4 "$test_dir/input20" 10 2>/dev/null)
    compare_csplit_dirs "csplit_digits" "$gnu_dir" "$f_dir"

    # Test 18: csplit_digits_3 — custom digit count with -n 3
    gnu_dir="$test_dir/gnu_n3"; f_dir="$test_dir/f_n3"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n 3 "$test_dir/input20" 5 10 15 2>/dev/null)
    (cd "$f_dir" && $F_TOOL -n 3 "$test_dir/input20" 5 10 15 2>/dev/null)
    compare_csplit_dirs "csplit_digits_3" "$gnu_dir" "$f_dir"

    # Test 19: csplit_suppress_size — suppress byte count output with -s
    gnu_dir="$test_dir/gnu_silent"; f_dir="$test_dir/f_silent"
    mkdir -p "$gnu_dir" "$f_dir"
    run_stdout_test "csplit_suppress_size" \
        "(cd '$gnu_dir' && $GNU_TOOL -s '$test_dir/input20' 10)" \
        "(cd '$f_dir' && $F_TOOL -s '$test_dir/input20' 10)"

    # Test 20: csplit_elide_empty — elide empty files with -z
    gnu_dir="$test_dir/gnu_elide"; f_dir="$test_dir/f_elide"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -z "$test_dir/pattern_input.txt" '/---/' '{*}' 2>/dev/null)
    (cd "$f_dir" && $F_TOOL -z "$test_dir/pattern_input.txt" '/---/' '{*}' 2>/dev/null)
    compare_csplit_dirs "csplit_elide_empty" "$gnu_dir" "$f_dir"

    # Test 21: csplit_byte_counts — byte count output matches
    gnu_dir="$test_dir/gnu_bytes"; f_dir="$test_dir/f_bytes"
    mkdir -p "$gnu_dir" "$f_dir"
    run_stdout_test "csplit_byte_counts" \
        "(cd '$gnu_dir' && $GNU_TOOL '$test_dir/input20' 10)" \
        "(cd '$f_dir' && $F_TOOL '$test_dir/input20' 10)"

    # Test 22: csplit_prefix_and_digits — combine -f and -n
    gnu_dir="$test_dir/gnu_pn"; f_dir="$test_dir/f_pn"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -f part -n 3 "$test_dir/input20" 5 10 15 2>/dev/null)
    (cd "$f_dir" && $F_TOOL -f part -n 3 "$test_dir/input20" 5 10 15 2>/dev/null)
    compare_csplit_prefix_dirs "csplit_prefix_and_digits" "$gnu_dir" "$f_dir" "part"

    # ════════════════════════════════════════════════════════════════════════
    # Section 4: Error Handling
    # ════════════════════════════════════════════════════════════════════════
    echo ""
    echo "=== Error Handling ==="

    # Test 23: csplit_keep_on_error — -k keeps partial files on error
    gnu_dir="$test_dir/gnu_keep"; f_dir="$test_dir/f_keep"
    mkdir -p "$gnu_dir" "$f_dir"
    run_exit_code_test "csplit_keep_on_error" \
        "(cd '$gnu_dir' && $GNU_TOOL -k '$test_dir/input20' '/nonexistent_pattern/' 2>&1)" \
        "(cd '$f_dir' && $F_TOOL -k '$test_dir/input20' '/nonexistent_pattern/' 2>&1)"

    # Test 24: csplit_no_keep_on_error — without -k, files removed on error
    run_exit_code_test "csplit_no_keep_on_error" \
        "$GNU_TOOL '$test_dir/input20' '/nonexistent_pattern/' 2>&1" \
        "$F_TOOL '$test_dir/input20' '/nonexistent_pattern/' 2>&1"

    # Test 25: csplit_pattern_not_found — pattern missing from file
    run_exit_code_test "csplit_pattern_not_found" \
        "$GNU_TOOL '$test_dir/input20' '/xyz_never_matches/' 2>&1" \
        "$F_TOOL '$test_dir/input20' '/xyz_never_matches/' 2>&1"

    # Test 26: csplit_nonexistent_file — file does not exist
    run_exit_code_test "csplit_nonexistent_file" \
        "$GNU_TOOL /tmp/nonexistent_csplit_$$ 5 2>&1" \
        "$F_TOOL /tmp/nonexistent_csplit_$$ 5 2>&1"

    # Test 27: csplit_no_args — no arguments (error)
    run_exit_code_test "csplit_no_args" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # Test 28: csplit_line_beyond_end — split line beyond file end
    run_exit_code_test "csplit_line_beyond_end" \
        "$GNU_TOOL '$test_dir/input20' 999 2>&1" \
        "$F_TOOL '$test_dir/input20' 999 2>&1"

    # Test 29: csplit_line_zero — line 0 should fail
    local csplit_in_zero
    csplit_in_zero=$(make_temp "$(printf '\n')")
    register_temp "$csplit_in_zero"
    run_exit_code_test "csplit_line_zero" \
        "$GNU_TOOL '$csplit_in_zero' 0 2>&1" \
        "$F_TOOL '$csplit_in_zero' 0 2>&1"

    # Test 30: csplit_decreasing_line_numbers — decreasing offsets should fail
    run_exit_code_test "csplit_decreasing_line_numbers" \
        "$GNU_TOOL '$csplit_in_zero' 2 1 2>&1" \
        "$F_TOOL '$csplit_in_zero' 2 1 2>&1"

    # ════════════════════════════════════════════════════════════════════════
    # Section 5: Edge Cases
    # ════════════════════════════════════════════════════════════════════════
    echo ""
    echo "=== Edge Cases ==="

    # Test 31: csplit_empty_file — split empty file at line 1
    run_exit_code_test "csplit_empty_file" \
        "$GNU_TOOL '$test_dir/empty_file' 1 2>&1" \
        "$F_TOOL '$test_dir/empty_file' 1 2>&1"

    # Test 32: csplit_single_line — split single-line file at line 1
    gnu_dir="$test_dir/gnu_single"; f_dir="$test_dir/f_single"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/single_line" 1 2>/dev/null || true)
    (cd "$f_dir" && $F_TOOL "$test_dir/single_line" 1 2>/dev/null || true)
    compare_csplit_dirs "csplit_single_line" "$gnu_dir" "$f_dir"

    # Test 33: csplit_stdin — reading from stdin
    gnu_dir="$test_dir/gnu_stdin"; f_dir="$test_dir/f_stdin"
    mkdir -p "$gnu_dir" "$f_dir"
    run_stdout_test "csplit_stdin" \
        "(cd '$gnu_dir' && $GNU_TOOL - 5 < '$test_dir/input20')" \
        "(cd '$f_dir' && $F_TOOL - 5 < '$test_dir/input20')"

    # Test 34: csplit_large_file — split large file by pattern
    gnu_dir="$test_dir/gnu_large"; f_dir="$test_dir/f_large"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/large_input" 2500 5000 7500 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/large_input" 2500 5000 7500 2>/dev/null)
    compare_csplit_dirs "csplit_large_file" "$gnu_dir" "$f_dir"

    # Test 35: csplit_dev_null — split /dev/null at line 1 (error)
    run_exit_code_test "csplit_dev_null" \
        "$GNU_TOOL /dev/null 1 2>&1" \
        "$F_TOOL /dev/null 1 2>&1"

    # Test 36: csplit_help — --help exit code
    run_exit_code_test "csplit_help" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    # Test 37: csplit_version — --version exit code
    run_exit_code_test "csplit_version" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    # ════════════════════════════════════════════════════════════════════════
    # Section 6: GNU Upstream Tests
    # ════════════════════════════════════════════════════════════════════════
    echo ""
    echo "=== GNU Upstream Tests ==="

    # From csplit-1000.sh: split 1000 lines each matching /./ (every line)
    gnu_dir="$test_dir/gnu_1000"; f_dir="$test_dir/f_1000"
    mkdir -p "$gnu_dir" "$f_dir"
    seq 1000 > "$test_dir/input1000"
    run_stdout_test "csplit_1000_lines_regex" \
        "(cd '$gnu_dir' && $GNU_TOOL '$test_dir/input1000' '/./' '{*}' 2>/dev/null | tail -5)" \
        "(cd '$f_dir' && $F_TOOL '$test_dir/input1000' '/./' '{*}' 2>/dev/null | tail -5)"

    # From csplit.sh: csplit with empty line pattern and line number
    local csplit_in1
    csplit_in1=$(make_temp "$(printf 'a\n\n\n')")
    register_temp "$csplit_in1"
    run_stdout_test "csplit_empty_line_pattern" \
        "(cd '$test_dir' && rm -f xx* && $GNU_TOOL '$csplit_in1' '/^\$/' 2 2>&1)" \
        "(cd '$test_dir' && rm -f xx* && $F_TOOL '$csplit_in1' '/^\$/' 2 2>&1)"

    # From csplit.sh: csplit with negative offset pattern
    local csplit_in2
    csplit_in2=$(make_temp "$(printf '\na\n')")
    register_temp "$csplit_in2"
    run_stdout_test "csplit_negative_offset_pattern" \
        "(cd '$test_dir' && rm -f xx* && $GNU_TOOL '$csplit_in2' '/a/-1' '{*}' 2>&1)" \
        "(cd '$test_dir' && rm -f xx* && $F_TOOL '$csplit_in2' '/a/-1' '{*}' 2>&1)"

    # Test: csplit with regex repeat on 100-line file
    gnu_dir="$test_dir/gnu_100rep"; f_dir="$test_dir/f_100rep"
    mkdir -p "$gnu_dir" "$f_dir"
    run_stdout_test "csplit_100_lines_every_10" \
        "(cd '$gnu_dir' && $GNU_TOOL '$test_dir/input100' 10 '{*}' 2>/dev/null)" \
        "(cd '$f_dir' && $F_TOOL '$test_dir/input100' 10 '{*}' 2>/dev/null)"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_csplit_tests
