#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fdirname"
run_dirname_functional_tests() {
    init_test_suite "dirname"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dirname","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/dirname_results.json"
        return 0
    fi
    run_expected_test "simple path" "$F_TOOL /usr/bin/sort" "/usr/bin"
    run_expected_test "no dir component" "$F_TOOL hello" "."
    run_expected_test "root" "$F_TOOL /" "/"
    run_expected_test "trailing slash" "$F_TOOL /usr/bin/" "/usr"
    run_expected_test "double slash" "$F_TOOL //foo" "/"
    run_expected_exit_test "exits 0" "$F_TOOL /foo" 0
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_dirname_functional_tests
