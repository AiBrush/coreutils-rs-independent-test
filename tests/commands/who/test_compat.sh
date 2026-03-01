#!/usr/bin/env bash
# Compatibility tests for fwho vs GNU who
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "who")
F_TOOL="fwho"

run_who_tests() {
    init_test_suite "who"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"who","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/who_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU who not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: Basic Output ===
    echo ""
    echo "=== Basic Output ==="

    run_stdout_test "default (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    # === Section 2: Various Flags ===
    echo ""
    echo "=== Various Flags ==="

    run_stdout_test "-q quick (count + usernames)" \
        "$GNU_TOOL -q" \
        "$F_TOOL -q"

    run_stdout_test "-H with headings" \
        "$GNU_TOOL -H" \
        "$F_TOOL -H"

    run_stdout_test "-b boot time" \
        "$GNU_TOOL -b" \
        "$F_TOOL -b"

    run_stdout_test "-a all information" \
        "$GNU_TOOL -a" \
        "$F_TOOL -a"

    run_stdout_test "-s short form (default)" \
        "$GNU_TOOL -s" \
        "$F_TOOL -s"

    run_stdout_test "-u add idle time" \
        "$GNU_TOOL -u" \
        "$F_TOOL -u"

    run_stdout_test "-d dead processes" \
        "$GNU_TOOL -d" \
        "$F_TOOL -d"

    run_stdout_test "-l login processes" \
        "$GNU_TOOL -l" \
        "$F_TOOL -l"

    run_stdout_test "-r runlevel" \
        "$GNU_TOOL -r" \
        "$F_TOOL -r"

    run_stdout_test "-T show message status" \
        "$GNU_TOOL -T" \
        "$F_TOOL -T"

    # === Section 3: who am i ===
    echo ""
    echo "=== who am i ==="

    run_stdout_test "who am i" \
        "$GNU_TOOL am i" \
        "$F_TOOL am i"

    # === Section 4: Utmp File ===
    echo ""
    echo "=== Utmp File ==="

    if [[ -f /var/run/utmp ]]; then
        run_stdout_test "explicit /var/run/utmp" \
            "$GNU_TOOL /var/run/utmp" \
            "$F_TOOL /var/run/utmp"
    else
        skip_test "explicit /var/run/utmp" "/var/run/utmp not found"
    fi

    # === Section 5: Additional Flags ===
    echo ""
    echo "=== Additional Flags ==="

    run_stdout_test "-w writable status (synonym for -T)" \
        "$GNU_TOOL -w" \
        "$F_TOOL -w"

    run_stdout_test "--lookup DNS hostname lookup" \
        "$GNU_TOOL --lookup" \
        "$F_TOOL --lookup"

    run_stdout_test "-p active processes" \
        "$GNU_TOOL -p" \
        "$F_TOOL -p"

    run_stdout_test "-t time changes" \
        "$GNU_TOOL -t" \
        "$F_TOOL -t"

    # === Section 6: Combined Options ===
    echo ""
    echo "=== Combined Options ==="

    run_stdout_test "-bT boot time + message status" \
        "$GNU_TOOL -bT" \
        "$F_TOOL -bT"

    run_stdout_test "-bu boot time + idle" \
        "$GNU_TOOL -bu" \
        "$F_TOOL -bu"

    run_stdout_test "-Hu heading + idle" \
        "$GNU_TOOL -Hu" \
        "$F_TOOL -Hu"

    run_stdout_test "-dT dead processes + message status" \
        "$GNU_TOOL -dT" \
        "$F_TOOL -dT"

    run_stdout_test "-lu login + idle" \
        "$GNU_TOOL -lu" \
        "$F_TOOL -lu"

    # === Section 7: Piped Output ===
    echo ""
    echo "=== Piped Output ==="

    run_stdout_test "who piped through cat" \
        "$GNU_TOOL | cat" \
        "$F_TOOL | cat"

    run_stdout_test "who -q piped through cat" \
        "$GNU_TOOL -q | cat" \
        "$F_TOOL -q | cat"

    run_stdout_test "who -a piped through cat" \
        "$GNU_TOOL -a | cat" \
        "$F_TOOL -a | cat"

    run_stdout_test "who piped through wc -l" \
        "$GNU_TOOL | wc -l" \
        "$F_TOOL | wc -l"

    # === Section 8: am i Variants ===
    echo ""
    echo "=== am i Variants ==="

    run_stdout_test "-m same as am i" \
        "$GNU_TOOL -m" \
        "$F_TOOL -m"

    run_stdout_test "who am i with -H" \
        "$GNU_TOOL -H am i" \
        "$F_TOOL -H am i"

    run_stdout_test "who am i with -u" \
        "$GNU_TOOL -u am i" \
        "$F_TOOL -u am i"

    # === Section 9: More Combined Options ===
    echo ""
    echo "=== More Combined Options ==="

    run_stdout_test "-aH all with headers" \
        "$GNU_TOOL -aH" \
        "$F_TOOL -aH"

    run_stdout_test "-qH quick with headers" \
        "$GNU_TOOL -qH" \
        "$F_TOOL -qH"

    run_stdout_test "-rT runlevel + message status" \
        "$GNU_TOOL -rT" \
        "$F_TOOL -rT"

    run_stdout_test "-dlu dead + login + idle" \
        "$GNU_TOOL -dlu" \
        "$F_TOOL -dlu"

    # === Section 10: Exit Codes & Error Handling ===
    echo ""
    echo "=== Exit Codes & Error Handling ==="

    run_exit_code_test "exit code is 0" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_exit_code_test "--invalid option fails" \
        "$GNU_TOOL --invalid 2>&1" \
        "$F_TOOL --invalid 2>&1"

    run_exit_code_test "extra operand error" \
        "$GNU_TOOL am i extra 2>&1" \
        "$F_TOOL am i extra 2>&1"

    # === Section 11: Help & Version ===
    echo ""
    echo "=== Help & Version ==="

    run_exit_code_test "--help exits 0" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version exits 0" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    finish_test_suite
}

run_who_tests
