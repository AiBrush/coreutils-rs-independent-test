#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fchmod"
run_chmod_functional_tests() {
    init_test_suite "chmod"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chmod","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chmod_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent file fails" "$F_TOOL 755 /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    # Test basic chmod on a temp file
    local tmp
    tmp=$(mktemp /tmp/fcoreutils_chmod_XXXXXX)
    run_expected_exit_test "chmod 644 exits 0" "$F_TOOL 644 $tmp" 0
    rm -f "$tmp"
    finish_test_suite
}
run_chmod_functional_tests
