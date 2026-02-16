#!/usr/bin/env bash
# Compatibility tests for fnice vs GNU nice
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="nice"
F_TOOL="fnice"

run_nice_tests() {
    init_test_suite "nice"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nice","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/nice_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU nice not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Default Niceness ==="

    run_test "default (no args, print niceness)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    echo ""
    echo "=== Run Command ==="

    run_test "run echo" \
        "$GNU_TOOL echo 'hello'" \
        "$F_TOOL echo 'hello'"

    run_test "run sh -c" \
        "$GNU_TOOL sh -c 'echo ok'" \
        "$F_TOOL sh -c 'echo ok'"

    run_test "exit code passthrough" \
        "$GNU_TOOL sh -c 'exit 0'; echo \$?" \
        "$F_TOOL sh -c 'exit 0'; echo \$?"

    run_test "nonzero exit code" \
        "$GNU_TOOL sh -c 'exit 42'; echo \$?" \
        "$F_TOOL sh -c 'exit 42'; echo \$?"

    echo ""
    echo "=== Adjustment (-n) ==="

    run_test "-n 5 increase niceness" \
        "$GNU_TOOL -n 5 echo 'nice 5'" \
        "$F_TOOL -n 5 echo 'nice 5'"

    run_test "-n 10" \
        "$GNU_TOOL -n 10 echo 'nice 10'" \
        "$F_TOOL -n 10 echo 'nice 10'"

    run_test "-n 0 (no change)" \
        "$GNU_TOOL -n 0 echo 'nice 0'" \
        "$F_TOOL -n 0 echo 'nice 0'"

    run_test "-n 19 (max user niceness)" \
        "$GNU_TOOL -n 19 echo 'nice 19'" \
        "$F_TOOL -n 19 echo 'nice 19'"

    # Negative niceness requires root, test error behavior
    run_exit_code_test "-n -1 (requires root)" \
        "$GNU_TOOL -n -1 echo test 2>&1" \
        "$F_TOOL -n -1 echo test 2>&1"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent command" \
        "$GNU_TOOL /nonexistent_cmd_$$ 2>&1" \
        "$F_TOOL /nonexistent_cmd_$$ 2>&1"

    run_exit_code_test "invalid adjustment" \
        "$GNU_TOOL -n abc echo test 2>&1" \
        "$F_TOOL -n abc echo test 2>&1"

    finish_test_suite
}

run_nice_tests
