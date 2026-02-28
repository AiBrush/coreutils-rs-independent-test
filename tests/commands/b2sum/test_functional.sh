#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fb2sum"
run_b2sum_functional_tests() {
    init_test_suite "b2sum"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"b2sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/b2sum_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0 on stdin" "printf \"hello\" | $F_TOOL" 0
    run_expected_stdin_test "empty input hash" "$F_TOOL" "" "786a02f742015903c6c6fd852552d272912f4740e15847618a86e217f71f5419d25e1031afee585313896444934eb04b903a685b1448b755d56f701afe9be2ce  -"
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_b2sum_functional_tests
