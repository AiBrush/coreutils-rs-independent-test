#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fpaste"
run_paste_functional_tests() {
    init_test_suite "paste"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"paste","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/paste_results.json"
        return 0
    fi
    local f1 f2
    f1=$(mktemp /tmp/fcoreutils_paste1_XXXXXX)
    f2=$(mktemp /tmp/fcoreutils_paste2_XXXXXX)
    printf "a\nb\nc\n" > "$f1"
    printf "1\n2\n3\n" > "$f2"
    run_expected_test "default merge" "$F_TOOL $f1 $f2" "$(printf 'a\t1\nb\t2\nc\t3')"
    run_expected_test "custom delimiter" "$F_TOOL -d, $f1 $f2" "$(printf 'a,1\nb,2\nc,3')"
    run_expected_stdin_test "serial mode" "$F_TOOL -s" "$(printf 'a\nb\nc')" "$(printf 'a\tb\tc')"
    run_expected_stdin_test "serial with delimiter" "$F_TOOL -s -d," "$(printf 'a\nb\nc')" "a,b,c"
    rm -f "$f1" "$f2"
    run_expected_exit_test "exits 0" "printf 'a' | $F_TOOL" 0
    finish_test_suite
}
run_paste_functional_tests
