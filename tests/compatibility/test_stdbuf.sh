#!/usr/bin/env bash
# Compatibility tests for fstdbuf vs GNU stdbuf
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="stdbuf"
F_TOOL="fstdbuf"

run_stdbuf_tests() {
    init_test_suite "stdbuf"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"stdbuf","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/stdbuf_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU stdbuf not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: Basic Execution ===
    echo ""
    echo "=== Basic Execution ==="

    run_stdout_test "line buffered stdout with echo" \
        "$GNU_TOOL -oL /usr/bin/echo hello" \
        "$F_TOOL -oL /usr/bin/echo hello"

    run_stdout_test "unbuffered stdout with echo" \
        "$GNU_TOOL -o0 /usr/bin/echo hello" \
        "$F_TOOL -o0 /usr/bin/echo hello"

    run_stdout_test "line buffered with cat" \
        "echo test | $GNU_TOOL -oL cat" \
        "echo test | $F_TOOL -oL cat"

    # === Section 2: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "--help exits successfully" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version exits successfully" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    finish_test_suite
}

run_stdbuf_tests
