#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="chcon"
F_TOOL="fchcon"

run_chcon_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chcon","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/chcon_benchmark.json"
        return 0
    fi

    init_benchmark "chcon"

    if ! command -v "$GNU_TOOL" &>/dev/null; then
        echo "GNU chcon not available (SELinux not supported on this platform)"
        save_benchmark_results
        return 0
    fi

    echo ""
    echo "=== Startup overhead ==="

    run_benchmark "chcon --help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    save_benchmark_results
}

run_chcon_benchmarks
