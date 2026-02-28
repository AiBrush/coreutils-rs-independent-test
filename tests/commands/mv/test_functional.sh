#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fmv"
run_mv_functional_tests() {
    init_test_suite "mv"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mv","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mv_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent source fails" "$F_TOOL /tmp/nonexistent_file_functional_test /tmp/dest_$$ 2>/dev/null" 1
    local src="/tmp/fcoreutils_mvsrc_$$"
    local dst="/tmp/fcoreutils_mvdst_$$"
    printf "hello" > "$src"
    run_expected_exit_test "basic move" "$F_TOOL $src $dst" 0
    rm -f "$src" "$dst"
    finish_test_suite
}
run_mv_functional_tests
