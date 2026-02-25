#!/usr/bin/env bash
# Compatibility tests for fstdbuf vs GNU stdbuf
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "stdbuf")
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

    # === GNU Upstream: Size Syntax Validation ===
    echo ""
    echo "=== GNU Upstream: Size Syntax Validation ==="

    run_exit_code_test "-o1 with true (numeric size)" \
        "$GNU_TOOL -o1 true 2>&1" \
        "$F_TOOL -o1 true 2>&1"

    run_exit_code_test "-oK with true (K suffix)" \
        "$GNU_TOOL -oK true 2>&1" \
        "$F_TOOL -oK true 2>&1"

    run_exit_code_test "-o0 with true (unbuffered)" \
        "$GNU_TOOL -o0 true 2>&1" \
        "$F_TOOL -o0 true 2>&1"

    run_exit_code_test "-oL with true (line buffered)" \
        "$GNU_TOOL -oL true 2>&1" \
        "$F_TOOL -oL true 2>&1"

    # === GNU Upstream: Invalid Parameters ===
    echo ""
    echo "=== GNU Upstream: Invalid Parameters ==="

    run_exit_code_test "lowercase -ol rejected" \
        "$GNU_TOOL -ol true 2>&1" \
        "$F_TOOL -ol true 2>&1"

    run_exit_code_test "-iL stdin line buffer disallowed" \
        "$GNU_TOOL -iL true 2>&1" \
        "$F_TOOL -iL true 2>&1"

    run_exit_code_test "no buffering mode specified" \
        "$GNU_TOOL true 2>&1" \
        "$F_TOOL true 2>&1"

    run_exit_code_test "-o1 nonexistent command" \
        "$GNU_TOOL -o1 no_such 2>&1" \
        "$F_TOOL -o1 no_such 2>&1"

    # === GNU Upstream: All Streams Buffering ===
    echo ""
    echo "=== GNU Upstream: All Streams Buffering ==="

    run_exit_code_test "-i0 -o0 -e0 all unbuffered" \
        "$GNU_TOOL -i0 -o0 -e0 true 2>&1" \
        "$F_TOOL -i0 -o0 -e0 true 2>&1"

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
