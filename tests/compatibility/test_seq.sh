#!/usr/bin/env bash
# Compatibility tests for fseq vs GNU seq
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="seq"
F_TOOL="fseq"

run_seq_tests() {
    init_test_suite "seq"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"seq","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/seq_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU seq not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Sequences (single arg: LAST) ==="

    run_test "seq 1" \
        "$GNU_TOOL 1" \
        "$F_TOOL 1"

    run_test "seq 5" \
        "$GNU_TOOL 5" \
        "$F_TOOL 5"

    run_test "seq 10" \
        "$GNU_TOOL 10" \
        "$F_TOOL 10"

    run_test "seq 100" \
        "$GNU_TOOL 100" \
        "$F_TOOL 100"

    run_test "seq 0 (empty output)" \
        "$GNU_TOOL 0" \
        "$F_TOOL 0"

    run_test "seq negative last (-3)" \
        "$GNU_TOOL -- -3" \
        "$F_TOOL -- -3"

    echo ""
    echo "=== Two Args (FIRST LAST) ==="

    run_test "seq 1 5" \
        "$GNU_TOOL 1 5" \
        "$F_TOOL 1 5"

    run_test "seq 5 10" \
        "$GNU_TOOL 5 10" \
        "$F_TOOL 5 10"

    run_test "seq -5 5" \
        "$GNU_TOOL -- -5 5" \
        "$F_TOOL -- -5 5"

    run_test "seq 5 5 (single element)" \
        "$GNU_TOOL 5 5" \
        "$F_TOOL 5 5"

    run_test "seq 5 3 (empty - first > last)" \
        "$GNU_TOOL 5 3" \
        "$F_TOOL 5 3"

    run_test "seq -10 -5" \
        "$GNU_TOOL -- -10 -5" \
        "$F_TOOL -- -10 -5"

    echo ""
    echo "=== Three Args (FIRST INCREMENT LAST) ==="

    run_test "seq 1 1 5" \
        "$GNU_TOOL 1 1 5" \
        "$F_TOOL 1 1 5"

    run_test "seq 1 2 10 (step 2)" \
        "$GNU_TOOL 1 2 10" \
        "$F_TOOL 1 2 10"

    run_test "seq 0 3 15" \
        "$GNU_TOOL 0 3 15" \
        "$F_TOOL 0 3 15"

    run_test "seq 10 -1 1 (count down)" \
        "$GNU_TOOL 10 -1 1" \
        "$F_TOOL 10 -1 1"

    run_test "seq 5 -2 -5 (count down by 2)" \
        "$GNU_TOOL 5 -2 -5" \
        "$F_TOOL 5 -2 -5"

    run_test "seq 0 5 100" \
        "$GNU_TOOL 0 5 100" \
        "$F_TOOL 0 5 100"

    run_test "seq 1 10 100 (step 10)" \
        "$GNU_TOOL 1 10 100" \
        "$F_TOOL 1 10 100"

    run_test "seq with step not reaching last exactly" \
        "$GNU_TOOL 1 3 10" \
        "$F_TOOL 1 3 10"

    echo ""
    echo "=== Floating Point ==="

    run_test "seq 0.5 1.5" \
        "$GNU_TOOL 0.5 1.5" \
        "$F_TOOL 0.5 1.5"

    run_test "seq 0.1 0.1 1.0" \
        "$GNU_TOOL 0.1 0.1 1.0" \
        "$F_TOOL 0.1 0.1 1.0"

    run_test "seq 0 0.25 2" \
        "$GNU_TOOL 0 0.25 2" \
        "$F_TOOL 0 0.25 2"

    run_test "seq 1.5 0.5 5.0" \
        "$GNU_TOOL 1.5 0.5 5.0" \
        "$F_TOOL 1.5 0.5 5.0"

    run_test "seq -1.0 0.5 1.0" \
        "$GNU_TOOL -- -1.0 0.5 1.0" \
        "$F_TOOL -- -1.0 0.5 1.0"

    echo ""
    echo "=== Separator Option (-s) ==="

    run_test "-s comma" \
        "$GNU_TOOL -s ',' 1 5" \
        "$F_TOOL -s ',' 1 5"

    run_test "-s colon" \
        "$GNU_TOOL -s ':' 1 10" \
        "$F_TOOL -s ':' 1 10"

    run_test "-s space" \
        "$GNU_TOOL -s ' ' 1 5" \
        "$F_TOOL -s ' ' 1 5"

    run_test "-s tab" \
        "$GNU_TOOL -s '\t' 1 5" \
        "$F_TOOL -s '\t' 1 5"

    run_test "-s multi-char" \
        "$GNU_TOOL -s ', ' 1 5" \
        "$F_TOOL -s ', ' 1 5"

    run_test "-s empty string" \
        "$GNU_TOOL -s '' 1 5" \
        "$F_TOOL -s '' 1 5"

    echo ""
    echo "=== Equal Width (-w) ==="

    run_test "-w single digit range" \
        "$GNU_TOOL -w 1 10" \
        "$F_TOOL -w 1 10"

    run_test "-w padding to 3 digits" \
        "$GNU_TOOL -w 1 100" \
        "$F_TOOL -w 1 100"

    run_test "-w with step" \
        "$GNU_TOOL -w 1 5 20" \
        "$F_TOOL -w 1 5 20"

    run_test "-w negative numbers" \
        "$GNU_TOOL -w -- -5 5" \
        "$F_TOOL -w -- -5 5"

    run_test "-w already equal width" \
        "$GNU_TOOL -w 10 15" \
        "$F_TOOL -w 10 15"

    echo ""
    echo "=== Format String (-f) ==="

    run_test "-f percent-g" \
        "$GNU_TOOL -f '%g' 1 5" \
        "$F_TOOL -f '%g' 1 5"

    run_test "-f percent-e" \
        "$GNU_TOOL -f '%e' 1 5" \
        "$F_TOOL -f '%e' 1 5"

    run_test "-f fixed width" \
        "$GNU_TOOL -f '%05g' 1 10" \
        "$F_TOOL -f '%05g' 1 10"

    run_test "-f with text" \
        "$GNU_TOOL -f 'item_%03g' 1 5" \
        "$F_TOOL -f 'item_%03g' 1 5"

    run_test "-f float format" \
        "$GNU_TOOL -f '%.2f' 1 0.5 3" \
        "$F_TOOL -f '%.2f' 1 0.5 3"

    echo ""
    echo "=== Edge Cases ==="

    run_test "seq 1 0 (zero step - should error)" \
        "$GNU_TOOL 1 0 5 2>&1 || true" \
        "$F_TOOL 1 0 5 2>&1 || true"

    run_exit_code_test "zero increment error" \
        "$GNU_TOOL 1 0 5 2>&1" \
        "$F_TOOL 1 0 5 2>&1"

    run_test "very large last" \
        "$GNU_TOOL 999999 1000005" \
        "$F_TOOL 999999 1000005"

    run_test "single element (first == last)" \
        "$GNU_TOOL 42 42" \
        "$F_TOOL 42 42"

    run_test "large step beyond range" \
        "$GNU_TOOL 1 100 5" \
        "$F_TOOL 1 100 5"

    run_test "negative step with positive range (empty)" \
        "$GNU_TOOL 1 -1 10" \
        "$F_TOOL 1 -1 10"

    run_test "positive step with descending range (empty)" \
        "$GNU_TOOL 10 1 1" \
        "$F_TOOL 10 1 1"

    echo ""
    echo "=== Large Output ==="

    run_test "seq 1 10000 (checksum)" \
        "$GNU_TOOL 1 10000 | md5sum" \
        "$F_TOOL 1 10000 | md5sum"

    run_test "seq 1 100000 (checksum)" \
        "$GNU_TOOL 1 100000 | md5sum" \
        "$F_TOOL 1 100000 | md5sum"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "non-numeric argument" \
        "$GNU_TOOL abc 2>&1" \
        "$F_TOOL abc 2>&1"

    run_exit_code_test "too many arguments" \
        "$GNU_TOOL 1 2 3 4 2>&1" \
        "$F_TOOL 1 2 3 4 2>&1"

    finish_test_suite
}

run_seq_tests
