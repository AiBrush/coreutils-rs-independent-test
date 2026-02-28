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

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chroot","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/chroot_benchmark.json"
        return 0
    fi

    init_benchmark "chroot"

    echo ""
    echo "=== Startup overhead ==="

    run_benchmark "chroot --help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    save_benchmark_results
}

run_chroot_benchmarks
