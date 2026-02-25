#!/usr/bin/env bash
# Compatibility tests for fdir vs GNU dir
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

init_test_suite "dir"

if ! check_tool_exists "fdir"; then
    echo '{"tool":"dir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/dir_results.json"
    exit 0
fi

skip_test "dir basic" "Not yet implemented / tests pending"

run_gnu_upstream_tests "dir"

finish_test_suite
