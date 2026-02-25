#!/usr/bin/env bash
# Compatibility tests for ffalse vs GNU false
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "false")
F_TOOL="ffalse"

run_false_tests() {
    init_test_suite "false"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"false","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/false_results.json"
        return 0
    fi

    echo ""
    echo "=== Exit Code ==="

    run_test "exit code 1" \
        "$GNU_TOOL; echo \$?" \
        "$F_TOOL; echo \$?"

    run_test "always fails" \
        "$GNU_TOOL || echo 'FAILED'" \
        "$F_TOOL || echo 'FAILED'"

    echo ""
    echo "=== No Output ==="

    run_test "no stdout" \
        "$GNU_TOOL 2>/dev/null | wc -c; true" \
        "$F_TOOL 2>/dev/null | wc -c; true"

    echo ""
    echo "=== Ignores Arguments ==="

    run_test "with random args" \
        "$GNU_TOOL foo bar baz; echo \$?" \
        "$F_TOOL foo bar baz; echo \$?"

    run_test "with flags" \
        "$GNU_TOOL --help 2>/dev/null; echo \$?" \
        "$F_TOOL --help 2>/dev/null; echo \$?"

    echo ""
    echo "=== Pipeline Usage ==="

    run_test "in if statement" \
        "if $GNU_TOOL; then echo 'YES'; else echo 'NO'; fi" \
        "if $F_TOOL; then echo 'YES'; else echo 'NO'; fi"

    run_test "in || chain" \
        "$GNU_TOOL || echo 'FALLBACK'" \
        "$F_TOOL || echo 'FALLBACK'"

    # === GNU Upstream: Nonzero Exit with --help/--version ===
    echo ""
    echo "=== GNU Upstream: Nonzero Exit with --help/--version ==="

    run_exit_code_test "--version exits nonzero" \
        "$GNU_TOOL --version > /dev/null 2>&1" \
        "$F_TOOL --version > /dev/null 2>&1"

    run_exit_code_test "--help exits nonzero" \
        "$GNU_TOOL --help > /dev/null 2>&1" \
        "$F_TOOL --help > /dev/null 2>&1"


    finish_test_suite
}

run_false_tests
