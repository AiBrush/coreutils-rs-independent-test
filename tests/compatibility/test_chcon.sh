#!/usr/bin/env bash
# Compatibility tests for fchcon vs GNU chcon
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

init_test_suite "chcon"

if ! check_tool_exists "fchcon"; then
    echo '{"tool":"chcon","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chcon_results.json"
    exit 0
fi

skip_test "chcon basic" "Not yet implemented / requires SELinux environment"

finish_test_suite
