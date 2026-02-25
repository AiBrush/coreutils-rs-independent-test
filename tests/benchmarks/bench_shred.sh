#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="shred"
F_TOOL="fshred"

run_shred_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"shred","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/shred_benchmark.json"
        return 0
    fi

    init_benchmark "shred"

    echo ""
    echo "=== Shred file ==="

    run_benchmark "shred 1MB file" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_shred_gnu && $GNU_TOOL /tmp/bench_shred_gnu" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_shred_f && $F_TOOL /tmp/bench_shred_f" \

    run_benchmark "shred 1MB file with remove (-u)" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_shred_u_gnu && $GNU_TOOL -u /tmp/bench_shred_u_gnu" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_shred_u_f && $F_TOOL -u /tmp/bench_shred_u_f" \

    # Cleanup (in case any remain)
    rm -f /tmp/bench_shred_gnu /tmp/bench_shred_f /tmp/bench_shred_u
    rm -f /tmp/bench_shred_u_gnu /tmp/bench_shred_u_f /tmp/bench_shred_u_uu

    save_benchmark_results
}

run_shred_benchmarks
