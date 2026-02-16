#!/usr/bin/env bash
# Compatibility tests for fwhoami vs GNU whoami
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="whoami"
F_TOOL="fwhoami"

run_whoami_tests() {
    init_test_suite "whoami"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"whoami","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/whoami_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU whoami not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    run_test "current user" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "matches id -un" \
        "$GNU_TOOL && id -un" \
        "$F_TOOL && id -un"

    echo ""
    echo "=== Exit Code ==="

    run_test "exit code 0" \
        "$GNU_TOOL > /dev/null && echo 'EXIT_OK'" \
        "$F_TOOL > /dev/null && echo 'EXIT_OK'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "extra arguments" \
        "$GNU_TOOL extra_arg 2>&1" \
        "$F_TOOL extra_arg 2>&1"

    finish_test_suite
}

run_whoami_tests
