#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="readlink"
F_TOOL="freadlink"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/readlink}"

run_readlink_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"readlink","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/readlink_benchmark.json"
        return 0
    fi

    # Create symlink for benchmarking
    ln -sf "$TEST_DATA_DIR/text_1m.txt" /tmp/bench_readlink_target

    init_benchmark "readlink"

    echo ""
    echo "=== Read symlink target ==="

    run_benchmark "readlink symlink" \
        "$GNU_TOOL /tmp/bench_readlink_target" \
        "$F_TOOL /tmp/bench_readlink_target" \
        "${U_TOOL:+$U_TOOL /tmp/bench_readlink_target}"

    echo ""
    echo "=== Canonicalize symlink (-f) ==="

    run_benchmark "readlink -f (canonicalize)" \
        "$GNU_TOOL -f /tmp/bench_readlink_target" \
        "$F_TOOL -f /tmp/bench_readlink_target" \
        "${U_TOOL:+$U_TOOL -f /tmp/bench_readlink_target}"

    # Cleanup
    rm -f /tmp/bench_readlink_target

    save_benchmark_results
}

run_readlink_benchmarks
