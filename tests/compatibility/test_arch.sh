#!/usr/bin/env bash
# Compatibility tests for farch vs GNU arch
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="arch"
F_TOOL="farch"

run_arch_tests() {
    init_test_suite "arch"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"arch","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/arch_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU arch not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    run_test "machine architecture" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "matches uname -m" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "exit code 0" \
        "$GNU_TOOL > /dev/null && echo 'EXIT_OK'" \
        "$F_TOOL > /dev/null && echo 'EXIT_OK'"

    run_test "single line output" \
        "$GNU_TOOL | wc -l" \
        "$F_TOOL | wc -l"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "extra arguments" \
        "$GNU_TOOL extra_arg 2>&1" \
        "$F_TOOL extra_arg 2>&1"

    finish_test_suite
}

run_arch_tests
