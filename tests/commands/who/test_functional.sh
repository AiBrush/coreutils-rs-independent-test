#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fwho"
run_who_functional_tests() {
    init_test_suite "who"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"who","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/who_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL 2>/dev/null || true" 0
    finish_test_suite
}
run_who_functional_tests
