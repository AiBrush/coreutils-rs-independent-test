#!/usr/bin/env bash
# Compatibility tests for fsync vs GNU sync
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sync"
F_TOOL="fsync"

run_sync_tests() {
    init_test_suite "sync"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sync","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sync_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU sync not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Sync ==="

    run_test "sync (no args)" \
        "$GNU_TOOL && echo 'OK'" \
        "$F_TOOL && echo 'OK'"

    run_test "exit code 0" \
        "$GNU_TOOL; echo \$?" \
        "$F_TOOL; echo \$?"

    echo ""
    echo "=== File Sync ==="

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_sync_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo "test data" > "$WORK_DIR/syncfile.txt"

    run_test "sync specific file" \
        "$GNU_TOOL '$WORK_DIR/syncfile.txt' && echo 'OK'" \
        "$F_TOOL '$WORK_DIR/syncfile.txt' && echo 'OK'"

    echo ""
    echo "=== Data Sync (--data) ==="

    if $GNU_TOOL --data 2>/dev/null; then
        run_test "--data sync" \
            "$GNU_TOOL --data && echo 'OK'" \
            "$F_TOOL --data && echo 'OK'"
    else
        skip_test "--data sync" "not supported"
    fi

    echo ""
    echo "=== File System (--file-system / -f) ==="

    if $GNU_TOOL -f "$WORK_DIR/syncfile.txt" 2>/dev/null; then
        run_test "-f file system sync" \
            "$GNU_TOOL -f '$WORK_DIR/syncfile.txt' && echo 'OK'" \
            "$F_TOOL -f '$WORK_DIR/syncfile.txt' && echo 'OK'"
    else
        skip_test "-f file system sync" "not supported"
    fi

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_sync_tests
