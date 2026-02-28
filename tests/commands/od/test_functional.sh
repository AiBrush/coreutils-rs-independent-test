#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fod"
run_od_functional_tests() {
    init_test_suite "od"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"od","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/od_results.json"
        return 0
    fi
    run_expected_stdin_test "hex bytes" "$F_TOOL -An -tx1" "AB" "41 42"
    run_expected_exit_test "exits 0" "printf 'hello' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_od_functional_tests
