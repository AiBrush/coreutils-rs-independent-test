#!/usr/bin/env bash
# Compatibility tests for fpwd vs GNU pwd
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="pwd"
F_TOOL="fpwd"

run_pwd_tests() {
    init_test_suite "pwd"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pwd","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/pwd_results.json"
        return 0
    fi

    # pwd is a shell builtin, we need the GNU version
    local GNU_PWD
    GNU_PWD=$(command -v pwd 2>/dev/null || which pwd 2>/dev/null)
    if [[ -z "$GNU_PWD" ]]; then
        echo "GNU pwd not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    run_test "default current directory" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "from /tmp" \
        "cd /tmp && $GNU_TOOL && cd -" \
        "cd /tmp && $F_TOOL && cd -"

    run_test "from root" \
        "cd / && $GNU_TOOL && cd -" \
        "cd / && $F_TOOL && cd -"

    echo ""
    echo "=== Logical (-L) ==="

    run_test "-L logical path" \
        "$GNU_TOOL -L" \
        "$F_TOOL -L"

    echo ""
    echo "=== Physical (-P) ==="

    run_test "-P physical path" \
        "$GNU_TOOL -P" \
        "$F_TOOL -P"

    echo ""
    echo "=== Symlinked Directories ==="

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_pwd_test_XXXXXX)
    register_temp "$WORK_DIR"
    mkdir -p "$WORK_DIR/real_dir"
    ln -sf "$WORK_DIR/real_dir" "$WORK_DIR/link_dir" 2>/dev/null || true

    if [[ -L "$WORK_DIR/link_dir" ]]; then
        run_test "-P through symlink" \
            "cd '$WORK_DIR/link_dir' && $GNU_TOOL -P && cd -" \
            "cd '$WORK_DIR/link_dir' && $F_TOOL -P && cd -"
    fi

    rm -rf "$WORK_DIR"

    echo ""
    echo "=== Exit Code ==="

    run_test "exit code 0" \
        "$GNU_TOOL > /dev/null && echo 'EXIT_OK'" \
        "$F_TOOL > /dev/null && echo 'EXIT_OK'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "invalid option" \
        "$GNU_TOOL --invalid-option 2>&1" \
        "$F_TOOL --invalid-option 2>&1"

    finish_test_suite
}

run_pwd_tests
