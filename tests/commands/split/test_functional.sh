#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fsplit"
run_split_functional_tests() {
    init_test_suite "split"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"split","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/split_results.json"
        return 0
    fi
    run_expected_exit_test "no args from stdin" "printf 'hello\nworld\n' | $F_TOOL -l 1 /dev/stdin /tmp/fcoreutils_split_$$_ && rm -f /tmp/fcoreutils_split_$$_*" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_split_functional_tests
