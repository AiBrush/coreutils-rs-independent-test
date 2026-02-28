#!/usr/bin/env bash
# Compatibility tests for fptx vs GNU ptx
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "ptx")
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

    # === Section 6: GNU Upstream Tests ===
    echo ""
    echo "=== GNU Upstream: Input with Multi-Byte Characters ==="

    # GNU ptx-overrun.sh: ensure ptx handles input ending with multi-byte char
    local ptx_mb_input
    ptx_mb_input=$(make_temp '012345678901234567890123456789')
    register_temp "$ptx_mb_input"

    run_stdout_test "input with long numeric string" \
        "$GNU_TOOL '$ptx_mb_input'" \
        "$F_TOOL '$ptx_mb_input'"

    echo ""
    echo "=== GNU Upstream: Regex with Trailing Backslash ==="

    # GNU ptx-overrun.sh: lone trailing backslash in regex options
    local ptx_empty
    ptx_empty=$(mktemp /tmp/fcoreutils_ptx_empty_XXXXXX)
    register_temp "$ptx_empty"
    : > "$ptx_empty"

    local ptx_longname
    ptx_longname=$(mktemp /tmp/fcoreutils_ptx_01234567890123456789012345678901234567890123456789_XXXXXX)
    register_temp "$ptx_longname"
    : > "$ptx_longname"

    run_stdout_test "-F with lone backslash on empty file" \
        "$GNU_TOOL -F '\\' '$ptx_longname' < /dev/null" \
        "$F_TOOL -F '\\' '$ptx_longname' < /dev/null"

    run_stdout_test "-S with trailing backslash on empty file" \
        "$GNU_TOOL -S 'foo\\' '$ptx_longname' < /dev/null" \
        "$F_TOOL -S 'foo\\' '$ptx_longname' < /dev/null"

    run_stdout_test "-W with trailing backslash on empty file" \
        "$GNU_TOOL -W 'bar\\\\\\' '$ptx_longname' < /dev/null" \
        "$F_TOOL -W 'bar\\\\\\' '$ptx_longname' < /dev/null"

    echo ""
    echo "=== GNU Upstream: Whitespace Trimming Consistency ==="

    # GNU ptx-overrun.sh: ensure consistent whitespace trimming with duplicate files
    local ptx_ws_input
    ptx_ws_input=$(make_temp 'This is a ptx whitespace Trimming test
')
    register_temp "$ptx_ws_input"

    run_stdout_test "duplicate files produce consistent output" \
        "$GNU_TOOL '$ptx_ws_input' '$ptx_ws_input' | sort" \
        "$F_TOOL '$ptx_ws_input' '$ptx_ws_input' | sort"

    echo ""
    echo "=== GNU Upstream: Small Width with Absolute Path ==="

    # GNU ptx-overrun.sh: -w1 -A with absolute path
    local ptx_a_input
    ptx_a_input=$(mktemp /tmp/fcoreutils_ptx_a_XXXXXX)
    register_temp "$ptx_a_input"
    echo a > "$ptx_a_input"

    run_exit_code_test "-w1 -A with absolute path" \
        "$GNU_TOOL -w1 -A '$ptx_a_input' 2>&1" \
        "$F_TOOL -w1 -A '$ptx_a_input' 2>&1"

    # === Section 7: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_ptx_tests
