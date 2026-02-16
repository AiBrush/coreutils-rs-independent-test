#!/usr/bin/env bash
# Compatibility tests for fdirname vs GNU dirname
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="dirname"
F_TOOL="fdirname"

run_dirname_tests() {
    init_test_suite "dirname"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dirname","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/dirname_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU dirname not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Dirname ==="

    run_test "simple path" \
        "$GNU_TOOL /usr/bin/sort" \
        "$F_TOOL /usr/bin/sort"

    run_test "two-level path" \
        "$GNU_TOOL /usr/bin" \
        "$F_TOOL /usr/bin"

    run_test "root file" \
        "$GNU_TOOL /file.txt" \
        "$F_TOOL /file.txt"

    run_test "filename only" \
        "$GNU_TOOL file.txt" \
        "$F_TOOL file.txt"

    run_test "root" \
        "$GNU_TOOL /" \
        "$F_TOOL /"

    run_test "current dir" \
        "$GNU_TOOL ." \
        "$F_TOOL ."

    run_test "parent dir" \
        "$GNU_TOOL .." \
        "$F_TOOL .."

    run_test "trailing slash" \
        "$GNU_TOOL /usr/bin/" \
        "$F_TOOL /usr/bin/"

    run_test "double trailing slash" \
        "$GNU_TOOL /usr/bin//" \
        "$F_TOOL /usr/bin//"

    echo ""
    echo "=== Multiple Paths ==="

    run_test "multiple arguments" \
        "$GNU_TOOL /usr/bin/sort /etc/hosts /var/log/syslog" \
        "$F_TOOL /usr/bin/sort /etc/hosts /var/log/syslog"

    echo ""
    echo "=== Zero Terminated (-z) ==="

    run_test "-z null terminated" \
        "$GNU_TOOL -z /usr/bin/sort | od -c" \
        "$F_TOOL -z /usr/bin/sort | od -c"

    run_test "-z multiple" \
        "$GNU_TOOL -z /usr/bin/sort /etc/hosts | od -c" \
        "$F_TOOL -z /usr/bin/sort /etc/hosts | od -c"

    echo ""
    echo "=== Edge Cases ==="

    run_test "single slash" \
        "$GNU_TOOL /" \
        "$F_TOOL /"

    run_test "multiple slashes" \
        "$GNU_TOOL ////" \
        "$F_TOOL ////"

    run_test "double slashes in path" \
        "$GNU_TOOL //usr//bin//file" \
        "$F_TOOL //usr//bin//file"

    run_test "relative path" \
        "$GNU_TOOL path/to/file.txt" \
        "$F_TOOL path/to/file.txt"

    run_test "hidden file" \
        "$GNU_TOOL /home/user/.bashrc" \
        "$F_TOOL /home/user/.bashrc"

    run_test "path with spaces" \
        "$GNU_TOOL '/path/to my/file.txt'" \
        "$F_TOOL '/path/to my/file.txt'"

    run_test "just a filename" \
        "$GNU_TOOL hello" \
        "$F_TOOL hello"

    run_test "empty string" \
        "$GNU_TOOL ''" \
        "$F_TOOL ''"

    run_test "dot dot path" \
        "$GNU_TOOL ../foo/bar" \
        "$F_TOOL ../foo/bar"

    run_test "deeply nested" \
        "$GNU_TOOL /a/b/c/d/e/f/g/h" \
        "$F_TOOL /a/b/c/d/e/f/g/h"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    finish_test_suite
}

run_dirname_tests
