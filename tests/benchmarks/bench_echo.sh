#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="/usr/bin/echo"
F_TOOL="fecho"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/echo}"

run_echo_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"echo","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/echo_benchmark.json"
        return 0
    fi

    init_benchmark "echo"

    echo ""
    echo "=== Simple string ==="

    run_benchmark "echo hello" \
        "$GNU_TOOL hello" \
        "$F_TOOL hello" \
        "${U_TOOL:+$U_TOOL hello}"

    echo ""
    echo "=== No newline (-n) ==="

    run_benchmark "echo -n hello" \
        "$GNU_TOOL -n hello" \
        "$F_TOOL -n hello" \
        "${U_TOOL:+$U_TOOL -n hello}"

    echo ""
    echo "=== Escape sequences (-e) ==="

    run_benchmark "echo -e with escapes" \
        "$GNU_TOOL -e 'hello\tworld\n'" \
        "$F_TOOL -e 'hello\tworld\n'" \
        "${U_TOOL:+$U_TOOL -e 'hello\tworld\n'}"

    save_benchmark_results
}

run_echo_benchmarks
