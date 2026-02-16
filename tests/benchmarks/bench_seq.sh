#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="seq"
F_TOOL="fseq"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/seq}"

run_seq_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"seq","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/seq_benchmark.json"
        return 0
    fi

    init_benchmark "seq"

    echo ""
    echo "=== Integer sequences ==="

    run_benchmark "seq 1000000" \
        "$GNU_TOOL 1000000" \
        "$F_TOOL 1000000" \
        "${U_TOOL:+$U_TOOL 1000000}"

    run_benchmark "seq 1 10000000" \
        "$GNU_TOOL 1 10000000" \
        "$F_TOOL 1 10000000" \
        "${U_TOOL:+$U_TOOL 1 10000000}"

    echo ""
    echo "=== Float sequences ==="

    run_benchmark "seq 0 0.1 100000 (float)" \
        "$GNU_TOOL 0 0.1 100000" \
        "$F_TOOL 0 0.1 100000" \
        "${U_TOOL:+$U_TOOL 0 0.1 100000}"

    echo ""
    echo "=== Zero-padded sequences ==="

    run_benchmark "seq -w 1 1000000 (zero-padded)" \
        "$GNU_TOOL -w 1 1000000" \
        "$F_TOOL -w 1 1000000" \
        "${U_TOOL:+$U_TOOL -w 1 1000000}"

    save_benchmark_results
}

run_seq_benchmarks
