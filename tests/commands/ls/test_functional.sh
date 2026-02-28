#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fls"
run_ls_functional_tests() {
    init_test_suite "ls"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"ls","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/ls_results.json"
        return 0
    fi
    # Create a controlled test directory
    local testdir="/tmp/fcoreutils_ls_test_$$"
    mkdir -p "$testdir"
    printf "hello" > "$testdir/afile.txt"
    printf "world" > "$testdir/bfile.txt"
    mkdir -p "$testdir/cdir"
    run_expected_test "list files" "$F_TOOL $testdir" "$(printf 'afile.txt\nbfile.txt\ncdir')"
    run_expected_exit_test "exits 0" "$F_TOOL $testdir" 0
    run_expected_exit_test "long format exits 0" "$F_TOOL -l $testdir" 0
    run_expected_exit_test "all files exits 0" "$F_TOOL -a $testdir" 0
    run_expected_exit_test "reverse exits 0" "$F_TOOL -r $testdir" 0
    run_expected_test "one per line" "$F_TOOL -1 $testdir" "$(printf 'afile.txt\nbfile.txt\ncdir')"
    run_expected_exit_test "nonexistent dir fails" "$F_TOOL /tmp/nonexistent_dir_functional_test 2>/dev/null" 2
    rm -rf "$testdir"
    finish_test_suite
}
run_ls_functional_tests
