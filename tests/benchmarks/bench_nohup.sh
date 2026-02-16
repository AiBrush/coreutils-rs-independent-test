#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="nohup"
F_TOOL="fnohup"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/nohup}"

run_nohup_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nohup","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/nohup_benchmark.json"
        return 0
    fi

    init_benchmark "nohup"

    echo ""
    echo "=== Run true under nohup ==="

    run_benchmark "nohup true" \
        "$GNU_TOOL true 2>/dev/null && rm -f nohup.out" \
        "$F_TOOL true 2>/dev/null && rm -f nohup.out" \
        "${U_TOOL:+$U_TOOL true 2>/dev/null && rm -f nohup.out}"

    save_benchmark_results
}

run_nohup_benchmarks
