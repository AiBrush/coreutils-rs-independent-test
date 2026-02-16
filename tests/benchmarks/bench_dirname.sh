#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="dirname"
F_TOOL="fdirname"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/dirname}"

run_dirname_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dirname","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/dirname_benchmark.json"
        return 0
    fi

    init_benchmark "dirname"

    echo ""
    echo "=== Basic dirname ==="

    run_benchmark "dirname simple path" \
        "$GNU_TOOL /usr/local/bin/test" \
        "$F_TOOL /usr/local/bin/test" \
        "${U_TOOL:+$U_TOOL /usr/local/bin/test}"

    echo ""
    echo "=== Dirname deep path ==="

    run_benchmark "dirname deep path" \
        "$GNU_TOOL /a/b/c/d/e/f/g" \
        "$F_TOOL /a/b/c/d/e/f/g" \
        "${U_TOOL:+$U_TOOL /a/b/c/d/e/f/g}"

    save_benchmark_results
}

run_dirname_benchmarks
