#!/usr/bin/env bash
# Compatibility tests for fpinky vs GNU pinky
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "pinky")
F_TOOL="fpinky"

run_pinky_tests() {
    init_test_suite "pinky"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pinky","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/pinky_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU pinky not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: Basic Output ===
    echo ""
    echo "=== Basic Output ==="

    run_stdout_test "default (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    # === Section 2: Short Format ===
    echo ""
    echo "=== Short Format ==="

    run_stdout_test "-s short format" \
        "$GNU_TOOL -s" \
        "$F_TOOL -s"

    # === Section 3: Long Format ===
    echo ""
    echo "=== Long Format ==="

    local current_user
    current_user=$(whoami)

    run_stdout_test "-l long format for current user" \
        "$GNU_TOOL -l $current_user" \
        "$F_TOOL -l $current_user"

    # === Section 4: Specific Flags ===
    echo ""
    echo "=== Specific Flags ==="

    run_stdout_test "-f omit header in short format" \
        "$GNU_TOOL -f" \
        "$F_TOOL -f"

    run_stdout_test "-b omit home dir and shell in long format" \
        "$GNU_TOOL -b -l $current_user" \
        "$F_TOOL -b -l $current_user"

    run_stdout_test "-p omit project file in long format" \
        "$GNU_TOOL -p -l $current_user" \
        "$F_TOOL -p -l $current_user"

    run_stdout_test "-h omit plan file in long format" \
        "$GNU_TOOL -h -l $current_user" \
        "$F_TOOL -h -l $current_user"

    # === Section 5: Additional Short Format Flags ===
    echo ""
    echo "=== Additional Short Format Flags ==="

    run_stdout_test "-w omit full name in short format" \
        "$GNU_TOOL -w" \
        "$F_TOOL -w"

    run_stdout_test "-i omit full name and remote host in short format" \
        "$GNU_TOOL -i" \
        "$F_TOOL -i"

    run_stdout_test "-q quick short format" \
        "$GNU_TOOL -q" \
        "$F_TOOL -q"

    # === Section 6: Combined Flags ===
    echo ""
    echo "=== Combined Flags ==="

    run_stdout_test "-bh combined long format" \
        "$GNU_TOOL -bh -l $current_user" \
        "$F_TOOL -bh -l $current_user"

    run_stdout_test "-bp combined long format" \
        "$GNU_TOOL -bp -l $current_user" \
        "$F_TOOL -bp -l $current_user"

    run_stdout_test "-bhp all suppress in long format" \
        "$GNU_TOOL -bhp -l $current_user" \
        "$F_TOOL -bhp -l $current_user"

    run_stdout_test "-sf short format no header" \
        "$GNU_TOOL -s -f" \
        "$F_TOOL -s -f"

    # === Section 7: Multiple Users ===
    echo ""
    echo "=== Multiple Users ==="

    run_stdout_test "multiple same user" \
        "$GNU_TOOL -l $current_user $current_user" \
        "$F_TOOL -l $current_user $current_user"

    # === Section 8: Nonexistent User ===
    echo ""
    echo "=== Nonexistent User ==="

    run_exit_code_test "nonexistent user exit code" \
        "$GNU_TOOL -l nonexistent_user_$$ 2>&1" \
        "$F_TOOL -l nonexistent_user_$$ 2>&1"

    run_stdout_test "nonexistent user long format output" \
        "$GNU_TOOL -l nonexistent_user_$$ 2>/dev/null || true" \
        "$F_TOOL -l nonexistent_user_$$ 2>/dev/null || true"

    # === Section 9: Piped Output ===
    echo ""
    echo "=== Piped Output ==="

    run_stdout_test "pinky piped through cat" \
        "$GNU_TOOL | cat" \
        "$F_TOOL | cat"

    # === Section 10: Help & Version ===
    echo ""
    echo "=== Help & Version ==="

    run_exit_code_test "--help exits 0" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version exits 0" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    # === Section 11: Additional Long Format Variants ===
    echo ""
    echo "=== Additional Long Format Variants ==="

    run_stdout_test "-l long format for root" \
        "$GNU_TOOL -l root 2>/dev/null || true" \
        "$F_TOOL -l root 2>/dev/null || true"

    run_exit_code_test "-l root exit code" \
        "$GNU_TOOL -l root 2>&1" \
        "$F_TOOL -l root 2>&1"

    run_stdout_test "-bl no home dir for root" \
        "$GNU_TOOL -b -l root 2>/dev/null || true" \
        "$F_TOOL -b -l root 2>/dev/null || true"

    # === Section 12: Additional Combined Flags ===
    echo ""
    echo "=== Additional Combined Flags ==="

    run_stdout_test "-wi combined short format" \
        "$GNU_TOOL -wi" \
        "$F_TOOL -wi"

    run_stdout_test "-fw combined short format" \
        "$GNU_TOOL -f -w" \
        "$F_TOOL -f -w"

    run_stdout_test "-fi combined short format" \
        "$GNU_TOOL -f -i" \
        "$F_TOOL -f -i"

    run_stdout_test "-bhp combined for root" \
        "$GNU_TOOL -bhp -l root 2>/dev/null || true" \
        "$F_TOOL -bhp -l root 2>/dev/null || true"

    # === Section 13: Specific User Short Format ===
    echo ""
    echo "=== Specific User Short Format ==="

    run_stdout_test "specific user in short format" \
        "$GNU_TOOL -s $current_user" \
        "$F_TOOL -s $current_user"

    run_stdout_test "specific user default (no -l)" \
        "$GNU_TOOL $current_user" \
        "$F_TOOL $current_user"

    # === Section 14: Additional Piped Output ===
    echo ""
    echo "=== Additional Piped Output ==="

    run_stdout_test "pinky -l piped through cat" \
        "$GNU_TOOL -l $current_user | cat" \
        "$F_TOOL -l $current_user | cat"

    run_stdout_test "pinky -s piped through cat" \
        "$GNU_TOOL -s | cat" \
        "$F_TOOL -s | cat"

    run_stdout_test "pinky -f piped through cat" \
        "$GNU_TOOL -f | cat" \
        "$F_TOOL -f | cat"

    finish_test_suite
}

run_pinky_tests
