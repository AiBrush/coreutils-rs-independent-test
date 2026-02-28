#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fbasename"
run_basename_functional_tests() {
    init_test_suite "basename"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"basename","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/basename_results.json"
        return 0
    fi
    run_expected_test "simple path" "$F_TOOL /usr/bin/sort" "sort"
    run_expected_test "strip suffix" "$F_TOOL /usr/bin/file.txt .txt" "file"
    run_expected_test "trailing slash" "$F_TOOL /usr/bin/" "bin"
    run_expected_test "no directory" "$F_TOOL hello" "hello"
    run_expected_test "root" "$F_TOOL /" "/"
    run_expected_test "double slash" "$F_TOOL //foo" "foo"
    run_expected_exit_test "exits 0" "$F_TOOL /foo/bar" 0
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_basename_functional_tests
