#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"
F_TOOL="fchroot"
run_chroot_functional_tests() {
    init_test_suite "chroot"
    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chroot","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chroot_results.json"
        return 0
    fi
    skip_test "chroot requires root" "requires root privileges"
    finish_test_suite
}
run_chroot_functional_tests
