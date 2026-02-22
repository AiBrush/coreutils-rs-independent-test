#!/usr/bin/env bash
# Compatibility tests for fvdir vs GNU vdir
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

init_test_suite "vdir"

if ! check_tool_exists "fvdir"; then
    echo '{"tool":"vdir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/vdir_results.json"
    exit 0
fi

skip_test "vdir basic" "Not yet implemented / tests pending"

finish_test_suite
