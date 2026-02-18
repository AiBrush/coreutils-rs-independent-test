#!/usr/bin/env bash
# Compatibility tests for fyes vs GNU yes
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="yes"
F_TOOL="fyes"

run_yes_tests() {
    init_test_suite "yes"
    # No test data needed for yes (it's a generator, not a file processor)

    # NOTE: We cannot use check_tool_exists for 'yes' because it pipes
    # "echo test | $tool" which would hang (yes ignores stdin and writes forever).
    # Instead, check directly with command -v.
    if ! command -v "$F_TOOL" &>/dev/null; then
        echo -e "${YELLOW}SKIP: $F_TOOL not found in PATH${NC}"
        echo '{"tool":"yes","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/yes_results.json"
        return 0
    fi

    if ! command -v "$GNU_TOOL" &>/dev/null; then
        echo "GNU yes not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Output Tests ==="

    # yes runs forever; pipe through head to limit output.
    # Both GNU yes and fyes will receive SIGPIPE when head closes the pipe.
    run_test "default output (y)" \
        "$GNU_TOOL | head -n 100" \
        "$F_TOOL | head -n 100"

    run_test "single arg" \
        "$GNU_TOOL hello | head -n 100" \
        "$F_TOOL hello | head -n 100"

    run_test "multiple args (space-joined)" \
        "$GNU_TOOL hello world | head -n 100" \
        "$F_TOOL hello world | head -n 100"

    run_test "empty string arg" \
        "$GNU_TOOL '' | head -n 10" \
        "$F_TOOL '' | head -n 10"

    run_test "numeric arg" \
        "$GNU_TOOL 42 | head -n 10" \
        "$F_TOOL 42 | head -n 10"

    run_test "three args" \
        "$GNU_TOOL a b c | head -n 20" \
        "$F_TOOL a b c | head -n 20"

    run_test "arg with spaces (quoted)" \
        "$GNU_TOOL 'hello world' | head -n 10" \
        "$F_TOOL 'hello world' | head -n 10"

    run_test "special characters" \
        "$GNU_TOOL '!@#\$%' | head -n 10" \
        "$F_TOOL '!@#\$%' | head -n 10"

    echo ""
    echo "=== End-of-Options (--) ==="

    run_test "-- then arg" \
        "$GNU_TOOL -- foo | head -n 10" \
        "$F_TOOL -- foo | head -n 10"

    run_test "-- alone (falls to default y)" \
        "$GNU_TOOL -- | head -n 5" \
        "$F_TOOL -- | head -n 5"

    run_test "-- then --help (literal string)" \
        "$GNU_TOOL -- --help | head -n 5" \
        "$F_TOOL -- --help | head -n 5"

    run_test "-- then --version (literal string)" \
        "$GNU_TOOL -- --version | head -n 5" \
        "$F_TOOL -- --version | head -n 5"

    echo ""
    echo "=== Option-like Strings (treated as output) ==="

    # GNU yes treats unrecognized options as output strings
    run_test "long option treated as string" \
        "$GNU_TOOL --badopt | head -n 5" \
        "$F_TOOL --badopt | head -n 5"

    run_test "short option treated as string" \
        "$GNU_TOOL -z | head -n 5" \
        "$F_TOOL -z | head -n 5"

    echo ""
    echo "=== --help / --version ==="

    # --help and --version: check exit code 0 and non-empty stdout.
    # Assembly binary matches GNU exactly; Rust fallback has different format.
    # So we only validate behavior, not byte-exact output.
    TESTS_RUN=$((TESTS_RUN + 1))
    local help_exit=0
    local help_out=""
    help_out=$(timeout 5 "$F_TOOL" --help 2>&1) || help_exit=$?
    if [[ "$help_exit" -eq 0 ]] && [[ -n "$help_out" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --help exits 0 with output"
        record_result "--help exits 0 with output" "PASS" "" "" "$F_TOOL --help"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --help should exit 0 with output (exit=$help_exit, len=${#help_out})"
        record_result "--help exits 0 with output" "FAIL" "exit=$help_exit, output_len=${#help_out}" "" "$F_TOOL --help"
    fi

    TESTS_RUN=$((TESTS_RUN + 1))
    local ver_exit=0
    local ver_out=""
    ver_out=$(timeout 5 "$F_TOOL" --version 2>&1) || ver_exit=$?
    if [[ "$ver_exit" -eq 0 ]] && [[ -n "$ver_out" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --version exits 0 with output"
        record_result "--version exits 0 with output" "PASS" "" "" "$F_TOOL --version"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --version should exit 0 with output (exit=$ver_exit, len=${#ver_out})"
        record_result "--version exits 0 with output" "FAIL" "exit=$ver_exit, output_len=${#ver_out}" "" "$F_TOOL --version"
    fi

    echo ""
    echo "=== Pipe Handling ==="

    run_test "pipe closes cleanly (head -n 5)" \
        "$GNU_TOOL | head -n 5" \
        "$F_TOOL | head -n 5"

    run_test "pipe to wc -l (1000 lines)" \
        "$GNU_TOOL | head -n 1000 | wc -l" \
        "$F_TOOL | head -n 1000 | wc -l"

    run_test "pipe arg to wc -l (500 lines)" \
        "$GNU_TOOL hello | head -n 500 | wc -l" \
        "$F_TOOL hello | head -n 500 | wc -l"

    echo ""
    echo "=== Large Output Tests ==="

    # Compare first 10KB of output byte-for-byte
    run_test "large output 10KB default" \
        "$GNU_TOOL | head -c 10000" \
        "$F_TOOL | head -c 10000"

    run_test "large output 10KB with arg" \
        "$GNU_TOOL test | head -c 10000" \
        "$F_TOOL test | head -c 10000"

    run_test "10000 lines" \
        "$GNU_TOOL | head -n 10000" \
        "$F_TOOL | head -n 10000"

    run_test "10000 lines with arg" \
        "$GNU_TOOL hello | head -n 10000" \
        "$F_TOOL hello | head -n 10000"

    finish_test_suite
}

run_yes_tests
