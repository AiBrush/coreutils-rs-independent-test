#!/usr/bin/env bash
# Compatibility tests for fecho vs GNU echo
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

# GNU echo is NOT the shell builtin — we need the external binary
if [[ -x /usr/bin/echo ]]; then
    GNU_TOOL="/usr/bin/echo"
elif [[ -x /bin/echo ]]; then
    GNU_TOOL="/bin/echo"
elif command -v gecho &>/dev/null; then
    GNU_TOOL="gecho"
else
    GNU_TOOL="env echo"
fi

F_TOOL="fecho"

run_echo_tests() {
    init_test_suite "echo"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"echo","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/echo_results.json"
        return 0
    fi

    if ! command -v $GNU_TOOL &>/dev/null && ! [[ -x $GNU_TOOL ]]; then
        echo "GNU echo not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: Basic Output ===
    echo ""
    echo "=== Basic Output ==="

    run_stdout_test "no arguments (just newline)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_stdout_test "single argument" \
        "$GNU_TOOL hello" \
        "$F_TOOL hello"

    run_stdout_test "multiple arguments (space separated)" \
        "$GNU_TOOL hello world" \
        "$F_TOOL hello world"

    run_stdout_test "three arguments" \
        "$GNU_TOOL one two three" \
        "$F_TOOL one two three"

    run_stdout_test "argument with numbers" \
        "$GNU_TOOL 12345" \
        "$F_TOOL 12345"

    # === Section 2: -n Flag (No Trailing Newline) ===
    echo ""
    echo "=== -n Flag (No Trailing Newline) ==="

    run_stdout_test "-n with no args" \
        "$GNU_TOOL -n" \
        "$F_TOOL -n"

    run_stdout_test "-n hello" \
        "$GNU_TOOL -n hello" \
        "$F_TOOL -n hello"

    run_stdout_test "-n hello world" \
        "$GNU_TOOL -n hello world" \
        "$F_TOOL -n hello world"

    run_stdout_test "-n with empty string" \
        "$GNU_TOOL -n ''" \
        "$F_TOOL -n ''"

    # === Section 3: -e Flag (Escape Sequences) ===
    echo ""
    echo "=== -e Flag (Escape Sequences) ==="

    run_stdout_test "-e tab escape" \
        "$GNU_TOOL -e 'hello\tworld'" \
        "$F_TOOL -e 'hello\tworld'"

    run_stdout_test "-e newline escape" \
        "$GNU_TOOL -e 'hello\nworld'" \
        "$F_TOOL -e 'hello\nworld'"

    run_stdout_test "-e backslash escape" \
        "$GNU_TOOL -e 'hello\\\\world'" \
        "$F_TOOL -e 'hello\\\\world'"

    run_stdout_test "-e bell character" \
        "$GNU_TOOL -e '\a'" \
        "$F_TOOL -e '\a'"

    run_stdout_test "-e backspace" \
        "$GNU_TOOL -e '\b'" \
        "$F_TOOL -e '\b'"

    run_stdout_test "-e escape char" \
        "$GNU_TOOL -e '\e'" \
        "$F_TOOL -e '\e'"

    run_stdout_test "-e form feed" \
        "$GNU_TOOL -e '\f'" \
        "$F_TOOL -e '\f'"

    run_stdout_test "-e carriage return" \
        "$GNU_TOOL -e '\r'" \
        "$F_TOOL -e '\r'"

    run_stdout_test "-e vertical tab" \
        "$GNU_TOOL -e '\v'" \
        "$F_TOOL -e '\v'"

    run_stdout_test "-e octal 0101 (A)" \
        "$GNU_TOOL -e '\0101'" \
        "$F_TOOL -e '\0101'"

    run_stdout_test "-e hex x41 (A)" \
        "$GNU_TOOL -e '\x41'" \
        "$F_TOOL -e '\x41'"

    run_stdout_test "-e \\c suppress trailing" \
        "$GNU_TOOL -e 'stop\cignored'" \
        "$F_TOOL -e 'stop\cignored'"

    run_stdout_test "-e multiple escapes" \
        "$GNU_TOOL -e 'a\tb\nc\td'" \
        "$F_TOOL -e 'a\tb\nc\td'"

    # === Section 4: -E Flag (Disable Escapes) ===
    echo ""
    echo "=== -E Flag (Disable Escapes) ==="

    run_stdout_test "-E literal backslash-t" \
        "$GNU_TOOL -E 'hello\tworld'" \
        "$F_TOOL -E 'hello\tworld'"

    run_stdout_test "default is -E (literal backslash-n)" \
        "$GNU_TOOL 'hello\nworld'" \
        "$F_TOOL 'hello\nworld'"

    # === Section 5: Combined Flags ===
    echo ""
    echo "=== Combined Flags ==="

    run_stdout_test "-ne hello\\n" \
        "$GNU_TOOL -ne 'hello\n'" \
        "$F_TOOL -ne 'hello\n'"

    run_stdout_test "-en hello" \
        "$GNU_TOOL -en 'hello'" \
        "$F_TOOL -en 'hello'"

    run_stdout_test "-nE hello\\t" \
        "$GNU_TOOL -nE 'hello\t'" \
        "$F_TOOL -nE 'hello\t'"

    # === Section 6: Non-Flag Arguments That Look Like Flags ===
    echo ""
    echo "=== Non-Flag Edge Cases ==="

    run_stdout_test "-a is not a valid flag (printed literally)" \
        "$GNU_TOOL -a" \
        "$F_TOOL -a"

    run_stdout_test "-- is not supported (printed literally)" \
        "$GNU_TOOL --" \
        "$F_TOOL --"

    run_stdout_test "single dash" \
        "$GNU_TOOL -" \
        "$F_TOOL -"

    run_stdout_test "-nee hello (multiple flag chars)" \
        "$GNU_TOOL -nee hello" \
        "$F_TOOL -nee hello"

    run_stdout_test "-neE hello" \
        "$GNU_TOOL -neE hello" \
        "$F_TOOL -neE hello"

    run_stdout_test "-z is not a valid flag" \
        "$GNU_TOOL -z" \
        "$F_TOOL -z"

    # === Section 7: Empty/Edge Inputs ===
    echo ""
    echo "=== Empty/Edge Inputs ==="

    run_stdout_test "empty string argument" \
        "$GNU_TOOL ''" \
        "$F_TOOL ''"

    run_stdout_test "two empty string arguments" \
        "$GNU_TOOL '' ''" \
        "$F_TOOL '' ''"

    run_stdout_test "many arguments" \
        "$GNU_TOOL a b c d e f g h i j" \
        "$F_TOOL a b c d e f g h i j"

    run_stdout_test "argument with spaces in quotes" \
        "$GNU_TOOL 'hello world'" \
        "$F_TOOL 'hello world'"

    run_stdout_test "leading/trailing spaces" \
        "$GNU_TOOL '  hello  '" \
        "$F_TOOL '  hello  '"

    finish_test_suite
}

run_echo_tests
