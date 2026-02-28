#!/usr/bin/env bash
# Compatibility tests for fyes vs GNU yes
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "yes")
F_TOOL="fyes"

run_yes_tests() {
    init_test_suite "yes"
    # No test data needed for yes (it's a generator, not a file processor)

    # NOTE: We cannot use check_tool_exists for 'yes' because it pipes
    # "echo test | $tool" which would hang (yes ignores stdin and writes forever).
    # Instead, check directly with command -v.
    if ! command -v "$F_TOOL" &>/dev/null; then
        echo -e "${YELLOW}SKIP: $F_TOOL not found in PATH${NC}"
        echo '{"tool":"yes","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/yes_results.json"
        return 0
    fi

    if ! command -v "$GNU_TOOL" &>/dev/null; then
        echo "GNU yes not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Output Tests ==="

    # yes runs forever; pipe through head to limit output.
    # Both GNU yes and fyes will receive SIGPIPE when head closes the pipe.
    run_test "default output (y)" \
        "$GNU_TOOL | head -n 100" \
        "$F_TOOL | head -n 100"

    run_test "single arg" \
        "$GNU_TOOL hello | head -n 100" \
        "$F_TOOL hello | head -n 100"

    run_test "multiple args (space-joined)" \
        "$GNU_TOOL hello world | head -n 100" \
        "$F_TOOL hello world | head -n 100"

    run_test "empty string arg" \
        "$GNU_TOOL '' | head -n 10" \
        "$F_TOOL '' | head -n 10"

    run_test "numeric arg" \
        "$GNU_TOOL 42 | head -n 10" \
        "$F_TOOL 42 | head -n 10"

    run_test "three args" \
        "$GNU_TOOL a b c | head -n 20" \
        "$F_TOOL a b c | head -n 20"

    run_test "arg with spaces (quoted)" \
        "$GNU_TOOL 'hello world' | head -n 10" \
        "$F_TOOL 'hello world' | head -n 10"

    run_test "special characters" \
        "$GNU_TOOL '!@#\$%' | head -n 10" \
        "$F_TOOL '!@#\$%' | head -n 10"

    echo ""
    echo "=== End-of-Options (--) ==="

    run_test "-- then arg" \
        "$GNU_TOOL -- foo | head -n 10" \
        "$F_TOOL -- foo | head -n 10"

    run_test "-- alone (falls to default y)" \
        "$GNU_TOOL -- | head -n 5" \
        "$F_TOOL -- | head -n 5"

    run_test "-- then --help (literal string)" \
        "$GNU_TOOL -- --help | head -n 5" \
        "$F_TOOL -- --help | head -n 5"

    run_test "-- then --version (literal string)" \
        "$GNU_TOOL -- --version | head -n 5" \
        "$F_TOOL -- --version | head -n 5"

    echo ""
    echo "=== Option-like Strings (treated as output) ==="

    # GNU yes treats unrecognized options as output strings
    run_test "long option treated as string" \
        "$GNU_TOOL --badopt | head -n 5" \
        "$F_TOOL --badopt | head -n 5"

    run_test "short option treated as string" \
        "$GNU_TOOL -z | head -n 5" \
        "$F_TOOL -z | head -n 5"

    echo ""
    echo "=== Pipe Handling ==="

    run_test "pipe closes cleanly (head -n 5)" \
        "$GNU_TOOL | head -n 5" \
        "$F_TOOL | head -n 5"

    run_test "pipe to wc -l (1000 lines)" \
        "$GNU_TOOL | head -n 1000 | wc -l" \
        "$F_TOOL | head -n 1000 | wc -l"

    run_test "pipe arg to wc -l (500 lines)" \
        "$GNU_TOOL hello | head -n 500 | wc -l" \
        "$F_TOOL hello | head -n 500 | wc -l"

    echo ""
    echo "=== Large Output Tests ==="

    # Compare first 10KB of output byte-for-byte
    run_test "large output 10KB default" \
        "$GNU_TOOL | head -c 10000" \
        "$F_TOOL | head -c 10000"

    run_test "large output 10KB with arg" \
        "$GNU_TOOL test | head -c 10000" \
        "$F_TOOL test | head -c 10000"

    run_test "10000 lines" \
        "$GNU_TOOL | head -n 10000" \
        "$F_TOOL | head -n 10000"

    run_test "10000 lines with arg" \
        "$GNU_TOOL hello | head -n 10000" \
        "$F_TOOL hello | head -n 10000"

    # === GNU Upstream: Buffer Size Handling ===
    echo ""
    echo "=== GNU Upstream: Buffer Size Handling ==="

    run_test "basic y output" \
        "$GNU_TOOL | head -n 1" \
        "$F_TOOL | head -n 1"

    run_test "1-char repeated line (uniq)" \
        "$GNU_TOOL ' ' | head -n 2 | uniq" \
        "$F_TOOL ' ' | head -n 2 | uniq"

    run_test "1999-char padded string" \
        "$GNU_TOOL \"\$(printf '%1999s' '')\" | head -n 2 | uniq" \
        "$F_TOOL \"\$(printf '%1999s' '')\" | head -n 2 | uniq"

    run_test "4095-char padded string" \
        "$GNU_TOOL \"\$(printf '%4095s' '')\" | head -n 2 | uniq" \
        "$F_TOOL \"\$(printf '%4095s' '')\" | head -n 2 | uniq"

    run_test "4096-char padded string" \
        "$GNU_TOOL \"\$(printf '%4096s' '')\" | head -n 2 | uniq" \
        "$F_TOOL \"\$(printf '%4096s' '')\" | head -n 2 | uniq"

    run_test "8191-char padded string" \
        "$GNU_TOOL \"\$(printf '%8191s' '')\" | head -n 2 | uniq" \
        "$F_TOOL \"\$(printf '%8191s' '')\" | head -n 2 | uniq"

    run_test "8192-char padded string" \
        "$GNU_TOOL \"\$(printf '%8192s' '')\" | head -n 2 | uniq" \
        "$F_TOOL \"\$(printf '%8192s' '')\" | head -n 2 | uniq"

    # === GNU Upstream: Many Small Items ===
    echo ""
    echo "=== GNU Upstream: Many Small Items ==="

    run_test "100 numeric args" \
        "$GNU_TOOL \$(seq 100) | head -n 2 | uniq" \
        "$F_TOOL \$(seq 100) | head -n 2 | uniq"


    finish_test_suite
}

run_yes_tests
