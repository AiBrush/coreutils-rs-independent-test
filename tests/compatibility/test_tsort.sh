#!/usr/bin/env bash
# Compatibility tests for ftsort vs GNU tsort
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tsort"
F_TOOL="ftsort"

run_tsort_tests() {
    init_test_suite "tsort"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tsort","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tsort_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU tsort not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Topological Sort ==="

    run_test "simple chain a->b->c->d" \
        "$GNU_TOOL '$TEST_DATA_DIR/tsort_simple.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tsort_simple.txt'"

    run_test "diamond dependency a->{b,c}->d" \
        "$GNU_TOOL '$TEST_DATA_DIR/tsort_diamond.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tsort_diamond.txt'"

    run_test "self-loop" \
        "$GNU_TOOL '$TEST_DATA_DIR/tsort_single.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tsort_single.txt'"

    run_test "multiple roots" \
        "$GNU_TOOL '$TEST_DATA_DIR/tsort_multi_roots.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tsort_multi_roots.txt'"

    echo ""
    echo "=== Stdin Input ==="

    run_test "stdin simple pair" \
        "printf 'a b\n' | $GNU_TOOL" \
        "printf 'a b\n' | $F_TOOL"

    run_test "stdin two pairs" \
        "printf 'a b\nb c\n' | $GNU_TOOL" \
        "printf 'a b\nb c\n' | $F_TOOL"

    run_test "stdin single node" \
        "printf 'a a\n' | $GNU_TOOL" \
        "printf 'a a\n' | $F_TOOL"

    run_test "stdin multiple disconnected" \
        "printf 'a b\nc d\ne f\n' | $GNU_TOOL" \
        "printf 'a b\nc d\ne f\n' | $F_TOOL"

    echo ""
    echo "=== Edge Cases ==="

    run_test "empty input" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    run_test "single pair" \
        "printf 'x y\n' | $GNU_TOOL" \
        "printf 'x y\n' | $F_TOOL"

    run_test "numeric nodes" \
        "printf '1 2\n2 3\n3 4\n' | $GNU_TOOL" \
        "printf '1 2\n2 3\n3 4\n' | $F_TOOL"

    run_test "longer chain" \
        "printf 'a b\nb c\nc d\nd e\ne f\nf g\ng h\n' | $GNU_TOOL" \
        "printf 'a b\nb c\nc d\nd e\ne f\nf g\ng h\n' | $F_TOOL"

    run_test "all self-loops" \
        "printf 'a a\nb b\nc c\n' | $GNU_TOOL" \
        "printf 'a a\nb b\nc c\n' | $F_TOOL"

    run_test "extra whitespace" \
        "printf '  a   b  \n  b   c  \n' | $GNU_TOOL" \
        "printf '  a   b  \n  b   c  \n' | $F_TOOL"

    echo ""
    echo "=== Cycle Detection ==="

    # tsort should report cycle and still produce output
    run_exit_code_test "cycle detection exit code" \
        "$GNU_TOOL '$TEST_DATA_DIR/tsort_cycle.txt' 2>&1" \
        "$F_TOOL '$TEST_DATA_DIR/tsort_cycle.txt' 2>&1"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "odd number of tokens" \
        "printf 'a b c\n' | $GNU_TOOL 2>&1" \
        "printf 'a b c\n' | $F_TOOL 2>&1"

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Complex Graphs ==="

    run_test "build system deps" \
        "printf 'main.o link\nutils.o link\nmain.c main.o\nutils.c utils.o\nutils.h main.o\nutils.h utils.o\n' | $GNU_TOOL" \
        "printf 'main.o link\nutils.o link\nmain.c main.o\nutils.c utils.o\nutils.h main.o\nutils.h utils.o\n' | $F_TOOL"

    run_test "package dependencies" \
        "printf 'libc base\nlibm libc\nopenssl libm\ncurl openssl\nwget curl\n' | $GNU_TOOL" \
        "printf 'libc base\nlibm libc\nopenssl libm\ncurl openssl\nwget curl\n' | $F_TOOL"

    finish_test_suite
}

run_tsort_tests
