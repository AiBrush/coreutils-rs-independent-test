#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="printf"
F_TOOL="fprintf"

run_printf_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"printf","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/printf_benchmark.json"
        return 0
    fi

    init_benchmark "printf"

    # Use /usr/bin/printf for GNU (not the shell builtin)
    local gnu_printf="/usr/bin/printf"
    if [[ ! -x "$gnu_printf" ]]; then
        gnu_printf="printf"
    fi

    echo ""
    echo "=== Simple string ==="

    run_benchmark "simple string" \
        "$gnu_printf 'Hello, World!\n'" \
        "$F_TOOL 'Hello, World!\n'"

    echo ""
    echo "=== Format specifiers ==="

    run_benchmark "integer formatting" \
        "$gnu_printf '%d %d %d\n' 42 1000 999999" \
        "$F_TOOL '%d %d %d\n' 42 1000 999999"

    run_benchmark "float formatting" \
        "$gnu_printf '%.6f %.2f %e\n' 3.14159 2.71828 1000000.5" \
        "$F_TOOL '%.6f %.2f %e\n' 3.14159 2.71828 1000000.5"

    run_benchmark "string padding" \
        "$gnu_printf '%-20s %10s\n' hello world" \
        "$F_TOOL '%-20s %10s\n' hello world"

    save_benchmark_results
}

run_printf_benchmarks
