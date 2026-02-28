#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fmd5sum"
run_md5sum_functional_tests() {
    init_test_suite "md5sum"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"md5sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/md5sum_results.json"
        return 0
    fi
    run_expected_stdin_test "empty input" "$F_TOOL" "" "d41d8cd98f00b204e9800998ecf8427e  -"
    run_expected_stdin_test "hello newline" "$F_TOOL" "$(printf 'hello\n')" "b1946ac92492d2347c6235b4d2611184  -"
    run_expected_exit_test "exits 0" "printf 'test' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_md5sum_functional_tests
