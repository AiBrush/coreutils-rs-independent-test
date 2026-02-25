#!/usr/bin/env bash
# Compatibility tests for fnice vs GNU nice
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "nice")
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
    echo "=== GNU Upstream: nice-fail (Exit Status) ==="

    # From nice-fail.sh: verify exact exit status of internal failures
    run_exit_code_test "missing command exits 125" \
        "$GNU_TOOL -n 1 2>&1" \
        "$F_TOOL -n 1 2>&1"

    run_exit_code_test "unknown option exits 125" \
        "$GNU_TOOL --- 2>&1" \
        "$F_TOOL --- 2>&1"

    run_exit_code_test "invalid adjustment 1a exits 125" \
        "$GNU_TOOL -n 1a 2>&1" \
        "$F_TOOL -n 1a 2>&1"

    run_test "exit status propagation (exit 2)" \
        "$GNU_TOOL sh -c 'exit 2'; echo \$?" \
        "$F_TOOL sh -c 'exit 2'; echo \$?"

    run_exit_code_test "no such command exits 127" \
        "$GNU_TOOL no_such 2>&1" \
        "$F_TOOL no_such 2>&1"

    echo ""
    echo "=== GNU Upstream: nice (Adjustment Stacking) ==="

    # From nice.sh: verify niceness stacking with multiple adjustments
    # These tests require running at nice level 0
    run_test "default nice level is 10" \
        "$GNU_TOOL $GNU_TOOL" \
        "$F_TOOL $F_TOOL"

    run_test "nice -1 adjustment" \
        "$GNU_TOOL -1 $GNU_TOOL" \
        "$F_TOOL -1 $F_TOOL"

    run_test "nice -12 adjustment" \
        "$GNU_TOOL -12 $GNU_TOOL" \
        "$F_TOOL -12 $F_TOOL"

    run_test "nice -n 1 adjustment" \
        "$GNU_TOOL -n 1 $GNU_TOOL" \
        "$F_TOOL -n 1 $F_TOOL"

    run_test "nice -+1 adjustment" \
        "$GNU_TOOL -+1 $GNU_TOOL" \
        "$F_TOOL -+1 $F_TOOL"

    run_test "nice -n +1 adjustment" \
        "$GNU_TOOL -n +1 $GNU_TOOL" \
        "$F_TOOL -n +1 $F_TOOL"

    # From nice.sh: combined adjustment stacking (-1 -2 = niceness 2)
    run_test "nice -1 -2 stacked adjustments" \
        "$GNU_TOOL -1 $GNU_TOOL -2 $GNU_TOOL" \
        "$F_TOOL -1 $F_TOOL -2 $F_TOOL"

    # From nice.sh: -n 1 then -2 = niceness 2
    run_test "nice -n 1 -2 stacked" \
        "$GNU_TOOL -n 1 $GNU_TOOL -2 $GNU_TOOL" \
        "$F_TOOL -n 1 $F_TOOL -2 $F_TOOL"

    # From nice.sh: -n 1 then -+12 = niceness 12
    run_test "nice -n 1 then -+12 stacked" \
        "$GNU_TOOL -n 1 $GNU_TOOL -+12 $GNU_TOOL" \
        "$F_TOOL -n 1 $F_TOOL -+12 $F_TOOL"

    # From nice.sh: -2 then -n 1 = niceness 1
    run_test "nice -2 then -n 1 stacked" \
        "$GNU_TOOL -2 $GNU_TOOL -n 1 $GNU_TOOL" \
        "$F_TOOL -2 $F_TOOL -n 1 $F_TOOL"

    # From nice.sh: -2 then -n 12 = niceness 12
    run_test "nice -2 then -n 12 stacked" \
        "$GNU_TOOL -2 $GNU_TOOL -n 12 $GNU_TOOL" \
        "$F_TOOL -2 $F_TOOL -n 12 $F_TOOL"

    # From nice.sh: -+12 adjustment
    run_test "nice -+12 adjustment" \
        "$GNU_TOOL -+12 $GNU_TOOL" \
        "$F_TOOL -+12 $F_TOOL"

    # From nice.sh: stacked -+1 -+12 = niceness 12
    run_test "nice -+1 then -+12 stacked" \
        "$GNU_TOOL -+1 $GNU_TOOL -+12 $GNU_TOOL" \
        "$F_TOOL -+1 $F_TOOL -+12 $F_TOOL"

    # From nice-fail.sh: exit status 126 for invalid command (directory as command)
    # Only test if 'env .' also returns 126 (platform-dependent)
    set +e
    env . 2>/dev/null
    local env_dot_exit=$?
    set -e
    if [[ "$env_dot_exit" -eq 126 ]]; then
        run_exit_code_test "invalid command (directory) exits 126" \
            "$GNU_TOOL . 2>&1" \
            "$F_TOOL . 2>&1"
    else
        skip_test "invalid command (directory) exits 126" "Platform does not return 126 for 'env .'"
    fi

    # From nice-fail.sh: exit status 2 propagation
    run_test "exit status 2 propagation via sh -c" \
        "$GNU_TOOL sh -c 'exit 2'; echo \$?" \
        "$F_TOOL sh -c 'exit 2'; echo \$?"

    # nice.sh: negative niceness tests skipped (requires root or produces warning)
    skip_test "nice negative adjustment as superuser" "Requires root access for negative niceness"

    # nice.sh overflow/clamping tests: skipped (requires getlimits_ UINTMAX_OFLOW)
    skip_test "nice large value clamping" "Requires getlimits_ overflow values"

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
