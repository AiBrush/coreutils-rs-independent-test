#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fnohup"
run_nohup_functional_tests() {
    init_test_suite "nohup"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nohup","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/nohup_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 127
    run_expected_exit_test "run true exits 0" "$F_TOOL true 2>/dev/null" 0
    finish_test_suite
}
run_nohup_functional_tests
