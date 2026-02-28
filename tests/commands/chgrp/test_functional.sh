#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fchgrp"
run_chgrp_functional_tests() {
    init_test_suite "chgrp"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chgrp","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chgrp_results.json"
        return 0
    fi
    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1
    run_expected_exit_test "nonexistent file fails" "$F_TOOL root /tmp/nonexistent_file_functional_test 2>/dev/null" 1
    finish_test_suite
}
run_chgrp_functional_tests
