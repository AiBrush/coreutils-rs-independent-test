#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fruncon"
run_runcon_functional_tests() {
    init_test_suite "runcon"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"runcon","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/runcon_results.json"
        return 0
    fi
    skip_test "runcon requires SELinux" "requires SELinux support"
    finish_test_suite
}
run_runcon_functional_tests
