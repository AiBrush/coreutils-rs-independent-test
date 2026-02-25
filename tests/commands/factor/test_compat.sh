#!/usr/bin/env bash
# Compatibility tests for ffactor vs GNU factor
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "factor")
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

    # === GNU Upstream: Large Factors (Pollard Rho) ===
    echo ""
    echo "=== GNU Upstream: Large Factors ==="

    # From create-test.sh: numbers with large Pollard rho factors (>2^64)
    run_test "factor large rho t1" \
        "$GNU_TOOL 170141183460469225450570946617781744489" \
        "$F_TOOL 170141183460469225450570946617781744489"

    run_test "factor large rho t2" \
        "$GNU_TOOL 170141183460469229545748130981302223887" \
        "$F_TOOL 170141183460469229545748130981302223887"

    # From create-test.sh: bug#73474 number
    run_test "factor bug73474 number" \
        "$GNU_TOOL 22222222222222222202111121111" \
        "$F_TOOL 22222222222222222202111121111"

    # === GNU Upstream: Sequential Range ===
    echo ""
    echo "=== GNU Upstream: Sequential Range ==="

    # From run.sh: verify factoring a small sequential range via stdin
    local range_input
    range_input=$(make_temp "$(seq 1 100 | tr '\n' '\n')")
    register_temp "$range_input"

    run_test "factor range 1-100 via stdin" \
        "seq 1 100 | $GNU_TOOL" \
        "seq 1 100 | $F_TOOL"

    run_test "factor range 9990-10010 via stdin" \
        "seq 9990 10010 | $GNU_TOOL" \
        "seq 9990 10010 | $F_TOOL"

    # === GNU Upstream: factor.pl Basic Factorization Vectors ===
    echo ""
    echo "=== GNU Upstream: factor.pl Basic Factorization Vectors ==="

    # From factor.pl: basic test cases
    run_test "gnu factor.pl 1: factor 9" \
        "$GNU_TOOL 9" \
        "$F_TOOL 9"

    run_test "gnu factor.pl 1a: factor 7 (prime)" \
        "$GNU_TOOL 7" \
        "$F_TOOL 7"

    run_test "gnu factor.pl 1b: factor +7 (leading plus)" \
        "$GNU_TOOL +7" \
        "$F_TOOL +7"

    run_test "gnu factor.pl 2: factor 4294967291 (large prime)" \
        "$GNU_TOOL 4294967291" \
        "$F_TOOL 4294967291"

    run_test "gnu factor.pl 3: factor 4294967292" \
        "$GNU_TOOL 4294967292" \
        "$F_TOOL 4294967292"

    run_test "gnu factor.pl 4: factor 4294967293" \
        "$GNU_TOOL 4294967293" \
        "$F_TOOL 4294967293"

    # From factor.pl: semi-prime tests near 2^32
    run_test "gnu factor.pl a: 4294966201" \
        "$GNU_TOOL 4294966201" \
        "$F_TOOL 4294966201"

    run_test "gnu factor.pl s: 4294967071 (near-equal factors)" \
        "$GNU_TOOL 4294967071" \
        "$F_TOOL 4294967071"

    # From factor.pl: various composite types near 2^32
    run_test "gnu factor.pl t: 4294966194 (many small factors)" \
        "$GNU_TOOL 4294966194" \
        "$F_TOOL 4294966194"

    run_test "gnu factor.pl u: 4294966272 (power of 2 heavy)" \
        "$GNU_TOOL 4294966272" \
        "$F_TOOL 4294966272"

    run_test "gnu factor.pl v: 4294966400 (powers of 2 and 5)" \
        "$GNU_TOOL 4294966400" \
        "$F_TOOL 4294966400"

    # === GNU Upstream: factor.pl Bug Regression Tests ===
    echo ""
    echo "=== GNU Upstream: factor.pl Bug Regression Tests ==="

    # From factor.pl: bug-2012 regression tests
    run_test "gnu factor.pl bug-2012-a: 465658903" \
        "$GNU_TOOL 465658903" \
        "$F_TOOL 465658903"

    run_test "gnu factor.pl bug-2012-b: 2242724851" \
        "$GNU_TOOL 2242724851" \
        "$F_TOOL 2242724851"

    run_test "gnu factor.pl bug-2012-c: 6635692801" \
        "$GNU_TOOL 6635692801" \
        "$F_TOOL 6635692801"

    run_test "gnu factor.pl bug-2012-d: 17709149503" \
        "$GNU_TOOL 17709149503" \
        "$F_TOOL 17709149503"

    run_test "gnu factor.pl bug-2012-e: 17754345703" \
        "$GNU_TOOL 17754345703" \
        "$F_TOOL 17754345703"

    # From factor.pl: infinite loop bugs in v8.20 to 8.26
    run_test "gnu factor.pl bug-2016-a: 158909489063877810457" \
        "$GNU_TOOL 158909489063877810457" \
        "$F_TOOL 158909489063877810457"

    run_test "gnu factor.pl bug-2016-b: 222087527029934481871" \
        "$GNU_TOOL 222087527029934481871" \
        "$F_TOOL 222087527029934481871"

    run_test "gnu factor.pl bug-2016-c: large 128-bit composite" \
        "$GNU_TOOL 12847291069740315094892340035" \
        "$F_TOOL 12847291069740315094892340035"

    # === GNU Upstream: factor.pl GMP/Large Number Tests ===
    echo ""
    echo "=== GNU Upstream: factor.pl GMP/Large Number Tests ==="

    # From factor.pl: 2^128
    run_test "gnu factor.pl: 2^128" \
        "$GNU_TOOL 340282366920938463463374607431768211456" \
        "$F_TOOL 340282366920938463463374607431768211456"

    # From factor.pl: +2^127+1 (with leading plus)
    run_test "gnu factor.pl: +2^127+1" \
        "$GNU_TOOL +170141183460469231731687303715884105729" \
        "$F_TOOL +170141183460469231731687303715884105729"

    # From factor.pl: 128-bit uintmax_t edge case
    run_test "gnu factor.pl: 128-bit uintmax_t edge" \
        "$GNU_TOOL 340282366920938463463374607431768211355" \
        "$F_TOOL 340282366920938463463374607431768211355"

    # === GNU Upstream: factor.pl Exponent Output (-h) ===
    echo ""
    echo "=== GNU Upstream: factor.pl Exponent Output (-h) ==="

    # From factor.pl: -h / --exponents flag
    run_test "gnu factor.pl h-1: -h 3000" \
        "$GNU_TOOL -h 3000" \
        "$F_TOOL -h 3000"

    run_test "gnu factor.pl h-2: --exponents 3000" \
        "$GNU_TOOL --exponents 3000" \
        "$F_TOOL --exponents 3000"

    # === GNU Upstream: factor.pl Continued Output on Error ===
    echo ""
    echo "=== GNU Upstream: factor.pl Continued Output on Error ==="

    # From factor.pl: 'cont' test - invalid followed by valid should still output valid
    run_stdout_test "gnu factor.pl cont: invalid then valid" \
        "$GNU_TOOL a 4 2>/dev/null" \
        "$F_TOOL a 4 2>/dev/null"

    # From factor.pl: create-test.sh large number vectors
    # (These come from the sequential SHA1 test - we test individual factorizations)
    run_test "gnu create-test: bug73474" \
        "$GNU_TOOL 22222222222222222202111121111" \
        "$F_TOOL 22222222222222222202111121111"

    # factor-parallel.sh: skipped (requires split -nr, background processes, timing)
    skip_test "factor parallel" "Requires background processes and split -nr"

    # create-test.sh/run.sh: sequential range SHA1 tests skipped (very expensive)
    skip_test "factor sequential SHA1 range" "Very expensive: requires seq|factor|sha1sum over millions of numbers"

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
