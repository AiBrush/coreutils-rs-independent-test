#!/usr/bin/env bash
# Compatibility tests for fgroups vs GNU groups
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "groups")
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
    echo "=== GNU Upstream: groups-dash (Argument Handling) ==="

    # From groups-dash.sh: ensure groups handles -- sanely
    # Invalid user name ':invalid' with trailing -- should still error
    run_exit_code_test "invalid user with -- arg" \
        "$GNU_TOOL :invalid -- 2>&1" \
        "$F_TOOL :invalid -- 2>&1"

    echo ""
    echo "=== GNU Upstream: groups-process-all (Multiple Args) ==="

    # From groups-process-all.sh: ensure groups processes all arguments
    # before exiting (coreutils-2.27 and prior would exit on first failure)
    run_exit_code_test "multiple invalid users all processed" \
        "$GNU_TOOL :1 :2 :3 2>&1" \
        "$F_TOOL :1 :2 :3 2>&1"

    # From groups-process-all.sh: verify that all invalid users produce error lines
    # (tests error line count matches the number of invalid arguments)
    run_test "multiple invalid users error line count" \
        "$GNU_TOOL :1 :2 :3 2>&1 | wc -l" \
        "$F_TOOL :1 :2 :3 2>&1 | wc -l"

    # From groups-dash.sh: valid user followed by -- should show user's groups
    run_test "current user with trailing --" \
        "$GNU_TOOL \$(whoami) -- 2>/dev/null || true" \
        "$F_TOOL \$(whoami) -- 2>/dev/null || true"

    # groups-version.sh: skipped (compares version output format, implementation-specific)
    skip_test "groups --version format" "Implementation-specific version output"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent user" \
        "$GNU_TOOL nonexistent_user_$$ 2>&1" \
        "$F_TOOL nonexistent_user_$$ 2>&1"


    finish_test_suite
}

run_groups_tests
