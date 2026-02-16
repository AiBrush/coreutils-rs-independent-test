#!/usr/bin/env bash
# Compatibility tests for ffmt vs GNU fmt
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="fmt"
F_TOOL="ffmt"

run_fmt_tests() {
    init_test_suite "fmt"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"fmt","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/fmt_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU fmt not found, cannot compare" >&2
        return 1
    fi

    # Create test files
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_fmt_XXXXXX)
    register_temp "$test_dir"

    # Long line
    python3 -c "print('a very long line that should be wrapped at the default width of 75 characters because that is what GNU fmt does by default when reformatting text and it keeps going to make sure we exceed that limit significantly')" > "$test_dir/longline.txt"

    # Multiple short words
    python3 -c "print(' '.join(['word'] * 50))" > "$test_dir/manywords.txt"

    # Paragraphs
    cat > "$test_dir/paragraphs.txt" <<'EOF'
This is the first paragraph which has a very long line that needs to be wrapped because it exceeds the default column width of seventy-five characters.

This is the second paragraph. It is separate from the first and should remain so after formatting. Short lines here.

A third paragraph with a single sentence.
EOF

    # Indented text
    cat > "$test_dir/indented.txt" <<'EOF'
    This is an indented paragraph with a very long line that should be wrapped while preserving the initial indent on all continuation lines that follow.
EOF

    # Short lines
    cat > "$test_dir/short.txt" <<'EOF'
a
b
c
d
e
EOF

    # === Section 1: Default Wrapping ===
    echo ""
    echo "=== Default Wrapping ==="

    run_stdout_test "default wrap long line" \
        "$GNU_TOOL '$test_dir/longline.txt'" \
        "$F_TOOL '$test_dir/longline.txt'"

    run_stdout_test "default wrap many words" \
        "$GNU_TOOL '$test_dir/manywords.txt'" \
        "$F_TOOL '$test_dir/manywords.txt'"

    run_stdout_test "default wrap paragraphs" \
        "$GNU_TOOL '$test_dir/paragraphs.txt'" \
        "$F_TOOL '$test_dir/paragraphs.txt'"

    run_stdout_test "default wrap short lines" \
        "$GNU_TOOL '$test_dir/short.txt'" \
        "$F_TOOL '$test_dir/short.txt'"

    # === Section 2: Width (-w) ===
    echo ""
    echo "=== Width (-w) ==="

    run_stdout_test "-w 40" \
        "$GNU_TOOL -w 40 '$test_dir/longline.txt'" \
        "$F_TOOL -w 40 '$test_dir/longline.txt'"

    run_stdout_test "-w 20" \
        "$GNU_TOOL -w 20 '$test_dir/manywords.txt'" \
        "$F_TOOL -w 20 '$test_dir/manywords.txt'"

    run_stdout_test "-w 100" \
        "$GNU_TOOL -w 100 '$test_dir/paragraphs.txt'" \
        "$F_TOOL -w 100 '$test_dir/paragraphs.txt'"

    run_stdout_test "-w 10 narrow" \
        "$GNU_TOOL -w 10 '$test_dir/manywords.txt'" \
        "$F_TOOL -w 10 '$test_dir/manywords.txt'"

    # === Section 3: Split Only (-s) ===
    echo ""
    echo "=== Split Only (-s) ==="

    run_stdout_test "-s split only (don't refill)" \
        "$GNU_TOOL -s '$test_dir/longline.txt'" \
        "$F_TOOL -s '$test_dir/longline.txt'"

    run_stdout_test "-s -w 40" \
        "$GNU_TOOL -s -w 40 '$test_dir/longline.txt'" \
        "$F_TOOL -s -w 40 '$test_dir/longline.txt'"

    run_stdout_test "-s with short lines (no change)" \
        "$GNU_TOOL -s '$test_dir/short.txt'" \
        "$F_TOOL -s '$test_dir/short.txt'"

    # === Section 4: Stdin ===
    echo ""
    echo "=== Stdin ==="

    run_stdout_test "stdin input" \
        "echo 'This is a single very long line of text that should be wrapped at the default column width by the fmt command' | $GNU_TOOL" \
        "echo 'This is a single very long line of text that should be wrapped at the default column width by the fmt command' | $F_TOOL"

    # === Section 5: Uniform spacing (-u) ===
    echo ""
    echo "=== Uniform Spacing (-u) ==="

    local spacing_input
    spacing_input=$(make_temp "hello    world   with    extra   spaces")
    register_temp "$spacing_input"

    run_stdout_test "-u uniform spacing" \
        "$GNU_TOOL -u '$spacing_input'" \
        "$F_TOOL -u '$spacing_input'"

    # === Section 6: Crown Margin (-c) ===
    echo ""
    echo "=== Crown Margin (-c) ==="

    run_stdout_test "-c crown margin" \
        "$GNU_TOOL -c '$test_dir/indented.txt'" \
        "$F_TOOL -c '$test_dir/indented.txt'"

    # === Section 7: Empty/Edge Cases ===
    echo ""
    echo "=== Edge Cases ==="

    run_stdout_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_stdout_test "single word" \
        "echo hello | $GNU_TOOL" \
        "echo hello | $F_TOOL"

    run_stdout_test "only whitespace" \
        "echo '   ' | $GNU_TOOL" \
        "echo '   ' | $F_TOOL"

    # === Section 8: Goal Width (-g) ===
    echo ""
    echo "=== Goal Width (-g) ==="

    run_stdout_test "-g 50 -w 60" \
        "$GNU_TOOL -g 50 -w 60 '$test_dir/longline.txt'" \
        "$F_TOOL -g 50 -w 60 '$test_dir/longline.txt'"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_fmt_tests
