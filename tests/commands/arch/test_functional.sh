#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="farch"
run_arch_functional_tests() {
    init_test_suite "arch"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"arch","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/arch_results.json"
        return 0
    fi
    # arch should output a non-empty architecture string
    run_expected_exit_test "exits 0" "$F_TOOL" 0

    # Output should match uname -m
    local expected_arch
    expected_arch=$(uname -m)
    run_expected_test "matches uname -m" "$F_TOOL" "$expected_arch"

    # Single line output
    run_expected_test "single line output" \
        "$F_TOOL | wc -l | tr -d ' '" \
        "1"

    # Piped output works
    run_expected_test "piped through cat" \
        "$F_TOOL | cat" \
        "$expected_arch"

    # Output is non-empty
    run_expected_test "non-empty output" \
        "[ -n \"\$($F_TOOL)\" ] && echo YES || echo NO" \
        "YES"

    # No trailing whitespace
    run_expected_test "no trailing whitespace" \
        "$F_TOOL | grep -c '[[:space:]]$' || echo 0" \
        "0"

    # Consistent across runs
    run_expected_test "consistent output" \
        "a=\$($F_TOOL); b=\$($F_TOOL); [ \"\$a\" = \"\$b\" ] && echo SAME || echo DIFF" \
        "SAME"

    # No stderr on success
    run_expected_test "stderr clean" \
        "$F_TOOL 2>/tmp/farch_err_$$ >/dev/null; wc -c < /tmp/farch_err_$$ | tr -d ' '; rm -f /tmp/farch_err_$$" \
        "0"

    # Output matches known architecture values
    run_expected_test "known architecture value" \
        "$F_TOOL | grep -cE '^(x86_64|aarch64|arm64|i686|i386|armv7l|ppc64le|s390x|riscv64)$' | tr -d ' '" \
        "1"

    # Invalid option should fail
    run_expected_exit_test "invalid option fails" "$F_TOOL --invalid-option 2>/dev/null" 1

    # Help flag exits 0
    run_expected_exit_test "help flag" "$F_TOOL --help 2>/dev/null" 0

    # Version flag exits 0
    run_expected_exit_test "version flag" "$F_TOOL --version 2>/dev/null" 0

    # Double-dash separator still works
    run_expected_test "double-dash separator" "$F_TOOL --" "$expected_arch"

    finish_test_suite
}
run_arch_functional_tests
