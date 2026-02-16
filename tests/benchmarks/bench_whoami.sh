#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="whoami"
F_TOOL="fwhoami"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/whoami}"

run_whoami_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"whoami","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/whoami_benchmark.json"
        return 0
    fi

    init_benchmark "whoami"

    echo ""
    echo "=== Startup/execution overhead ==="

    run_benchmark "whoami (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    save_benchmark_results
}

run_whoami_benchmarks
