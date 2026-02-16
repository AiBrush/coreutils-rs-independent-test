#!/usr/bin/env bash
# Compatibility tests for ftrue vs GNU true
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="true"
F_TOOL="ftrue"

run_true_tests() {
    init_test_suite "true"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"true","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/true_results.json"
        return 0
    fi

    echo ""
    echo "=== Exit Code ==="

    run_test "exit code 0" \
        "$GNU_TOOL; echo \$?" \
        "$F_TOOL; echo \$?"

    run_test "always succeeds" \
        "$GNU_TOOL && echo 'SUCCESS'" \
        "$F_TOOL && echo 'SUCCESS'"

    echo ""
    echo "=== No Output ==="

    run_test "no stdout" \
        "$GNU_TOOL 2>/dev/null | wc -c" \
        "$F_TOOL 2>/dev/null | wc -c"

    echo ""
    echo "=== Ignores Arguments ==="

    run_test "with random args" \
        "$GNU_TOOL foo bar baz; echo \$?" \
        "$F_TOOL foo bar baz; echo \$?"

    run_test "with flags" \
        "$GNU_TOOL --help 2>/dev/null; echo \$?" \
        "$F_TOOL --help 2>/dev/null; echo \$?"

    run_test "with dashes" \
        "$GNU_TOOL -- --invalid; echo \$?" \
        "$F_TOOL -- --invalid; echo \$?"

    echo ""
    echo "=== Pipeline Usage ==="

    run_test "in if statement" \
        "if $GNU_TOOL; then echo 'YES'; else echo 'NO'; fi" \
        "if $F_TOOL; then echo 'YES'; else echo 'NO'; fi"

    run_test "in && chain" \
        "$GNU_TOOL && echo 'CHAINED'" \
        "$F_TOOL && echo 'CHAINED'"

    finish_test_suite
}

run_true_tests
