#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="finstall"
run_install_functional_tests() {
    init_test_suite "install"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"install","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/install_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    # Test creating directory
    local tmpdir="/tmp/fcoreutils_install_test_$$"
    run_expected_exit_test "create directory" "$F_TOOL -d $tmpdir" 0
    rm -rf "$tmpdir"
    finish_test_suite
}
run_install_functional_tests
