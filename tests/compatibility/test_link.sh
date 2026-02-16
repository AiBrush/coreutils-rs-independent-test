#!/usr/bin/env bash
# Compatibility tests for flink vs GNU link
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="link"
F_TOOL="flink"

run_link_tests() {
    init_test_suite "link"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"link","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/link_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU link not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_link_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic Hard Link ==="

    echo "source content" > "$WORK_DIR/source.txt"

    run_test "create hard link" \
        "$GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/gnu_link.txt' && cat '$WORK_DIR/gnu_link.txt'" \
        "$F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/f_link.txt' && cat '$WORK_DIR/f_link.txt'"

    run_test "hard link same inode" \
        "$GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/gnu_link2.txt' && test \$(stat -c '%i' '$WORK_DIR/source.txt') -eq \$(stat -c '%i' '$WORK_DIR/gnu_link2.txt') && echo 'SAME'" \
        "$F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/f_link2.txt' && test \$(stat -c '%i' '$WORK_DIR/source.txt') -eq \$(stat -c '%i' '$WORK_DIR/f_link2.txt') && echo 'SAME'"

    run_test "link increases nlink count" \
        "$GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/gnu_link3.txt' && stat -c '%h' '$WORK_DIR/source.txt'" \
        "$F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/f_link3.txt' && stat -c '%h' '$WORK_DIR/source.txt'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "source not found" \
        "$GNU_TOOL '/tmp/nonexistent_$$' '$WORK_DIR/gnu_err.txt' 2>&1" \
        "$F_TOOL '/tmp/nonexistent_$$' '$WORK_DIR/f_err.txt' 2>&1"

    run_exit_code_test "target already exists" \
        "echo 'x' > '$WORK_DIR/gnu_exists.txt' && $GNU_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/gnu_exists.txt' 2>&1" \
        "echo 'x' > '$WORK_DIR/f_exists.txt' && $F_TOOL '$WORK_DIR/source.txt' '$WORK_DIR/f_exists.txt' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "one argument" \
        "$GNU_TOOL '$WORK_DIR/source.txt' 2>&1" \
        "$F_TOOL '$WORK_DIR/source.txt' 2>&1"

    run_exit_code_test "too many arguments" \
        "$GNU_TOOL a b c 2>&1" \
        "$F_TOOL a b c 2>&1"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_link_tests
