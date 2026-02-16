#!/usr/bin/env bash
# Compatibility tests for fid vs GNU id
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="id"
F_TOOL="fid"

run_id_tests() {
    init_test_suite "id"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"id","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/id_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU id not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Default Output (all IDs) ==="

    run_test "default (current user)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    echo ""
    echo "=== User ID (-u) ==="

    run_test "-u effective user ID" \
        "$GNU_TOOL -u" \
        "$F_TOOL -u"

    run_test "-un user name" \
        "$GNU_TOOL -un" \
        "$F_TOOL -un"

    run_test "-ur real user ID" \
        "$GNU_TOOL -ur" \
        "$F_TOOL -ur"

    echo ""
    echo "=== Group ID (-g) ==="

    run_test "-g effective group ID" \
        "$GNU_TOOL -g" \
        "$F_TOOL -g"

    run_test "-gn group name" \
        "$GNU_TOOL -gn" \
        "$F_TOOL -gn"

    run_test "-gr real group ID" \
        "$GNU_TOOL -gr" \
        "$F_TOOL -gr"

    echo ""
    echo "=== Groups (-G) ==="

    run_test "-G all groups" \
        "$GNU_TOOL -G" \
        "$F_TOOL -G"

    run_test "-Gn all group names" \
        "$GNU_TOOL -Gn" \
        "$F_TOOL -Gn"

    echo ""
    echo "=== Name Output (-n) ==="

    run_test "-un user name" \
        "$GNU_TOOL -un" \
        "$F_TOOL -un"

    run_test "-gn group name" \
        "$GNU_TOOL -gn" \
        "$F_TOOL -gn"

    echo ""
    echo "=== Zero Delimited (-z) ==="

    run_test "-Gz null-separated groups" \
        "$GNU_TOOL -Gz | od -c" \
        "$F_TOOL -Gz | od -c"

    echo ""
    echo "=== Specific User ==="

    run_test "root user" \
        "$GNU_TOOL root 2>/dev/null || echo 'NO_ROOT'" \
        "$F_TOOL root 2>/dev/null || echo 'NO_ROOT'"

    run_test "current user by name" \
        "$GNU_TOOL \$(whoami)" \
        "$F_TOOL \$(whoami)"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent user" \
        "$GNU_TOOL nonexistent_user_$$ 2>&1" \
        "$F_TOOL nonexistent_user_$$ 2>&1"

    run_exit_code_test "-u and -g together" \
        "$GNU_TOOL -u -g 2>&1" \
        "$F_TOOL -u -g 2>&1"

    finish_test_suite
}

run_id_tests
