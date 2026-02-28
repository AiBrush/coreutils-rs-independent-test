#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fcomm"
run_comm_functional_tests() {
    init_test_suite "comm"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"comm","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/comm_results.json"
        return 0
    fi
    local f1 f2
    f1=$(mktemp /tmp/fcoreutils_comm1_XXXXXX)
    f2=$(mktemp /tmp/fcoreutils_comm2_XXXXXX)
    printf "a\nb\nc\n" > "$f1"
    printf "b\nc\nd\n" > "$f2"
    run_expected_test "default output" "$F_TOOL $f1 $f2" "$(printf 'a\n\t\tb\n\t\tc\n\td')"
    run_expected_test "suppress col 1" "$F_TOOL -1 $f1 $f2" "$(printf '\tb\n\tc\nd')"
    run_expected_test "suppress col 2" "$F_TOOL -2 $f1 $f2" "$(printf 'a\n\tb\n\tc')"
    run_expected_test "suppress col 3" "$F_TOOL -3 $f1 $f2" "$(printf 'a\n\td')"
    run_expected_test "only common lines" "$F_TOOL -12 $f1 $f2" "$(printf 'b\nc')"
    rm -f "$f1" "$f2"
    run_expected_exit_test "exits 0" "$F_TOOL <(printf 'a\n') <(printf 'a\n')" 0
    finish_test_suite
}
run_comm_functional_tests
