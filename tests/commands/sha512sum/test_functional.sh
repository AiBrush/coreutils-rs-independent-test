#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fsha512sum"
run_sha512sum_functional_tests() {
    init_test_suite "sha512sum"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha512sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha512sum_results.json"
        return 0
    fi
    run_expected_stdin_test "empty input" "$F_TOOL" "" "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e  -"
    run_expected_exit_test "exits 0" "printf 'test' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_sha512sum_functional_tests
