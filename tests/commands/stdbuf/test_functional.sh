#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fstdbuf"
run_stdbuf_functional_tests() {
    init_test_suite "stdbuf"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"stdbuf","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/stdbuf_results.json"
        return 0
    fi
    run_expected_exit_test "run with line buffering" "$F_TOOL -oL true" 0
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_stdbuf_functional_tests
