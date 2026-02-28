#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="farch"
run_arch_functional_tests() {
    init_test_suite "arch"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"arch","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/arch_results.json"
        return 0
    fi
    # arch should output a non-empty architecture string
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    # Output should match uname -m
    local expected_arch
    expected_arch=$(uname -m)
    run_expected_test "matches uname -m" "$F_TOOL" "$expected_arch"
    finish_test_suite
}
run_arch_functional_tests
