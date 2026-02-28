#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fcut"
run_cut_functional_tests() {
    init_test_suite "cut"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cut","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/cut_results.json"
        return 0
    fi
    run_expected_stdin_test "bytes 1-3" "$F_TOOL -b1-3" "hello" "hel"
    run_expected_stdin_test "chars 1-3" "$F_TOOL -c1-3" "hello" "hel"
    run_expected_stdin_test "field 1 tab delim" "$F_TOOL -f1" "$(printf 'a\tb\tc')" "a"
    run_expected_stdin_test "field 2 tab delim" "$F_TOOL -f2" "$(printf 'a\tb\tc')" "b"
    run_expected_stdin_test "field 1-2 comma delim" "$F_TOOL -d, -f1-2" "a,b,c" "a,b"
    run_expected_stdin_test "field 3 comma delim" "$F_TOOL -d, -f3" "a,b,c" "c"
    run_expected_stdin_test "complement bytes" "$F_TOOL -b1-3 --complement" "hello" "lo"
    run_expected_stdin_test "only delimited" "$F_TOOL -d, -f1 -s" "$(printf 'a,b\nnodelete')" "a"
    run_expected_stdin_test "multiline" "$F_TOOL -d, -f2" "$(printf 'a,1\nb,2\nc,3')" "$(printf '1\n2\n3')"
    run_expected_stdin_test "byte range open end" "$F_TOOL -b3-" "hello" "llo"
    run_expected_stdin_test "byte range open start" "$F_TOOL -b-3" "hello" "hel"
    run_expected_exit_test "exits 0" "printf \"hello\" | $F_TOOL -b1" 0
    run_expected_exit_test "no flags fails" "printf \"hello\" | $F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_cut_functional_tests
