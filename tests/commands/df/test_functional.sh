#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fdf"
run_df_functional_tests() {
    init_test_suite "df"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"df","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/df_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    run_expected_exit_test "human readable exits 0" "$F_TOOL -h" 0
    run_expected_exit_test "specific path exits 0" "$F_TOOL /" 0
    finish_test_suite
}
run_df_functional_tests
