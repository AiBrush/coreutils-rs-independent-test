#!/usr/bin/env bash
# Compatibility tests for fusers vs GNU users
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="users"
F_TOOL="fusers"

run_users_tests() {
    init_test_suite "users"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"users","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/users_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU users not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: Basic Output ===
    echo ""
    echo "=== Basic Output ==="

    run_stdout_test "default (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    # === Section 2: With utmp file ===
    echo ""
    echo "=== Utmp File ==="

    if [[ -f /var/run/utmp ]]; then
        run_stdout_test "explicit /var/run/utmp" \
            "$GNU_TOOL /var/run/utmp" \
            "$F_TOOL /var/run/utmp"
    else
        skip_test "explicit /var/run/utmp" "/var/run/utmp not found"
    fi

    if [[ -f /var/log/wtmp ]]; then
        run_stdout_test "wtmp file" \
            "$GNU_TOOL /var/log/wtmp" \
            "$F_TOOL /var/log/wtmp"
    else
        skip_test "wtmp file" "/var/log/wtmp not found"
    fi

    # === Section 3: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_utmp_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_utmp_$$ 2>&1"

    # === Section 4: Output Format ===
    echo ""
    echo "=== Output Format Verification ==="

    # users output should be space-separated sorted usernames on one line
    run_stdout_test "output is single line" \
        "$GNU_TOOL | wc -l" \
        "$F_TOOL | wc -l"

    run_stdout_test "output format matches" \
        "$GNU_TOOL | tr ' ' '\n' | sort" \
        "$F_TOOL | tr ' ' '\n' | sort"

    # === Section 5: Version/Help ===
    echo ""
    echo "=== Version/Help ==="

    run_exit_code_test "--help exits successfully" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version exits successfully" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    finish_test_suite
}

run_users_tests
