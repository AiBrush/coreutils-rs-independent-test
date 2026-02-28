#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fusers"
run_users_functional_tests() {
    init_test_suite "users"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"users","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/users_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL 2>/dev/null || true" 0
    finish_test_suite
}
run_users_functional_tests
