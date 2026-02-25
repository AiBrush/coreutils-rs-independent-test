#!/usr/bin/env bash
# Compatibility tests for fprintenv vs GNU printenv
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "printenv")
F_TOOL="fprintenv"

run_printenv_tests() {
    init_test_suite "printenv"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"printenv","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/printenv_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU printenv not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== GNU Upstream: Single Variable ==="

    # GNU printenv.sh: printing a single variable's value
    run_test "print single set variable" \
        "ENV_TEST=a env -- $GNU_TOOL ENV_TEST" \
        "ENV_TEST=a env -- $F_TOOL ENV_TEST"

    # GNU printenv.sh: non-existent variable returns exit code 1
    run_exit_code_test "missing variable exits nonzero" \
        "env -- $GNU_TOOL ENV_TEST_NONEXISTENT_$$ 2>&1" \
        "env -- $F_TOOL ENV_TEST_NONEXISTENT_$$ 2>&1"

    echo ""
    echo "=== GNU Upstream: Multiple Variables ==="

    # GNU printenv.sh: printing multiple variables, order follows command line
    run_test "multiple variables in command line order" \
        "ENV_TEST1=a ENV_TEST2=b env -- $GNU_TOOL ENV_TEST2 ENV_TEST1 ENV_TEST2" \
        "ENV_TEST1=a ENV_TEST2=b env -- $F_TOOL ENV_TEST2 ENV_TEST1 ENV_TEST2"

    run_test "multiple variables forward order" \
        "ENV_TEST1=a ENV_TEST2=b env -- $GNU_TOOL ENV_TEST1 ENV_TEST2" \
        "ENV_TEST1=a ENV_TEST2=b env -- $F_TOOL ENV_TEST1 ENV_TEST2"

    echo ""
    echo "=== GNU Upstream: Missing Variable Among Valid ==="

    # GNU printenv.sh: exit status reflects missing variable but remaining args processed
    run_exit_code_test "missing var among valid exits nonzero" \
        "ENV_TEST1=a env -- $GNU_TOOL ENV_TEST_NONE_$$ ENV_TEST1 2>&1" \
        "ENV_TEST1=a env -- $F_TOOL ENV_TEST_NONE_$$ ENV_TEST1 2>&1"

    run_stdout_test "missing var still prints valid ones" \
        "ENV_TEST1=a env -- $GNU_TOOL ENV_TEST_NONE_$$ ENV_TEST1 || true" \
        "ENV_TEST1=a env -- $F_TOOL ENV_TEST_NONE_$$ ENV_TEST1 || true"

    echo ""
    echo "=== GNU Upstream: Non-Standard Variable Names ==="

    # GNU printenv.sh: non-standard env var name via env
    run_test "non-standard var name via env" \
        "env -- -a=b $GNU_TOOL -- -a" \
        "env -- -a=b $F_TOOL -- -a"

    echo ""
    echo "=== GNU Upstream: Invalid Variable Name Rejection ==="

    # GNU printenv.sh: silently reject var names containing '='
    run_exit_code_test "reject var name with equals sign" \
        "env a=b=c $GNU_TOOL a=b 2>&1" \
        "env a=b=c $F_TOOL a=b 2>&1"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments prints all env" \
        "env -- $GNU_TOOL >/dev/null 2>&1" \
        "env -- $F_TOOL >/dev/null 2>&1"


    finish_test_suite
}

run_printenv_tests
