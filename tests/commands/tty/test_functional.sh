#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftty"
run_tty_functional_tests() {
    init_test_suite "tty"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tty","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tty_results.json"
        return 0
    fi
    # In CI/pipe mode tty should report "not a tty" and exit 1
    run_expected_exit_test "not a tty in pipe" "echo | $F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_tty_functional_tests
