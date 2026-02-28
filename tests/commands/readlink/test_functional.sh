#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="freadlink"
run_readlink_functional_tests() {
    init_test_suite "readlink"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"readlink","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/readlink_results.json"
        return 0
    fi
    local src="/tmp/fcoreutils_readlink_src_$$"
    local lnk="/tmp/fcoreutils_readlink_lnk_$$"
    printf "hello" > "$src"
    ln -sf "$src" "$lnk"
    run_expected_test "read symlink" "$F_TOOL $lnk" "$src"
    run_expected_exit_test "canonicalize exits 0" "$F_TOOL -f $lnk" 0
    rm -f "$src" "$lnk"
    run_expected_exit_test "nonexistent fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_readlink_functional_tests
