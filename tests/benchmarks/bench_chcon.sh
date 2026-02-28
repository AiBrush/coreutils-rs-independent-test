#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="chcon"
F_TOOL="fchcon"

run_chcon_benchmarks() {
    check_hyperfine
    ensure_test_data

    # chcon requires SELinux which is not available in CI environments.
    # Mark as not implemented for benchmarking purposes.
    echo '{"tool":"chcon","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/chcon_benchmark.json"
    return 0
}

run_chcon_benchmarks
