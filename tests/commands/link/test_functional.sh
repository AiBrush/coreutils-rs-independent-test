#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="flink"
run_link_functional_tests() {
    init_test_suite "link"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"link","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/link_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent source fails" "$F_TOOL /tmp/nonexistent_file_functional_test /tmp/link_dest_$$ 2>/dev/null" 1
    # Test creating a hard link
    local src="/tmp/fcoreutils_linksrc_$$"
    local dst="/tmp/fcoreutils_linkdst_$$"
    printf "hello" > "$src"
    run_expected_exit_test "create hard link" "$F_TOOL $src $dst" 0
    rm -f "$src" "$dst"
    finish_test_suite
}
run_link_functional_tests
