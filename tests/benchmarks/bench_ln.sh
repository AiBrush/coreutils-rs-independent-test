#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="ln"
F_TOOL="fln"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/ln}"

run_ln_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"ln","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/ln_benchmark.json"
        return 0
    fi

    init_benchmark "ln"

    echo ""
    echo "=== Symbolic link creation ==="

    run_benchmark "symlink single file" \
        "rm -f /tmp/bench_ln_gnu && $GNU_TOOL -s '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_ln_gnu" \
        "rm -f /tmp/bench_ln_f && $F_TOOL -s '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_ln_f" \
        "${U_TOOL:+rm -f /tmp/bench_ln_u && $U_TOOL -s '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_ln_u}"

    run_benchmark "symlink force overwrite (-sf)" \
        "rm -f /tmp/bench_ln_sf_gnu && $GNU_TOOL -sf '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_ln_sf_gnu" \
        "rm -f /tmp/bench_ln_sf_f && $F_TOOL -sf '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_ln_sf_f" \
        "${U_TOOL:+rm -f /tmp/bench_ln_sf_u && $U_TOOL -sf '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_ln_sf_u}"

    echo ""
    echo "=== Hard link creation ==="

    run_benchmark "hard link single file" \
        "rm -f /tmp/bench_ln_hard_gnu && $GNU_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_ln_hard_gnu" \
        "rm -f /tmp/bench_ln_hard_f && $F_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_ln_hard_f" \
        "${U_TOOL:+rm -f /tmp/bench_ln_hard_u && $U_TOOL '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_ln_hard_u}"

    # Cleanup
    rm -f /tmp/bench_ln_gnu /tmp/bench_ln_f /tmp/bench_ln_u
    rm -f /tmp/bench_ln_sf_gnu /tmp/bench_ln_sf_f /tmp/bench_ln_sf_u
    rm -f /tmp/bench_ln_hard_gnu /tmp/bench_ln_hard_f /tmp/bench_ln_hard_u

    save_benchmark_results
}

run_ln_benchmarks
