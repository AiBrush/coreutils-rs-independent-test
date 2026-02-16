#!/usr/bin/env bash
# Compatibility tests for fprintf vs GNU printf
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

# GNU printf is NOT the shell builtin
if [[ -x /usr/bin/printf ]]; then
    GNU_TOOL="/usr/bin/printf"
elif [[ -x /bin/printf ]]; then
    GNU_TOOL="/bin/printf"
elif command -v gprintf &>/dev/null; then
    GNU_TOOL="gprintf"
else
    GNU_TOOL="env printf"
fi

F_TOOL="fprintf"

run_printf_tests() {
    init_test_suite "printf"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"printf","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/printf_results.json"
        return 0
    fi

    if ! command -v $GNU_TOOL &>/dev/null && ! [[ -x $GNU_TOOL ]]; then
        echo "GNU printf not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: Basic Format Specifiers ===
    echo ""
    echo "=== Basic Format Specifiers ==="

    run_stdout_test "%s string" \
        "$GNU_TOOL '%s\n' hello" \
        "$F_TOOL '%s\n' hello"

    run_stdout_test "%d integer" \
        "$GNU_TOOL '%d\n' 42" \
        "$F_TOOL '%d\n' 42"

    run_stdout_test "%05d zero-padded" \
        "$GNU_TOOL '%05d\n' 42" \
        "$F_TOOL '%05d\n' 42"

    run_stdout_test "%x hex lowercase" \
        "$GNU_TOOL '%x\n' 255" \
        "$F_TOOL '%x\n' 255"

    run_stdout_test "%X hex uppercase" \
        "$GNU_TOOL '%X\n' 255" \
        "$F_TOOL '%X\n' 255"

    run_stdout_test "%o octal" \
        "$GNU_TOOL '%o\n' 8" \
        "$F_TOOL '%o\n' 8"

    run_stdout_test "%#x hex with prefix" \
        "$GNU_TOOL '%#x\n' 255" \
        "$F_TOOL '%#x\n' 255"

    run_stdout_test "%c character" \
        "$GNU_TOOL '%c\n' A" \
        "$F_TOOL '%c\n' A"

    run_stdout_test "%% literal percent" \
        "$GNU_TOOL '%%\n'" \
        "$F_TOOL '%%\n'"

    run_stdout_test "%i integer (alias for d)" \
        "$GNU_TOOL '%i\n' 42" \
        "$F_TOOL '%i\n' 42"

    run_stdout_test "%u unsigned" \
        "$GNU_TOOL '%u\n' 42" \
        "$F_TOOL '%u\n' 42"

    # === Section 2: Floating Point ===
    echo ""
    echo "=== Floating Point ==="

    run_stdout_test "%.3f" \
        "$GNU_TOOL '%.3f\n' 3.14159" \
        "$F_TOOL '%.3f\n' 3.14159"

    run_stdout_test "%e scientific" \
        "$GNU_TOOL '%e\n' 1000" \
        "$F_TOOL '%e\n' 1000"

    run_stdout_test "%g general float 1000" \
        "$GNU_TOOL '%g\n' 1000" \
        "$F_TOOL '%g\n' 1000"

    run_stdout_test "%g general float 0.00001" \
        "$GNU_TOOL '%g\n' 0.00001" \
        "$F_TOOL '%g\n' 0.00001"

    run_stdout_test "%f default precision" \
        "$GNU_TOOL '%f\n' 3.14" \
        "$F_TOOL '%f\n' 3.14"

    run_stdout_test "%.0f no decimal" \
        "$GNU_TOOL '%.0f\n' 3.7" \
        "$F_TOOL '%.0f\n' 3.7"

    run_stdout_test "%E uppercase scientific" \
        "$GNU_TOOL '%E\n' 1000" \
        "$F_TOOL '%E\n' 1000"

    # === Section 3: Width and Alignment ===
    echo ""
    echo "=== Width and Alignment ==="

    run_stdout_test "%10s right aligned" \
        "$GNU_TOOL '%10s|\n' hi" \
        "$F_TOOL '%10s|\n' hi"

    run_stdout_test "%-10s left aligned" \
        "$GNU_TOOL '%-10s|\n' hi" \
        "$F_TOOL '%-10s|\n' hi"

    run_stdout_test "%+d positive" \
        "$GNU_TOOL '%+d\n' 42" \
        "$F_TOOL '%+d\n' 42"

    run_stdout_test "%+d negative" \
        "$GNU_TOOL '%+d\n' -42" \
        "$F_TOOL '%+d\n' -- -42"

    run_stdout_test "%10d padded int" \
        "$GNU_TOOL '%10d\n' 42" \
        "$F_TOOL '%10d\n' 42"

    run_stdout_test "%-10d left int" \
        "$GNU_TOOL '%-10d|\n' 42" \
        "$F_TOOL '%-10d|\n' 42"

    # === Section 4: Argument Recycling ===
    echo ""
    echo "=== Argument Recycling ==="

    run_stdout_test "%s recycled over 3 args" \
        "$GNU_TOOL '%s ' a b c" \
        "$F_TOOL '%s ' a b c"

    run_stdout_test "%d %d recycled over 4 args" \
        "$GNU_TOOL '%d %d\n' 1 2 3 4" \
        "$F_TOOL '%d %d\n' 1 2 3 4"

    run_stdout_test "%s with no args (empty)" \
        "$GNU_TOOL '%s\n'" \
        "$F_TOOL '%s\n'"

    run_stdout_test "%d with no args (zero)" \
        "$GNU_TOOL '%d\n'" \
        "$F_TOOL '%d\n'"

    run_stdout_test "multiple format reuse" \
        "$GNU_TOOL '%s\n' a b c d e" \
        "$F_TOOL '%s\n' a b c d e"

    # === Section 5: %b (Backslash Interpretation) ===
    echo ""
    echo "=== %b Backslash Interpretation ==="

    run_stdout_test "%b with \\t" \
        "$GNU_TOOL '%b\n' 'hello\tworld'" \
        "$F_TOOL '%b\n' 'hello\tworld'"

    run_stdout_test "%b with \\n" \
        "$GNU_TOOL '%b\n' 'hello\nworld'" \
        "$F_TOOL '%b\n' 'hello\nworld'"

    run_stdout_test "%b with \\c (stop)" \
        "$GNU_TOOL '%b' 'stop\cignored'" \
        "$F_TOOL '%b' 'stop\cignored'"

    run_stdout_test "%b with \\0NNN octal" \
        "$GNU_TOOL '%b\n' '\0101'" \
        "$F_TOOL '%b\n' '\0101'"

    # === Section 6: Character Value with Quote ===
    echo ""
    echo "=== Character Value ==="

    run_stdout_test "%d with single-quote A" \
        "$GNU_TOOL '%d\n' \"'A\"" \
        "$F_TOOL '%d\n' \"'A\""

    run_stdout_test "%d with single-quote Z" \
        "$GNU_TOOL '%d\n' \"'Z\"" \
        "$F_TOOL '%d\n' \"'Z\""

    # === Section 7: Escape Sequences in FORMAT ===
    echo ""
    echo "=== Escape Sequences in FORMAT ==="

    run_stdout_test "\\n in format" \
        "$GNU_TOOL 'hello\nworld\n'" \
        "$F_TOOL 'hello\nworld\n'"

    run_stdout_test "\\t in format" \
        "$GNU_TOOL 'hello\tworld\n'" \
        "$F_TOOL 'hello\tworld\n'"

    run_stdout_test "\\\\ in format" \
        "$GNU_TOOL 'back\\\\slash\n'" \
        "$F_TOOL 'back\\\\slash\n'"

    run_stdout_test "\\x41 hex in format" \
        "$GNU_TOOL '\\x41\n'" \
        "$F_TOOL '\\x41\n'"

    run_stdout_test "\\101 octal in format" \
        "$GNU_TOOL '\\101\n'" \
        "$F_TOOL '\\101\n'"

    # === Section 8: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_stdout_test "non-numeric to %d" \
        "$GNU_TOOL '%d\n' notanumber 2>/dev/null || true" \
        "$F_TOOL '%d\n' notanumber 2>/dev/null || true"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # === Section 9: Multiple Conversions in One Format ===
    echo ""
    echo "=== Multiple Conversions ==="

    run_stdout_test "%s is %d" \
        "$GNU_TOOL '%s is %d\n' answer 42" \
        "$F_TOOL '%s is %d\n' answer 42"

    run_stdout_test "mixed types" \
        "$GNU_TOOL 'Name: %s Age: %d Score: %.1f\n' Alice 30 95.5" \
        "$F_TOOL 'Name: %s Age: %d Score: %.1f\n' Alice 30 95.5"

    # === Section 10: Edge Cases ===
    echo ""
    echo "=== Edge Cases ==="

    run_stdout_test "empty format string" \
        "$GNU_TOOL ''" \
        "$F_TOOL ''"

    run_stdout_test "format with no specifiers" \
        "$GNU_TOOL 'hello world\n'" \
        "$F_TOOL 'hello world\n'"

    run_stdout_test "%s with empty arg" \
        "$GNU_TOOL '%s\n' ''" \
        "$F_TOOL '%s\n' ''"

    run_stdout_test "negative integer" \
        "$GNU_TOOL '%d\n' -- -42" \
        "$F_TOOL '%d\n' -- -42"

    run_stdout_test "large integer" \
        "$GNU_TOOL '%d\n' 2147483647" \
        "$F_TOOL '%d\n' 2147483647"

    run_stdout_test "zero" \
        "$GNU_TOOL '%d\n' 0" \
        "$F_TOOL '%d\n' 0"

    # === Section 11: %q Shell Quoting ===
    echo ""
    echo "=== %q Shell Quoting ==="

    run_stdout_test "%q simple" \
        "$GNU_TOOL '%q\n' hello" \
        "$F_TOOL '%q\n' hello"

    run_stdout_test "%q with spaces" \
        "$GNU_TOOL '%q\n' 'hello world'" \
        "$F_TOOL '%q\n' 'hello world'"

    run_stdout_test "%q with special chars" \
        "$GNU_TOOL '%q\n' 'it'\''s'" \
        "$F_TOOL '%q\n' 'it'\''s'"

    finish_test_suite
}

run_printf_tests
