#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="date"
F_TOOL="fdate"

run_date_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"date","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/date_benchmark.json"
        return 0
    fi

    init_benchmark "date"

    echo ""
    echo "=== Default output ==="

    run_benchmark "date (default)" \
        "$GNU_TOOL" \
        "$F_TOOL"

    echo ""
    echo "=== Format strings ==="

    run_benchmark "+%Y-%m-%d %H:%M:%S" \
        "$GNU_TOOL '+%Y-%m-%d %H:%M:%S'" \
        "$F_TOOL '+%Y-%m-%d %H:%M:%S'"

    run_benchmark "+%s (epoch)" \
        "$GNU_TOOL +%s" \
        "$F_TOOL +%s"

    run_benchmark "ISO 8601 format" \
        "$GNU_TOOL --iso-8601=seconds" \
        "$F_TOOL --iso-8601=seconds"

    run_benchmark "RFC 3339" \
        "$GNU_TOOL --rfc-3339=seconds" \
        "$F_TOOL --rfc-3339=seconds"

    echo ""
    echo "=== UTC ==="

    run_benchmark "-u (UTC)" \
        "$GNU_TOOL -u" \
        "$F_TOOL -u"

    save_benchmark_results
}

run_date_benchmarks
