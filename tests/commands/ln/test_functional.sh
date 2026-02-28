#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fln"
run_ln_functional_tests() {
    init_test_suite "ln"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"ln","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/ln_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    # Test creating symlink
    local src="/tmp/fcoreutils_lnsrc_$$"
    local dst="/tmp/fcoreutils_lndst_$$"
    printf "hello" > "$src"
    run_expected_exit_test "create symlink" "$F_TOOL -s $src $dst" 0
    rm -f "$src" "$dst"
    run_expected_exit_test "nonexistent source for hardlink fails" "$F_TOOL /tmp/nonexistent_file_functional_test /tmp/link_dest_$$ 2>/dev/null" 1
    finish_test_suite
}
run_ln_functional_tests
