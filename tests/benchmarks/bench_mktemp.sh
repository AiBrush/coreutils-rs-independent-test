#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mktemp"
F_TOOL="fmktemp"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/mktemp}"

run_mktemp_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mktemp","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/mktemp_benchmark.json"
        return 0
    fi

    init_benchmark "mktemp"

    echo ""
    echo "=== Create temp file ==="

    run_benchmark "mktemp default" \
        "f=\$($GNU_TOOL) && rm -f \"\$f\"" \
        "f=\$($F_TOOL) && rm -f \"\$f\"" \
        "${U_TOOL:+f=\$($U_TOOL) && rm -f \"\$f\"}"

    echo ""
    echo "=== Create temp directory ==="

    run_benchmark "mktemp -d directory" \
        "d=\$($GNU_TOOL -d) && rmdir \"\$d\"" \
        "d=\$($F_TOOL -d) && rmdir \"\$d\"" \
        "${U_TOOL:+d=\$($U_TOOL -d) && rmdir \"\$d\"}"

    save_benchmark_results
}

run_mktemp_benchmarks
