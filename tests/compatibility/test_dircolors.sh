#!/usr/bin/env bash
# Compatibility tests for fdircolors vs GNU dircolors
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="dircolors"
F_TOOL="fdircolors"

run_dircolors_tests() {
    init_test_suite "dircolors"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dircolors","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/dircolors_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU dircolors not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Default Output (Bourne shell) ==="

    run_test "default output (-b)" \
        "$GNU_TOOL -b" \
        "$F_TOOL -b"

    echo ""
    echo "=== Bourne Shell (-b / --sh) ==="

    run_test "-b bourne shell format" \
        "$GNU_TOOL -b" \
        "$F_TOOL -b"

    run_test "--sh format" \
        "$GNU_TOOL --sh" \
        "$F_TOOL --sh"

    echo ""
    echo "=== C Shell (-c / --csh) ==="

    run_test "-c c-shell format" \
        "$GNU_TOOL -c" \
        "$F_TOOL -c"

    run_test "--csh format" \
        "$GNU_TOOL --csh" \
        "$F_TOOL --csh"

    echo ""
    echo "=== Print Database (-p / --print-database) ==="

    # The -p database may differ between GNU versions (copyright year, comments, TERM entries).
    # Normalize by stripping comments and blank lines, comparing only key-value entries.
    run_test "-p print database" \
        "$GNU_TOOL -p | grep -v '^#' | grep -v '^\$'" \
        "$F_TOOL -p | grep -v '^#' | grep -v '^\$'"

    run_test "--print-database" \
        "$GNU_TOOL --print-database | grep -v '^#' | grep -v '^\$'" \
        "$F_TOOL --print-database | grep -v '^#' | grep -v '^\$'"

    echo ""
    echo "=== Custom Config File ==="

    run_test "custom config file (-b)" \
        "$GNU_TOOL -b '$TEST_DATA_DIR/dircolors_custom.txt'" \
        "$F_TOOL -b '$TEST_DATA_DIR/dircolors_custom.txt'"

    run_test "custom config file (-c)" \
        "$GNU_TOOL -c '$TEST_DATA_DIR/dircolors_custom.txt'" \
        "$F_TOOL -c '$TEST_DATA_DIR/dircolors_custom.txt'"

    echo ""
    echo "=== Stdin Input ==="

    run_test "stdin config" \
        "cat '$TEST_DATA_DIR/dircolors_custom.txt' | $GNU_TOOL -b -" \
        "cat '$TEST_DATA_DIR/dircolors_custom.txt' | $F_TOOL -b -"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    run_exit_code_test "-b and -c together" \
        "$GNU_TOOL -b -c 2>&1" \
        "$F_TOOL -b -c 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "empty config" \
        "printf '' | $GNU_TOOL -b - 2>/dev/null || echo 'EMPTY_ERR'" \
        "printf '' | $F_TOOL -b - 2>/dev/null || echo 'EMPTY_ERR'"

    run_test "config with only comments" \
        "printf '# comment\n# another\n' | $GNU_TOOL -b -" \
        "printf '# comment\n# another\n' | $F_TOOL -b -"

    finish_test_suite
}

run_dircolors_tests
