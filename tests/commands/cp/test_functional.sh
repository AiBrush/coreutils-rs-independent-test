#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fcp"
run_cp_functional_tests() {
    init_test_suite "cp"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cp","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/cp_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent source fails" "$F_TOOL /tmp/nonexistent_file_functional_test /tmp/dest_$$ 2>/dev/null" 1
    # Test basic copy
    local src dst
    src=$(mktemp /tmp/fcoreutils_cpsrc_XXXXXX)
    dst="/tmp/fcoreutils_cpdst_$$"
    printf "hello world" > "$src"
    run_expected_exit_test "basic copy exits 0" "$F_TOOL $src $dst" 0
    rm -f "$src" "$dst"
    finish_test_suite
}
run_cp_functional_tests
