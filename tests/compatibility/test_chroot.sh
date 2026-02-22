#!/usr/bin/env bash
# Compatibility tests for fchroot vs GNU chroot
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

init_test_suite "chroot"

if ! check_tool_exists "fchroot"; then
    echo '{"tool":"chroot","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chroot_results.json"
    exit 0
fi

skip_test "chroot basic" "Not yet implemented / requires root"

finish_test_suite
