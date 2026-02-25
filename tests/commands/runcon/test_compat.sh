#!/usr/bin/env bash
# Compatibility tests for fruncon vs GNU runcon
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "runcon")
F_TOOL="fruncon"

init_test_suite "runcon"

if ! check_tool_exists "$F_TOOL"; then
    echo '{"tool":"runcon","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/runcon_results.json"
    exit 0
fi

# Check if GNU runcon is available for comparison
GNU_AVAILABLE=false
if check_tool_exists "$GNU_TOOL" 2>/dev/null; then
    GNU_AVAILABLE=true
fi

echo ""
echo "=== GNU Upstream: runcon-no-reorder (Argument Handling) ==="

# From runcon-no-reorder.sh: ensure runcon does not reorder arguments
if $GNU_AVAILABLE; then
    # Invalid option -j should exit 125
    run_exit_code_test "GNU: runcon invalid option -j" \
        "$GNU_TOOL -j true 2>&1" \
        "$F_TOOL -j true 2>&1"

    # --help exit code
    run_exit_code_test "GNU: runcon --help exit code" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    # --version exit code
    run_exit_code_test "GNU: runcon --version exit code" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    # No arguments should fail
    run_exit_code_test "GNU: runcon no args" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"
else
    skip_test "runcon invalid option -j" "GNU runcon not available for comparison"
    skip_test "runcon --help exit code" "GNU runcon not available for comparison"
    skip_test "runcon --version exit code" "GNU runcon not available for comparison"
    skip_test "runcon no args" "GNU runcon not available for comparison"
fi

# Argument reordering test requires SELinux (id -Z)
skip_test "runcon no reorder args with context" "Requires SELinux kernel (id -Z)"

echo ""
echo "=== GNU Upstream: runcon-compute ==="

# From runcon-compute.sh: test -c flag with absolute paths
# Requires SELinux runtime for meaningful results
skip_test "runcon -c compute context" "Requires SELinux kernel"
skip_test "runcon -c with local executable" "Requires SELinux kernel"


finish_test_suite
