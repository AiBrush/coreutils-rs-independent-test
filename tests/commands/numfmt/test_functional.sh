#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fnumfmt"
run_numfmt_functional_tests() {
    init_test_suite "numfmt"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"numfmt","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/numfmt_results.json"
        return 0
    fi
    run_expected_stdin_test "to iec" "$F_TOOL --to=iec" "1048576" "1.0M"
    run_expected_stdin_test "from iec" "$F_TOOL --from=iec" "1M" "1048576"
    run_expected_stdin_test "to si" "$F_TOOL --to=si" "1000000" "1.0M"
    run_expected_test "direct arg" "$F_TOOL --to=iec 1048576" "1.0M"
    run_expected_exit_test "exits 0" "printf '1000' | $F_TOOL --to=si" 0
    finish_test_suite
}
run_numfmt_functional_tests
