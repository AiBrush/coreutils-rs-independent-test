#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fsha256sum"
run_sha256sum_functional_tests() {
    init_test_suite "sha256sum"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha256sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha256sum_results.json"
        return 0
    fi
    run_expected_stdin_test "empty input" "$F_TOOL" "" "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  -"
    run_expected_stdin_test "hello newline" "$F_TOOL" "$(printf 'hello\n')" "5891b5b522d5df086d0ff0b110fbd9d21bb4fc7163af34d08286a2e846f6be03  -"
    run_expected_exit_test "exits 0" "printf 'test' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_sha256sum_functional_tests
