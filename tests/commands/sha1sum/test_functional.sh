#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fsha1sum"
run_sha1sum_functional_tests() {
    init_test_suite "sha1sum"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha1sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha1sum_results.json"
        return 0
    fi
    run_expected_stdin_test "empty input" "$F_TOOL" "" "da39a3ee5e6b4b0d3255bfef95601890afd80709  -"
    run_expected_stdin_test "hello newline" "$F_TOOL" "$(printf 'hello\n')" "f572d396fae9206628714fb2ce00f72e94f2258f  -"
    run_expected_exit_test "exits 0" "printf 'test' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_sha1sum_functional_tests
