#!/usr/bin/env bash
# Compatibility tests for fptx vs GNU ptx
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="ptx"
F_TOOL="fptx"

run_ptx_tests() {
    init_test_suite "ptx"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"ptx","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/ptx_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU ptx not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_ptx_XXXXXX)
    register_temp "$test_dir"

    cat > "$test_dir/sample.txt" <<'EOF'
The quick brown fox jumps over the lazy dog.
A stitch in time saves nine.
All that glitters is not gold.
EOF

    cat > "$test_dir/words.txt" <<'EOF'
hello world
foo bar baz
one two three
EOF

    # === Section 1: Basic Output ===
    echo ""
    echo "=== Basic Output ==="

    run_stdout_test "default output" \
        "$GNU_TOOL '$test_dir/sample.txt'" \
        "$F_TOOL '$test_dir/sample.txt'"

    run_stdout_test "simple words" \
        "$GNU_TOOL '$test_dir/words.txt'" \
        "$F_TOOL '$test_dir/words.txt'"

    # === Section 2: Width (-w) ===
    echo ""
    echo "=== Width (-w) ==="

    run_stdout_test "-w 60" \
        "$GNU_TOOL -w 60 '$test_dir/sample.txt'" \
        "$F_TOOL -w 60 '$test_dir/sample.txt'"

    run_stdout_test "-w 40" \
        "$GNU_TOOL -w 40 '$test_dir/sample.txt'" \
        "$F_TOOL -w 40 '$test_dir/sample.txt'"

    run_stdout_test "-w 80" \
        "$GNU_TOOL -w 80 '$test_dir/words.txt'" \
        "$F_TOOL -w 80 '$test_dir/words.txt'"

    # === Section 3: Traditional mode (-t) ===
    echo ""
    echo "=== Traditional Mode (-t) ==="

    run_stdout_test "-t traditional" \
        "$GNU_TOOL -t '$test_dir/sample.txt'" \
        "$F_TOOL -t '$test_dir/sample.txt'"

    # === Section 4: Stdin ===
    echo ""
    echo "=== Stdin ==="

    run_stdout_test "stdin input" \
        "echo 'the quick brown fox' | $GNU_TOOL" \
        "echo 'the quick brown fox' | $F_TOOL"

    # === Section 5: Gap size (-g) ===
    echo ""
    echo "=== Gap Size (-g) ==="

    run_stdout_test "-g 4" \
        "$GNU_TOOL -g 4 '$test_dir/words.txt'" \
        "$F_TOOL -g 4 '$test_dir/words.txt'"

    # === Section 6: Error Handling ===
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

run_ptx_tests
