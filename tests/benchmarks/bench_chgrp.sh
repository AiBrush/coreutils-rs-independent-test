#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="chgrp"
F_TOOL="fchgrp"
U_TOOL="${UUTILS_DIR:+$UUTILS_DIR/chgrp}"

run_chgrp_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chgrp","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/chgrp_benchmark.json"
        return 0
    fi

    init_benchmark "chgrp"

    local CURRENT_GROUP
    CURRENT_GROUP=$(id -gn)

    echo ""
    echo "=== chgrp to current group ==="

    run_benchmark "chgrp current group on file" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chgrp_gnu && $GNU_TOOL $CURRENT_GROUP /tmp/bench_chgrp_gnu" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chgrp_f && $F_TOOL $CURRENT_GROUP /tmp/bench_chgrp_f" \
        "${U_TOOL:+cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chgrp_u && $U_TOOL $CURRENT_GROUP /tmp/bench_chgrp_u}"

    run_benchmark "chgrp current group on 1MB file" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_chgrp_1m_gnu && $GNU_TOOL $CURRENT_GROUP /tmp/bench_chgrp_1m_gnu" \
        "cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_chgrp_1m_f && $F_TOOL $CURRENT_GROUP /tmp/bench_chgrp_1m_f" \
        "${U_TOOL:+cp '$TEST_DATA_DIR/text_1m.txt' /tmp/bench_chgrp_1m_u && $U_TOOL $CURRENT_GROUP /tmp/bench_chgrp_1m_u}"

    # Cleanup
    rm -f /tmp/bench_chgrp_gnu /tmp/bench_chgrp_f /tmp/bench_chgrp_u
    rm -f /tmp/bench_chgrp_1m_gnu /tmp/bench_chgrp_1m_f /tmp/bench_chgrp_1m_u

    save_benchmark_results
}

run_chgrp_benchmarks
