#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="env"
F_TOOL="fenv"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/env}"

run_env_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"env","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/env_benchmark.json"
        return 0
    fi

    init_benchmark "env"

    echo ""
    echo "=== Print all environment variables ==="

    run_benchmark "print all env vars" \
        "$GNU_TOOL" \
        "$F_TOOL" \
        "${U_TOOL:+$U_TOOL}"

    echo ""
    echo "=== Run a command ==="

    run_benchmark "env true (run command)" \
        "$GNU_TOOL true" \
        "$F_TOOL true" \
        "${U_TOOL:+$U_TOOL true}"

    echo ""
    echo "=== Set variable and run command ==="

    run_benchmark "env VAR=value true" \
        "$GNU_TOOL VAR=value true" \
        "$F_TOOL VAR=value true" \
        "${U_TOOL:+$U_TOOL VAR=value true}"

    save_benchmark_results
}

run_env_benchmarks
