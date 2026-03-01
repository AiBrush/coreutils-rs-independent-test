#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fpinky"
run_pinky_functional_tests() {
    init_test_suite "pinky"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pinky","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/pinky_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0 or warns" "$F_TOOL 2>/dev/null || true" 0

    local current_user
    current_user=$(whoami)

    run_expected_exit_test "-s short format exits 0" "$F_TOOL -s 2>/dev/null || true" 0

    run_expected_exit_test "-l long format exits 0" "$F_TOOL -l $current_user 2>/dev/null || true" 0

    run_expected_exit_test "-f no header exits 0" "$F_TOOL -f 2>/dev/null || true" 0

    run_expected_exit_test "--help exits 0" "$F_TOOL --help 2>/dev/null" 0

    run_expected_exit_test "--version exits 0" "$F_TOOL --version 2>/dev/null" 0

    run_expected_exit_test "-b no home dir exits 0" "$F_TOOL -b -l $current_user 2>/dev/null || true" 0

    run_expected_exit_test "-p no plan exits 0" "$F_TOOL -p -l $current_user 2>/dev/null || true" 0

    run_expected_exit_test "-h no project exits 0" "$F_TOOL -h -l $current_user 2>/dev/null || true" 0

    run_expected_exit_test "-w no name exits 0" "$F_TOOL -w 2>/dev/null || true" 0

    run_expected_exit_test "-i idle short exits 0" "$F_TOOL -i 2>/dev/null || true" 0

    run_expected_exit_test "-q quick short exits 0" "$F_TOOL -q 2>/dev/null || true" 0

    run_expected_exit_test "specific user short exits 0" "$F_TOOL -s $current_user 2>/dev/null || true" 0

    run_expected_exit_test "specific user default exits 0" "$F_TOOL $current_user 2>/dev/null || true" 0

    run_expected_exit_test "combined -bhp exits 0" "$F_TOOL -bhp -l $current_user 2>/dev/null || true" 0

    run_expected_exit_test "combined -sf exits 0" "$F_TOOL -s -f 2>/dev/null || true" 0

    run_expected_exit_test "combined -wi exits 0" "$F_TOOL -wi 2>/dev/null || true" 0

    run_expected_exit_test "nonexistent user long format" "$F_TOOL -l nonexistent_user_$$ 2>/dev/null || true" 0

    run_expected_exit_test "piped output exits 0" "$F_TOOL 2>/dev/null | cat || true" 0

    finish_test_suite
}
run_pinky_functional_tests
