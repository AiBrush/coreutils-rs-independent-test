#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="numfmt"
F_TOOL="fnumfmt"

run_numfmt_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"numfmt","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/numfmt_benchmark.json"
        return 0
    fi

    init_benchmark "numfmt"

    echo ""
    echo "=== To human readable ==="

    run_benchmark "--to=iec single value" \
        "echo 1048576 | $GNU_TOOL --to=iec" \
        "echo 1048576 | $F_TOOL --to=iec"

    echo ""
    echo "=== From human readable ==="

    run_benchmark "--from=iec single value" \
        "echo 1M | $GNU_TOOL --from=iec" \
        "echo 1M | $F_TOOL --from=iec"

    echo ""
    echo "=== Batch processing ==="

    run_stdin_benchmark "--to=si from CSV column" \
        "$TEST_DATA_DIR/csv_10m.csv" \
        "$GNU_TOOL --field=5 --to=si" \
        "$F_TOOL --field=5 --to=si"

    save_benchmark_results
}

run_numfmt_benchmarks
