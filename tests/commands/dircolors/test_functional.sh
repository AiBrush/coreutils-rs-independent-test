#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fdircolors"
run_dircolors_functional_tests() {
    init_test_suite "dircolors"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dircolors","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/dircolors_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0 with -b" "$F_TOOL -b" 0
    run_expected_exit_test "exits 0 with -c" "$F_TOOL -c" 0
    run_expected_exit_test "print database exits 0" "$F_TOOL -p" 0
    finish_test_suite
}
run_dircolors_functional_tests
