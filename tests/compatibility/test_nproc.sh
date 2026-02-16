#!/usr/bin/env bash
# Compatibility tests for fnproc vs GNU nproc
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="nproc"
F_TOOL="fnproc"

run_nproc_tests() {
    init_test_suite "nproc"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nproc","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/nproc_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU nproc not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    run_test "default processor count" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "output is positive integer" \
        "$GNU_TOOL | grep -cE '^[1-9][0-9]*$'" \
        "$F_TOOL | grep -cE '^[1-9][0-9]*$'"

    run_test "exit code 0" \
        "$GNU_TOOL > /dev/null && echo 'EXIT_OK'" \
        "$F_TOOL > /dev/null && echo 'EXIT_OK'"

    echo ""
    echo "=== All Processors (--all) ==="

    run_test "--all processors" \
        "$GNU_TOOL --all" \
        "$F_TOOL --all"

    echo ""
    echo "=== Ignore (--ignore) ==="

    run_test "--ignore=0" \
        "$GNU_TOOL --ignore=0" \
        "$F_TOOL --ignore=0"

    run_test "--ignore=1" \
        "$GNU_TOOL --ignore=1" \
        "$F_TOOL --ignore=1"

    # Ignore more than available (should return 1)
    run_test "--ignore=9999 (clamp to 1)" \
        "$GNU_TOOL --ignore=9999" \
        "$F_TOOL --ignore=9999"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "invalid option" \
        "$GNU_TOOL --invalid-option 2>&1" \
        "$F_TOOL --invalid-option 2>&1"

    finish_test_suite
}

run_nproc_tests
