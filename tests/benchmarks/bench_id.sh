#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="id"
F_TOOL="fid"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/id}"

run_id_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"id","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/id_benchmark.json"
        return 0
    fi

    init_benchmark "id"

    echo ""
    echo "=== Startup/execution overhead ==="

    run_benchmark "id (no args)" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    run_benchmark "id -u" \
        "$GNU_TOOL -u" \
        "$F_TOOL -u" \
        "${U_TOOL:+$U_TOOL -u}"

    run_benchmark "id -g" \
        "$GNU_TOOL -g" \
        "$F_TOOL -g" \
        "${U_TOOL:+$U_TOOL -g}"

    run_benchmark "id -un" \
        "$GNU_TOOL -un" \
        "$F_TOOL -un" \
        "${U_TOOL:+$U_TOOL -un}"

    save_benchmark_results
}

run_id_benchmarks
