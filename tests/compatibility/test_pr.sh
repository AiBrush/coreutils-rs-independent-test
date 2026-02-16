#!/usr/bin/env bash
# Compatibility tests for fpr vs GNU pr
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="pr"
F_TOOL="fpr"

run_pr_tests() {
    init_test_suite "pr"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pr","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/pr_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU pr not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_pr_XXXXXX)
    register_temp "$test_dir"

    # Create test files
    seq 1 50 > "$test_dir/numbers50.txt"
    seq 1 100 > "$test_dir/numbers100.txt"

    cat > "$test_dir/text.txt" <<'EOF'
The quick brown fox jumps over the lazy dog.
A stitch in time saves nine.
All that glitters is not gold.
To be or not to be, that is the question.
Four score and seven years ago.
It was the best of times, it was the worst of times.
In the beginning, there was nothing.
The end justifies the means.
Actions speak louder than words.
Beauty is in the eye of the beholder.
EOF

    cat > "$test_dir/file2.txt" <<'EOF'
Alpha
Bravo
Charlie
Delta
Echo
Foxtrot
Golf
Hotel
India
Juliet
EOF

    # === Section 1: Default Paginated Output ===
    echo ""
    echo "=== Default Paginated Output ==="

    run_stdout_test "default pr" \
        "$GNU_TOOL '$test_dir/text.txt'" \
        "$F_TOOL '$test_dir/text.txt'"

    run_stdout_test "default pr numbers50" \
        "$GNU_TOOL '$test_dir/numbers50.txt'" \
        "$F_TOOL '$test_dir/numbers50.txt'"

    # === Section 2: Page Length (-l) ===
    echo ""
    echo "=== Page Length (-l) ==="

    run_stdout_test "-l 20" \
        "$GNU_TOOL -l 20 '$test_dir/numbers50.txt'" \
        "$F_TOOL -l 20 '$test_dir/numbers50.txt'"

    run_stdout_test "-l 30" \
        "$GNU_TOOL -l 30 '$test_dir/text.txt'" \
        "$F_TOOL -l 30 '$test_dir/text.txt'"

    run_stdout_test "-l 10 (many pages)" \
        "$GNU_TOOL -l 10 '$test_dir/numbers50.txt'" \
        "$F_TOOL -l 10 '$test_dir/numbers50.txt'"

    # === Section 3: Number Lines (-n) ===
    echo ""
    echo "=== Number Lines (-n) ==="

    run_stdout_test "-n number lines" \
        "$GNU_TOOL -n '$test_dir/text.txt'" \
        "$F_TOOL -n '$test_dir/text.txt'"

    run_stdout_test "-n with numbers" \
        "$GNU_TOOL -n '$test_dir/numbers50.txt'" \
        "$F_TOOL -n '$test_dir/numbers50.txt'"

    # === Section 4: Columns (-COLUMN) ===
    echo ""
    echo "=== Columns ==="

    run_stdout_test "-2 two columns" \
        "$GNU_TOOL -2 '$test_dir/numbers50.txt'" \
        "$F_TOOL -2 '$test_dir/numbers50.txt'"

    run_stdout_test "-3 three columns" \
        "$GNU_TOOL -3 '$test_dir/numbers50.txt'" \
        "$F_TOOL -3 '$test_dir/numbers50.txt'"

    # === Section 5: Merge (-m) ===
    echo ""
    echo "=== Merge (-m) ==="

    run_stdout_test "-m merge two files" \
        "$GNU_TOOL -m '$test_dir/text.txt' '$test_dir/file2.txt'" \
        "$F_TOOL -m '$test_dir/text.txt' '$test_dir/file2.txt'"

    # === Section 6: Omit Header/Footer (-t) ===
    echo ""
    echo "=== Omit Header/Footer (-t) ==="

    run_stdout_test "-t omit header/footer" \
        "$GNU_TOOL -t '$test_dir/text.txt'" \
        "$F_TOOL -t '$test_dir/text.txt'"

    run_stdout_test "-t with numbers" \
        "$GNU_TOOL -t '$test_dir/numbers50.txt'" \
        "$F_TOOL -t '$test_dir/numbers50.txt'"

    # === Section 7: Custom Header (-h) ===
    echo ""
    echo "=== Custom Header (-h) ==="

    run_stdout_test "-h 'My Title'" \
        "$GNU_TOOL -h 'My Title' '$test_dir/text.txt'" \
        "$F_TOOL -h 'My Title' '$test_dir/text.txt'"

    # === Section 8: Width (-w) ===
    echo ""
    echo "=== Width (-w) ==="

    run_stdout_test "-w 60" \
        "$GNU_TOOL -w 60 '$test_dir/text.txt'" \
        "$F_TOOL -w 60 '$test_dir/text.txt'"

    run_stdout_test "-w 40 -2 columns" \
        "$GNU_TOOL -w 40 -2 '$test_dir/numbers50.txt'" \
        "$F_TOOL -w 40 -2 '$test_dir/numbers50.txt'"

    # === Section 9: Separator (-s) ===
    echo ""
    echo "=== Separator (-s) ==="

    run_stdout_test "-s: with colon separator" \
        "$GNU_TOOL -s: -2 '$test_dir/numbers50.txt'" \
        "$F_TOOL -s: -2 '$test_dir/numbers50.txt'"

    # === Section 10: Double Space (-d) ===
    echo ""
    echo "=== Double Space (-d) ==="

    run_stdout_test "-d double space" \
        "$GNU_TOOL -d -t '$test_dir/text.txt'" \
        "$F_TOOL -d -t '$test_dir/text.txt'"

    # === Section 11: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_pr_tests
