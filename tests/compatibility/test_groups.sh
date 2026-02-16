#!/usr/bin/env bash
# Compatibility tests for fgroups vs GNU groups
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="groups"
F_TOOL="fgroups"

run_groups_tests() {
    init_test_suite "groups"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"groups","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/groups_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU groups not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    run_test "current user groups" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "explicit current user" \
        "$GNU_TOOL \$(whoami)" \
        "$F_TOOL \$(whoami)"

    echo ""
    echo "=== Specific Users ==="

    run_test "root user" \
        "$GNU_TOOL root 2>/dev/null || echo 'NO_ROOT'" \
        "$F_TOOL root 2>/dev/null || echo 'NO_ROOT'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent user" \
        "$GNU_TOOL nonexistent_user_$$ 2>&1" \
        "$F_TOOL nonexistent_user_$$ 2>&1"

    finish_test_suite
}

run_groups_tests
