#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fsha1sum"
run_sha1sum_functional_tests() {
    init_test_suite "sha1sum"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha1sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha1sum_results.json"
        return 0
    fi
    # Known value tests
    run_expected_stdin_test "known value empty" "$F_TOOL" "" "da39a3ee5e6b4b0d3255bfef95601890afd80709  -"
    run_expected_stdin_test "known value abc" "$F_TOOL" "abc" "a9993e364706816aba3e25717850c26c9cd0d89d  -"
    run_expected_stdin_test "hello newline" "$F_TOOL" "$(printf 'hello\n')" "f572d396fae9206628714fb2ce00f72e94f2258f  -"

    # Exit code tests
    run_expected_exit_test "exits 0" "printf 'test' | $F_TOOL" 0
    run_expected_exit_test "nonexistent file fails" "$F_TOOL /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    run_expected_exit_test "--help exits 0" "$F_TOOL --help > /dev/null 2>&1" 0
    run_expected_exit_test "--version exits 0" "$F_TOOL --version > /dev/null 2>&1" 0

    # File hashing tests
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_sha1sum_func_XXXXXX)
    register_temp "$test_dir"

    echo -n "abc" > "$test_dir/abc.txt"
    run_expected_test "file hash abc" "$F_TOOL '$test_dir/abc.txt'" "a9993e364706816aba3e25717850c26c9cd0d89d"

    printf '' > "$test_dir/empty.txt"
    run_expected_test "file hash empty" "$F_TOOL '$test_dir/empty.txt'" "da39a3ee5e6b4b0d3255bfef95601890afd80709"

    # Binary mode
    run_expected_exit_test "-b exits 0" "$F_TOOL -b '$test_dir/abc.txt' > /dev/null" 0

    # Tag mode output format
    run_expected_test "tag mode format" "$F_TOOL --tag '$test_dir/abc.txt'" "SHA1"

    # Check mode
    $F_TOOL "$test_dir/abc.txt" > "$test_dir/checksums.txt"
    run_expected_exit_test "-c valid exits 0" "$F_TOOL -c '$test_dir/checksums.txt'" 0

    echo "0000000000000000000000000000000000000000  $test_dir/abc.txt" > "$test_dir/bad_checksums.txt"
    run_expected_exit_test "-c invalid exits 1" "$F_TOOL -c '$test_dir/bad_checksums.txt' 2>/dev/null" 1

    # Zero-terminated
    run_expected_exit_test "-z exits 0" "$F_TOOL -z '$test_dir/abc.txt' > /dev/null" 0

    # Multiple files
    echo -n "def" > "$test_dir/def.txt"
    run_expected_exit_test "multiple files exit 0" "$F_TOOL '$test_dir/abc.txt' '$test_dir/def.txt' > /dev/null" 0

    # Stdin via dash
    run_expected_stdin_test "stdin via dash" "$F_TOOL -" "abc" "a9993e364706816aba3e25717850c26c9cd0d89d  -"

    rm -rf "$test_dir"
    finish_test_suite
}
run_sha1sum_functional_tests
