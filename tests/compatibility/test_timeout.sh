#!/usr/bin/env bash
# Compatibility tests for ftimeout vs GNU timeout
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="timeout"
F_TOOL="ftimeout"

run_timeout_tests() {
    init_test_suite "timeout"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"timeout","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/timeout_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU timeout not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Timeout (command completes in time) ==="

    run_test "command finishes before timeout" \
        "$GNU_TOOL 10 echo 'hello'" \
        "$F_TOOL 10 echo 'hello'"

    run_test "exit code 0 on success" \
        "$GNU_TOOL 10 true; echo \$?" \
        "$F_TOOL 10 true; echo \$?"

    run_test "preserves exit code of command" \
        "$GNU_TOOL 10 sh -c 'exit 42'; echo \$?" \
        "$F_TOOL 10 sh -c 'exit 42'; echo \$?"

    echo ""
    echo "=== Timeout Triggered ==="

    run_test "kill on timeout (exit 124)" \
        "$GNU_TOOL 0.1 sleep 100; echo \$?" \
        "$F_TOOL 0.1 sleep 100; echo \$?"

    run_test "timeout with fractional seconds" \
        "$GNU_TOOL 0.5 sleep 100; echo \$?" \
        "$F_TOOL 0.5 sleep 100; echo \$?"

    echo ""
    echo "=== Duration Suffixes ==="

    run_test "seconds suffix (s)" \
        "$GNU_TOOL 1s echo 'ok'" \
        "$F_TOOL 1s echo 'ok'"

    run_test "minutes suffix (m)" \
        "$GNU_TOOL 1m echo 'ok'" \
        "$F_TOOL 1m echo 'ok'"

    echo ""
    echo "=== Signal Options (--signal) ==="

    run_test "--signal TERM" \
        "$GNU_TOOL --signal=TERM 0.1 sleep 100; echo \$?" \
        "$F_TOOL --signal=TERM 0.1 sleep 100; echo \$?"

    run_test "--signal KILL" \
        "$GNU_TOOL --signal=KILL 0.1 sleep 100; echo \$?" \
        "$F_TOOL --signal=KILL 0.1 sleep 100; echo \$?"

    run_test "-s 9 (KILL)" \
        "$GNU_TOOL -s 9 0.1 sleep 100; echo \$?" \
        "$F_TOOL -s 9 0.1 sleep 100; echo \$?"

    echo ""
    echo "=== Kill After (--kill-after / -k) ==="

    run_test "--kill-after backup kill" \
        "$GNU_TOOL --kill-after=0.1 0.1 sleep 100; echo \$?" \
        "$F_TOOL --kill-after=0.1 0.1 sleep 100; echo \$?"

    echo ""
    echo "=== Foreground (--foreground) ==="

    run_test "--foreground mode" \
        "$GNU_TOOL --foreground 10 echo 'fg mode'" \
        "$F_TOOL --foreground 10 echo 'fg mode'"

    echo ""
    echo "=== Preserve Status (--preserve-status) ==="

    run_test "--preserve-status" \
        "$GNU_TOOL --preserve-status 0.1 sleep 100; echo \$?" \
        "$F_TOOL --preserve-status 0.1 sleep 100; echo \$?"

    echo ""
    echo "=== Verbose (-v) ==="

    run_stdout_test "-v verbose timeout" \
        "$GNU_TOOL -v 0.1 sleep 100 2>/dev/null; echo \$?" \
        "$F_TOOL -v 0.1 sleep 100 2>/dev/null; echo \$?"

    echo ""
    echo "=== Edge Cases ==="

    run_test "zero timeout" \
        "$GNU_TOOL 0 echo 'zero'; echo \$?" \
        "$F_TOOL 0 echo 'zero'; echo \$?"

    run_test "command with args" \
        "$GNU_TOOL 10 sh -c 'echo one; echo two; echo three'" \
        "$F_TOOL 10 sh -c 'echo one; echo two; echo three'"

    run_test "stdout and stderr" \
        "$GNU_TOOL 10 sh -c 'echo out; echo err >&2' 2>&1" \
        "$F_TOOL 10 sh -c 'echo out; echo err >&2' 2>&1"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "missing command" \
        "$GNU_TOOL 10 2>&1" \
        "$F_TOOL 10 2>&1"

    run_exit_code_test "invalid duration" \
        "$GNU_TOOL abc echo test 2>&1" \
        "$F_TOOL abc echo test 2>&1"

    run_exit_code_test "nonexistent command" \
        "$GNU_TOOL 10 /nonexistent_cmd_$$ 2>&1" \
        "$F_TOOL 10 /nonexistent_cmd_$$ 2>&1"

    finish_test_suite
}

run_timeout_tests
