#!/usr/bin/env bash
# Compatibility tests for freadlink vs GNU readlink
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="readlink"
F_TOOL="freadlink"

run_readlink_tests() {
    init_test_suite "readlink"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"readlink","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/readlink_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU readlink not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_readlink_test_XXXXXX)
    register_temp "$WORK_DIR"

    # Setup test symlinks
    echo "target content" > "$WORK_DIR/target.txt"
    ln -sf "$WORK_DIR/target.txt" "$WORK_DIR/link1" 2>/dev/null || true
    ln -sf "$WORK_DIR/link1" "$WORK_DIR/link2" 2>/dev/null || true
    ln -sf "relative_target.txt" "$WORK_DIR/rellink" 2>/dev/null || true
    echo "rel target" > "$WORK_DIR/relative_target.txt"
    ln -sf "/nonexistent/path_$$" "$WORK_DIR/broken" 2>/dev/null || true

    echo ""
    echo "=== Basic Readlink ==="

    run_test "read symlink target" \
        "$GNU_TOOL '$WORK_DIR/link1'" \
        "$F_TOOL '$WORK_DIR/link1'"

    run_test "read chained symlink (one level)" \
        "$GNU_TOOL '$WORK_DIR/link2'" \
        "$F_TOOL '$WORK_DIR/link2'"

    run_test "relative symlink" \
        "$GNU_TOOL '$WORK_DIR/rellink'" \
        "$F_TOOL '$WORK_DIR/rellink'"

    run_test "broken symlink (read target)" \
        "$GNU_TOOL '$WORK_DIR/broken'" \
        "$F_TOOL '$WORK_DIR/broken'"

    echo ""
    echo "=== Canonicalize (-f) ==="

    run_test "-f resolve fully" \
        "$GNU_TOOL -f '$WORK_DIR/link1'" \
        "$F_TOOL -f '$WORK_DIR/link1'"

    run_test "-f chained symlinks" \
        "$GNU_TOOL -f '$WORK_DIR/link2'" \
        "$F_TOOL -f '$WORK_DIR/link2'"

    run_test "-f regular file" \
        "$GNU_TOOL -f '$WORK_DIR/target.txt'" \
        "$F_TOOL -f '$WORK_DIR/target.txt'"

    run_test "-f directory" \
        "$GNU_TOOL -f '$WORK_DIR'" \
        "$F_TOOL -f '$WORK_DIR'"

    echo ""
    echo "=== Canonicalize Existing (-e) ==="

    run_test "-e existing file" \
        "$GNU_TOOL -e '$WORK_DIR/link1'" \
        "$F_TOOL -e '$WORK_DIR/link1'"

    run_exit_code_test "-e nonexistent target" \
        "$GNU_TOOL -e '$WORK_DIR/broken' 2>&1" \
        "$F_TOOL -e '$WORK_DIR/broken' 2>&1"

    echo ""
    echo "=== Canonicalize Missing (-m) ==="

    run_test "-m with nonexistent final component" \
        "$GNU_TOOL -m '$WORK_DIR/nonexistent_file'" \
        "$F_TOOL -m '$WORK_DIR/nonexistent_file'"

    echo ""
    echo "=== No Newline (-n) ==="

    run_test "-n no trailing newline" \
        "$GNU_TOOL -n '$WORK_DIR/link1' | od -c" \
        "$F_TOOL -n '$WORK_DIR/link1' | od -c"

    echo ""
    echo "=== Zero Terminated (-z) ==="

    run_test "-z null terminated" \
        "$GNU_TOOL -z '$WORK_DIR/link1' | od -c" \
        "$F_TOOL -z '$WORK_DIR/link1' | od -c"

    echo ""
    echo "=== Verbose (-v) ==="

    run_stdout_test "-v verbose" \
        "$GNU_TOOL -v '$WORK_DIR/link1'" \
        "$F_TOOL -v '$WORK_DIR/link1'"

    echo ""
    echo "=== Non-Symlink (should fail) ==="

    run_exit_code_test "regular file (no -f)" \
        "$GNU_TOOL '$WORK_DIR/target.txt' 2>&1" \
        "$F_TOOL '$WORK_DIR/target.txt' 2>&1"

    run_exit_code_test "directory (no -f)" \
        "$GNU_TOOL '$WORK_DIR' 2>&1" \
        "$F_TOOL '$WORK_DIR' 2>&1"

    echo ""
    echo "=== Multiple Files ==="

    run_test "multiple symlinks" \
        "$GNU_TOOL '$WORK_DIR/link1' '$WORK_DIR/link2'" \
        "$F_TOOL '$WORK_DIR/link1' '$WORK_DIR/link2'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL '/tmp/nonexistent_$$' 2>&1" \
        "$F_TOOL '/tmp/nonexistent_$$' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_readlink_tests
