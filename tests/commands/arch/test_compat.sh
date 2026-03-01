#!/usr/bin/env bash
# Compatibility tests for farch vs GNU arch
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "arch")
F_TOOL="farch"

run_arch_tests() {
    init_test_suite "arch"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"arch","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/arch_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU arch not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    run_test "machine architecture" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "matches uname -m" \
        "uname -m" \
        "$F_TOOL"

    run_test "exit code 0" \
        "$GNU_TOOL > /dev/null && echo 'EXIT_OK'" \
        "$F_TOOL > /dev/null && echo 'EXIT_OK'"

    run_test "single line output" \
        "$GNU_TOOL | wc -l" \
        "$F_TOOL | wc -l"

    echo ""
    echo "=== GNU Upstream: Double-Dash Separator ==="

    run_test "double-dash separator" \
        "$GNU_TOOL --" \
        "$F_TOOL --"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "extra arguments" \
        "$GNU_TOOL extra_arg 2>&1" \
        "$F_TOOL extra_arg 2>&1"

    run_exit_code_test "multiple extra args" \
        "$GNU_TOOL arg1 arg2 2>&1" \
        "$F_TOOL arg1 arg2 2>&1"

    run_exit_code_test "invalid option" \
        "$GNU_TOOL --invalid-option 2>&1" \
        "$F_TOOL --invalid-option 2>&1"

    echo ""
    echo "=== Options ==="

    run_exit_code_test "version flag" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    run_exit_code_test "help flag" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    echo ""
    echo "=== Output Format ==="

    # Piped output should be the same
    run_test "piped through cat" \
        "$GNU_TOOL | cat" \
        "$F_TOOL | cat"

    # Output should have no trailing spaces
    run_test "no trailing spaces" \
        "$GNU_TOOL | sed 's/[[:space:]]*$//' " \
        "$F_TOOL | sed 's/[[:space:]]*$//' "

    # No stderr on success
    run_test "stderr clean on success" \
        "$GNU_TOOL 2>/tmp/gnu_arch_err_$$ >/dev/null; wc -c < /tmp/gnu_arch_err_$$ | tr -d ' '; rm -f /tmp/gnu_arch_err_$$" \
        "$F_TOOL 2>/tmp/f_arch_err_$$ >/dev/null; wc -c < /tmp/f_arch_err_$$ | tr -d ' '; rm -f /tmp/f_arch_err_$$"

    # Consistent results across runs
    run_test "consistent output" \
        "out1=\$($GNU_TOOL); out2=\$($GNU_TOOL); [ \"\$out1\" = \"\$out2\" ] && echo CONSISTENT || echo INCONSISTENT" \
        "out1=\$($F_TOOL); out2=\$($F_TOOL); [ \"\$out1\" = \"\$out2\" ] && echo CONSISTENT || echo INCONSISTENT"

    # Output non-empty
    run_test "non-empty output" \
        "$GNU_TOOL | wc -c | tr -d ' '" \
        "$F_TOOL | wc -c | tr -d ' '"

    # Output matches known architecture values
    run_test "known architecture value" \
        "$GNU_TOOL | grep -cE '^(x86_64|aarch64|arm64|i686|i386|armv7l|ppc64le|s390x|riscv64)$' | tr -d ' '" \
        "$F_TOOL | grep -cE '^(x86_64|aarch64|arm64|i686|i386|armv7l|ppc64le|s390x|riscv64)$' | tr -d ' '"

    # Output ends with newline
    run_test "ends with newline" \
        "$GNU_TOOL | xxd | tail -1 | grep -c '0a' | tr -d ' ' || echo 0" \
        "$F_TOOL | xxd | tail -1 | grep -c '0a' | tr -d ' ' || echo 0"

    finish_test_suite
}

run_arch_tests
