#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="pathchk"
F_TOOL="fpathchk"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/pathchk}"

run_pathchk_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pathchk","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/pathchk_benchmark.json"
        return 0
    fi

    init_benchmark "pathchk"

    echo ""
    echo "=== Basic pathchk ==="

    run_benchmark "pathchk default" \
        "$GNU_TOOL /tmp/testfile" \
        "$F_TOOL /tmp/testfile" \
        "${U_TOOL:+$U_TOOL /tmp/testfile}"

    echo ""
    echo "=== POSIX portable check (-p) ==="

    run_benchmark "pathchk -p (POSIX portable)" \
        "$GNU_TOOL -p /tmp/testfile" \
        "$F_TOOL -p /tmp/testfile" \
        "${U_TOOL:+$U_TOOL -p /tmp/testfile}"

    save_benchmark_results
}

run_pathchk_benchmarks
