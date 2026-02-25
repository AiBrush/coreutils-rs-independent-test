#!/usr/bin/env bash
# Compatibility tests for fshuf vs GNU shuf
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "shuf")
F_TOOL="fshuf"

run_shuf_tests() {
    init_test_suite "shuf"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"shuf","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/shuf_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU shuf not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Shuffling (verify element preservation) ==="

    # shuf is random, so we can't compare output directly - compare sorted output
    run_test "all elements preserved (sorted compare)" \
        "printf 'a\nb\nc\nd\ne\n' | $GNU_TOOL | sort" \
        "printf 'a\nb\nc\nd\ne\n' | $F_TOOL | sort"

    run_test "file input preserves elements" \
        "$GNU_TOOL '$TEST_DATA_DIR/unsorted.txt' | sort" \
        "$F_TOOL '$TEST_DATA_DIR/unsorted.txt' | sort"

    run_test "single element" \
        "printf 'only\n' | $GNU_TOOL" \
        "printf 'only\n' | $F_TOOL"

    run_test "empty input" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    run_test "line count preserved" \
        "printf 'a\nb\nc\nd\ne\nf\ng\n' | $GNU_TOOL | wc -l" \
        "printf 'a\nb\nc\nd\ne\nf\ng\n' | $F_TOOL | wc -l"

    echo ""
    echo "=== Head Count (-n) ==="

    run_test "-n 1 (single output)" \
        "printf 'a\nb\nc\nd\ne\n' | $GNU_TOOL -n 1 | wc -l" \
        "printf 'a\nb\nc\nd\ne\n' | $F_TOOL -n 1 | wc -l"

    run_test "-n 3 (subset)" \
        "printf 'a\nb\nc\nd\ne\n' | $GNU_TOOL -n 3 | wc -l" \
        "printf 'a\nb\nc\nd\ne\n' | $F_TOOL -n 3 | wc -l"

    run_test "-n 0 (empty output)" \
        "printf 'a\nb\nc\n' | $GNU_TOOL -n 0" \
        "printf 'a\nb\nc\n' | $F_TOOL -n 0"

    run_test "-n greater than input (all elements)" \
        "printf 'a\nb\nc\n' | $GNU_TOOL -n 100 | sort" \
        "printf 'a\nb\nc\n' | $F_TOOL -n 100 | sort"

    echo ""
    echo "=== Input Range (-i) ==="

    run_test "-i 1-10 (sorted check)" \
        "$GNU_TOOL -i 1-10 | sort -n" \
        "$F_TOOL -i 1-10 | sort -n"

    run_test "-i 1-10 -n 5 count" \
        "$GNU_TOOL -i 1-10 -n 5 | wc -l" \
        "$F_TOOL -i 1-10 -n 5 | wc -l"

    run_test "-i 1-1 (single value)" \
        "$GNU_TOOL -i 1-1" \
        "$F_TOOL -i 1-1"

    run_test "-i 5-5 (single value)" \
        "$GNU_TOOL -i 5-5" \
        "$F_TOOL -i 5-5"

    run_test "-i 1-100 count" \
        "$GNU_TOOL -i 1-100 | wc -l" \
        "$F_TOOL -i 1-100 | wc -l"

    run_test "-i 0-0" \
        "$GNU_TOOL -i 0-0" \
        "$F_TOOL -i 0-0"

    echo ""
    echo "=== Echo Mode (-e) ==="

    run_test "-e elements preserved" \
        "$GNU_TOOL -e a b c d e | sort" \
        "$F_TOOL -e a b c d e | sort"

    run_test "-e single element" \
        "$GNU_TOOL -e hello" \
        "$F_TOOL -e hello"

    run_test "-e with -n 2" \
        "$GNU_TOOL -e a b c d e -n 2 | wc -l" \
        "$F_TOOL -e a b c d e -n 2 | wc -l"

    run_test "-e no elements" \
        "$GNU_TOOL -e" \
        "$F_TOOL -e"

    echo ""
    echo "=== Repeat (-r) ==="

    run_test "-r -n 5 can repeat elements (count)" \
        "printf 'a\nb\n' | $GNU_TOOL -r -n 5 | wc -l" \
        "printf 'a\nb\n' | $F_TOOL -r -n 5 | wc -l"

    run_test "-r -n 10 -i 1-3 (all from small range)" \
        "$GNU_TOOL -r -n 10 -i 1-3 | wc -l" \
        "$F_TOOL -r -n 10 -i 1-3 | wc -l"

    echo ""
    echo "=== Zero Terminated (-z) ==="

    run_test "-z output null terminated" \
        "printf 'a\nb\nc\n' | $GNU_TOOL -z | od -c | head -5" \
        "printf 'a\nb\nc\n' | $F_TOOL -z | od -c | head -5"

    echo ""
    echo "=== Random Source (--random-source) ==="

    run_test "--random-source deterministic" \
        "printf 'a\nb\nc\nd\ne\n' | $GNU_TOOL --random-source=/dev/zero" \
        "printf 'a\nb\nc\nd\ne\n' | $F_TOOL --random-source=/dev/zero"

    echo ""
    echo "=== GNU Upstream: shuf (Permutation Verification) ==="

    # From shuf.sh: sorted output of shuffled input should match input
    local shuf_seq_tmp=$(make_temp "$(seq 100)")
    register_temp "$shuf_seq_tmp"

    run_test "shuffled seq 100 is permutation" \
        "$GNU_TOOL '$shuf_seq_tmp' | sort -n | md5sum" \
        "$F_TOOL '$shuf_seq_tmp' | sort -n | md5sum"

    run_test "-i 1-100 is permutation" \
        "$GNU_TOOL -i 1-100 | sort -n | md5sum" \
        "$F_TOOL -i 1-100 | sort -n | md5sum"

    echo ""
    echo "=== GNU Upstream: shuf (Error Conditions) ==="

    # From shuf.sh: -i and -e must not be used together
    run_exit_code_test "-i and -e conflict" \
        "echo '' | $GNU_TOOL -i0-9 -e A B 2>&1" \
        "echo '' | $F_TOOL -i0-9 -e A B 2>&1"

    # From shuf.sh: invalid -n value
    run_exit_code_test "-n with non-numeric value" \
        "echo '' | $GNU_TOOL -nA 2>&1" \
        "echo '' | $F_TOOL -nA 2>&1"

    # From shuf.sh: multiple -i is an error
    run_exit_code_test "multiple -i is error" \
        "$GNU_TOOL -i0-9 -n10 -i8-90 2>&1" \
        "$F_TOOL -i0-9 -n10 -i8-90 2>&1"

    # From shuf.sh: invalid -i range formats
    run_exit_code_test "-i with bare number" \
        "$GNU_TOOL -i1 2>&1" \
        "$F_TOOL -i1 2>&1"

    run_exit_code_test "-i with non-numeric" \
        "$GNU_TOOL -iA 2>&1" \
        "$F_TOOL -iA 2>&1"

    run_exit_code_test "-i with missing end" \
        "$GNU_TOOL -i1- 2>&1" \
        "$F_TOOL -i1- 2>&1"

    run_exit_code_test "-i with non-numeric end" \
        "$GNU_TOOL -i1-A 2>&1" \
        "$F_TOOL -i1-A 2>&1"

    echo ""
    echo "=== GNU Upstream: shuf (Repeat Mode) ==="

    # From shuf.sh: --repeat can output more values than input
    run_test "--repeat -i0-9 -n1000 count" \
        "$GNU_TOOL --rep -i0-9 -n1000 | wc -l" \
        "$F_TOOL --rep -i0-9 -n1000 | wc -l"

    # From shuf.sh: --repeat with -n0 produces no output
    run_test "--repeat -i0-9 -n0 empty output" \
        "$GNU_TOOL --rep -i0-9 -n0" \
        "$F_TOOL --rep -i0-9 -n0"

    # From shuf.sh: --repeat with stdin and -n0
    run_test "--repeat stdin -n0 empty output" \
        "printf 'A\nB\nC\n' | $GNU_TOOL --rep -n0" \
        "printf 'A\nB\nC\n' | $F_TOOL --rep -n0"

    # From shuf.sh: -e -r (empty repeat) should error
    run_exit_code_test "-e -r with no args errors" \
        "$GNU_TOOL -er 2>&1" \
        "$F_TOOL -er 2>&1"

    echo ""
    echo "=== GNU Upstream: shuf (Multiple -n Uses Smallest) ==="

    # From shuf.sh: multiple -n should use the smallest value
    run_test "multiple -n uses smallest" \
        "$GNU_TOOL -n10 -i0-9 -n3 -n20 | wc -l" \
        "$F_TOOL -n10 -i0-9 -n3 -n20 | wc -l"

    echo ""
    echo "=== GNU Upstream: shuf (Zero Terminated) ==="

    # From shuf.sh: --zero-terminated output uses NUL
    run_test "--zero-terminated -i 1-1 output" \
        "$GNU_TOOL --zero-terminated -i 1-1 | od -c" \
        "$F_TOOL --zero-terminated -i 1-1 | od -c"

    # From shuf.sh: -r -n 0 with no stdin produces empty output
    run_test "-r -n 0 with file produces empty" \
        "$GNU_TOOL -r -n 0 '$shuf_seq_tmp'" \
        "$F_TOOL -r -n 0 '$shuf_seq_tmp'"

    # shuf-reservoir.sh: skipped (requires valgrind)
    skip_test "shuf reservoir sampling" "Requires valgrind"

    # === GNU Upstream: shuf (Additional Error Conditions) ===
    echo ""
    echo "=== GNU Upstream: shuf (Additional Error Conditions) ==="

    # From shuf.sh: redundant operand with --input-range should fail
    run_exit_code_test "-i0-0 with extra operand" \
        "$GNU_TOOL -i0-0 1 2>&1" \
        "$F_TOOL -i0-0 1 2>&1"

    # From shuf.sh: multiple -o are forbidden
    run_exit_code_test "multiple -o is error" \
        "$GNU_TOOL -i0-9 -o /tmp/shuf_a_$$ -o /tmp/shuf_b_$$ 2>&1" \
        "$F_TOOL -i0-9 -o /tmp/shuf_a_$$ -o /tmp/shuf_b_$$ 2>&1"

    # From shuf.sh: multiple --random-source are forbidden
    run_exit_code_test "multiple --random-source is error" \
        "$GNU_TOOL -i0-9 --random-source /dev/zero --random-source /dev/zero 2>&1" \
        "$F_TOOL -i0-9 --random-source /dev/zero --random-source /dev/zero 2>&1"

    # === GNU Upstream: shuf (Repeat with Non-Zero Low Range) ===
    echo ""
    echo "=== GNU Upstream: shuf (Repeat with Non-Zero Low Range) ==="

    # From shuf.sh: --repeat with non-zero low value should produce values in range
    run_test "--repeat -i222-233 -n2000 count" \
        "$GNU_TOOL --rep -i222-233 -n2000 | wc -l" \
        "$F_TOOL --rep -i222-233 -n2000 | wc -l"

    # From shuf.sh: --repeat with STDIN and -n count can return more values than input
    run_test "--repeat STDIN -n2000 count" \
        "printf 'A\nB\nC\nD\nE\n' | $GNU_TOOL --rep -n2000 | wc -l" \
        "printf 'A\nB\nC\nD\nE\n' | $F_TOOL --rep -n2000 | wc -l"

    # From shuf.sh: --repeat stdin -n0 produces no output
    run_test "--repeat stdin -n0 no output" \
        "printf 'A\nB\nC\nD\nE\n' | $GNU_TOOL --rep -n0" \
        "printf 'A\nB\nC\nD\nE\n' | $F_TOOL --rep -n0"

    # === GNU Upstream: shuf (Large Input Handling) ===
    echo ""
    echo "=== GNU Upstream: shuf (Large Input Handling) ==="

    # From shuf.sh: seq 1860 produces 8193 bytes (8K + 1), previously caused infloop
    run_test "seq 1860 large input line count" \
        "seq 1860 | $GNU_TOOL | wc -l" \
        "seq 1860 | $F_TOOL | wc -l"

    # From shuf.sh: shuf /dev/null produces empty output
    run_test "shuf /dev/null empty output" \
        "$GNU_TOOL /dev/null" \
        "$F_TOOL /dev/null"

    # === GNU Upstream: shuf (Echo Permutation) ===
    echo ""
    echo "=== GNU Upstream: shuf (Echo Permutation) ==="

    # From shuf.sh: -e produces permutation
    run_test "-e a b c d e sorted is permutation" \
        "$GNU_TOOL -e a b c d e | sort | tr '\n' ' '" \
        "$F_TOOL -e a b c d e | sort | tr '\n' ' '"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "invalid range" \
        "$GNU_TOOL -i 5-3 2>&1" \
        "$F_TOOL -i 5-3 2>&1"

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Large Input ==="

    run_test "1000 lines preserved count" \
        "$GNU_TOOL '$TEST_DATA_DIR/numbered_10k.txt' | wc -l" \
        "$F_TOOL '$TEST_DATA_DIR/numbered_10k.txt' | wc -l"

    run_test "1000 lines sorted checksum" \
        "$GNU_TOOL '$TEST_DATA_DIR/numbered_100.txt' | sort | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/numbered_100.txt' | sort | md5sum"


    finish_test_suite
}

run_shuf_tests
