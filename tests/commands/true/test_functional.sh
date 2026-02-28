#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftrue"
run_true_functional_tests() {
    init_test_suite "true"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"true","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/true_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    run_expected_exit_test "exits 0 with args" "$F_TOOL foo bar" 0
    finish_test_suite
}
run_true_functional_tests
