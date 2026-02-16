#!/usr/bin/env bash
# Compatibility tests for fwho vs GNU who
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="who"
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

    # === Section 5: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    finish_test_suite
}

run_who_tests
