#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="dircolors"
F_TOOL="fdircolors"

run_dircolors_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dircolors","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/dircolors_benchmark.json"
        return 0
    fi

    init_benchmark "dircolors"

    echo ""
    echo "=== Default database ==="

    run_benchmark "dircolors -b (default)" \
        "$GNU_TOOL -b" \
        "$F_TOOL -b"

    run_benchmark "dircolors -c (csh)" \
        "$GNU_TOOL -c" \
        "$F_TOOL -c"

    echo ""
    echo "=== Print database ==="

    run_benchmark "dircolors -p (print)" \
        "$GNU_TOOL -p" \
        "$F_TOOL -p"

    echo ""
    echo "=== Custom database ==="

    if [[ -f "$TEST_DATA_DIR/dircolors_custom.txt" ]]; then
        run_benchmark "custom db file" \
            "$GNU_TOOL -b '$TEST_DATA_DIR/dircolors_custom.txt'" \
            "$F_TOOL -b '$TEST_DATA_DIR/dircolors_custom.txt'"
    fi

    save_benchmark_results
}

run_dircolors_benchmarks
