#!/usr/bin/env bash
# Compatibility tests for ftest vs GNU test
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

# Must use external test, not shell builtin
if [[ -x /usr/bin/test ]]; then
    GNU_TOOL="/usr/bin/test"
elif [[ -x /bin/test ]]; then
    GNU_TOOL="/bin/test"
elif command -v gtest &>/dev/null; then
    GNU_TOOL="gtest"
else
    GNU_TOOL="env test"
fi

F_TOOL="ftest"

run_test_tests() {
    init_test_suite "test"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"test","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/test_results.json"
        return 0
    fi

    if ! command -v $GNU_TOOL &>/dev/null && ! [[ -x $GNU_TOOL ]]; then
        echo "GNU test not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$test_dir"

    # Create test fixtures
    echo "content" > "$test_dir/regular_file"
    mkdir "$test_dir/a_directory"
    ln -s "$test_dir/regular_file" "$test_dir/a_symlink"
    ln -s /nonexistent "$test_dir/broken_link"
    mkfifo "$test_dir/a_pipe" 2>/dev/null || true
    chmod 755 "$test_dir/regular_file"

    # === Section 1: File Tests ===
    echo ""
    echo "=== File Tests ==="

    run_exit_code_test "-f regular file" \
        "$GNU_TOOL -f '$test_dir/regular_file'" \
        "$F_TOOL -f '$test_dir/regular_file'"

    run_exit_code_test "-f nonexistent" \
        "$GNU_TOOL -f /nonexistent" \
        "$F_TOOL -f /nonexistent"

    run_exit_code_test "-d directory" \
        "$GNU_TOOL -d '$test_dir/a_directory'" \
        "$F_TOOL -d '$test_dir/a_directory'"

    run_exit_code_test "-d on regular file" \
        "$GNU_TOOL -d '$test_dir/regular_file'" \
        "$F_TOOL -d '$test_dir/regular_file'"

    run_exit_code_test "-e /dev/null" \
        "$GNU_TOOL -e /dev/null" \
        "$F_TOOL -e /dev/null"

    run_exit_code_test "-e nonexistent" \
        "$GNU_TOOL -e /nonexistent" \
        "$F_TOOL -e /nonexistent"

    run_exit_code_test "-r readable file" \
        "$GNU_TOOL -r '$test_dir/regular_file'" \
        "$F_TOOL -r '$test_dir/regular_file'"

    run_exit_code_test "-w writable dir" \
        "$GNU_TOOL -w '$test_dir'" \
        "$F_TOOL -w '$test_dir'"

    run_exit_code_test "-x executable file" \
        "$GNU_TOOL -x '$test_dir/regular_file'" \
        "$F_TOOL -x '$test_dir/regular_file'"

    run_exit_code_test "-s non-empty file" \
        "$GNU_TOOL -s '$test_dir/regular_file'" \
        "$F_TOOL -s '$test_dir/regular_file'"

    run_exit_code_test "-s /dev/null (empty)" \
        "$GNU_TOOL -s /dev/null" \
        "$F_TOOL -s /dev/null"

    run_exit_code_test "-L symlink" \
        "$GNU_TOOL -L '$test_dir/a_symlink'" \
        "$F_TOOL -L '$test_dir/a_symlink'"

    run_exit_code_test "-L regular file (not symlink)" \
        "$GNU_TOOL -L '$test_dir/regular_file'" \
        "$F_TOOL -L '$test_dir/regular_file'"

    run_exit_code_test "-h symlink (alias for -L)" \
        "$GNU_TOOL -h '$test_dir/a_symlink'" \
        "$F_TOOL -h '$test_dir/a_symlink'"

    run_exit_code_test "-c /dev/null (char device)" \
        "$GNU_TOOL -c /dev/null" \
        "$F_TOOL -c /dev/null"

    if [[ -p "$test_dir/a_pipe" ]]; then
        run_exit_code_test "-p pipe" \
            "$GNU_TOOL -p '$test_dir/a_pipe'" \
            "$F_TOOL -p '$test_dir/a_pipe'"
    else
        skip_test "-p pipe" "mkfifo not available"
    fi

    # === Section 2: String Tests ===
    echo ""
    echo "=== String Tests ==="

    run_exit_code_test "-z empty string" \
        "$GNU_TOOL -z ''" \
        "$F_TOOL -z ''"

    run_exit_code_test "-z non-empty string" \
        "$GNU_TOOL -z 'hello'" \
        "$F_TOOL -z 'hello'"

    run_exit_code_test "-n non-empty string" \
        "$GNU_TOOL -n 'hello'" \
        "$F_TOOL -n 'hello'"

    run_exit_code_test "-n empty string" \
        "$GNU_TOOL -n ''" \
        "$F_TOOL -n ''"

    run_exit_code_test "string = same string" \
        "$GNU_TOOL 'hello' = 'hello'" \
        "$F_TOOL 'hello' = 'hello'"

    run_exit_code_test "string = different string" \
        "$GNU_TOOL 'hello' = 'world'" \
        "$F_TOOL 'hello' = 'world'"

    run_exit_code_test "string != different string" \
        "$GNU_TOOL 'hello' != 'world'" \
        "$F_TOOL 'hello' != 'world'"

    run_exit_code_test "string != same string" \
        "$GNU_TOOL 'hello' != 'hello'" \
        "$F_TOOL 'hello' != 'hello'"

    # === Section 3: Integer Comparisons ===
    echo ""
    echo "=== Integer Comparisons ==="

    run_exit_code_test "5 -eq 5" \
        "$GNU_TOOL 5 -eq 5" \
        "$F_TOOL 5 -eq 5"

    run_exit_code_test "5 -eq 3" \
        "$GNU_TOOL 5 -eq 3" \
        "$F_TOOL 5 -eq 3"

    run_exit_code_test "5 -ne 3" \
        "$GNU_TOOL 5 -ne 3" \
        "$F_TOOL 5 -ne 3"

    run_exit_code_test "5 -gt 3" \
        "$GNU_TOOL 5 -gt 3" \
        "$F_TOOL 5 -gt 3"

    run_exit_code_test "3 -gt 5" \
        "$GNU_TOOL 3 -gt 5" \
        "$F_TOOL 3 -gt 5"

    run_exit_code_test "5 -lt 3" \
        "$GNU_TOOL 5 -lt 3" \
        "$F_TOOL 5 -lt 3"

    run_exit_code_test "3 -lt 5" \
        "$GNU_TOOL 3 -lt 5" \
        "$F_TOOL 3 -lt 5"

    run_exit_code_test "5 -ge 5" \
        "$GNU_TOOL 5 -ge 5" \
        "$F_TOOL 5 -ge 5"

    run_exit_code_test "5 -ge 6" \
        "$GNU_TOOL 5 -ge 6" \
        "$F_TOOL 5 -ge 6"

    run_exit_code_test "5 -le 5" \
        "$GNU_TOOL 5 -le 5" \
        "$F_TOOL 5 -le 5"

    run_exit_code_test "5 -le 4" \
        "$GNU_TOOL 5 -le 4" \
        "$F_TOOL 5 -le 4"

    # === Section 4: Logical Operators ===
    echo ""
    echo "=== Logical Operators ==="

    run_exit_code_test "! -f /nonexistent" \
        "$GNU_TOOL ! -f /nonexistent" \
        "$F_TOOL ! -f /nonexistent"

    run_exit_code_test "! -f existing" \
        "$GNU_TOOL ! -f '$test_dir/regular_file'" \
        "$F_TOOL ! -f '$test_dir/regular_file'"

    run_exit_code_test "-f file -a -r file" \
        "$GNU_TOOL -f '$test_dir/regular_file' -a -r '$test_dir/regular_file'" \
        "$F_TOOL -f '$test_dir/regular_file' -a -r '$test_dir/regular_file'"

    run_exit_code_test "-f /nonexistent -o -d /tmp" \
        "$GNU_TOOL -f /nonexistent -o -d /tmp" \
        "$F_TOOL -f /nonexistent -o -d /tmp"

    run_exit_code_test "-f /nonexistent -a -d /tmp" \
        "$GNU_TOOL -f /nonexistent -a -d /tmp" \
        "$F_TOOL -f /nonexistent -a -d /tmp"

    # === Section 5: Edge Cases ===
    echo ""
    echo "=== Edge Cases ==="

    run_exit_code_test "no arguments (exit 1)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_exit_code_test "empty string (false)" \
        "$GNU_TOOL ''" \
        "$F_TOOL ''"

    run_exit_code_test "non-empty string (true)" \
        "$GNU_TOOL 'hello'" \
        "$F_TOOL 'hello'"

    run_exit_code_test "-f as single arg (non-empty string = true)" \
        "$GNU_TOOL '-f'" \
        "$F_TOOL '-f'"

    run_exit_code_test "parenthesized empty" \
        "$GNU_TOOL '(' ')'" \
        "$F_TOOL '(' ')'"

    run_exit_code_test "single non-empty in parens" \
        "$GNU_TOOL '(' 'hello' ')'" \
        "$F_TOOL '(' 'hello' ')'"

    run_exit_code_test "nested negation" \
        "$GNU_TOOL ! ! 'hello'" \
        "$F_TOOL ! ! 'hello'"

    run_exit_code_test "comparison with negative numbers" \
        "$GNU_TOOL -5 -lt -3" \
        "$F_TOOL -5 -lt -3"

    # === Section 6: File Comparison Tests ===
    echo ""
    echo "=== File Comparison ==="

    echo "newer" > "$test_dir/newer_file"
    sleep 1
    echo "older" > "$test_dir/older_file"

    run_exit_code_test "-nt newer than" \
        "$GNU_TOOL '$test_dir/older_file' -nt '$test_dir/newer_file'" \
        "$F_TOOL '$test_dir/older_file' -nt '$test_dir/newer_file'"

    run_exit_code_test "-ot older than" \
        "$GNU_TOOL '$test_dir/newer_file' -ot '$test_dir/older_file'" \
        "$F_TOOL '$test_dir/newer_file' -ot '$test_dir/older_file'"

    run_exit_code_test "-ef same file" \
        "$GNU_TOOL '$test_dir/regular_file' -ef '$test_dir/regular_file'" \
        "$F_TOOL '$test_dir/regular_file' -ef '$test_dir/regular_file'"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_test_tests
