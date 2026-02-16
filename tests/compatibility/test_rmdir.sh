#!/usr/bin/env bash
# Compatibility tests for frmdir vs GNU rmdir
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="rmdir"
F_TOOL="frmdir"

run_rmdir_tests() {
    init_test_suite "rmdir"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"rmdir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/rmdir_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU rmdir not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_rmdir_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic Empty Directory Removal ==="

    run_test "remove empty directory" \
        "mkdir '$WORK_DIR/gnu_empty' && $GNU_TOOL '$WORK_DIR/gnu_empty' && test ! -d '$WORK_DIR/gnu_empty' && echo 'REMOVED'" \
        "mkdir '$WORK_DIR/f_empty' && $F_TOOL '$WORK_DIR/f_empty' && test ! -d '$WORK_DIR/f_empty' && echo 'REMOVED'"

    run_test "remove multiple empty directories" \
        "mkdir '$WORK_DIR/gnu_m1' '$WORK_DIR/gnu_m2' '$WORK_DIR/gnu_m3' && $GNU_TOOL '$WORK_DIR/gnu_m1' '$WORK_DIR/gnu_m2' '$WORK_DIR/gnu_m3' && echo 'ALL_REMOVED'" \
        "mkdir '$WORK_DIR/f_m1' '$WORK_DIR/f_m2' '$WORK_DIR/f_m3' && $F_TOOL '$WORK_DIR/f_m1' '$WORK_DIR/f_m2' '$WORK_DIR/f_m3' && echo 'ALL_REMOVED'"

    echo ""
    echo "=== Parents (-p) ==="

    run_test "-p remove parent chain" \
        "mkdir -p '$WORK_DIR/gnu_chain/b/c' && $GNU_TOOL -p '$WORK_DIR/gnu_chain/b/c' && test ! -d '$WORK_DIR/gnu_chain' && echo 'CHAIN_REMOVED'" \
        "mkdir -p '$WORK_DIR/f_chain/b/c' && $F_TOOL -p '$WORK_DIR/f_chain/b/c' && test ! -d '$WORK_DIR/f_chain' && echo 'CHAIN_REMOVED'"

    run_test "-p deep chain" \
        "mkdir -p '$WORK_DIR/gnu_deep/a/b/c/d' && $GNU_TOOL -p '$WORK_DIR/gnu_deep/a/b/c/d' && test ! -d '$WORK_DIR/gnu_deep' && echo 'DEEP_REMOVED'" \
        "mkdir -p '$WORK_DIR/f_deep/a/b/c/d' && $F_TOOL -p '$WORK_DIR/f_deep/a/b/c/d' && test ! -d '$WORK_DIR/f_deep' && echo 'DEEP_REMOVED'"

    echo ""
    echo "=== Verbose (--verbose) ==="

    run_stdout_test "--verbose remove" \
        "mkdir '$WORK_DIR/gnu_verb' && $GNU_TOOL --verbose '$WORK_DIR/gnu_verb'" \
        "mkdir '$WORK_DIR/f_verb' && $F_TOOL --verbose '$WORK_DIR/f_verb'"

    echo ""
    echo "=== Ignore Non-Empty (--ignore-fail-on-non-empty) ==="

    run_test "--ignore-fail-on-non-empty" \
        "mkdir -p '$WORK_DIR/gnu_nonempty' && echo 'x' > '$WORK_DIR/gnu_nonempty/file.txt' && $GNU_TOOL --ignore-fail-on-non-empty '$WORK_DIR/gnu_nonempty' 2>/dev/null; test -d '$WORK_DIR/gnu_nonempty' && echo 'STILL_EXISTS'" \
        "mkdir -p '$WORK_DIR/f_nonempty' && echo 'x' > '$WORK_DIR/f_nonempty/file.txt' && $F_TOOL --ignore-fail-on-non-empty '$WORK_DIR/f_nonempty' 2>/dev/null; test -d '$WORK_DIR/f_nonempty' && echo 'STILL_EXISTS'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "non-empty directory" \
        "mkdir -p '$WORK_DIR/gnu_ne' && echo 'x' > '$WORK_DIR/gnu_ne/f.txt' && $GNU_TOOL '$WORK_DIR/gnu_ne' 2>&1" \
        "mkdir -p '$WORK_DIR/f_ne' && echo 'x' > '$WORK_DIR/f_ne/f.txt' && $F_TOOL '$WORK_DIR/f_ne' 2>&1"

    run_exit_code_test "nonexistent directory" \
        "$GNU_TOOL '$WORK_DIR/nonexistent_$$' 2>&1" \
        "$F_TOOL '$WORK_DIR/nonexistent_$$' 2>&1"

    run_exit_code_test "remove file (not directory)" \
        "echo 'x' > '$WORK_DIR/gnu_file.txt' && $GNU_TOOL '$WORK_DIR/gnu_file.txt' 2>&1" \
        "echo 'x' > '$WORK_DIR/f_file.txt' && $F_TOOL '$WORK_DIR/f_file.txt' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "directory with trailing slash" \
        "mkdir '$WORK_DIR/gnu_trail' && $GNU_TOOL '$WORK_DIR/gnu_trail/' && test ! -d '$WORK_DIR/gnu_trail' && echo 'REMOVED'" \
        "mkdir '$WORK_DIR/f_trail' && $F_TOOL '$WORK_DIR/f_trail/' && test ! -d '$WORK_DIR/f_trail' && echo 'REMOVED'"

    run_test "directory name with spaces" \
        "mkdir '$WORK_DIR/gnu dir space' && $GNU_TOOL '$WORK_DIR/gnu dir space' && test ! -d '$WORK_DIR/gnu dir space' && echo 'REMOVED'" \
        "mkdir '$WORK_DIR/f dir space' && $F_TOOL '$WORK_DIR/f dir space' && test ! -d '$WORK_DIR/f dir space' && echo 'REMOVED'"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_rmdir_tests
