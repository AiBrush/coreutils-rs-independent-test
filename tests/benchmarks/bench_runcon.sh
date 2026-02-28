#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="runcon"
F_TOOL="fruncon"

run_runcon_benchmarks() {
    check_hyperfine
    ensure_test_data

    # runcon requires SELinux which is not available in CI environments.
    echo '{"tool":"runcon","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/runcon_benchmark.json"
    return 0
}

run_runcon_benchmarks
