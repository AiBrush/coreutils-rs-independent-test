#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fnice"
run_nice_functional_tests() {
    init_test_suite "nice"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nice","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/nice_results.json"
        return 0
    fi
    run_expected_exit_test "print niceness exits 0" "$F_TOOL" 0
    run_expected_exit_test "run true exits 0" "$F_TOOL true" 0
    run_expected_exit_test "run with adjustment exits 0" "$F_TOOL -n 5 true" 0
    finish_test_suite
}
run_nice_functional_tests
