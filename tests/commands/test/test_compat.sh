#!/usr/bin/env bash
# Compatibility tests for ftest vs GNU test
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

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

    # === GNU Upstream: File Tests (test-file.sh) ===
    echo ""
    echo "=== GNU Upstream: File Tests ==="

    # From test-file.sh: -f on non-existent should return 1
    run_exit_code_test "-f nonexistent file (fail)" \
        "$GNU_TOOL -f '$test_dir/no_such_file_$$'" \
        "$F_TOOL -f '$test_dir/no_such_file_$$'"

    # From test-file.sh: -d on file should return 1
    run_exit_code_test "-d on regular file" \
        "$GNU_TOOL -d '$test_dir/regular_file'" \
        "$F_TOOL -d '$test_dir/regular_file'"

    # From test-file.sh: -s on empty file should return 1
    run_exit_code_test "-s on /dev/null" \
        "$GNU_TOOL -s /dev/null" \
        "$F_TOOL -s /dev/null"

    # From test-file.sh: -S on regular file should return 1
    run_exit_code_test "-S on regular file" \
        "$GNU_TOOL -S '$test_dir/regular_file'" \
        "$F_TOOL -S '$test_dir/regular_file'"

    # From test-file.sh: -b on regular file should return 1
    run_exit_code_test "-b on regular file" \
        "$GNU_TOOL -b '$test_dir/regular_file'" \
        "$F_TOOL -b '$test_dir/regular_file'"

    # From test-file.sh: file -nt missing should be true
    run_exit_code_test "file -nt missing (true)" \
        "$GNU_TOOL '$test_dir/regular_file' -nt '$test_dir/no_such_$$'" \
        "$F_TOOL '$test_dir/regular_file' -nt '$test_dir/no_such_$$'"

    # missing -nt file should be false
    run_exit_code_test "missing -nt file (false)" \
        "$GNU_TOOL '$test_dir/no_such_$$' -nt '$test_dir/regular_file'" \
        "$F_TOOL '$test_dir/no_such_$$' -nt '$test_dir/regular_file'"

    # missing -ot file should be true
    run_exit_code_test "missing -ot file (true)" \
        "$GNU_TOOL '$test_dir/no_such_$$' -ot '$test_dir/regular_file'" \
        "$F_TOOL '$test_dir/no_such_$$' -ot '$test_dir/regular_file'"

    # From test-file.sh: -ef on missing files should return 1
    run_exit_code_test "-ef missing1 missing2" \
        "$GNU_TOOL '$test_dir/miss1_$$' -ef '$test_dir/miss2_$$'" \
        "$F_TOOL '$test_dir/miss1_$$' -ef '$test_dir/miss2_$$'"

    run_exit_code_test "-ef file missing" \
        "$GNU_TOOL '$test_dir/regular_file' -ef '$test_dir/miss_$$'" \
        "$F_TOOL '$test_dir/regular_file' -ef '$test_dir/miss_$$'"

    # From test-file.sh: -ef with symlinks
    run_exit_code_test "-ef file symlink (same target)" \
        "$GNU_TOOL '$test_dir/regular_file' -ef '$test_dir/a_symlink'" \
        "$F_TOOL '$test_dir/regular_file' -ef '$test_dir/a_symlink'"

    run_exit_code_test "-ef symlink file (same target)" \
        "$GNU_TOOL '$test_dir/a_symlink' -ef '$test_dir/regular_file'" \
        "$F_TOOL '$test_dir/a_symlink' -ef '$test_dir/regular_file'"

    # From test-file.sh: -nt and -ot on two existing files with different mtimes
    touch -m -t 202510230300 "$test_dir/file_old" 2>/dev/null || touch "$test_dir/file_old"
    sleep 1
    touch -m -t 202510230400 "$test_dir/file_new" 2>/dev/null || touch "$test_dir/file_new"

    run_exit_code_test "newer -nt older (true)" \
        "$GNU_TOOL '$test_dir/file_new' -nt '$test_dir/file_old'" \
        "$F_TOOL '$test_dir/file_new' -nt '$test_dir/file_old'"

    run_exit_code_test "older -nt newer (false)" \
        "$GNU_TOOL '$test_dir/file_old' -nt '$test_dir/file_new'" \
        "$F_TOOL '$test_dir/file_old' -nt '$test_dir/file_new'"

    run_exit_code_test "older -ot newer (true)" \
        "$GNU_TOOL '$test_dir/file_old' -ot '$test_dir/file_new'" \
        "$F_TOOL '$test_dir/file_old' -ot '$test_dir/file_new'"

    run_exit_code_test "newer -ot older (false)" \
        "$GNU_TOOL '$test_dir/file_new' -ot '$test_dir/file_old'" \
        "$F_TOOL '$test_dir/file_new' -ot '$test_dir/file_old'"

    echo ""
    echo "=== GNU Upstream: String Equality Operators (test.pl) ==="

    # From test.pl: streqeq-1 - == operator (same as =)
    run_exit_code_test "== operator same strings (true)" \
        "$GNU_TOOL 't' == 't'" \
        "$F_TOOL 't' == 't'"

    # From test.pl: streqeq-2 - == operator different strings
    run_exit_code_test "== operator diff strings (false)" \
        "$GNU_TOOL 't' == 'f'" \
        "$F_TOOL 't' == 'f'"

    # From test.pl: streq-3 - special chars as operands: ! = !
    run_exit_code_test "! = ! (true, both are '!')" \
        "$GNU_TOOL '!' = '!'" \
        "$F_TOOL '!' = '!'"

    # From test.pl: streq-4 - = = = (all are '=')
    run_exit_code_test "= = = (true)" \
        "$GNU_TOOL '=' = '='" \
        "$F_TOOL '=' = '='"

    # From test.pl: streq-5 - ( = (
    run_exit_code_test "'(' = '(' (true)" \
        "$GNU_TOOL '(' = '('" \
        "$F_TOOL '(' = '('"

    # From test.pl: streq-6 - ( = ) should be false
    run_exit_code_test "'(' = ')' (false)" \
        "$GNU_TOOL '(' = ')'" \
        "$F_TOOL '(' = ')'"

    # From test.pl: strne-3 - ! != !
    run_exit_code_test "'!' != '!' (false)" \
        "$GNU_TOOL '!' != '!'" \
        "$F_TOOL '!' != '!'"

    # From test.pl: strne-4 - = != =
    run_exit_code_test "'=' != '=' (false)" \
        "$GNU_TOOL '=' != '='" \
        "$F_TOOL '=' != '='"

    echo ""
    echo "=== GNU Upstream: Integer Edge Cases (test.pl) ==="

    # From test.pl: eq-2 - 0 -eq 0
    run_exit_code_test "0 -eq 0 (true)" \
        "$GNU_TOOL 0 -eq 0" \
        "$F_TOOL 0 -eq 0"

    # From test.pl: eq-3 - 0 -eq 00 (leading zeros)
    run_exit_code_test "0 -eq 00 (true, leading zeros)" \
        "$GNU_TOOL 0 -eq 00" \
        "$F_TOOL 0 -eq 00"

    # From test.pl: gt-4 - negative numbers
    run_exit_code_test "-1 -gt -2 (true)" \
        "$GNU_TOOL -1 -gt -2" \
        "$F_TOOL -1 -gt -2"

    # From test.pl: lt-4 - negative number comparison
    run_exit_code_test "-1 -lt -2 (false)" \
        "$GNU_TOOL -1 -lt -2" \
        "$F_TOOL -1 -lt -2"

    echo ""
    echo "=== GNU Upstream: And/Or Operators (test.pl) ==="

    # From test.pl: and-1 through and-4
    run_exit_code_test "t -a t (true)" \
        "$GNU_TOOL 't' -a 't'" \
        "$F_TOOL 't' -a 't'"

    run_exit_code_test "'' -a t (false)" \
        "$GNU_TOOL '' -a 't'" \
        "$F_TOOL '' -a 't'"

    run_exit_code_test "t -a '' (false)" \
        "$GNU_TOOL 't' -a ''" \
        "$F_TOOL 't' -a ''"

    run_exit_code_test "'' -a '' (false)" \
        "$GNU_TOOL '' -a ''" \
        "$F_TOOL '' -a ''"

    # From test.pl: or-1 through or-4
    run_exit_code_test "t -o t (true)" \
        "$GNU_TOOL 't' -o 't'" \
        "$F_TOOL 't' -o 't'"

    run_exit_code_test "'' -o t (true)" \
        "$GNU_TOOL '' -o 't'" \
        "$F_TOOL '' -o 't'"

    run_exit_code_test "t -o '' (true)" \
        "$GNU_TOOL 't' -o ''" \
        "$F_TOOL 't' -o ''"

    run_exit_code_test "'' -o '' (false)" \
        "$GNU_TOOL '' -o ''" \
        "$F_TOOL '' -o ''"

    echo ""
    echo "=== GNU Upstream: Special Single-Arg Strings (test.pl) ==="

    # From test.pl: 1b - -z '' should be true (exit 0)
    run_exit_code_test "-z '' (true)" \
        "$GNU_TOOL -z ''" \
        "$F_TOOL -z ''"

    # From test.pl: 1c - any non-empty string is true
    run_exit_code_test "any-string (true)" \
        "$GNU_TOOL 'any-string'" \
        "$F_TOOL 'any-string'"

    # From test.pl: 1f - '-' as single arg (non-empty = true)
    run_exit_code_test "'-' single arg (true)" \
        "$GNU_TOOL '-'" \
        "$F_TOOL '-'"

    # From test.pl: 1g - '--' as single arg (non-empty = true)
    run_exit_code_test "'--' single arg (true)" \
        "$GNU_TOOL '--'" \
        "$F_TOOL '--'"

    # From test.pl: 1h - '-0' as single arg (non-empty = true)
    run_exit_code_test "'-0' single arg (true)" \
        "$GNU_TOOL '-0'" \
        "$F_TOOL '-0'"

    # From test.pl: 1j - '--help' as single arg (non-empty = true)
    run_exit_code_test "'--help' single arg (true)" \
        "$GNU_TOOL '--help'" \
        "$F_TOOL '--help'"

    # From test.pl: 1k - '--version' as single arg (non-empty = true)
    run_exit_code_test "'--version' single arg (true)" \
        "$GNU_TOOL '--version'" \
        "$F_TOOL '--version'"

    echo ""
    echo "=== GNU Upstream: Collation Operators (test.pl) ==="

    # From test.pl: less-collate-1 through less-collate-3
    run_exit_code_test "'a' < 'b' (true)" \
        "$GNU_TOOL 'a' '<' 'b'" \
        "$F_TOOL 'a' '<' 'b'"

    run_exit_code_test "'a' < 'a' (false)" \
        "$GNU_TOOL 'a' '<' 'a'" \
        "$F_TOOL 'a' '<' 'a'"

    run_exit_code_test "'b' < 'a' (false)" \
        "$GNU_TOOL 'b' '<' 'a'" \
        "$F_TOOL 'b' '<' 'a'"

    # From test.pl: greater-collate-1 through greater-collate-3
    run_exit_code_test "'b' > 'a' (true)" \
        "$GNU_TOOL 'b' '>' 'a'" \
        "$F_TOOL 'b' '>' 'a'"

    run_exit_code_test "'a' > 'a' (false)" \
        "$GNU_TOOL 'a' '>' 'a'" \
        "$F_TOOL 'a' '>' 'a'"

    run_exit_code_test "'a' > 'b' (false)" \
        "$GNU_TOOL 'a' '>' 'b'" \
        "$F_TOOL 'a' '>' 'b'"

    echo ""
    echo "=== GNU Upstream: Parenthesized Expressions (test.pl) ==="

    # From test.pl: paren-1 - empty in parens is false
    run_exit_code_test "'(' '' ')' (false)" \
        "$GNU_TOOL '(' '' ')'" \
        "$F_TOOL '(' '' ')'"

    # From test.pl: paren-2 - '(' in parens is non-empty = true
    run_exit_code_test "'(' '(' ')' (true)" \
        "$GNU_TOOL '(' '(' ')'" \
        "$F_TOOL '(' '(' ')'"

    # From test.pl: paren-3 - ')' in parens is non-empty = true
    run_exit_code_test "'(' ')' ')' (true)" \
        "$GNU_TOOL '(' ')' ')'" \
        "$F_TOOL '(' ')' ')'"

    # From test.pl: paren-4 - '!' in parens is non-empty = true
    run_exit_code_test "'(' '!' ')' (true)" \
        "$GNU_TOOL '(' '!' ')'" \
        "$F_TOOL '(' '!' ')'"

    # From test.pl: paren-5 - '-a' in parens is non-empty = true
    run_exit_code_test "'(' '-a' ')' (true)" \
        "$GNU_TOOL '(' '-a' ')'" \
        "$F_TOOL '(' '-a' ')'"

    echo ""
    echo "=== GNU Upstream: Hard Link -ef (test-file.sh) ==="

    # From test-file.sh: -ef with hard links
    if ln "$test_dir/regular_file" "$test_dir/hardlink1" 2>/dev/null; then
        run_exit_code_test "-ef file hardlink (true)" \
            "$GNU_TOOL '$test_dir/regular_file' -ef '$test_dir/hardlink1'" \
            "$F_TOOL '$test_dir/regular_file' -ef '$test_dir/hardlink1'"

        run_exit_code_test "-ef hardlink file (true)" \
            "$GNU_TOOL '$test_dir/hardlink1' -ef '$test_dir/regular_file'" \
            "$F_TOOL '$test_dir/hardlink1' -ef '$test_dir/regular_file'"

        # Different files should not be -ef
        echo "other" > "$test_dir/other_file"
        if ln "$test_dir/other_file" "$test_dir/hardlink2" 2>/dev/null; then
            run_exit_code_test "-ef hardlink1 hardlink2 (false, diff files)" \
                "$GNU_TOOL '$test_dir/hardlink1' -ef '$test_dir/hardlink2'" \
                "$F_TOOL '$test_dir/hardlink1' -ef '$test_dir/hardlink2'"
        fi
    else
        skip_test "-ef hard link tests" "hard links not supported"
    fi

    echo ""
    echo "=== GNU Upstream: Inverse Operators (test.pl) ==="

    # From test.pl: inverse operator tests (ne from eq, ge from lt, le from gt)
    run_exit_code_test "9 -ne 9 (false)" \
        "$GNU_TOOL 9 -ne 9" \
        "$F_TOOL 9 -ne 9"

    run_exit_code_test "8 -ne 9 (true)" \
        "$GNU_TOOL 8 -ne 9" \
        "$F_TOOL 8 -ne 9"

    run_exit_code_test "5 -ge 5 (true)" \
        "$GNU_TOOL 5 -ge 5" \
        "$F_TOOL 5 -ge 5"

    run_exit_code_test "5 -ge 4 (true)" \
        "$GNU_TOOL 5 -ge 4" \
        "$F_TOOL 5 -ge 4"

    run_exit_code_test "4 -ge 5 (false)" \
        "$GNU_TOOL 4 -ge 5" \
        "$F_TOOL 4 -ge 5"

    run_exit_code_test "5 -le 5 (true)" \
        "$GNU_TOOL 5 -le 5" \
        "$F_TOOL 5 -le 5"

    run_exit_code_test "5 -le 4 (false)" \
        "$GNU_TOOL 5 -le 4" \
        "$F_TOOL 5 -le 4"

    run_exit_code_test "4 -le 5 (true)" \
        "$GNU_TOOL 4 -le 5" \
        "$F_TOOL 4 -le 5"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_test_tests
