#!/usr/bin/env bash
# Compatibility tests for frealpath vs GNU realpath
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="realpath"
F_TOOL="frealpath"

run_realpath_tests() {
    init_test_suite "realpath"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"realpath","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/realpath_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU realpath not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_realpath_test_XXXXXX)
    register_temp "$WORK_DIR"

    # Setup test structure
    mkdir -p "$WORK_DIR/a/b/c"
    echo "target" > "$WORK_DIR/a/b/c/file.txt"
    ln -sf "$WORK_DIR/a/b/c/file.txt" "$WORK_DIR/link1" 2>/dev/null || true
    ln -sf "$WORK_DIR/link1" "$WORK_DIR/link2" 2>/dev/null || true
    ln -sf "$WORK_DIR/a/b" "$WORK_DIR/dir_link" 2>/dev/null || true

    echo ""
    echo "=== Basic Realpath ==="

    run_test "regular file" \
        "$GNU_TOOL '$WORK_DIR/a/b/c/file.txt'" \
        "$F_TOOL '$WORK_DIR/a/b/c/file.txt'"

    run_test "directory" \
        "$GNU_TOOL '$WORK_DIR/a/b/c'" \
        "$F_TOOL '$WORK_DIR/a/b/c'"

    run_test "root" \
        "$GNU_TOOL /" \
        "$F_TOOL /"

    run_test "dot" \
        "$GNU_TOOL ." \
        "$F_TOOL ."

    run_test "dot-dot" \
        "$GNU_TOOL .." \
        "$F_TOOL .."

    echo ""
    echo "=== Symlink Resolution ==="

    run_test "resolve single symlink" \
        "$GNU_TOOL '$WORK_DIR/link1'" \
        "$F_TOOL '$WORK_DIR/link1'"

    run_test "resolve chained symlinks" \
        "$GNU_TOOL '$WORK_DIR/link2'" \
        "$F_TOOL '$WORK_DIR/link2'"

    run_test "resolve directory symlink" \
        "$GNU_TOOL '$WORK_DIR/dir_link'" \
        "$F_TOOL '$WORK_DIR/dir_link'"

    run_test "path through dir symlink" \
        "$GNU_TOOL '$WORK_DIR/dir_link/c/file.txt'" \
        "$F_TOOL '$WORK_DIR/dir_link/c/file.txt'"

    echo ""
    echo "=== Path with .. ==="

    run_test "path with .." \
        "$GNU_TOOL '$WORK_DIR/a/b/../b/c'" \
        "$F_TOOL '$WORK_DIR/a/b/../b/c'"

    run_test "path with ." \
        "$GNU_TOOL '$WORK_DIR/./a/./b'" \
        "$F_TOOL '$WORK_DIR/./a/./b'"

    run_test "multiple .. components" \
        "$GNU_TOOL '$WORK_DIR/a/b/c/../../b'" \
        "$F_TOOL '$WORK_DIR/a/b/c/../../b'"

    echo ""
    echo "=== No Symlink Resolution (-s / --no-symlinks) ==="

    run_test "-s no symlink resolution" \
        "$GNU_TOOL -s '$WORK_DIR/link1'" \
        "$F_TOOL -s '$WORK_DIR/link1'"

    run_test "--no-symlinks" \
        "$GNU_TOOL --no-symlinks '$WORK_DIR/link1'" \
        "$F_TOOL --no-symlinks '$WORK_DIR/link1'"

    echo ""
    echo "=== Canonicalize Modes ==="

    run_test "--canonicalize-existing (all must exist)" \
        "$GNU_TOOL -e '$WORK_DIR/a/b/c/file.txt'" \
        "$F_TOOL -e '$WORK_DIR/a/b/c/file.txt'"

    run_exit_code_test "-e with nonexistent" \
        "$GNU_TOOL -e '$WORK_DIR/nonexistent' 2>&1" \
        "$F_TOOL -e '$WORK_DIR/nonexistent' 2>&1"

    run_test "--canonicalize-missing (may not exist)" \
        "$GNU_TOOL -m '$WORK_DIR/a/b/nonexistent'" \
        "$F_TOOL -m '$WORK_DIR/a/b/nonexistent'"

    echo ""
    echo "=== Relative (--relative-to) ==="

    run_test "--relative-to" \
        "$GNU_TOOL --relative-to='$WORK_DIR/a' '$WORK_DIR/a/b/c/file.txt'" \
        "$F_TOOL --relative-to='$WORK_DIR/a' '$WORK_DIR/a/b/c/file.txt'"

    run_test "--relative-to sibling" \
        "$GNU_TOOL --relative-to='$WORK_DIR/a/b' '$WORK_DIR/a'" \
        "$F_TOOL --relative-to='$WORK_DIR/a/b' '$WORK_DIR/a'"

    echo ""
    echo "=== Relative Base (--relative-base) ==="

    run_test "--relative-base" \
        "$GNU_TOOL --relative-base='$WORK_DIR' '$WORK_DIR/a/b/c'" \
        "$F_TOOL --relative-base='$WORK_DIR' '$WORK_DIR/a/b/c'"

    echo ""
    echo "=== Zero Terminated (-z) ==="

    run_test "-z null terminated" \
        "$GNU_TOOL -z '$WORK_DIR/a/b' | od -c" \
        "$F_TOOL -z '$WORK_DIR/a/b' | od -c"

    echo ""
    echo "=== Multiple Paths ==="

    run_test "multiple paths" \
        "$GNU_TOOL '$WORK_DIR/a' '$WORK_DIR/a/b' '$WORK_DIR/link1'" \
        "$F_TOOL '$WORK_DIR/a' '$WORK_DIR/a/b' '$WORK_DIR/link1'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent path" \
        "$GNU_TOOL /nonexistent_$$/path 2>&1" \
        "$F_TOOL /nonexistent_$$/path 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_realpath_tests
