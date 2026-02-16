#!/usr/bin/env bash
# Compatibility tests for fhostid vs GNU hostid
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="hostid"
F_TOOL="fhostid"

run_hostid_tests() {
    init_test_suite "hostid"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"hostid","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/hostid_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU hostid not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    run_test "host identifier" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "exit code 0" \
        "$GNU_TOOL > /dev/null && echo 'EXIT_OK'" \
        "$F_TOOL > /dev/null && echo 'EXIT_OK'"

    run_test "single line output" \
        "$GNU_TOOL | wc -l" \
        "$F_TOOL | wc -l"

    run_test "output is hex string" \
        "$GNU_TOOL | grep -cE '^[0-9a-f]+$'" \
        "$F_TOOL | grep -cE '^[0-9a-f]+$'"

    echo ""
    echo "=== Consistency ==="

    run_test "repeated calls same result" \
        "h1=\$($GNU_TOOL) && h2=\$($GNU_TOOL) && test \"\$h1\" = \"\$h2\" && echo 'CONSISTENT'" \
        "h1=\$($F_TOOL) && h2=\$($F_TOOL) && test \"\$h1\" = \"\$h2\" && echo 'CONSISTENT'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "extra arguments" \
        "$GNU_TOOL extra_arg 2>&1" \
        "$F_TOOL extra_arg 2>&1"

    finish_test_suite
}

run_hostid_tests
