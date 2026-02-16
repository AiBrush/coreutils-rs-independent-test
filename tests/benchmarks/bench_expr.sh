#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="expr"
F_TOOL="fexpr"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/expr}"

run_expr_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"expr","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/expr_benchmark.json"
        return 0
    fi

    init_benchmark "expr"

    echo ""
    echo "=== Simple arithmetic ==="

    run_benchmark "expr 1 + 1" \
        "$GNU_TOOL 1 + 1" \
        "$F_TOOL 1 + 1" \
        "${U_TOOL:+$U_TOOL 1 + 1}"

    echo ""
    echo "=== Multiplication ==="

    run_benchmark "expr 999999 * 999999" \
        "$GNU_TOOL 999999 \* 999999" \
        "$F_TOOL 999999 \* 999999" \
        "${U_TOOL:+$U_TOOL 999999 \* 999999}"

    echo ""
    echo "=== String length ==="

    run_benchmark "expr length 'hello world'" \
        "$GNU_TOOL length 'hello world'" \
        "$F_TOOL length 'hello world'" \
        "${U_TOOL:+$U_TOOL length 'hello world'}"

    echo ""
    echo "=== Regex match ==="

    run_benchmark "expr 'hello' : 'hel'" \
        "$GNU_TOOL 'hello' : 'hel'" \
        "$F_TOOL 'hello' : 'hel'" \
        "${U_TOOL:+$U_TOOL 'hello' : 'hel'}"

    save_benchmark_results
}

run_expr_benchmarks
