#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="csplit"
F_TOOL="fcsplit"

run_csplit_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"csplit","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/csplit_benchmark.json"
        return 0
    fi

    init_benchmark "csplit"

    # Create benchmark input files
    local bench_dir
    bench_dir=$(mktemp -d /tmp/fcoreutils_bench_csplit_$$_XXXXXX)
    register_temp "$bench_dir"

    # 10000-line file for line-based splitting
    seq 1 10000 > "$bench_dir/input_10k"

    # File with periodic pattern for regex splitting
    local i
    for i in $(seq 1 500); do
        printf 'data line %d\n' "$i"
        if (( i % 20 == 0 )); then
            printf '---MARKER---\n'
        fi
    done > "$bench_dir/pattern_input"

    # File with many short sections for many-splits test
    for i in $(seq 1 1000); do
        printf 'SECTION %d\nline a\nline b\n' "$i"
    done > "$bench_dir/many_sections"

    echo ""
    echo "=== Split by line number ==="

    run_benchmark "csplit 10000-line file by line number (5000)" \
        "rm -f /tmp/bench_csplit_gnu_* && cd /tmp && $GNU_TOOL '$bench_dir/input_10k' 5000 2>/dev/null && rm -f xx*" \
        "rm -f /tmp/bench_csplit_f_* && cd /tmp && $F_TOOL '$bench_dir/input_10k' 5000 2>/dev/null && rm -f xx*"

    echo ""
    echo "=== Split by regex pattern ==="

    run_benchmark "csplit by regex /---MARKER---/ {*}" \
        "rm -f /tmp/bench_csplit_gnu_* && cd /tmp && $GNU_TOOL -z '$bench_dir/pattern_input' '/---MARKER---/' '{*}' 2>/dev/null && rm -f xx*" \
        "rm -f /tmp/bench_csplit_f_* && cd /tmp && $F_TOOL -z '$bench_dir/pattern_input' '/---MARKER---/' '{*}' 2>/dev/null && rm -f xx*"

    echo ""
    echo "=== Split with many patterns ==="

    run_benchmark "csplit many sections /SECTION/ {*}" \
        "rm -f /tmp/bench_csplit_gnu_* && cd /tmp && $GNU_TOOL -z '$bench_dir/many_sections' '/SECTION/' '{*}' 2>/dev/null && rm -f xx*" \
        "rm -f /tmp/bench_csplit_f_* && cd /tmp && $F_TOOL -z '$bench_dir/many_sections' '/SECTION/' '{*}' 2>/dev/null && rm -f xx*"

    echo ""
    echo "=== Split large file from test data ==="

    if [[ -f "$TEST_DATA_DIR/text_1m.txt" ]]; then
        run_benchmark "csplit 1MB by pattern /the/ {*}" \
            "cd /tmp && rm -f xx* && $GNU_TOOL -z '$TEST_DATA_DIR/text_1m.txt' '/the/' '{*}' 2>/dev/null && rm -f xx*" \
            "cd /tmp && rm -f xx* && $F_TOOL -z '$TEST_DATA_DIR/text_1m.txt' '/the/' '{*}' 2>/dev/null && rm -f xx*"
    fi

    # Cleanup
    rm -rf "$bench_dir"
    rm -f /tmp/bench_csplit_gnu_* /tmp/bench_csplit_f_*

    save_benchmark_results
}

run_csplit_benchmarks
