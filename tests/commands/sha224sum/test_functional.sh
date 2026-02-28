#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fsha224sum"
run_sha224sum_functional_tests() {
    init_test_suite "sha224sum"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha224sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha224sum_results.json"
        return 0
    fi
    run_expected_stdin_test "empty input" "$F_TOOL" "" "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f  -"
    run_expected_exit_test "exits 0" "printf 'test' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_sha224sum_functional_tests
