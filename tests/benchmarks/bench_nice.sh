#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="nice"
F_TOOL="fnice"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/nice}"

run_nice_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nice","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/nice_benchmark.json"
        return 0
    fi

    init_benchmark "nice"

    echo ""
    echo "=== Default nice ==="

    run_benchmark "nice true (default priority)" \
        "$GNU_TOOL true" \
        "$F_TOOL true" \
        "${U_TOOL:+$U_TOOL true}"

    echo ""
    echo "=== Explicit nice value ==="

    run_benchmark "nice -n 10 true" \
        "$GNU_TOOL -n 10 true" \
        "$F_TOOL -n 10 true" \
        "${U_TOOL:+$U_TOOL -n 10 true}"

    save_benchmark_results
}

run_nice_benchmarks
