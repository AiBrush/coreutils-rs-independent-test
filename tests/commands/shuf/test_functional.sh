#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fshuf"
run_shuf_functional_tests() {
    init_test_suite "shuf"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"shuf","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/shuf_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "printf 'a\nb\nc\n' | $F_TOOL" 0
    # Pick one item
    run_expected_exit_test "pick one" "$F_TOOL -n 1 -i 1-10" 0
    # Range
    run_expected_exit_test "range shuffle" "$F_TOOL -i 1-5" 0
    # Echo mode
    run_expected_exit_test "echo mode" "$F_TOOL -e a b c" 0
    finish_test_suite
}
run_shuf_functional_tests
