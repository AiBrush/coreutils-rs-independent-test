#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fjoin"
run_join_functional_tests() {
    init_test_suite "join"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"join","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/join_results.json"
        return 0
    fi
    local f1 f2
    f1=$(mktemp /tmp/fcoreutils_join1_XXXXXX)
    f2=$(mktemp /tmp/fcoreutils_join2_XXXXXX)
    printf "1 apple\n2 banana\n3 cherry\n" > "$f1"
    printf "1 red\n2 yellow\n4 purple\n" > "$f2"
    run_expected_test "default join" "$F_TOOL $f1 $f2" "$(printf '1 apple red\n2 banana yellow')"
    run_expected_test "unpaired from file1" "$F_TOOL -a 1 $f1 $f2" "$(printf '1 apple red\n2 banana yellow\n3 cherry')"
    run_expected_test "unpaired from file2" "$F_TOOL -a 2 $f1 $f2" "$(printf '1 apple red\n2 banana yellow\n4 purple')"
    rm -f "$f1" "$f2"
    run_expected_exit_test "exits 0" "$F_TOOL <(printf '1 a\n') <(printf '1 b\n')" 0
    finish_test_suite
}
run_join_functional_tests
