#!/usr/bin/env bash
# Compatibility tests for fprintenv vs GNU printenv
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

init_test_suite "printenv"

if ! check_tool_exists "fprintenv"; then
    echo '{"tool":"printenv","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/printenv_results.json"
    exit 0
fi

skip_test "printenv basic" "Not yet implemented / tests pending"

finish_test_suite
