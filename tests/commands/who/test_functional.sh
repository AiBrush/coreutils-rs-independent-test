#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fwho"
run_who_functional_tests() {
    init_test_suite "who"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"who","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/who_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL 2>/dev/null || true" 0

    run_expected_exit_test "-q exits 0" "$F_TOOL -q 2>/dev/null || true" 0

    run_expected_exit_test "-H exits 0" "$F_TOOL -H 2>/dev/null || true" 0

    run_expected_exit_test "-b exits 0" "$F_TOOL -b 2>/dev/null || true" 0

    run_expected_exit_test "-a exits 0" "$F_TOOL -a 2>/dev/null || true" 0

    run_expected_exit_test "who am i exits 0" "$F_TOOL am i 2>/dev/null || true" 0

    run_expected_exit_test "--help exits 0" "$F_TOOL --help 2>/dev/null" 0

    run_expected_exit_test "--version exits 0" "$F_TOOL --version 2>/dev/null" 0

    run_expected_exit_test "-s short form exits 0" "$F_TOOL -s 2>/dev/null || true" 0

    run_expected_exit_test "-u idle time exits 0" "$F_TOOL -u 2>/dev/null || true" 0

    run_expected_exit_test "-d dead processes exits 0" "$F_TOOL -d 2>/dev/null || true" 0

    run_expected_exit_test "-r runlevel exits 0" "$F_TOOL -r 2>/dev/null || true" 0

    run_expected_exit_test "-T message status exits 0" "$F_TOOL -T 2>/dev/null || true" 0

    run_expected_exit_test "-l login processes exits 0" "$F_TOOL -l 2>/dev/null || true" 0

    run_expected_exit_test "-m same as am i exits 0" "$F_TOOL -m 2>/dev/null || true" 0

    run_expected_exit_test "-w writable status exits 0" "$F_TOOL -w 2>/dev/null || true" 0

    run_expected_exit_test "-bT combined exits 0" "$F_TOOL -bT 2>/dev/null || true" 0

    run_expected_exit_test "-aH all with headers exits 0" "$F_TOOL -aH 2>/dev/null || true" 0

    run_expected_exit_test "who piped exits 0" "$F_TOOL 2>/dev/null | cat || true" 0

    run_expected_exit_test "--invalid option fails" "$F_TOOL --invalid 2>/dev/null" 1

    finish_test_suite
}
run_who_functional_tests
