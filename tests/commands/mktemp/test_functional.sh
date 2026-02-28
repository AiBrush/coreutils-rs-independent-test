#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fmktemp"
run_mktemp_functional_tests() {
    init_test_suite "mktemp"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mktemp","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mktemp_results.json"
        return 0
    fi
    run_expected_exit_test "create temp file" "$F_TOOL" 0
    run_expected_exit_test "create temp dir" "$F_TOOL -d" 0
    local tmpf
    tmpf=$($F_TOOL 2>/dev/null) && rm -f "$tmpf"
    local tmpd
    tmpd=$($F_TOOL -d 2>/dev/null) && rm -rf "$tmpd"
    finish_test_suite
}
run_mktemp_functional_tests
