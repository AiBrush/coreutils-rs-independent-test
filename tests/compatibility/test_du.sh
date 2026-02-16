#!/usr/bin/env bash
# Compatibility tests for fdu vs GNU du
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="du"
F_TOOL="fdu"

run_du_tests() {
    init_test_suite "du"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"du","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/du_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU du not found, cannot compare" >&2
        return 1
    fi

    # Create test directory structure
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_du_XXXXXX)
    register_temp "$test_dir"

    mkdir -p "$test_dir/a/b/c"
    dd if=/dev/zero of="$test_dir/a/file1" bs=1024 count=10 2>/dev/null
    dd if=/dev/zero of="$test_dir/a/b/file2" bs=1024 count=20 2>/dev/null
    dd if=/dev/zero of="$test_dir/a/b/c/file3" bs=1024 count=5 2>/dev/null
    echo "small" > "$test_dir/a/small.txt"
    touch "$test_dir/a/empty.txt"
    echo "tmp content" > "$test_dir/a/temp.tmp"
    echo "another tmp" > "$test_dir/a/b/other.tmp"

    # === Section 1: Default ===
    echo ""
    echo "=== Default ==="

    run_stdout_test "default du" \
        "$GNU_TOOL '$test_dir'" \
        "$F_TOOL '$test_dir'"

    # === Section 2: Summarize (-s) ===
    echo ""
    echo "=== Summarize (-s) ==="

    run_stdout_test "-s summarize" \
        "$GNU_TOOL -s '$test_dir'" \
        "$F_TOOL -s '$test_dir'"

    # === Section 3: Human Readable (-h) ===
    echo ""
    echo "=== Human Readable (-h) ==="

    run_stdout_test "-sh summary human" \
        "$GNU_TOOL -sh '$test_dir'" \
        "$F_TOOL -sh '$test_dir'"

    run_stdout_test "-h all" \
        "$GNU_TOOL -h '$test_dir'" \
        "$F_TOOL -h '$test_dir'"

    # === Section 4: All Files (-a) ===
    echo ""
    echo "=== All Files (-a) ==="

    run_stdout_test "-a all files" \
        "$GNU_TOOL -a '$test_dir'" \
        "$F_TOOL -a '$test_dir'"

    # === Section 5: Max Depth (-d) ===
    echo ""
    echo "=== Max Depth (-d) ==="

    run_stdout_test "-d 0 (same as -s)" \
        "$GNU_TOOL -d 0 '$test_dir'" \
        "$F_TOOL -d 0 '$test_dir'"

    run_stdout_test "-d 1" \
        "$GNU_TOOL -d 1 '$test_dir'" \
        "$F_TOOL -d 1 '$test_dir'"

    run_stdout_test "-d 2" \
        "$GNU_TOOL -d 2 '$test_dir'" \
        "$F_TOOL -d 2 '$test_dir'"

    # === Section 6: Apparent Size ===
    echo ""
    echo "=== Apparent Size ==="

    run_stdout_test "--apparent-size" \
        "$GNU_TOOL --apparent-size '$test_dir'" \
        "$F_TOOL --apparent-size '$test_dir'"

    run_stdout_test "-b (bytes, apparent)" \
        "$GNU_TOOL -b '$test_dir/a/file1'" \
        "$F_TOOL -b '$test_dir/a/file1'"

    # === Section 7: Total (-c) ===
    echo ""
    echo "=== Total (-c) ==="

    run_stdout_test "-c total" \
        "$GNU_TOOL -c '$test_dir/a' '$test_dir/a/b'" \
        "$F_TOOL -c '$test_dir/a' '$test_dir/a/b'"

    run_stdout_test "-cs total summarized" \
        "$GNU_TOOL -cs '$test_dir/a' '$test_dir/a/b'" \
        "$F_TOOL -cs '$test_dir/a' '$test_dir/a/b'"

    # === Section 8: Block Size ===
    echo ""
    echo "=== Block Size ==="

    run_stdout_test "-k kilobytes" \
        "$GNU_TOOL -k '$test_dir'" \
        "$F_TOOL -k '$test_dir'"

    run_stdout_test "-m megabytes" \
        "$GNU_TOOL -m '$test_dir'" \
        "$F_TOOL -m '$test_dir'"

    run_stdout_test "-B 1 (byte blocks)" \
        "$GNU_TOOL -B 1 '$test_dir/a/file1'" \
        "$F_TOOL -B 1 '$test_dir/a/file1'"

    # === Section 9: Exclude ===
    echo ""
    echo "=== Exclude ==="

    run_stdout_test "--exclude=*.tmp" \
        "$GNU_TOOL --exclude='*.tmp' '$test_dir'" \
        "$F_TOOL --exclude='*.tmp' '$test_dir'"

    # === Section 10: One File System (-x) ===
    echo ""
    echo "=== One File System (-x) ==="

    run_stdout_test "-x stay on one filesystem" \
        "$GNU_TOOL -x '$test_dir'" \
        "$F_TOOL -x '$test_dir'"

    # === Section 11: Separate Dirs (-S) ===
    echo ""
    echo "=== Separate Dirs (-S) ==="

    run_stdout_test "-S separate dirs" \
        "$GNU_TOOL -S '$test_dir'" \
        "$F_TOOL -S '$test_dir'"

    # === Section 12: Null-Terminated (-0) ===
    echo ""
    echo "=== Null-Terminated (-0) ==="

    run_stdout_test "-0 null terminated" \
        "$GNU_TOOL -0 -s '$test_dir'" \
        "$F_TOOL -0 -s '$test_dir'"

    # === Section 13: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent path" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_du_tests
