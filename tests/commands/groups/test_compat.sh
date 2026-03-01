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

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent user" \
        "$GNU_TOOL nonexistent_user_$$ 2>&1" \
        "$F_TOOL nonexistent_user_$$ 2>&1"

    # === Multiple Valid Users ===
    echo ""
    echo "=== Multiple Valid Users ==="

    local current_user
    current_user=$(whoami)

    run_test "multiple valid users (self twice)" \
        "$GNU_TOOL $current_user $current_user" \
        "$F_TOOL $current_user $current_user"

    run_test "current user and root" \
        "$GNU_TOOL $current_user root 2>/dev/null || true" \
        "$F_TOOL $current_user root 2>/dev/null || true"

    # === Comparison with id ===
    echo ""
    echo "=== Comparison with id ==="

    run_test "groups vs id -Gn for current user" \
        "$GNU_TOOL | sed 's/^[^:]*: *//' | tr ' ' '\n' | sort" \
        "id -Gn | tr ' ' '\n' | sort"

    # === Output Format ===
    echo ""
    echo "=== Output Format ==="

    run_test "output format for current user" \
        "$GNU_TOOL $current_user" \
        "$F_TOOL $current_user"

    run_test "output format for root" \
        "$GNU_TOOL root 2>/dev/null || true" \
        "$F_TOOL root 2>/dev/null || true"

    # === Piped Output ===
    echo ""
    echo "=== Piped Output ==="

    run_test "groups piped through cat" \
        "$GNU_TOOL | cat" \
        "$F_TOOL | cat"

    run_test "groups user piped through cat" \
        "$GNU_TOOL $current_user | cat" \
        "$F_TOOL $current_user | cat"

    # === Invalid Options & Help ===
    echo ""
    echo "=== Invalid Options & Help ==="

    run_exit_code_test "--invalid option fails" \
        "$GNU_TOOL --invalid 2>&1" \
        "$F_TOOL --invalid 2>&1"

    run_exit_code_test "--help exits 0" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version exits 0" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    # === Comparison with id for Specific User ===
    echo ""
    echo "=== Comparison with id for Specific User ==="

    run_test "groups vs id -Gn for explicit current user" \
        "$GNU_TOOL $current_user | sed 's/^[^:]*: *//' | tr ' ' '\n' | sort" \
        "id -Gn $current_user | tr ' ' '\n' | sort"

    # === Mixed Valid and Invalid Users ===
    echo ""
    echo "=== Mixed Valid and Invalid Users ==="

    run_exit_code_test "valid then invalid user" \
        "$GNU_TOOL $current_user nonexistent_user_$$ 2>&1" \
        "$F_TOOL $current_user nonexistent_user_$$ 2>&1"

    run_test "valid then invalid user output" \
        "$GNU_TOOL $current_user nonexistent_user_$$ 2>&1 || true" \
        "$F_TOOL $current_user nonexistent_user_$$ 2>&1 || true"

    run_exit_code_test "invalid then valid user" \
        "$GNU_TOOL nonexistent_user_$$ $current_user 2>&1" \
        "$F_TOOL nonexistent_user_$$ $current_user 2>&1"

    run_test "invalid then valid user output" \
        "$GNU_TOOL nonexistent_user_$$ $current_user 2>&1 || true" \
        "$F_TOOL nonexistent_user_$$ $current_user 2>&1 || true"

    # === Additional Piped Output ===
    echo ""
    echo "=== Additional Piped Output ==="

    run_test "groups piped through sort" \
        "$GNU_TOOL | sort" \
        "$F_TOOL | sort"

    run_test "groups root piped through cat" \
        "$GNU_TOOL root 2>/dev/null | cat || true" \
        "$F_TOOL root 2>/dev/null | cat || true"

    # === Output Format Checks ===
    echo ""
    echo "=== Output Format Checks ==="

    run_test "output contains username prefix" \
        "$GNU_TOOL $current_user | grep -c '$current_user'" \
        "$F_TOOL $current_user | grep -c '$current_user'"

    run_test "output word count for current user" \
        "$GNU_TOOL $current_user | wc -w" \
        "$F_TOOL $current_user | wc -w"

    run_test "output line count for single user" \
        "$GNU_TOOL $current_user | wc -l" \
        "$F_TOOL $current_user | wc -l"

    finish_test_suite
}

run_groups_tests
