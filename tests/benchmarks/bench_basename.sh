#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="basename"
F_TOOL="fbasename"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/basename}"

run_basename_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"basename","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/basename_benchmark.json"
        return 0
    fi

    init_benchmark "basename"

    echo ""
    echo "=== Basic basename ==="

    run_benchmark "basename simple path" \
        "$GNU_TOOL /usr/local/bin/test" \
        "$F_TOOL /usr/local/bin/test" \
        "${U_TOOL:+$U_TOOL /usr/local/bin/test}"

    echo ""
    echo "=== Basename with suffix removal ==="

    run_benchmark "basename with suffix (.txt)" \
        "$GNU_TOOL /usr/local/bin/test.txt .txt" \
        "$F_TOOL /usr/local/bin/test.txt .txt" \
        "${U_TOOL:+$U_TOOL /usr/local/bin/test.txt .txt}"

    save_benchmark_results
}

run_basename_benchmarks
