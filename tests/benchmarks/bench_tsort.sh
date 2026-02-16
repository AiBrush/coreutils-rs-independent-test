#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tsort"
F_TOOL="ftsort"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/tsort}"

run_tsort_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tsort","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/tsort_benchmark.json"
        return 0
    fi

    init_benchmark "tsort"

    echo ""
    echo "=== Generating test data ==="

    python3 -c "
for i in range(100000):
    print(f'{i} {i+1}')
" > /tmp/bench_tsort_100k.txt

    python3 -c "
for i in range(1000000):
    print(f'{i} {i+1}')
" > /tmp/bench_tsort_1m.txt

    echo ""
    echo "=== Topological sort ==="

    run_stdin_benchmark "tsort 100K pairs" \
        "/tmp/bench_tsort_100k.txt" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    run_stdin_benchmark "tsort 1M pairs" \
        "/tmp/bench_tsort_1m.txt" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    rm -f /tmp/bench_tsort_100k.txt /tmp/bench_tsort_1m.txt

    save_benchmark_results
}

run_tsort_benchmarks
