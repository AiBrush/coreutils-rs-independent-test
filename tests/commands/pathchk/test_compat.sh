#!/usr/bin/env bash
# Compatibility tests for fpathchk vs GNU pathchk
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "pathchk")
F_TOOL="fpathchk"

run_pathchk_tests() {
    init_test_suite "pathchk"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pathchk","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/pathchk_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU pathchk not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Valid Paths ==="

    run_exit_code_test "simple valid path" \
        "$GNU_TOOL /tmp/valid_path 2>&1" \
        "$F_TOOL /tmp/valid_path 2>&1"

    run_exit_code_test "relative path" \
        "$GNU_TOOL some/relative/path 2>&1" \
        "$F_TOOL some/relative/path 2>&1"

    run_exit_code_test "simple filename" \
        "$GNU_TOOL filename.txt 2>&1" \
        "$F_TOOL filename.txt 2>&1"

    run_exit_code_test "root path" \
        "$GNU_TOOL / 2>&1" \
        "$F_TOOL / 2>&1"

    run_exit_code_test "dot" \
        "$GNU_TOOL . 2>&1" \
        "$F_TOOL . 2>&1"

    echo ""
    echo "=== Empty Path ==="

    run_exit_code_test "empty string" \
        "$GNU_TOOL '' 2>&1" \
        "$F_TOOL '' 2>&1"

    echo ""
    echo "=== POSIX Portable (-p) ==="

    run_exit_code_test "-p valid portable name" \
        "$GNU_TOOL -p /tmp/valid_file 2>&1" \
        "$F_TOOL -p /tmp/valid_file 2>&1"

    run_exit_code_test "-p portable chars only" \
        "$GNU_TOOL -p 'abc-def_123.txt' 2>&1" \
        "$F_TOOL -p 'abc-def_123.txt' 2>&1"

    run_exit_code_test "-p leading hyphen" \
        "$GNU_TOOL -p '/tmp/-badname' 2>&1" \
        "$F_TOOL -p '/tmp/-badname' 2>&1"

    echo ""
    echo "=== Extended Portable (-P) ==="

    run_exit_code_test "-P valid" \
        "$GNU_TOOL -P valid_file 2>&1" \
        "$F_TOOL -P valid_file 2>&1"

    run_exit_code_test "-P leading hyphen" \
        "$GNU_TOOL -P -- '-file' 2>&1" \
        "$F_TOOL -P -- '-file' 2>&1"

    run_exit_code_test "-P empty component" \
        "$GNU_TOOL -P 'path//double' 2>&1" \
        "$F_TOOL -P 'path//double' 2>&1"

    echo ""
    echo "=== Multiple Paths ==="

    run_exit_code_test "multiple valid" \
        "$GNU_TOOL /tmp /usr /etc 2>&1" \
        "$F_TOOL /tmp /usr /etc 2>&1"

    run_exit_code_test "mix valid and empty" \
        "$GNU_TOOL /tmp '' /etc 2>&1" \
        "$F_TOOL /tmp '' /etc 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_exit_code_test "very long component" \
        "$GNU_TOOL -p \$(python3 -c \"print('a' * 300)\") 2>&1" \
        "$F_TOOL -p \$(python3 -c \"print('a' * 300)\") 2>&1"

    run_exit_code_test "path with null byte" \
        "$GNU_TOOL \$'path\\x00null' 2>&1" \
        "$F_TOOL \$'path\\x00null' 2>&1"

    echo ""
    echo "=== GNU Upstream: Path Validation Edge Cases ==="

    # GNU pathchk.sh: file/x should fail when 'file' exists as a regular file
    local pathchk_dir
    pathchk_dir=$(mktemp -d /tmp/fcoreutils_pathchk_XXXXXX)
    register_temp "$pathchk_dir"
    touch "$pathchk_dir/file"

    run_exit_code_test "file component is not a directory" \
        "$GNU_TOOL '$pathchk_dir/file/x' 2>&1" \
        "$F_TOOL '$pathchk_dir/file/x' 2>&1"

    # GNU pathchk.sh: -p '' should fail (empty string in portable mode)
    run_exit_code_test "-p rejects empty string" \
        "$GNU_TOOL -p '' 2>&1" \
        "$F_TOOL -p '' 2>&1"

    # GNU pathchk.sh: -P '' should fail
    run_exit_code_test "-P rejects empty string" \
        "$GNU_TOOL -P '' 2>&1" \
        "$F_TOOL -P '' 2>&1"

    # GNU pathchk.sh: -P -- - should fail (leading hyphen)
    run_exit_code_test "-P rejects leading hyphen" \
        "$GNU_TOOL -P -- - 2>&1" \
        "$F_TOOL -P -- - 2>&1"

    # GNU pathchk.sh: -p -P x/- should fail (hyphen component)
    run_exit_code_test "-p -P rejects hyphen in component" \
        "$GNU_TOOL -p -P x/- 2>&1" \
        "$F_TOOL -p -P x/- 2>&1"

    rm -rf "$pathchk_dir"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"


    finish_test_suite
}

run_pathchk_tests
