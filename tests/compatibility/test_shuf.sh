#!/usr/bin/env bash
# Compatibility tests for fshuf vs GNU shuf
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="shuf"
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
