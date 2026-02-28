#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="frmdir"
run_rmdir_functional_tests() {
    init_test_suite "rmdir"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"rmdir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/rmdir_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent dir fails" "$F_TOOL /tmp/nonexistent_dir_$$ 2>/dev/null" 1
    local tmpdir="/tmp/fcoreutils_rmdir_$$"
    mkdir -p "$tmpdir"
    run_expected_exit_test "remove empty dir" "$F_TOOL $tmpdir" 0
    finish_test_suite
}
run_rmdir_functional_tests
