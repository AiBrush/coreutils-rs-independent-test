#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fptx"
run_ptx_functional_tests() {
    init_test_suite "ptx"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"ptx","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/ptx_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "printf 'hello world' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_ptx_functional_tests
