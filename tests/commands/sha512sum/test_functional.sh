#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fsha512sum"
run_sha512sum_functional_tests() {
    init_test_suite "sha512sum"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha512sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha512sum_results.json"
        return 0
    fi
    # Known value tests
    run_expected_stdin_test "known value empty" "$F_TOOL" "" "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e  -"
    run_expected_stdin_test "known value abc" "$F_TOOL" "abc" "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f  -"

    # Exit code tests
    run_expected_exit_test "exits 0" "printf 'test' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    run_expected_exit_test "--help exits 0" "$F_TOOL --help > /dev/null 2>&1" 0
    run_expected_exit_test "--version exits 0" "$F_TOOL --version > /dev/null 2>&1" 0

    # File hashing tests
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_sha512sum_func_XXXXXX)
    register_temp "$test_dir"

    echo -n "abc" > "$test_dir/abc.txt"
    run_expected_test "file hash abc" "$F_TOOL '$test_dir/abc.txt'" "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f"

    printf '' > "$test_dir/empty.txt"
    run_expected_test "file hash empty" "$F_TOOL '$test_dir/empty.txt'" "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e"

    # Binary mode
    run_expected_exit_test "-b exits 0" "$F_TOOL -b '$test_dir/abc.txt' > /dev/null" 0

    # Tag mode output format
    run_expected_test "tag mode format" "$F_TOOL --tag '$test_dir/abc.txt'" "SHA512"

    # Check mode
    $F_TOOL "$test_dir/abc.txt" > "$test_dir/checksums.txt"
    run_expected_exit_test "-c valid exits 0" "$F_TOOL -c '$test_dir/checksums.txt'" 0

    echo "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000  $test_dir/abc.txt" > "$test_dir/bad_checksums.txt"
    run_expected_exit_test "-c invalid exits 1" "$F_TOOL -c '$test_dir/bad_checksums.txt' 2>/dev/null" 1

    # Zero-terminated
    run_expected_exit_test "-z exits 0" "$F_TOOL -z '$test_dir/abc.txt' > /dev/null" 0

    # Multiple files
    echo -n "def" > "$test_dir/def.txt"
    run_expected_exit_test "multiple files exit 0" "$F_TOOL '$test_dir/abc.txt' '$test_dir/def.txt' > /dev/null" 0

    # Stdin via dash
    run_expected_stdin_test "stdin via dash" "$F_TOOL -" "abc" "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f  -"

    rm -rf "$test_dir"
    finish_test_suite
}
run_sha512sum_functional_tests
