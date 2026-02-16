#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="install"
F_TOOL="finstall"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/install}"

run_install_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"install","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/install_benchmark.json"
        return 0
    fi

    init_benchmark "install"

    echo ""
    echo "=== Install file to destination ==="

    run_benchmark "install 1MB file" \
        "rm -f /tmp/bench_install_gnu && $GNU_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_install_gnu" \
        "rm -f /tmp/bench_install_f && $F_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_install_f" \
        "${U_TOOL:+rm -f /tmp/bench_install_u && $U_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_install_u}"

    echo ""
    echo "=== Install directory (-d) ==="

    run_benchmark "install -d create directory" \
        "rm -rf /tmp/bench_install_dir_gnu && $GNU_TOOL -d /tmp/bench_install_dir_gnu/a/b/c" \
        "rm -rf /tmp/bench_install_dir_f && $F_TOOL -d /tmp/bench_install_dir_f/a/b/c" \
        "${U_TOOL:+rm -rf /tmp/bench_install_dir_u && $U_TOOL -d /tmp/bench_install_dir_u/a/b/c}"

    # Cleanup
    rm -f /tmp/bench_install_gnu /tmp/bench_install_f /tmp/bench_install_u
    rm -rf /tmp/bench_install_dir_gnu /tmp/bench_install_dir_f /tmp/bench_install_dir_u

    save_benchmark_results
}

run_install_benchmarks
