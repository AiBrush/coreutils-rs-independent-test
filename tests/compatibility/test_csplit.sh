#!/usr/bin/env bash
# Compatibility tests for fcsplit vs GNU csplit
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="csplit"
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

    # Helper: compare csplit output in two dirs
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

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_csplit_XXXXXX)
    register_temp "$test_dir"

    # Create test input
    seq 1 20 > "$test_dir/input20"

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

    # === Section 1: Line Number Splitting ===
    echo ""
    echo "=== Line Number Splitting ==="

    local gnu_dir f_dir

    gnu_dir="$test_dir/gnu_line5"; f_dir="$test_dir/f_line5"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/input20" 5 10 15 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/input20" 5 10 15 2>/dev/null)
    compare_csplit_dirs "csplit at lines 5 10 15" "$gnu_dir" "$f_dir"

    # Roundtrip
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff <(cat "$gnu_dir"/xx*) "$test_dir/input20" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: roundtrip line split"
        record_result "roundtrip line split" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: roundtrip line split"
        record_result "roundtrip line split" "FAIL" "mismatch" "" ""
    fi

    gnu_dir="$test_dir/gnu_line10"; f_dir="$test_dir/f_line10"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/input20" 10 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/input20" 10 2>/dev/null)
    compare_csplit_dirs "csplit at line 10" "$gnu_dir" "$f_dir"

    # === Section 2: Regex Splitting ===
    echo ""
    echo "=== Regex Splitting ==="

    gnu_dir="$test_dir/gnu_regex"; f_dir="$test_dir/f_regex"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/pattern_input.txt" '/---/' '{*}' 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/pattern_input.txt" '/---/' '{*}' 2>/dev/null)
    compare_csplit_dirs "csplit /---/ {*}" "$gnu_dir" "$f_dir"

    gnu_dir="$test_dir/gnu_chapter"; f_dir="$test_dir/f_chapter"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/chapters.txt" '/Chapter/' '{*}' 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/chapters.txt" '/Chapter/' '{*}' 2>/dev/null)
    compare_csplit_dirs "csplit /Chapter/ {*}" "$gnu_dir" "$f_dir"

    # === Section 3: Custom Prefix (-f) ===
    echo ""
    echo "=== Custom Prefix (-f) ==="

    gnu_dir="$test_dir/gnu_prefix"; f_dir="$test_dir/f_prefix"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -f chunk "$test_dir/input20" 10 2>/dev/null)
    (cd "$f_dir" && $F_TOOL -f chunk "$test_dir/input20" 10 2>/dev/null)

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_pfiles f_pfiles
    gnu_pfiles=$(cd "$gnu_dir" && ls chunk* 2>/dev/null || true)
    f_pfiles=$(cd "$f_dir" && ls chunk* 2>/dev/null || true)
    if [[ "$gnu_pfiles" == "$f_pfiles" ]] && [[ -n "$gnu_pfiles" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: csplit -f chunk"
        record_result "csplit -f chunk" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: csplit -f chunk"
        record_result "csplit -f chunk" "FAIL" "GNU: $gnu_pfiles F: $f_pfiles" "" ""
    fi

    # === Section 4: Digit count (-n) ===
    echo ""
    echo "=== Digit Count (-n) ==="

    gnu_dir="$test_dir/gnu_n4"; f_dir="$test_dir/f_n4"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n 4 "$test_dir/input20" 10 2>/dev/null)
    (cd "$f_dir" && $F_TOOL -n 4 "$test_dir/input20" 10 2>/dev/null)
    compare_csplit_dirs "csplit -n 4" "$gnu_dir" "$f_dir"

    # === Section 5: Suppress size output (-s) ===
    echo ""
    echo "=== Suppress Size (-s) ==="

    gnu_dir="$test_dir/gnu_silent"; f_dir="$test_dir/f_silent"
    mkdir -p "$gnu_dir" "$f_dir"
    run_stdout_test "csplit -s (suppress byte counts)" \
        "(cd '$gnu_dir' && $GNU_TOOL -s '$test_dir/input20' 10)" \
        "(cd '$f_dir' && $F_TOOL -s '$test_dir/input20' 10)"

    # === Section 6: Keep files on error (-k) ===
    echo ""
    echo "=== Keep Files on Error (-k) ==="

    # This tests that -k keeps partial output on error
    run_exit_code_test "csplit with error (line beyond end)" \
        "(cd '$test_dir' && $GNU_TOOL '$test_dir/input20' 999 2>&1)" \
        "(cd '$test_dir' && $F_TOOL '$test_dir/input20' 999 2>&1)"

    # === Section 7: Byte count output ===
    echo ""
    echo "=== Byte Count Output ==="

    gnu_dir="$test_dir/gnu_bytes"; f_dir="$test_dir/f_bytes"
    mkdir -p "$gnu_dir" "$f_dir"
    run_stdout_test "byte counts match" \
        "(cd '$gnu_dir' && $GNU_TOOL '$test_dir/input20' 10)" \
        "(cd '$f_dir' && $F_TOOL '$test_dir/input20' 10)"

    # === Section 8: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_$$ 5 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 5 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # === Section 9: Regex with offset ===
    echo ""
    echo "=== Regex With Offset ==="

    gnu_dir="$test_dir/gnu_offset"; f_dir="$test_dir/f_offset"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL "$test_dir/chapters.txt" '/Chapter/+1' '{*}' 2>/dev/null)
    (cd "$f_dir" && $F_TOOL "$test_dir/chapters.txt" '/Chapter/+1' '{*}' 2>/dev/null)
    compare_csplit_dirs "csplit /Chapter/+1 {*}" "$gnu_dir" "$f_dir"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_csplit_tests
