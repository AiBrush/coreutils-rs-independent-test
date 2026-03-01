#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fdir"

run_dir_functional_tests() {
    init_test_suite "dir"

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/dir_results.json"
        return 0
    fi

    # Create a deterministic test directory
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_dir_func_XXXXXX)
    register_temp "$test_dir"

    touch "$test_dir/alpha.txt" "$test_dir/beta.txt" "$test_dir/gamma.dat"
    mkdir "$test_dir/subdir"
    touch "$test_dir/subdir/inner.txt"
    touch "$test_dir/.hidden"

    # Basic exit code tests
    run_expected_exit_test "exits 0 on current dir" "$F_TOOL ." 0
    run_expected_exit_test "exits 0 on /tmp" "$F_TOOL /tmp" 0
    run_expected_exit_test "nonexistent dir fails" "$F_TOOL /tmp/nonexistent_dir_functional_test_$$ 2>/dev/null" 2

    # Test that dir produces output for a directory with files
    run_expected_exit_test "exits 0 on test dir" "$F_TOOL '$test_dir'" 0

    # Test various flags exit successfully
    run_expected_exit_test "-1 flag exits 0" "$F_TOOL -1 '$test_dir'" 0
    run_expected_exit_test "-l flag exits 0" "$F_TOOL -l '$test_dir'" 0
    run_expected_exit_test "-a flag exits 0" "$F_TOOL -a '$test_dir'" 0
    run_expected_exit_test "-A flag exits 0" "$F_TOOL -A '$test_dir'" 0
    run_expected_exit_test "-r flag exits 0" "$F_TOOL -r '$test_dir'" 0
    run_expected_exit_test "-R flag exits 0" "$F_TOOL -R '$test_dir'" 0
    run_expected_exit_test "-S flag exits 0" "$F_TOOL -S '$test_dir'" 0
    run_expected_exit_test "-t flag exits 0" "$F_TOOL -t '$test_dir'" 0
    run_expected_exit_test "-F flag exits 0" "$F_TOOL -F '$test_dir'" 0
    run_expected_exit_test "-i flag exits 0" "$F_TOOL -i '$test_dir'" 0
    run_expected_exit_test "-s flag exits 0" "$F_TOOL -s '$test_dir'" 0
    run_expected_exit_test "-m flag exits 0" "$F_TOOL -m '$test_dir'" 0
    run_expected_exit_test "-n flag exits 0" "$F_TOOL -n '$test_dir'" 0
    run_expected_exit_test "-d flag exits 0" "$F_TOOL -d '$test_dir'" 0
    run_expected_exit_test "-x flag exits 0" "$F_TOOL -x '$test_dir'" 0
    run_expected_exit_test "-Q flag exits 0" "$F_TOOL -Q '$test_dir'" 0
    run_expected_exit_test "--color=never exits 0" "$F_TOOL --color=never '$test_dir'" 0

    # Test empty directory
    local empty_dir
    empty_dir=$(mktemp -d /tmp/fcoreutils_dir_empty_XXXXXX)
    register_temp "$empty_dir"
    run_expected_exit_test "exits 0 on empty dir" "$F_TOOL '$empty_dir'" 0
    rm -rf "$empty_dir"

    # Combined flags
    run_expected_exit_test "-lah combined exits 0" "$F_TOOL -lah '$test_dir'" 0
    run_expected_exit_test "-1AF combined exits 0" "$F_TOOL -1AF '$test_dir'" 0
    run_expected_exit_test "-lSr combined exits 0" "$F_TOOL -lSr '$test_dir'" 0

    # Help and version
    run_expected_exit_test "--help exits 0" "$F_TOOL --help" 0
    run_expected_exit_test "--version exits 0" "$F_TOOL --version" 0

    rm -rf "$test_dir"

    finish_test_suite
}

run_dir_functional_tests
