#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="chroot"
F_TOOL="fchroot"

run_chroot_benchmarks() {
    check_hyperfine
    ensure_test_data

    # chroot requires root privileges, cannot benchmark in CI.
    echo '{"tool":"chroot","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/chroot_benchmark.json"
    return 0
}

run_chroot_benchmarks
