#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fdate"
run_date_functional_tests() {
    init_test_suite "date"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"date","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/date_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    run_expected_test "epoch 0 UTC" "TZ=UTC $F_TOOL -d @0 +%Y-%m-%d" "1970-01-01"
    run_expected_test "epoch 0 time" "TZ=UTC $F_TOOL -d @0 +%H:%M:%S" "00:00:00"
    run_expected_test "specific date" "TZ=UTC $F_TOOL -d '2024-01-15 12:30:00' +%Y-%m-%d" "2024-01-15"
    run_expected_test "format year only" "TZ=UTC $F_TOOL -d @0 +%Y" "1970"
    finish_test_suite
}
run_date_functional_tests
