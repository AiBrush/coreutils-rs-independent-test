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

    echo ""
    echo "=== Simple string ==="

    run_benchmark "simple string" \
        "$GNU_TOOL 'Hello, World!\n'" \
        "$F_TOOL 'Hello, World!\n'"

    echo ""
    echo "=== Format specifiers ==="

    run_benchmark "integer formatting" \
        "$GNU_TOOL '%d %d %d\n' 42 1000 999999" \
        "$F_TOOL '%d %d %d\n' 42 1000 999999"

    run_benchmark "float formatting" \
        "$GNU_TOOL '%.6f %.2f %e\n' 3.14159 2.71828 1000000.5" \
        "$F_TOOL '%.6f %.2f %e\n' 3.14159 2.71828 1000000.5"

    run_benchmark "string padding" \
        "$GNU_TOOL '%-20s %10s\n' hello world" \
        "$F_TOOL '%-20s %10s\n' hello world"

    echo ""
    echo "=== Repeated output ==="

    run_benchmark "repeated format (100 args)" \
        "$GNU_TOOL '%s\n' $(seq 1 100)" \
        "$F_TOOL '%s\n' $(seq 1 100)"

    save_benchmark_results
}

run_printf_benchmarks
