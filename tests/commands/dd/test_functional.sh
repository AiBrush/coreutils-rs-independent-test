#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fdd"
run_dd_functional_tests() {
    init_test_suite "dd"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dd","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/dd_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0 with null input" "printf \"hello\" | $F_TOOL of=/dev/null 2>/dev/null" 0
    # dd should copy data
    local src dst
    src=$(mktemp /tmp/fcoreutils_ddsrc_XXXXXX)
    dst=$(mktemp /tmp/fcoreutils_dddst_XXXXXX)
    printf "hello world" > "$src"
    run_expected_exit_test "basic copy exits 0" "$F_TOOL if=$src of=$dst 2>/dev/null" 0
    rm -f "$src" "$dst"
    run_expected_exit_test "nonexistent input fails" "$F_TOOL if=/tmp/nonexistent_file_functional_test of=/dev/null 2>/dev/null" 1
    finish_test_suite
}
run_dd_functional_tests
