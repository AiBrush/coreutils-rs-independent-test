#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fyes"
run_yes_functional_tests() {
    init_test_suite "yes"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"yes","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/yes_results.json"
        return 0
    fi
    run_expected_test "default outputs y" "$F_TOOL | head -3" "$(printf 'y\ny\ny')"
    run_expected_test "custom string" "$F_TOOL hello | head -3" "$(printf 'hello\nhello\nhello')"
    run_expected_exit_test "pipeable" "$F_TOOL | head -1 > /dev/null" 0
    finish_test_suite
}
run_yes_functional_tests
