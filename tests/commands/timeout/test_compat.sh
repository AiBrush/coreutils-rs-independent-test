#!/usr/bin/env bash
# Compatibility tests for ftimeout vs GNU timeout
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "timeout")
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

    # Use run_stdout_test to suppress shell "Killed" diagnostic messages
    # that differ between command names (timeout vs ftimeout) and PIDs
    run_stdout_test "--signal KILL" \
        "$GNU_TOOL --signal=KILL 0.1 sleep 100 2>/dev/null; echo \$?" \
        "$F_TOOL --signal=KILL 0.1 sleep 100 2>/dev/null; echo \$?"

    run_stdout_test "-s 9 (KILL)" \
        "$GNU_TOOL -s 9 0.1 sleep 100 2>/dev/null; echo \$?" \
        "$F_TOOL -s 9 0.1 sleep 100 2>/dev/null; echo \$?"

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
    echo "=== GNU Upstream: Duration Formats (timeout.sh, timeout-parameters.sh) ==="

    # From timeout.sh: day suffix
    run_test "1d day suffix" \
        "$GNU_TOOL 1d true; echo \$?" \
        "$F_TOOL 1d true; echo \$?"

    # From timeout.sh: disabled timeout with 0
    run_test "disabled timeout 0 true" \
        "$GNU_TOOL 0 true; echo \$?" \
        "$F_TOOL 0 true; echo \$?"

    # From timeout-parameters.sh: floating point notation
    run_test "floating point 10.34" \
        "$GNU_TOOL 10.34 true; echo \$?" \
        "$F_TOOL 10.34 true; echo \$?"

    # From timeout-parameters.sh: nanosecond precision
    run_test "nanosecond precision 9.999999999" \
        "$GNU_TOOL 9.999999999 true; echo \$?" \
        "$F_TOOL 9.999999999 true; echo \$?"

    echo ""
    echo "=== GNU Upstream: Exit Code Propagation (timeout.sh) ==="

    # From timeout.sh: exit status propagation
    run_test "exit code 2 propagation" \
        "$GNU_TOOL 10 sh -c 'exit 2'; echo \$?" \
        "$F_TOOL 10 sh -c 'exit 2'; echo \$?"

    # From timeout.sh: exit status propagation on timeout with --preserve-status
    # The exit status should be 128+SIGTERM (143 on most systems)
    run_stdout_test "--preserve-status gives 128+signal" \
        "$GNU_TOOL --preserve-status 0.1 sleep 10 2>/dev/null; echo \$?" \
        "$F_TOOL --preserve-status 0.1 sleep 10 2>/dev/null; echo \$?"

    echo ""
    echo "=== GNU Upstream: Kill-After with Signal 0 (timeout.sh) ==="

    # From timeout.sh: -s0 -k1 .1 - send signal 0 first, then KILL after delay
    run_stdout_test "-s0 -k1 send sig 0 then KILL" \
        "$GNU_TOOL -s0 -k1 0.1 sleep 10 2>/dev/null; echo \$?" \
        "$F_TOOL -s0 -k1 0.1 sleep 10 2>/dev/null; echo \$?"

    # From timeout.sh: --foreground with -s0 -k1
    run_stdout_test "--foreground -s0 -k1" \
        "$GNU_TOOL --foreground -s0 -k1 0.1 sleep 10 2>/dev/null; echo \$?" \
        "$F_TOOL --foreground -s0 -k1 0.1 sleep 10 2>/dev/null; echo \$?"

    echo ""
    echo "=== GNU Upstream: Parameter Validation (timeout-parameters.sh) ==="

    # From timeout-parameters.sh: invalid timeout string
    run_exit_code_test "invalid timeout string" \
        "$GNU_TOOL invalid sleep 0 2>&1" \
        "$F_TOOL invalid sleep 0 2>&1"

    # From timeout-parameters.sh: negative timeout
    run_exit_code_test "negative timeout -0.1" \
        "$GNU_TOOL ' -0.1' sleep 0 2>&1" \
        "$F_TOOL ' -0.1' sleep 0 2>&1"

    # From timeout-parameters.sh: invalid kill-after
    run_exit_code_test "invalid --kill-after value" \
        "$GNU_TOOL --kill-after=invalid 1 sleep 0 2>&1" \
        "$F_TOOL --kill-after=invalid 1 sleep 0 2>&1"

    # From timeout-parameters.sh: invalid suffix
    run_exit_code_test "invalid duration suffix 42D" \
        "$GNU_TOOL 42D sleep 0 2>&1" \
        "$F_TOOL 42D sleep 0 2>&1"

    # From timeout-parameters.sh: invalid signal spec
    run_exit_code_test "invalid signal spec" \
        "$GNU_TOOL --signal=invalid 1 sleep 0 2>&1" \
        "$F_TOOL --signal=invalid 1 sleep 0 2>&1"

    # From timeout-parameters.sh: no such command returns 127
    run_exit_code_test "no such command exits 127" \
        "$GNU_TOOL 10 no_such_cmd_$$ 2>&1" \
        "$F_TOOL 10 no_such_cmd_$$ 2>&1"

    echo ""
    echo "=== GNU Upstream: SIGCHLD Immunity (timeout.sh) ==="

    # From timeout.sh: timeout is immune to parent SIGCHLD handler
    run_test "immune to parent SIGCHLD" \
        "sh -c 'trap \"\" CHLD; $GNU_TOOL 10 true; echo \$?'" \
        "sh -c 'trap \"\" CHLD; $F_TOOL 10 true; echo \$?'"

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
