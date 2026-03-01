#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="cp"
F_TOOL="fcp"

run_cp_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"cp","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/cp_benchmark.json"
        return 0
    fi

    init_benchmark "cp"

    # Prepare benchmark test files
    local bench_dir
    bench_dir=$(mktemp -d /tmp/fcoreutils_bench_cp_$$_XXXXXX)
    register_temp "$bench_dir"

    # Small file (1KB)
    dd if=/dev/urandom of="$bench_dir/small_file" bs=1024 count=1 2>/dev/null

    # Medium file (1MB)
    dd if=/dev/urandom of="$bench_dir/medium_file" bs=1024 count=1024 2>/dev/null

    # Large file (10MB)
    dd if=/dev/urandom of="$bench_dir/large_file" bs=1024 count=10240 2>/dev/null

    # Many small files directory (100 files)
    mkdir -p "$bench_dir/many_small"
    for i in $(seq 1 100); do
        echo "file content $i" > "$bench_dir/many_small/file_$i"
    done

    # Deep directory structure
    mkdir -p "$bench_dir/deep/a/b/c/d/e/f/g/h"
    for dir in "$bench_dir/deep" "$bench_dir/deep/a" "$bench_dir/deep/a/b" \
               "$bench_dir/deep/a/b/c" "$bench_dir/deep/a/b/c/d" \
               "$bench_dir/deep/a/b/c/d/e" "$bench_dir/deep/a/b/c/d/e/f" \
               "$bench_dir/deep/a/b/c/d/e/f/g" "$bench_dir/deep/a/b/c/d/e/f/g/h"; do
        echo "content in $(basename "$dir")" > "$dir/file.txt"
    done

    echo ""
    echo "=== Copy Single File ==="

    run_benchmark "cp small file (1KB)" \
        "rm -f /tmp/bench_cp_small_gnu_$$ && $GNU_TOOL '$bench_dir/small_file' /tmp/bench_cp_small_gnu_$$" \
        "rm -f /tmp/bench_cp_small_f_$$ && $F_TOOL '$bench_dir/small_file' /tmp/bench_cp_small_f_$$"

    run_benchmark "cp medium file (1MB)" \
        "rm -f /tmp/bench_cp_med_gnu_$$ && $GNU_TOOL '$bench_dir/medium_file' /tmp/bench_cp_med_gnu_$$" \
        "rm -f /tmp/bench_cp_med_f_$$ && $F_TOOL '$bench_dir/medium_file' /tmp/bench_cp_med_f_$$"

    run_benchmark "cp large file (10MB)" \
        "rm -f /tmp/bench_cp_lg_gnu_$$ && $GNU_TOOL '$bench_dir/large_file' /tmp/bench_cp_lg_gnu_$$" \
        "rm -f /tmp/bench_cp_lg_f_$$ && $F_TOOL '$bench_dir/large_file' /tmp/bench_cp_lg_f_$$"

    echo ""
    echo "=== Copy Directory Recursively ==="

    run_benchmark "cp -r many small files (100 files)" \
        "rm -rf /tmp/bench_cp_many_gnu_$$ && $GNU_TOOL -r '$bench_dir/many_small' /tmp/bench_cp_many_gnu_$$" \
        "rm -rf /tmp/bench_cp_many_f_$$ && $F_TOOL -r '$bench_dir/many_small' /tmp/bench_cp_many_f_$$"

    run_benchmark "cp -r deep directory (8 levels)" \
        "rm -rf /tmp/bench_cp_deep_gnu_$$ && $GNU_TOOL -r '$bench_dir/deep' /tmp/bench_cp_deep_gnu_$$" \
        "rm -rf /tmp/bench_cp_deep_f_$$ && $F_TOOL -r '$bench_dir/deep' /tmp/bench_cp_deep_f_$$"

    # Cleanup
    rm -rf "$bench_dir"
    rm -f /tmp/bench_cp_small_gnu_$$ /tmp/bench_cp_small_f_$$
    rm -f /tmp/bench_cp_med_gnu_$$ /tmp/bench_cp_med_f_$$
    rm -f /tmp/bench_cp_lg_gnu_$$ /tmp/bench_cp_lg_f_$$
    rm -rf /tmp/bench_cp_many_gnu_$$ /tmp/bench_cp_many_f_$$
    rm -rf /tmp/bench_cp_deep_gnu_$$ /tmp/bench_cp_deep_f_$$

    save_benchmark_results
}

run_cp_benchmarks
