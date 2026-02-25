#!/usr/bin/env bash
# Compatibility tests for fkill vs GNU kill
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

init_test_suite "kill"

if ! check_tool_exists "fkill"; then
    echo '{"tool":"kill","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/kill_results.json"
    exit 0
fi

skip_test "kill basic" "Not yet implemented / tests pending"

run_gnu_upstream_tests "kill"

finish_test_suite
