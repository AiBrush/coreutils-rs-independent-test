#!/usr/bin/env bash
# Compatibility tests for fenv vs GNU env
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="env"
F_TOOL="fenv"

run_env_tests() {
    init_test_suite "env"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"env","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/env_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU env not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Print Environment ==="

    # Can't compare full env (too dynamic), test specific vars
    run_test "print env has PATH" \
        "$GNU_TOOL | grep -c '^PATH='" \
        "$F_TOOL | grep -c '^PATH='"

    run_test "print env has HOME" \
        "$GNU_TOOL | grep -c '^HOME='" \
        "$F_TOOL | grep -c '^HOME='"

    echo ""
    echo "=== Set Variables ==="

    run_test "set single variable" \
        "$GNU_TOOL TESTVAR=hello printenv TESTVAR" \
        "$F_TOOL TESTVAR=hello printenv TESTVAR"

    run_test "set multiple variables" \
        "$GNU_TOOL VAR1=one VAR2=two sh -c 'echo \$VAR1 \$VAR2'" \
        "$F_TOOL VAR1=one VAR2=two sh -c 'echo \$VAR1 \$VAR2'"

    run_test "variable with spaces in value" \
        "$GNU_TOOL 'TESTVAR=hello world' printenv TESTVAR" \
        "$F_TOOL 'TESTVAR=hello world' printenv TESTVAR"

    run_test "variable with equals in value" \
        "$GNU_TOOL 'TESTVAR=a=b=c' printenv TESTVAR" \
        "$F_TOOL 'TESTVAR=a=b=c' printenv TESTVAR"

    run_test "empty value" \
        "$GNU_TOOL TESTVAR= printenv TESTVAR" \
        "$F_TOOL TESTVAR= printenv TESTVAR"

    echo ""
    echo "=== Unset Variables (-u) ==="

    run_test "-u unset variable" \
        "export MYTEST_VAR=remove_me && $GNU_TOOL -u MYTEST_VAR sh -c 'echo \${MYTEST_VAR:-UNSET}'" \
        "export MYTEST_VAR=remove_me && $F_TOOL -u MYTEST_VAR sh -c 'echo \${MYTEST_VAR:-UNSET}'"

    echo ""
    echo "=== Clean Environment (-i) ==="

    run_test "-i empty environment" \
        "$GNU_TOOL -i env | wc -l" \
        "$F_TOOL -i env | wc -l"

    run_test "-i with new var" \
        "$GNU_TOOL -i ONLY=this printenv ONLY" \
        "$F_TOOL -i ONLY=this printenv ONLY"

    run_test "-i PATH still works" \
        "$GNU_TOOL -i PATH=/usr/bin:/bin sh -c 'echo OK'" \
        "$F_TOOL -i PATH=/usr/bin:/bin sh -c 'echo OK'"

    echo ""
    echo "=== Run Command ==="

    run_test "run echo" \
        "$GNU_TOOL echo 'hello from env'" \
        "$F_TOOL echo 'hello from env'"

    run_test "run sh -c" \
        "$GNU_TOOL sh -c 'echo computed'" \
        "$F_TOOL sh -c 'echo computed'"

    run_test "exit code passthrough (success)" \
        "$GNU_TOOL true; echo \$?" \
        "$F_TOOL true; echo \$?"

    run_test "exit code passthrough (failure)" \
        "$GNU_TOOL false; echo \$?" \
        "$F_TOOL false; echo \$?"

    echo ""
    echo "=== Null Terminated (-0) ==="

    run_test "-0 null terminated output" \
        "$GNU_TOOL -i TEST=val -0 | od -c | head -3" \
        "$F_TOOL -i TEST=val -0 | od -c | head -3"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent command" \
        "$GNU_TOOL /nonexistent_command_$$ 2>&1" \
        "$F_TOOL /nonexistent_command_$$ 2>&1"

    finish_test_suite
}

run_env_tests
