#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fchcon"
run_chcon_functional_tests() {
    init_test_suite "chcon"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chcon","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chcon_results.json"
        return 0
    fi
    skip_test "chcon requires SELinux" "requires SELinux support"
    finish_test_suite
}
run_chcon_functional_tests
