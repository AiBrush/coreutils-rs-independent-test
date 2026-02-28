#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fbasenc"
run_basenc_functional_tests() {
    init_test_suite "basenc"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"basenc","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/basenc_results.json"
        return 0
    fi
    run_expected_stdin_test "base64 encode" "$F_TOOL --base64" "Hello" "SGVsbG8="
    run_expected_stdin_test "base64 decode" "$F_TOOL --base64 -d" "SGVsbG8=" "Hello"
    run_expected_stdin_test "base32 encode" "$F_TOOL --base32" "Hello" "JBSWY3DP"
    run_expected_stdin_test "base16 encode" "$F_TOOL --base16" "Hi" "4869"
    run_expected_exit_test "exits 0 on valid" "printf \"test\" | $F_TOOL --base64" 0
    finish_test_suite
}
run_basenc_functional_tests
