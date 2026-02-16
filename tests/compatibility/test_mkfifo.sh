#!/usr/bin/env bash
# Compatibility tests for fmkfifo vs GNU mkfifo
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mkfifo"
F_TOOL="fmkfifo"

run_mkfifo_tests() {
    init_test_suite "mkfifo"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mkfifo","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mkfifo_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU mkfifo not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_mkfifo_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic FIFO Creation ==="

    run_test "create FIFO" \
        "$GNU_TOOL '$WORK_DIR/gnu_fifo' && test -p '$WORK_DIR/gnu_fifo' && echo 'IS_FIFO'" \
        "$F_TOOL '$WORK_DIR/f_fifo' && test -p '$WORK_DIR/f_fifo' && echo 'IS_FIFO'"

    run_test "file type is fifo" \
        "$GNU_TOOL '$WORK_DIR/gnu_fifo2' && stat -c '%F' '$WORK_DIR/gnu_fifo2'" \
        "$F_TOOL '$WORK_DIR/f_fifo2' && stat -c '%F' '$WORK_DIR/f_fifo2'"

    run_test "create multiple FIFOs" \
        "$GNU_TOOL '$WORK_DIR/gnu_f1' '$WORK_DIR/gnu_f2' '$WORK_DIR/gnu_f3' && test -p '$WORK_DIR/gnu_f1' && test -p '$WORK_DIR/gnu_f2' && test -p '$WORK_DIR/gnu_f3' && echo 'ALL_FIFO'" \
        "$F_TOOL '$WORK_DIR/f_f1' '$WORK_DIR/f_f2' '$WORK_DIR/f_f3' && test -p '$WORK_DIR/f_f1' && test -p '$WORK_DIR/f_f2' && test -p '$WORK_DIR/f_f3' && echo 'ALL_FIFO'"

    echo ""
    echo "=== Mode (-m) ==="

    run_test "-m 644" \
        "$GNU_TOOL -m 644 '$WORK_DIR/gnu_m644' && stat -c '%a' '$WORK_DIR/gnu_m644'" \
        "$F_TOOL -m 644 '$WORK_DIR/f_m644' && stat -c '%a' '$WORK_DIR/f_m644'"

    run_test "-m 600" \
        "$GNU_TOOL -m 600 '$WORK_DIR/gnu_m600' && stat -c '%a' '$WORK_DIR/gnu_m600'" \
        "$F_TOOL -m 600 '$WORK_DIR/f_m600' && stat -c '%a' '$WORK_DIR/f_m600'"

    run_test "-m 777" \
        "$GNU_TOOL -m 777 '$WORK_DIR/gnu_m777' && stat -c '%a' '$WORK_DIR/gnu_m777'" \
        "$F_TOOL -m 777 '$WORK_DIR/f_m777' && stat -c '%a' '$WORK_DIR/f_m777'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "existing file" \
        "echo 'x' > '$WORK_DIR/gnu_exist' && $GNU_TOOL '$WORK_DIR/gnu_exist' 2>&1" \
        "echo 'x' > '$WORK_DIR/f_exist' && $F_TOOL '$WORK_DIR/f_exist' 2>&1"

    run_exit_code_test "existing FIFO" \
        "$GNU_TOOL '$WORK_DIR/gnu_dup' && $GNU_TOOL '$WORK_DIR/gnu_dup' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_dup' && $F_TOOL '$WORK_DIR/f_dup' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "nonexistent parent" \
        "$GNU_TOOL '/nonexistent_$$/fifo' 2>&1" \
        "$F_TOOL '/nonexistent_$$/fifo' 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "FIFO name with spaces" \
        "$GNU_TOOL '$WORK_DIR/gnu fifo space' && test -p '$WORK_DIR/gnu fifo space' && echo 'SPACE_OK'" \
        "$F_TOOL '$WORK_DIR/f fifo space' && test -p '$WORK_DIR/f fifo space' && echo 'SPACE_OK'"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_mkfifo_tests
