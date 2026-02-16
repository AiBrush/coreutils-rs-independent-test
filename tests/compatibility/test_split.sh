#!/usr/bin/env bash
# Compatibility tests for fsplit vs GNU split
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="split"
F_TOOL="fsplit"

run_split_tests() {
    init_test_suite "split"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"split","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/split_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU split not found, cannot compare" >&2
        return 1
    fi

    # Helper: compare split output in two dirs
    compare_split_dirs() {
        local test_name="$1"
        local gnu_dir="$2"
        local f_dir="$3"
        TESTS_RUN=$((TESTS_RUN + 1))
        local passed=true
        local diff_output=""

        # Compare file names
        local gnu_files f_files
        gnu_files=$(cd "$gnu_dir" && ls 2>/dev/null || true)
        f_files=$(cd "$f_dir" && ls 2>/dev/null || true)

        if [[ "$gnu_files" != "$f_files" ]]; then
            passed=false
            diff_output="File names differ:\nGNU: $gnu_files\nF: $f_files"
        fi

        # Compare file contents
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

    # === Section 1: Line Splitting (-l) ===
    echo ""
    echo "=== Line Splitting (-l) ==="

    # Create test input
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_split_XXXXXX)
    register_temp "$test_dir"

    seq 1 20 > "$test_dir/input20"
    seq 1 100 > "$test_dir/input100"
    seq 1 7 > "$test_dir/input7"

    # Test -l 5
    local gnu_dir="$test_dir/gnu_l5" f_dir="$test_dir/f_l5"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -l 5 "$test_dir/input20")
    (cd "$f_dir" && $F_TOOL -l 5 "$test_dir/input20")
    compare_split_dirs "split -l 5 (20 lines)" "$gnu_dir" "$f_dir"

    # Roundtrip test
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff <(cat "$gnu_dir"/x*) "$test_dir/input20" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: roundtrip -l 5 (cat x* = original)"
        record_result "roundtrip -l 5" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: roundtrip -l 5"
        record_result "roundtrip -l 5" "FAIL" "roundtrip mismatch" "" ""
    fi

    # Test -l 1
    gnu_dir="$test_dir/gnu_l1"; f_dir="$test_dir/f_l1"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -l 1 "$test_dir/input7")
    (cd "$f_dir" && $F_TOOL -l 1 "$test_dir/input7")
    compare_split_dirs "split -l 1 (7 lines)" "$gnu_dir" "$f_dir"

    # Test -l 10
    gnu_dir="$test_dir/gnu_l10"; f_dir="$test_dir/f_l10"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -l 10 "$test_dir/input100")
    (cd "$f_dir" && $F_TOOL -l 10 "$test_dir/input100")
    compare_split_dirs "split -l 10 (100 lines)" "$gnu_dir" "$f_dir"

    # Test -l 3 (not evenly divisible)
    gnu_dir="$test_dir/gnu_l3"; f_dir="$test_dir/f_l3"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -l 3 "$test_dir/input20")
    (cd "$f_dir" && $F_TOOL -l 3 "$test_dir/input20")
    compare_split_dirs "split -l 3 (20 lines, not even)" "$gnu_dir" "$f_dir"

    # === Section 2: Byte Splitting (-b) ===
    echo ""
    echo "=== Byte Splitting (-b) ==="

    # Create binary-like test data
    dd if=/dev/zero bs=1024 count=10 of="$test_dir/input10k" 2>/dev/null

    gnu_dir="$test_dir/gnu_b100"; f_dir="$test_dir/f_b100"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -b 100 "$test_dir/input20")
    (cd "$f_dir" && $F_TOOL -b 100 "$test_dir/input20")
    compare_split_dirs "split -b 100" "$gnu_dir" "$f_dir"

    gnu_dir="$test_dir/gnu_b1k"; f_dir="$test_dir/f_b1k"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -b 1024 "$test_dir/input10k")
    (cd "$f_dir" && $F_TOOL -b 1024 "$test_dir/input10k")
    compare_split_dirs "split -b 1024 (1K chunks)" "$gnu_dir" "$f_dir"

    # Roundtrip byte split
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff <(cat "$gnu_dir"/x*) "$test_dir/input10k" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: roundtrip -b 1024"
        record_result "roundtrip -b 1024" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: roundtrip -b 1024"
        record_result "roundtrip -b 1024" "FAIL" "mismatch" "" ""
    fi

    # === Section 3: Suffix Options ===
    echo ""
    echo "=== Suffix Options ==="

    # Numeric suffixes (-d)
    gnu_dir="$test_dir/gnu_d"; f_dir="$test_dir/f_d"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -l 5 -d "$test_dir/input20")
    (cd "$f_dir" && $F_TOOL -l 5 -d "$test_dir/input20")
    compare_split_dirs "split -l 5 -d (numeric suffixes)" "$gnu_dir" "$f_dir"

    # Suffix length (-a 3)
    gnu_dir="$test_dir/gnu_a3"; f_dir="$test_dir/f_a3"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -l 5 -a 3 "$test_dir/input20")
    (cd "$f_dir" && $F_TOOL -l 5 -a 3 "$test_dir/input20")
    compare_split_dirs "split -l 5 -a 3 (3-char suffixes)" "$gnu_dir" "$f_dir"

    # Custom prefix
    gnu_dir="$test_dir/gnu_prefix"; f_dir="$test_dir/f_prefix"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -l 5 "$test_dir/input20" "chunk_")
    (cd "$f_dir" && $F_TOOL -l 5 "$test_dir/input20" "chunk_")
    compare_split_dirs "split -l 5 with prefix 'chunk_'" "$gnu_dir" "$f_dir"

    # Additional suffix
    gnu_dir="$test_dir/gnu_addsuf"; f_dir="$test_dir/f_addsuf"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -l 5 --additional-suffix=.txt "$test_dir/input20")
    (cd "$f_dir" && $F_TOOL -l 5 --additional-suffix=.txt "$test_dir/input20")
    compare_split_dirs "split --additional-suffix=.txt" "$gnu_dir" "$f_dir"

    # === Section 4: Number of Chunks (-n) ===
    echo ""
    echo "=== Number of Chunks (-n) ==="

    gnu_dir="$test_dir/gnu_n5"; f_dir="$test_dir/f_n5"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n 5 "$test_dir/input100")
    (cd "$f_dir" && $F_TOOL -n 5 "$test_dir/input100")
    compare_split_dirs "split -n 5 (5 chunks)" "$gnu_dir" "$f_dir"

    gnu_dir="$test_dir/gnu_n3"; f_dir="$test_dir/f_n3"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n 3 "$test_dir/input20")
    (cd "$f_dir" && $F_TOOL -n 3 "$test_dir/input20")
    compare_split_dirs "split -n 3 (3 chunks)" "$gnu_dir" "$f_dir"

    # Roundtrip chunk split
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff <(cat "$gnu_dir"/x*) "$test_dir/input20" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: roundtrip -n 3"
        record_result "roundtrip -n 3" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: roundtrip -n 3"
        record_result "roundtrip -n 3" "FAIL" "mismatch" "" ""
    fi

    # === Section 5: Edge Cases ===
    echo ""
    echo "=== Edge Cases ==="

    # Empty file
    touch "$test_dir/empty"
    gnu_dir="$test_dir/gnu_empty"; f_dir="$test_dir/f_empty"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -l 5 "$test_dir/empty")
    (cd "$f_dir" && $F_TOOL -l 5 "$test_dir/empty")
    compare_split_dirs "split -l 5 empty file" "$gnu_dir" "$f_dir"

    # Stdin input
    gnu_dir="$test_dir/gnu_stdin"; f_dir="$test_dir/f_stdin"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && cat "$test_dir/input20" | $GNU_TOOL -l 5)
    (cd "$f_dir" && cat "$test_dir/input20" | $F_TOOL -l 5)
    compare_split_dirs "split -l 5 from stdin" "$gnu_dir" "$f_dir"

    # -e (elide empty files)
    gnu_dir="$test_dir/gnu_elide"; f_dir="$test_dir/f_elide"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -e -n 10 "$test_dir/input7")
    (cd "$f_dir" && $F_TOOL -e -n 10 "$test_dir/input7")
    compare_split_dirs "split -e -n 10 (elide empty)" "$gnu_dir" "$f_dir"

    # Numeric + suffix length
    gnu_dir="$test_dir/gnu_da4"; f_dir="$test_dir/f_da4"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -l 2 -d -a 4 "$test_dir/input20")
    (cd "$f_dir" && $F_TOOL -l 2 -d -a 4 "$test_dir/input20")
    compare_split_dirs "split -l 2 -d -a 4" "$gnu_dir" "$f_dir"

    # === Section 6: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent input file" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_split_tests
