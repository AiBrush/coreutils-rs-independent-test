#!/usr/bin/env bash
# Compatibility tests for funlink vs GNU unlink
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="unlink"
F_TOOL="funlink"

run_unlink_tests() {
    init_test_suite "unlink"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"unlink","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/unlink_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU unlink not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_unlink_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic File Removal ==="

    run_test "remove regular file" \
        "echo 'x' > '$WORK_DIR/gnu_file.txt' && $GNU_TOOL '$WORK_DIR/gnu_file.txt' && test ! -e '$WORK_DIR/gnu_file.txt' && echo 'REMOVED'" \
        "echo 'x' > '$WORK_DIR/f_file.txt' && $F_TOOL '$WORK_DIR/f_file.txt' && test ! -e '$WORK_DIR/f_file.txt' && echo 'REMOVED'"

    run_test "remove symlink" \
        "ln -sf '$WORK_DIR' '$WORK_DIR/gnu_symlink' && $GNU_TOOL '$WORK_DIR/gnu_symlink' && test ! -L '$WORK_DIR/gnu_symlink' && echo 'REMOVED'" \
        "ln -sf '$WORK_DIR' '$WORK_DIR/f_symlink' && $F_TOOL '$WORK_DIR/f_symlink' && test ! -L '$WORK_DIR/f_symlink' && echo 'REMOVED'"

    run_test "remove empty file" \
        "> '$WORK_DIR/gnu_empty.txt' && $GNU_TOOL '$WORK_DIR/gnu_empty.txt' && test ! -e '$WORK_DIR/gnu_empty.txt' && echo 'REMOVED'" \
        "> '$WORK_DIR/f_empty.txt' && $F_TOOL '$WORK_DIR/f_empty.txt' && test ! -e '$WORK_DIR/f_empty.txt' && echo 'REMOVED'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL '/tmp/nonexistent_$$' 2>&1" \
        "$F_TOOL '/tmp/nonexistent_$$' 2>&1"

    run_exit_code_test "directory (cannot unlink)" \
        "mkdir -p '$WORK_DIR/gnu_dir' && $GNU_TOOL '$WORK_DIR/gnu_dir' 2>&1" \
        "mkdir -p '$WORK_DIR/f_dir' && $F_TOOL '$WORK_DIR/f_dir' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "too many arguments" \
        "$GNU_TOOL a b 2>&1" \
        "$F_TOOL a b 2>&1"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_unlink_tests
