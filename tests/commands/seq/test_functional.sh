#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fseq"
run_seq_functional_tests() {
    init_test_suite "seq"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"seq","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/seq_results.json"
        return 0
    fi
    run_expected_test "seq 5" "$F_TOOL 5" "$(printf '1\n2\n3\n4\n5')"
    run_expected_test "seq 3 7" "$F_TOOL 3 7" "$(printf '3\n4\n5\n6\n7')"
    run_expected_test "seq 2 2 10" "$F_TOOL 2 2 10" "$(printf '2\n4\n6\n8\n10')"
    run_expected_test "seq 1 1" "$F_TOOL 1 1" "1"
    run_expected_test "seq with separator" "$F_TOOL -s, 3" "1,2,3"
    run_expected_test "seq equal width" "$F_TOOL -w 8 10" "$(printf '08\n09\n10')"
    run_expected_test "seq reverse" "$F_TOOL 5 -1 1" "$(printf '5\n4\n3\n2\n1')"
    run_expected_test "seq single value" "$F_TOOL 1" "1"
    run_expected_exit_test "exits 0" "$F_TOOL 3" 0
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    finish_test_suite
}
run_seq_functional_tests
