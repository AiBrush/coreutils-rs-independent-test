#!/usr/bin/env bash
# Compatibility tests for fnohup vs GNU nohup
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="nohup"
F_TOOL="fnohup"

run_nohup_tests() {
    init_test_suite "nohup"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nohup","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/nohup_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU nohup not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_nohup_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic Usage ==="

    run_test "run simple command" \
        "cd '$WORK_DIR' && $GNU_TOOL echo 'hello' 2>/dev/null && cat nohup.out 2>/dev/null && rm -f nohup.out" \
        "cd '$WORK_DIR' && $F_TOOL echo 'hello' 2>/dev/null && cat nohup.out 2>/dev/null && rm -f nohup.out"

    run_test "exit code passthrough" \
        "$GNU_TOOL true 2>/dev/null; echo \$?" \
        "$F_TOOL true 2>/dev/null; echo \$?"

    run_test "nonzero exit code" \
        "$GNU_TOOL false 2>/dev/null; echo \$?" \
        "$F_TOOL false 2>/dev/null; echo \$?"

    echo ""
    echo "=== Output Handling ==="

    run_test "stdout to nohup.out when not terminal" \
        "cd '$WORK_DIR' && $GNU_TOOL sh -c 'echo test_output' > /dev/null 2>&1 && cat nohup.out 2>/dev/null && rm -f nohup.out" \
        "cd '$WORK_DIR' && $F_TOOL sh -c 'echo test_output' > /dev/null 2>&1 && cat nohup.out 2>/dev/null && rm -f nohup.out"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "nonexistent command" \
        "$GNU_TOOL /nonexistent_cmd_$$ 2>&1" \
        "$F_TOOL /nonexistent_cmd_$$ 2>&1"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_nohup_tests
