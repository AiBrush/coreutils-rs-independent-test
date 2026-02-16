#!/usr/bin/env bash
# Compatibility tests for ffactor vs GNU factor
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="factor"
F_TOOL="ffactor"

run_factor_tests() {
    init_test_suite "factor"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"factor","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/factor_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU factor not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: Basic Factorization ===
    echo ""
    echo "=== Basic Factorization ==="

    run_test "factor 1" \
        "$GNU_TOOL 1" \
        "$F_TOOL 1"

    run_test "factor 2" \
        "$GNU_TOOL 2" \
        "$F_TOOL 2"

    run_test "factor 3" \
        "$GNU_TOOL 3" \
        "$F_TOOL 3"

    run_test "factor 4" \
        "$GNU_TOOL 4" \
        "$F_TOOL 4"

    run_test "factor 12" \
        "$GNU_TOOL 12" \
        "$F_TOOL 12"

    run_test "factor 100" \
        "$GNU_TOOL 100" \
        "$F_TOOL 100"

    run_test "factor 1024 (power of 2)" \
        "$GNU_TOOL 1024" \
        "$F_TOOL 1024"

    run_test "factor 997 (prime)" \
        "$GNU_TOOL 997" \
        "$F_TOOL 997"

    run_test "factor 0" \
        "$GNU_TOOL 0" \
        "$F_TOOL 0"

    run_test "factor 360" \
        "$GNU_TOOL 360" \
        "$F_TOOL 360"

    # === Section 2: Multiple Arguments ===
    echo ""
    echo "=== Multiple Arguments ==="

    run_test "factor 12 15 20" \
        "$GNU_TOOL 12 15 20" \
        "$F_TOOL 12 15 20"

    run_test "factor 2 3 5 7 11 13" \
        "$GNU_TOOL 2 3 5 7 11 13" \
        "$F_TOOL 2 3 5 7 11 13"

    run_test "factor 100 200 300" \
        "$GNU_TOOL 100 200 300" \
        "$F_TOOL 100 200 300"

    # === Section 3: Stdin Mode ===
    echo ""
    echo "=== Stdin Mode ==="

    local stdin_12
    stdin_12=$(make_temp "12")
    register_temp "$stdin_12"

    run_test "factor from stdin (12)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "$stdin_12"

    local stdin_multi
    stdin_multi=$(make_temp_printf "12\n15\n20\n")
    register_temp "$stdin_multi"

    run_test "factor from stdin (multiple lines)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "$stdin_multi"

    # === Section 4: Large Numbers ===
    echo ""
    echo "=== Large Numbers ==="

    run_test "factor 1000000007 (large prime)" \
        "$GNU_TOOL 1000000007" \
        "$F_TOOL 1000000007"

    run_test "factor 2147483647 (Mersenne prime 2^31-1)" \
        "$GNU_TOOL 2147483647" \
        "$F_TOOL 2147483647"

    run_test "factor 1000000000 (10^9)" \
        "$GNU_TOOL 1000000000" \
        "$F_TOOL 1000000000"

    run_test "factor 999999937 (large prime)" \
        "$GNU_TOOL 999999937" \
        "$F_TOOL 999999937"

    run_test "factor 123456789" \
        "$GNU_TOOL 123456789" \
        "$F_TOOL 123456789"

    # === Section 5: Edge Cases ===
    echo ""
    echo "=== Edge Cases ==="

    run_test "factor perfect square 144" \
        "$GNU_TOOL 144" \
        "$F_TOOL 144"

    run_test "factor perfect cube 27" \
        "$GNU_TOOL 27" \
        "$F_TOOL 27"

    run_test "factor semi-prime 15" \
        "$GNU_TOOL 15" \
        "$F_TOOL 15"

    run_test "factor highly composite 720720" \
        "$GNU_TOOL 720720" \
        "$F_TOOL 720720"

    # === Section 6: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "negative number" \
        "$GNU_TOOL -- -1 2>&1" \
        "$F_TOOL -- -1 2>&1"

    run_exit_code_test "non-numeric argument" \
        "$GNU_TOOL abc 2>&1" \
        "$F_TOOL abc 2>&1"

    finish_test_suite
}

run_factor_tests
