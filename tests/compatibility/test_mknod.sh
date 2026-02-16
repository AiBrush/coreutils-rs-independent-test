#!/usr/bin/env bash
# Compatibility tests for fmknod vs GNU mknod
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mknod"
F_TOOL="fmknod"

run_mknod_tests() {
    init_test_suite "mknod"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mknod","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mknod_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU mknod not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_mknod_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== FIFO Creation (p) ==="

    run_test "create FIFO" \
        "$GNU_TOOL '$WORK_DIR/gnu_fifo' p && test -p '$WORK_DIR/gnu_fifo' && echo 'IS_FIFO'" \
        "$F_TOOL '$WORK_DIR/f_fifo' p && test -p '$WORK_DIR/f_fifo' && echo 'IS_FIFO'"

    run_test "FIFO file type" \
        "$GNU_TOOL '$WORK_DIR/gnu_fifo2' p && stat -c '%F' '$WORK_DIR/gnu_fifo2'" \
        "$F_TOOL '$WORK_DIR/f_fifo2' p && stat -c '%F' '$WORK_DIR/f_fifo2'"

    echo ""
    echo "=== Mode (-m) ==="

    run_test "FIFO with mode 644" \
        "$GNU_TOOL -m 644 '$WORK_DIR/gnu_fifo_m' p && stat -c '%a' '$WORK_DIR/gnu_fifo_m'" \
        "$F_TOOL -m 644 '$WORK_DIR/f_fifo_m' p && stat -c '%a' '$WORK_DIR/f_fifo_m'"

    run_test "FIFO with mode 600" \
        "$GNU_TOOL -m 600 '$WORK_DIR/gnu_fifo_600' p && stat -c '%a' '$WORK_DIR/gnu_fifo_600'" \
        "$F_TOOL -m 600 '$WORK_DIR/f_fifo_600' p && stat -c '%a' '$WORK_DIR/f_fifo_600'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "existing file" \
        "echo 'x' > '$WORK_DIR/gnu_exists' && $GNU_TOOL '$WORK_DIR/gnu_exists' p 2>&1" \
        "echo 'x' > '$WORK_DIR/f_exists' && $F_TOOL '$WORK_DIR/f_exists' p 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "missing type" \
        "$GNU_TOOL '$WORK_DIR/gnu_notype' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_notype' 2>&1"

    run_exit_code_test "invalid type" \
        "$GNU_TOOL '$WORK_DIR/gnu_badtype' x 2>&1" \
        "$F_TOOL '$WORK_DIR/f_badtype' x 2>&1"

    # Note: block/char device creation requires root, so we test error behavior
    run_exit_code_test "block device without root (permission error)" \
        "$GNU_TOOL '$WORK_DIR/gnu_blk' b 1 0 2>&1" \
        "$F_TOOL '$WORK_DIR/f_blk' b 1 0 2>&1"

    run_exit_code_test "char device without root (permission error)" \
        "$GNU_TOOL '$WORK_DIR/gnu_chr' c 1 0 2>&1" \
        "$F_TOOL '$WORK_DIR/f_chr' c 1 0 2>&1"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_mknod_tests
