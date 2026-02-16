#!/usr/bin/env bash
# Compatibility tests for funame vs GNU uname
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="uname"
F_TOOL="funame"

run_uname_tests() {
    init_test_suite "uname"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"uname","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/uname_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU uname not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Default (kernel name) ==="

    run_test "default output" \
        "$GNU_TOOL" \
        "$F_TOOL"

    echo ""
    echo "=== Individual Flags ==="

    run_test "-s kernel name" \
        "$GNU_TOOL -s" \
        "$F_TOOL -s"

    run_test "-n nodename" \
        "$GNU_TOOL -n" \
        "$F_TOOL -n"

    run_test "-r kernel release" \
        "$GNU_TOOL -r" \
        "$F_TOOL -r"

    run_test "-v kernel version" \
        "$GNU_TOOL -v" \
        "$F_TOOL -v"

    run_test "-m machine" \
        "$GNU_TOOL -m" \
        "$F_TOOL -m"

    run_test "-p processor" \
        "$GNU_TOOL -p" \
        "$F_TOOL -p"

    run_test "-i hardware platform" \
        "$GNU_TOOL -i" \
        "$F_TOOL -i"

    run_test "-o operating system" \
        "$GNU_TOOL -o" \
        "$F_TOOL -o"

    echo ""
    echo "=== All Information (-a) ==="

    run_test "-a all information" \
        "$GNU_TOOL -a" \
        "$F_TOOL -a"

    echo ""
    echo "=== Combined Flags ==="

    run_test "-snr kernel name + node + release" \
        "$GNU_TOOL -snr" \
        "$F_TOOL -snr"

    run_test "-sm kernel + machine" \
        "$GNU_TOOL -sm" \
        "$F_TOOL -sm"

    run_test "-srvm release + version + machine" \
        "$GNU_TOOL -srvm" \
        "$F_TOOL -srvm"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "invalid option" \
        "$GNU_TOOL -Z 2>&1" \
        "$F_TOOL -Z 2>&1"

    finish_test_suite
}

run_uname_tests
