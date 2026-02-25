#!/usr/bin/env bash
# Compatibility tests for fruncon vs GNU runcon
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

init_test_suite "runcon"

if ! check_tool_exists "fruncon"; then
    echo '{"tool":"runcon","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/runcon_results.json"
    exit 0
fi

skip_test "runcon basic" "Not yet implemented / requires SELinux environment"

run_gnu_upstream_tests "runcon"

finish_test_suite
