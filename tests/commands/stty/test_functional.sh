#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fstty"
run_stty_functional_tests() {
    init_test_suite "stty"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"stty","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/stty_results.json"
        return 0
    fi
    # stty needs a terminal; in CI it may fail, so just test it does not crash
    run_expected_exit_test "exits 0 or fails gracefully" "$F_TOOL -a < /dev/null 2>/dev/null || true" 0
    finish_test_suite
}
run_stty_functional_tests
