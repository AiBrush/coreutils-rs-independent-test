#!/usr/bin/env bash
# Compatibility tests for fsplit vs GNU split
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "split")
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

    # === GNU Upstream: Lines (lines.sh) ===
    echo ""
    echo "=== GNU Upstream: Lines ==="

    # From lines.sh: split --lines=2 on 5-line input produces 3 files
    printf '1\n2\n3\n4\n5\n' > "$test_dir/input_lines5"

    gnu_dir="$test_dir/gnu_lines2"; f_dir="$test_dir/f_lines2"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL --lines=2 "$test_dir/input_lines5")
    (cd "$f_dir" && $F_TOOL --lines=2 "$test_dir/input_lines5")
    compare_split_dirs "GNU: split --lines=2 (5 lines)" "$gnu_dir" "$f_dir"

    # Verify no extra file created
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_count f_count
    gnu_count=$(ls "$gnu_dir" | wc -l | tr -d ' ')
    f_count=$(ls "$f_dir" | wc -l | tr -d ' ')
    if [[ "$gnu_count" == "$f_count" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: GNU: same number of output files ($gnu_count)"
        record_result "GNU: split --lines=2 file count" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: GNU: file count mismatch (GNU=$gnu_count F=$f_count)"
        record_result "GNU: split --lines=2 file count" "FAIL" "GNU=$gnu_count F=$f_count" "" ""
    fi

    # === GNU Upstream: Numeric Suffixes (numeric.sh) ===
    echo ""
    echo "=== GNU Upstream: Numeric Suffixes ==="

    # From numeric.sh: --numeric-suffixes with --lines=2
    gnu_dir="$test_dir/gnu_numeric"; f_dir="$test_dir/f_numeric"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL --numeric-suffixes --lines=2 "$test_dir/input_lines5")
    (cd "$f_dir" && $F_TOOL --numeric-suffixes --lines=2 "$test_dir/input_lines5")
    compare_split_dirs "GNU: split --numeric-suffixes --lines=2" "$gnu_dir" "$f_dir"

    # From numeric.sh: --numeric-suffixes=9 (start from 9)
    gnu_dir="$test_dir/gnu_num9"; f_dir="$test_dir/f_num9"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL --numeric-suffixes=9 --lines=2 "$test_dir/input_lines5")
    (cd "$f_dir" && $F_TOOL --numeric-suffixes=9 --lines=2 "$test_dir/input_lines5")
    compare_split_dirs "GNU: split --numeric-suffixes=9" "$gnu_dir" "$f_dir"

    # From numeric.sh: --hex-suffixes with --lines=2
    gnu_dir="$test_dir/gnu_hex"; f_dir="$test_dir/f_hex"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL --hex-suffixes --lines=2 "$test_dir/input_lines5")
    (cd "$f_dir" && $F_TOOL --hex-suffixes --lines=2 "$test_dir/input_lines5")
    compare_split_dirs "GNU: split --hex-suffixes --lines=2" "$gnu_dir" "$f_dir"

    # From numeric.sh: invalid start values should fail
    run_exit_code_test "GNU: reject --numeric-suffixes=-1" \
        "$GNU_TOOL --numeric-suffixes=-1 '$test_dir/input_lines5' 2>&1" \
        "$F_TOOL --numeric-suffixes=-1 '$test_dir/input_lines5' 2>&1"

    run_exit_code_test "GNU: reject --numeric-suffixes=one" \
        "$GNU_TOOL --numeric-suffixes=one '$test_dir/input_lines5' 2>&1" \
        "$F_TOOL --numeric-suffixes=one '$test_dir/input_lines5' 2>&1"

    # === GNU Upstream: Additional Suffix (additional-suffix.sh) ===
    echo ""
    echo "=== GNU Upstream: Additional Suffix ==="

    # From additional-suffix.sh: --additional-suffix=.txt
    gnu_dir="$test_dir/gnu_addsuf2"; f_dir="$test_dir/f_addsuf2"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL --lines=2 --additional-suffix=.txt "$test_dir/input_lines5")
    (cd "$f_dir" && $F_TOOL --lines=2 --additional-suffix=.txt "$test_dir/input_lines5")
    compare_split_dirs "GNU: split --additional-suffix=.txt (5 lines)" "$gnu_dir" "$f_dir"

    # From additional-suffix.sh: suffix with slash should fail
    run_exit_code_test "GNU: reject --additional-suffix with slash" \
        "$GNU_TOOL --lines=2 --additional-suffix=a/b '$test_dir/input_lines5' 2>&1" \
        "$F_TOOL --lines=2 --additional-suffix=a/b '$test_dir/input_lines5' 2>&1"

    # === GNU Upstream: Suffix Length (suffix-length.sh) ===
    echo ""
    echo "=== GNU Upstream: Suffix Length ==="

    # From suffix-length.sh: -a 1 with too many splits should fail
    printf '%s' 'abcdefghijklmnopqrstuvwxyz0' > "$test_dir/input_27"

    run_exit_code_test "GNU: -a 1 too short for 27 1-byte splits" \
        "cd '$test_dir/gnu_a1_fail' 2>/dev/null; mkdir -p '$test_dir/gnu_a1_fail' && cd '$test_dir/gnu_a1_fail' && $GNU_TOOL -b 1 -a 1 '$test_dir/input_27' 2>&1" \
        "cd '$test_dir/f_a1_fail' 2>/dev/null; mkdir -p '$test_dir/f_a1_fail' && cd '$test_dir/f_a1_fail' && $F_TOOL -b 1 -a 1 '$test_dir/input_27' 2>&1"

    # From suffix-length.sh: -a 2 should succeed with 27 single-byte files
    gnu_dir="$test_dir/gnu_a2_ok"; f_dir="$test_dir/f_a2_ok"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -b 1 -a 2 "$test_dir/input_27")
    (cd "$f_dir" && $F_TOOL -b 1 -a 2 "$test_dir/input_27")
    compare_split_dirs "GNU: split -b 1 -a 2 (27 bytes)" "$gnu_dir" "$f_dir"

    # From suffix-length.sh: -a is independent of -b/-l/-C
    run_exit_code_test "GNU: -a2 -b1000 on empty input succeeds" \
        "$GNU_TOOL -a2 -b1000 < /dev/null 2>&1" \
        "$F_TOOL -a2 -b1000 < /dev/null 2>&1"

    # === GNU Upstream: Failure Conditions (fail.sh) ===
    echo ""
    echo "=== GNU Upstream: Failure Conditions ==="

    # From fail.sh: split with zero values should fail
    run_exit_code_test "GNU: reject -b 0" \
        "$GNU_TOOL -b 0 '$test_dir/input_lines5' 2>&1" \
        "$F_TOOL -b 0 '$test_dir/input_lines5' 2>&1"

    run_exit_code_test "GNU: reject -l 0" \
        "$GNU_TOOL -l 0 '$test_dir/input_lines5' 2>&1" \
        "$F_TOOL -l 0 '$test_dir/input_lines5' 2>&1"

    run_exit_code_test "GNU: reject -n 0" \
        "$GNU_TOOL -n 0 '$test_dir/input_lines5' 2>&1" \
        "$F_TOOL -n 0 '$test_dir/input_lines5' 2>&1"

    run_exit_code_test "GNU: reject -C 0" \
        "$GNU_TOOL -C 0 '$test_dir/input_lines5' 2>&1" \
        "$F_TOOL -C 0 '$test_dir/input_lines5' 2>&1"

    run_exit_code_test "GNU: reject -n 2/1 (K > N)" \
        "$GNU_TOOL -n 2/1 '$test_dir/input_lines5' 2>&1" \
        "$F_TOOL -n 2/1 '$test_dir/input_lines5' 2>&1"

    run_exit_code_test "GNU: reject -n 0/1" \
        "$GNU_TOOL -n 0/1 '$test_dir/input_lines5' 2>&1" \
        "$F_TOOL -n 0/1 '$test_dir/input_lines5' 2>&1"

    # === GNU Upstream: Byte Chunk Splitting (-n) ===
    echo ""
    echo "=== GNU Upstream: Byte Chunk Splitting ==="

    # From b-chunk.sh: -n 4 on 3-byte file produces 3 data + 1 empty
    printf 'abc' > "$test_dir/input_abc"
    gnu_dir="$test_dir/gnu_bchunk4"; f_dir="$test_dir/f_bchunk4"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n 4 "$test_dir/input_abc")
    (cd "$f_dir" && $F_TOOL -n 4 "$test_dir/input_abc")
    compare_split_dirs "GNU: split -n 4 on 3-byte file" "$gnu_dir" "$f_dir"

    # From b-chunk.sh: -n 2 on 3-byte file
    gnu_dir="$test_dir/gnu_bchunk2"; f_dir="$test_dir/f_bchunk2"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n 2 "$test_dir/input_abc")
    (cd "$f_dir" && $F_TOOL -n 2 "$test_dir/input_abc")
    compare_split_dirs "GNU: split -n 2 on 3-byte file" "$gnu_dir" "$f_dir"

    # From b-chunk.sh: -n 10 on /dev/null produces 10 empty files
    gnu_dir="$test_dir/gnu_bchunknull"; f_dir="$test_dir/f_bchunknull"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n 10 /dev/null)
    (cd "$f_dir" && $F_TOOL -n 10 /dev/null)
    compare_split_dirs "GNU: split -n 10 /dev/null" "$gnu_dir" "$f_dir"

    # From b-chunk.sh: -e -n 10 on /dev/null produces no files
    gnu_dir="$test_dir/gnu_bchunknull_e"; f_dir="$test_dir/f_bchunknull_e"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -e -n 10 /dev/null)
    (cd "$f_dir" && $F_TOOL -e -n 10 /dev/null)
    compare_split_dirs "GNU: split -e -n 10 /dev/null (elide)" "$gnu_dir" "$f_dir"

    # From b-chunk.sh: K/N extraction produces no files, just stdout
    run_test "GNU: split -n 2/3 /dev/null produces empty" \
        "$GNU_TOOL -n 2/3 /dev/null" \
        "$F_TOOL -n 2/3 /dev/null"

    # From b-chunk.sh: roundtrip -n 3 on 5-line file
    gnu_dir="$test_dir/gnu_bchunk3r"; f_dir="$test_dir/f_bchunk3r"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n 3 "$test_dir/input_lines5")
    (cd "$f_dir" && $F_TOOL -n 3 "$test_dir/input_lines5")
    compare_split_dirs "GNU: split -n 3 (5-line file)" "$gnu_dir" "$f_dir"

    # Roundtrip: cat chunks should equal original
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff <(cat "$gnu_dir"/x*) "$test_dir/input_lines5" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: GNU: roundtrip -n 3 byte chunks"
        record_result "GNU: roundtrip -n 3 byte chunks" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: GNU: roundtrip -n 3 byte chunks"
        record_result "GNU: roundtrip -n 3 byte chunks" "FAIL" "mismatch" "" ""
    fi

    # === GNU Upstream: Line Chunk Splitting (-n l/) ===
    echo ""
    echo "=== GNU Upstream: Line Chunk Splitting ==="

    # From l-chunk.sh: -n l/1 on empty produces one empty file
    gnu_dir="$test_dir/gnu_lchunk1"; f_dir="$test_dir/f_lchunk1"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && printf '' | $GNU_TOOL -n l/1)
    (cd "$f_dir" && printf '' | $F_TOOL -n l/1)
    compare_split_dirs "GNU: split -n l/1 empty stdin" "$gnu_dir" "$f_dir"

    # From l-chunk.sh: -n l/10 on /dev/null produces 10 empty files
    gnu_dir="$test_dir/gnu_lchunk10"; f_dir="$test_dir/f_lchunk10"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n l/10 /dev/null)
    (cd "$f_dir" && $F_TOOL -n l/10 /dev/null)
    compare_split_dirs "GNU: split -n l/10 /dev/null" "$gnu_dir" "$f_dir"

    # From l-chunk.sh: -e -n l/10 on /dev/null elides empty files
    gnu_dir="$test_dir/gnu_lchunk10e"; f_dir="$test_dir/f_lchunk10e"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -e -n l/10 /dev/null)
    (cd "$f_dir" && $F_TOOL -e -n l/10 /dev/null)
    compare_split_dirs "GNU: split -e -n l/10 /dev/null (elide)" "$gnu_dir" "$f_dir"

    # From l-chunk.sh: -n l/3 on 5-line file
    gnu_dir="$test_dir/gnu_lchunk3"; f_dir="$test_dir/f_lchunk3"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n l/3 "$test_dir/input_lines5")
    (cd "$f_dir" && $F_TOOL -n l/3 "$test_dir/input_lines5")
    compare_split_dirs "GNU: split -n l/3 (5-line file)" "$gnu_dir" "$f_dir"

    # From l-chunk.sh: specific chunk extraction -n l/K/N
    run_test "GNU: split -n l/15/15 last chunk" \
        "$GNU_TOOL -n l/15/15 '$test_dir/input_lines5'" \
        "$F_TOOL -n l/15/15 '$test_dir/input_lines5'"

    # From l-chunk.sh: invalid chunk number K > N
    run_exit_code_test "GNU: reject -n l/16/15 (K > N)" \
        "$GNU_TOOL -n l/16/15 '$test_dir/input_lines5' 2>&1" \
        "$F_TOOL -n l/16/15 '$test_dir/input_lines5' 2>&1"

    # From l-chunk.sh: test input with no trailing newline
    printf '12\n34\n5' > "$test_dir/input_no_trail"
    run_test "GNU: split -n l/7/7 no trailing newline" \
        "$GNU_TOOL -n l/7/7 '$test_dir/input_no_trail'" \
        "$F_TOOL -n l/7/7 '$test_dir/input_no_trail'"

    # === GNU Upstream: Round-Robin Chunk Splitting (-n r/) ===
    echo ""
    echo "=== GNU Upstream: Round-Robin Chunk Splitting ==="

    # From r-chunk.sh: -n r/3 on 5-line file
    gnu_dir="$test_dir/gnu_rchunk3"; f_dir="$test_dir/f_rchunk3"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n r/3 "$test_dir/input_lines5")
    (cd "$f_dir" && $F_TOOL -n r/3 "$test_dir/input_lines5")
    compare_split_dirs "GNU: split -n r/3 (5-line file)" "$gnu_dir" "$f_dir"

    # From r-chunk.sh: -n r/10 on /dev/null produces 10 empty files
    gnu_dir="$test_dir/gnu_rchunknull"; f_dir="$test_dir/f_rchunknull"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -n r/10 /dev/null)
    (cd "$f_dir" && $F_TOOL -n r/10 /dev/null)
    compare_split_dirs "GNU: split -n r/10 /dev/null" "$gnu_dir" "$f_dir"

    # From r-chunk.sh: -e -n r/10 on /dev/null elides empty
    gnu_dir="$test_dir/gnu_rchunknull_e"; f_dir="$test_dir/f_rchunknull_e"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -e -n r/10 /dev/null)
    (cd "$f_dir" && $F_TOOL -e -n r/10 /dev/null)
    compare_split_dirs "GNU: split -e -n r/10 /dev/null (elide)" "$gnu_dir" "$f_dir"

    # From r-chunk.sh: specific round-robin chunk extraction
    run_test "GNU: split -n r/1/3 first round-robin chunk" \
        "$GNU_TOOL -n r/1/3 '$test_dir/input_lines5'" \
        "$F_TOOL -n r/1/3 '$test_dir/input_lines5'"

    run_test "GNU: split -n r/2/3 second round-robin chunk" \
        "$GNU_TOOL -n r/2/3 '$test_dir/input_lines5'" \
        "$F_TOOL -n r/2/3 '$test_dir/input_lines5'"

    run_test "GNU: split -n r/3/3 third round-robin chunk" \
        "$GNU_TOOL -n r/3/3 '$test_dir/input_lines5'" \
        "$F_TOOL -n r/3/3 '$test_dir/input_lines5'"

    # From r-chunk.sh: input without trailing newline
    run_test "GNU: split -n r/2/3 no trailing newline" \
        "printf '1\n2\n3\n4\n5' | $GNU_TOOL -n r/2/3" \
        "printf '1\n2\n3\n4\n5' | $F_TOOL -n r/2/3"

    # === GNU Upstream: Line-Bytes (-C) ===
    echo ""
    echo "=== GNU Upstream: Line-Bytes ==="

    # From line-bytes.sh: -C splits at line boundaries within size limit
    printf '1\n2222\n3\n4' > "$test_dir/input_linebytes"
    gnu_dir="$test_dir/gnu_C3"; f_dir="$test_dir/f_C3"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -C 3 "$test_dir/input_linebytes")
    (cd "$f_dir" && $F_TOOL -C 3 "$test_dir/input_linebytes")
    compare_split_dirs "GNU: split -C 3 line-bytes" "$gnu_dir" "$f_dir"

    gnu_dir="$test_dir/gnu_C5"; f_dir="$test_dir/f_C5"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL -C 5 "$test_dir/input_linebytes")
    (cd "$f_dir" && $F_TOOL -C 5 "$test_dir/input_linebytes")
    compare_split_dirs "GNU: split -C 5 line-bytes" "$gnu_dir" "$f_dir"

    # Roundtrip: -C split should reconstruct original
    TESTS_RUN=$((TESTS_RUN + 1))
    if diff <(cat "$gnu_dir"/x*) "$test_dir/input_linebytes" >/dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: GNU: roundtrip -C 5 line-bytes"
        record_result "GNU: roundtrip -C 5 line-bytes" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: GNU: roundtrip -C 5 line-bytes"
        record_result "GNU: roundtrip -C 5 line-bytes" "FAIL" "mismatch" "" ""
    fi

    # From fail.sh: -C 0 should fail
    # (already tested above as -C 0 in Failure Conditions)

    # From line-bytes.sh: -C does not create empty files
    gnu_dir="$test_dir/gnu_C1_notempty"; f_dir="$test_dir/f_C1_notempty"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && printf 'x\n' | $GNU_TOOL -C 1)
    (cd "$f_dir" && printf 'x\n' | $F_TOOL -C 1)
    compare_split_dirs "GNU: split -C 1 on 'x\\n' (no extra files)" "$gnu_dir" "$f_dir"

    # === GNU Upstream: Record Separator (-t) ===
    echo ""
    echo "=== GNU Upstream: Record Separator ==="

    # From record-sep.sh: -t : with --lines=2
    printf '1:2:3:4:5:' > "$test_dir/input_recsep"
    gnu_dir="$test_dir/gnu_recsep"; f_dir="$test_dir/f_recsep"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && $GNU_TOOL --lines=2 -t ':' "$test_dir/input_recsep")
    (cd "$f_dir" && $F_TOOL --lines=2 -t ':' "$test_dir/input_recsep")
    compare_split_dirs "GNU: split --lines=2 -t : (record separator)" "$gnu_dir" "$f_dir"

    # From record-sep.sh: multi-character separator should fail
    run_exit_code_test "GNU: reject -txx multi-char separator" \
        "$GNU_TOOL -txx < /dev/null 2>&1" \
        "$F_TOOL -txx < /dev/null 2>&1"

    # From record-sep.sh: different separators should fail
    run_exit_code_test "GNU: reject -ta -tb different separators" \
        "$GNU_TOOL -ta -tb < /dev/null 2>&1" \
        "$F_TOOL -ta -tb < /dev/null 2>&1"

    # From record-sep.sh: same separator used multiple times should succeed
    run_exit_code_test "GNU: -t: -t: same separator OK" \
        "$GNU_TOOL -t: -t: < /dev/null 2>&1" \
        "$F_TOOL -t: -t: < /dev/null 2>&1"

    # === GNU Upstream: Guard Input Against Overwrite ===
    echo ""
    echo "=== GNU Upstream: Guard Input Against Overwrite ==="

    # From guard-input.sh: split should refuse to overwrite input file
    local guard_dir="$test_dir/guard_test"
    mkdir -p "$guard_dir"
    seq 10 > "$guard_dir/xaa"
    set +e
    local gnu_guard_exit=0 f_guard_exit=0
    (cd "$guard_dir" && $GNU_TOOL -C 6 xaa 2>/dev/null); gnu_guard_exit=$?
    seq 10 > "$guard_dir/xaa"  # restore
    local f_guard_dir="$test_dir/f_guard_test"
    mkdir -p "$f_guard_dir"
    seq 10 > "$f_guard_dir/xaa"
    (cd "$f_guard_dir" && $F_TOOL -C 6 xaa 2>/dev/null); f_guard_exit=$?
    set -e
    TESTS_RUN=$((TESTS_RUN + 1))
    if { [[ "$gnu_guard_exit" -eq 0 ]] && [[ "$f_guard_exit" -eq 0 ]]; } || \
       { [[ "$gnu_guard_exit" -ne 0 ]] && [[ "$f_guard_exit" -ne 0 ]]; }; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: GNU: guard input from overwrite (exit: GNU=$gnu_guard_exit, F=$f_guard_exit)"
        record_result "GNU: guard input from overwrite" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: GNU: guard input from overwrite (exit: GNU=$gnu_guard_exit, F=$f_guard_exit)"
        record_result "GNU: guard input from overwrite" "FAIL" "Exit mismatch GNU=$gnu_guard_exit F=$f_guard_exit" "" ""
    fi

    # === GNU Upstream: Suffix Auto-Length ===
    echo ""
    echo "=== GNU Upstream: Suffix Auto-Length ==="

    # From suffix-auto-length.sh: --numeric with start value that exceeds suffix length
    run_exit_code_test "GNU: reject --numeric=89 -b1 with 12 byte file" \
        "dd if=/dev/zero bs=12 count=1 2>/dev/null | $GNU_TOOL -b1 --numeric=89 2>&1" \
        "dd if=/dev/zero bs=12 count=1 2>/dev/null | $F_TOOL -b1 --numeric=89 2>&1"

    # From suffix-auto-length.sh: -a fails early with -n too large
    run_exit_code_test "GNU: reject -a2 -n1000 on empty input" \
        "$GNU_TOOL -a2 -n1000 < /dev/null 2>&1" \
        "$F_TOOL -a2 -n1000 < /dev/null 2>&1"

    # === Section 6: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent input file" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    echo ""
    echo "=== Additional split Tests ==="

    # Numeric suffixes
    gnu_dir="$test_dir/gnu_numsuf"; f_dir="$test_dir/f_numsuf"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && echo 'test' | $GNU_TOOL -l1 --numeric-suffixes)
    (cd "$f_dir" && echo 'test' | $F_TOOL -l1 --numeric-suffixes)
    compare_split_dirs "split -l1 --numeric-suffixes" "$gnu_dir" "$f_dir"

    # Suffix length
    gnu_dir="$test_dir/gnu_suflen"; f_dir="$test_dir/f_suflen"
    mkdir -p "$gnu_dir" "$f_dir"
    (cd "$gnu_dir" && printf 'a\nb\nc\n' | $GNU_TOOL -l1 --suffix-length=3)
    (cd "$f_dir" && printf 'a\nb\nc\n' | $F_TOOL -l1 --suffix-length=3)
    compare_split_dirs "split -l1 --suffix-length=3" "$gnu_dir" "$f_dir"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_split_tests
