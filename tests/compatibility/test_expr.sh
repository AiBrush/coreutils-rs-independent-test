#!/usr/bin/env bash
# Compatibility tests for fexpr vs GNU expr
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="expr"
F_TOOL="fexpr"

run_expr_tests() {
    init_test_suite "expr"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"expr","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/expr_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU expr not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: Arithmetic ===
    echo ""
    echo "=== Arithmetic ==="

    run_stdout_test "2 + 3" \
        "$GNU_TOOL 2 + 3" \
        "$F_TOOL 2 + 3"

    run_stdout_test "10 - 3" \
        "$GNU_TOOL 10 - 3" \
        "$F_TOOL 10 - 3"

    run_stdout_test "4 * 5 (escaped)" \
        "$GNU_TOOL 4 '*' 5" \
        "$F_TOOL 4 '*' 5"

    run_stdout_test "10 / 3" \
        "$GNU_TOOL 10 / 3" \
        "$F_TOOL 10 / 3"

    run_stdout_test "10 % 3" \
        "$GNU_TOOL 10 % 3" \
        "$F_TOOL 10 % 3"

    run_stdout_test "100 + 200" \
        "$GNU_TOOL 100 + 200" \
        "$F_TOOL 100 + 200"

    run_stdout_test "negative result: 3 - 10" \
        "$GNU_TOOL 3 - 10" \
        "$F_TOOL 3 - 10"

    # Zero result (exit code 1!)
    run_stdout_test "0 + 0 (result is zero)" \
        "$GNU_TOOL 0 + 0 || true" \
        "$F_TOOL 0 + 0 || true"

    run_exit_code_test "0 + 0 exit code (should be 1)" \
        "$GNU_TOOL 0 + 0" \
        "$F_TOOL 0 + 0"

    # === Section 2: Comparisons ===
    echo ""
    echo "=== Comparisons ==="

    run_stdout_test "5 > 3" \
        "$GNU_TOOL 5 '>' 3" \
        "$F_TOOL 5 '>' 3"

    run_stdout_test "5 < 3" \
        "$GNU_TOOL 5 '<' 3 || true" \
        "$F_TOOL 5 '<' 3 || true"

    run_stdout_test "5 = 5" \
        "$GNU_TOOL 5 = 5" \
        "$F_TOOL 5 = 5"

    run_stdout_test "5 != 3" \
        "$GNU_TOOL 5 '!=' 3" \
        "$F_TOOL 5 '!=' 3"

    run_stdout_test "5 >= 5" \
        "$GNU_TOOL 5 '>=' 5" \
        "$F_TOOL 5 '>=' 5"

    run_stdout_test "5 <= 5" \
        "$GNU_TOOL 5 '<=' 5" \
        "$F_TOOL 5 '<=' 5"

    run_stdout_test "string comparison: abc < def" \
        "$GNU_TOOL abc '<' def" \
        "$F_TOOL abc '<' def"

    # === Section 3: String Operations ===
    echo ""
    echo "=== String Operations ==="

    run_stdout_test "length hello" \
        "$GNU_TOOL length hello" \
        "$F_TOOL length hello"

    run_stdout_test "length empty" \
        "$GNU_TOOL length '' || true" \
        "$F_TOOL length '' || true"

    run_stdout_test "substr hello 2 3" \
        "$GNU_TOOL substr hello 2 3" \
        "$F_TOOL substr hello 2 3"

    run_stdout_test "substr hello 1 5" \
        "$GNU_TOOL substr hello 1 5" \
        "$F_TOOL substr hello 1 5"

    run_stdout_test "index hello l" \
        "$GNU_TOOL index hello l" \
        "$F_TOOL index hello l"

    run_stdout_test "index hello x (not found)" \
        "$GNU_TOOL index hello x || true" \
        "$F_TOOL index hello x || true"

    run_exit_code_test "index hello x exit code" \
        "$GNU_TOOL index hello x" \
        "$F_TOOL index hello x"

    run_stdout_test "index hello e" \
        "$GNU_TOOL index hello e" \
        "$F_TOOL index hello e"

    # === Section 4: Regex Matching ===
    echo ""
    echo "=== Regex Matching ==="

    run_stdout_test "abc : 'a.*' (match length)" \
        "$GNU_TOOL abc : 'a.*'" \
        "$F_TOOL abc : 'a.*'"

    run_stdout_test "abc : 'xyz' (no match)" \
        "$GNU_TOOL abc : 'xyz' || true" \
        "$F_TOOL abc : 'xyz' || true"

    run_exit_code_test "abc : 'xyz' exit code" \
        "$GNU_TOOL abc : 'xyz'" \
        "$F_TOOL abc : 'xyz'"

    run_stdout_test "abc : 'a\\(b\\)c' (captured group)" \
        "$GNU_TOOL abc : 'a\\(b\\)c'" \
        "$F_TOOL abc : 'a\\(b\\)c'"

    run_stdout_test "match abc 'a\\(.\\)c'" \
        "$GNU_TOOL match abc 'a\\(.\\)c'" \
        "$F_TOOL match abc 'a\\(.\\)c'"

    run_stdout_test "abc : '\\(abc\\)'" \
        "$GNU_TOOL abc : '\\(abc\\)'" \
        "$F_TOOL abc : '\\(abc\\)'"

    # === Section 5: OR/AND ===
    echo ""
    echo "=== OR/AND ==="

    run_stdout_test "'' | default" \
        "$GNU_TOOL '' '|' default" \
        "$F_TOOL '' '|' default"

    run_stdout_test "0 | 5" \
        "$GNU_TOOL 0 '|' 5" \
        "$F_TOOL 0 '|' 5"

    run_stdout_test "hello | default" \
        "$GNU_TOOL hello '|' default" \
        "$F_TOOL hello '|' default"

    run_stdout_test "hello & world" \
        "$GNU_TOOL hello '&' world" \
        "$F_TOOL hello '&' world"

    run_stdout_test "'' & world" \
        "$GNU_TOOL '' '&' world || true" \
        "$F_TOOL '' '&' world || true"

    # === Section 6: Grouping ===
    echo ""
    echo "=== Grouping ==="

    run_stdout_test "( 2 + 3 ) * 4" \
        "$GNU_TOOL '(' 2 + 3 ')' '*' 4" \
        "$F_TOOL '(' 2 + 3 ')' '*' 4"

    run_stdout_test "( 10 - 3 ) / 2" \
        "$GNU_TOOL '(' 10 - 3 ')' / 2" \
        "$F_TOOL '(' 10 - 3 ')' / 2"

    # === Section 7: Exit Codes ===
    echo ""
    echo "=== Exit Codes ==="

    run_exit_code_test "non-null result (exit 0)" \
        "$GNU_TOOL 2 + 3" \
        "$F_TOOL 2 + 3"

    run_exit_code_test "null/zero result (exit 1)" \
        "$GNU_TOOL 0 + 0" \
        "$F_TOOL 0 + 0"

    run_exit_code_test "syntax error (exit 2)" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "division by zero (exit 2)" \
        "$GNU_TOOL 1 / 0 2>&1" \
        "$F_TOOL 1 / 0 2>&1"

    # === Section 8: Edge Cases ===
    echo ""
    echo "=== Edge Cases ==="

    run_stdout_test "large number" \
        "$GNU_TOOL 999999999 + 1" \
        "$F_TOOL 999999999 + 1"

    run_stdout_test "negative input" \
        "$GNU_TOOL -5 + 3 || true" \
        "$F_TOOL -5 + 3 || true"

    finish_test_suite
}

run_expr_tests
