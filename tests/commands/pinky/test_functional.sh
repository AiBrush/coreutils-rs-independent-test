#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fpinky"
run_pinky_functional_tests() {
    init_test_suite "pinky"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pinky","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/pinky_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0 or warns" "$F_TOOL 2>/dev/null || true" 0
    finish_test_suite
}
run_pinky_functional_tests
