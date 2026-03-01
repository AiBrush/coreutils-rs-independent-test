#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fsha384sum"
run_sha384sum_functional_tests() {
    init_test_suite "sha384sum"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha384sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha384sum_results.json"
        return 0
    fi
    # Known value tests
    run_expected_stdin_test "known value empty" "$F_TOOL" "" "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b  -"
    run_expected_stdin_test "known value abc" "$F_TOOL" "abc" "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7  -"

    # Exit code tests
    run_expected_exit_test "exits 0" "printf 'test' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    run_expected_exit_test "--help exits 0" "$F_TOOL --help > /dev/null 2>&1" 0
    run_expected_exit_test "--version exits 0" "$F_TOOL --version > /dev/null 2>&1" 0

    # File hashing tests
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_sha384sum_func_XXXXXX)
    register_temp "$test_dir"

    echo -n "abc" > "$test_dir/abc.txt"
    run_expected_test "file hash abc" "$F_TOOL '$test_dir/abc.txt'" "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7"

    printf '' > "$test_dir/empty.txt"
    run_expected_test "file hash empty" "$F_TOOL '$test_dir/empty.txt'" "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b"

    # Binary mode
    run_expected_exit_test "-b exits 0" "$F_TOOL -b '$test_dir/abc.txt' > /dev/null" 0

    # Tag mode output format
    run_expected_test "tag mode format" "$F_TOOL --tag '$test_dir/abc.txt'" "SHA384"

    # Check mode
    $F_TOOL "$test_dir/abc.txt" > "$test_dir/checksums.txt"
    run_expected_exit_test "-c valid exits 0" "$F_TOOL -c '$test_dir/checksums.txt'" 0

    echo "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000  $test_dir/abc.txt" > "$test_dir/bad_checksums.txt"
    run_expected_exit_test "-c invalid exits 1" "$F_TOOL -c '$test_dir/bad_checksums.txt' 2>/dev/null" 1

    # Zero-terminated
    run_expected_exit_test "-z exits 0" "$F_TOOL -z '$test_dir/abc.txt' > /dev/null" 0

    # Multiple files
    echo -n "def" > "$test_dir/def.txt"
    run_expected_exit_test "multiple files exit 0" "$F_TOOL '$test_dir/abc.txt' '$test_dir/def.txt' > /dev/null" 0

    # Stdin via dash
    run_expected_stdin_test "stdin via dash" "$F_TOOL -" "abc" "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7  -"

    rm -rf "$test_dir"
    finish_test_suite
}
run_sha384sum_functional_tests
