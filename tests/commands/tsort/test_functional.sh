#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="ftsort"
run_tsort_functional_tests() {
    init_test_suite "tsort"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tsort","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tsort_results.json"
        return 0
    fi
    run_expected_stdin_test "simple dag" "$F_TOOL" "$(printf 'a b\nb c')" "$(printf 'a\nb\nc')"
    run_expected_stdin_test "single pair" "$F_TOOL" "a b" "$(printf 'a\nb')"
    run_expected_exit_test "exits 0" "printf 'a b\n' | $F_TOOL" 0
    finish_test_suite
}
run_tsort_functional_tests
