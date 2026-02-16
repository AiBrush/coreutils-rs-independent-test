#!/usr/bin/env bash
# Compatibility tests for fbasename vs GNU basename
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="basename"
F_TOOL="fbasename"

run_basename_tests() {
    init_test_suite "basename"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"basename","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/basename_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU basename not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Basename ==="

    run_test "simple path" \
        "$GNU_TOOL /usr/bin/sort" \
        "$F_TOOL /usr/bin/sort"

    run_test "filename only" \
        "$GNU_TOOL file.txt" \
        "$F_TOOL file.txt"

    run_test "path with trailing slash" \
        "$GNU_TOOL /usr/bin/" \
        "$F_TOOL /usr/bin/"

    run_test "root path" \
        "$GNU_TOOL /" \
        "$F_TOOL /"

    run_test "current dir" \
        "$GNU_TOOL ." \
        "$F_TOOL ."

    run_test "parent dir" \
        "$GNU_TOOL .." \
        "$F_TOOL .."

    run_test "double slashes" \
        "$GNU_TOOL //usr//bin//file" \
        "$F_TOOL //usr//bin//file"

    run_test "just a name" \
        "$GNU_TOOL hello" \
        "$F_TOOL hello"

    echo ""
    echo "=== Suffix Stripping ==="

    run_test "strip .txt suffix" \
        "$GNU_TOOL /path/to/file.txt .txt" \
        "$F_TOOL /path/to/file.txt .txt"

    run_test "strip .tar.gz suffix" \
        "$GNU_TOOL archive.tar.gz .tar.gz" \
        "$F_TOOL archive.tar.gz .tar.gz"

    run_test "suffix not found (no strip)" \
        "$GNU_TOOL file.txt .csv" \
        "$F_TOOL file.txt .csv"

    run_test "suffix equals filename (no strip)" \
        "$GNU_TOOL .txt .txt" \
        "$F_TOOL .txt .txt"

    run_test "strip single char suffix" \
        "$GNU_TOOL file.c .c" \
        "$F_TOOL file.c .c"

    run_test "empty suffix" \
        "$GNU_TOOL /path/to/file ''" \
        "$F_TOOL /path/to/file ''"

    echo ""
    echo "=== Multiple Mode (-a) ==="

    run_test "-a multiple paths" \
        "$GNU_TOOL -a /usr/bin/sort /usr/bin/wc /etc/hosts" \
        "$F_TOOL -a /usr/bin/sort /usr/bin/wc /etc/hosts"

    run_test "-a with suffix (-s)" \
        "$GNU_TOOL -a -s .txt /path/file.txt /path/other.txt" \
        "$F_TOOL -a -s .txt /path/file.txt /path/other.txt"

    echo ""
    echo "=== Zero Terminated (-z) ==="

    run_test "-z null terminated" \
        "$GNU_TOOL -z /usr/bin/sort | od -c" \
        "$F_TOOL -z /usr/bin/sort | od -c"

    run_test "-az multiple null terminated" \
        "$GNU_TOOL -az /usr/bin/sort /usr/bin/wc | od -c" \
        "$F_TOOL -az /usr/bin/sort /usr/bin/wc | od -c"

    echo ""
    echo "=== Edge Cases ==="

    run_test "single slash" \
        "$GNU_TOOL /" \
        "$F_TOOL /"

    run_test "multiple slashes" \
        "$GNU_TOOL ////" \
        "$F_TOOL ////"

    run_test "hidden file" \
        "$GNU_TOOL /home/user/.bashrc" \
        "$F_TOOL /home/user/.bashrc"

    run_test "path with spaces" \
        "$GNU_TOOL '/path/to/my file.txt'" \
        "$F_TOOL '/path/to/my file.txt'"

    run_test "empty string" \
        "$GNU_TOOL ''" \
        "$F_TOOL ''"

    run_test "dot file" \
        "$GNU_TOOL /path/.hidden" \
        "$F_TOOL /path/.hidden"

    run_test "no slash" \
        "$GNU_TOOL filename.ext .ext" \
        "$F_TOOL filename.ext .ext"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    finish_test_suite
}

run_basename_tests
