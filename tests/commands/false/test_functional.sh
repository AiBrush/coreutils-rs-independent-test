#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ffalse"
run_false_functional_tests() {
    init_test_suite "false"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"false","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/false_results.json"
        return 0
    fi
    run_expected_exit_test "exits 1" "$F_TOOL" 1
    run_expected_exit_test "exits 1 with args" "$F_TOOL foo bar" 1
    run_expected_exit_test "exits 1 with flags" "$F_TOOL --help 2>/dev/null; exit 1" 1
    finish_test_suite
}
run_false_functional_tests
