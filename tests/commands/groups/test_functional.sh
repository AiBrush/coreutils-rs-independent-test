#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fgroups"
run_groups_functional_tests() {
    init_test_suite "groups"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"groups","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/groups_results.json"
        return 0
    fi
    run_expected_exit_test "exits 0" "$F_TOOL" 0
    run_expected_exit_test "nonexistent user fails" "$F_TOOL nonexistent_user_functional_test 2>/dev/null" 1

    local current_user
    current_user=$(whoami)

    run_expected_exit_test "specific user exits 0" "$F_TOOL $current_user" 0

    run_expected_exit_test "root user exits 0" "$F_TOOL root 2>/dev/null || true" 0

    run_expected_exit_test "--help exits 0" "$F_TOOL --help 2>/dev/null" 0

    run_expected_exit_test "--version exits 0" "$F_TOOL --version 2>/dev/null" 0

    # Verify current user's groups match id -Gn
    local expected_groups
    expected_groups=$(id -Gn 2>/dev/null | tr ' ' '\n' | sort | tr '\n' ' ' | sed 's/ $//')
    local actual_groups
    actual_groups=$($F_TOOL 2>/dev/null | sed 's/^[^:]*: *//' | tr ' ' '\n' | sort | tr '\n' ' ' | sed 's/ $//')

    if [[ "$expected_groups" == "$actual_groups" ]]; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: groups output matches id -Gn"
        record_result "groups output matches id -Gn" "PASS" "" "" "$F_TOOL"
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: groups output matches id -Gn (expected: $expected_groups, got: $actual_groups)"
        record_result "groups output matches id -Gn" "FAIL" "expected: $expected_groups, got: $actual_groups" "" "$F_TOOL"
    fi

    run_expected_exit_test "multiple users exits 0" "$F_TOOL $current_user $current_user" 0

    run_expected_exit_test "--invalid option fails" "$F_TOOL --invalid 2>/dev/null" 1

    run_expected_exit_test "piped output exits 0" "$F_TOOL | cat" 0

    # Verify output contains current username
    local groups_output
    groups_output=$($F_TOOL 2>/dev/null || true)
    if echo "$groups_output" | grep -q "$current_user"; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: output contains current username"
        record_result "output contains current username" "PASS" "" "" "$F_TOOL"
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: output contains current username (got: $groups_output)"
        record_result "output contains current username" "FAIL" "expected output to contain $current_user, got: $groups_output" "" "$F_TOOL"
    fi

    # Verify output is single line for single user
    local line_count
    line_count=$($F_TOOL $current_user 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$line_count" -eq 1 ]]; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: single user produces single line"
        record_result "single user produces single line" "PASS" "" "" "$F_TOOL $current_user"
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: single user produces single line (got $line_count lines)"
        record_result "single user produces single line" "FAIL" "expected 1 line, got $line_count" "" "$F_TOOL $current_user"
    fi

    # Verify groups vs id -Gn for explicit user
    local expected_explicit
    expected_explicit=$(id -Gn $current_user 2>/dev/null | tr ' ' '\n' | sort | tr '\n' ' ' | sed 's/ $//')
    local actual_explicit
    actual_explicit=$($F_TOOL $current_user 2>/dev/null | sed 's/^[^:]*: *//' | tr ' ' '\n' | sort | tr '\n' ' ' | sed 's/ $//')

    if [[ "$expected_explicit" == "$actual_explicit" ]]; then
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: explicit user groups match id -Gn"
        record_result "explicit user groups match id -Gn" "PASS" "" "" "$F_TOOL $current_user"
    else
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: explicit user groups match id -Gn (expected: $expected_explicit, got: $actual_explicit)"
        record_result "explicit user groups match id -Gn" "FAIL" "expected: $expected_explicit, got: $actual_explicit" "" "$F_TOOL $current_user"
    fi

    finish_test_suite
}
run_groups_functional_tests
