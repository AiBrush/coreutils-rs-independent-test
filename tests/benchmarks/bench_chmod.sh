#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bench_common.sh"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="chmod"
F_TOOL="fchmod"

run_chmod_benchmarks() {
    check_hyperfine
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chmod","status":"NOT_IMPLEMENTED"}' > "$RESULTS_DIR/chmod_benchmark.json"
        return 0
    fi

    init_benchmark "chmod"

    # --- Single file benchmarks ---
    echo ""
    echo "=== chmod single file ==="

    # Toggle between 644 and 755 so each run does real work
    local bench_dir
    bench_dir=$(mktemp -d /tmp/fcoreutils_bench_chmod_$$_XXXXXX)
    register_temp "$bench_dir"
    touch "$bench_dir/testfile"

    run_benchmark "single file chmod (644/755 toggle)" \
        "$GNU_TOOL 644 '$bench_dir/testfile' && $GNU_TOOL 755 '$bench_dir/testfile'" \
        "$F_TOOL 644 '$bench_dir/testfile' && $F_TOOL 755 '$bench_dir/testfile'"

    echo ""
    echo "=== chmod numeric mode ==="

    run_benchmark "chmod 644 on file" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chmod_gnu_$$ && $GNU_TOOL 644 /tmp/bench_chmod_gnu_$$" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chmod_f_$$ && $F_TOOL 644 /tmp/bench_chmod_f_$$"

    echo ""
    echo "=== chmod symbolic mode ==="

    run_benchmark "chmod u+x on file" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chmod_ux_gnu_$$ && $GNU_TOOL u+x /tmp/bench_chmod_ux_gnu_$$" \
        "cp '$TEST_DATA_DIR/text_100k.txt' /tmp/bench_chmod_ux_f_$$ && $F_TOOL u+x /tmp/bench_chmod_ux_f_$$"

    # --- Many files benchmark ---
    echo ""
    echo "=== chmod many files ==="

    local many_dir="$bench_dir/many"
    mkdir -p "$many_dir"
    for i in $(seq 1 100); do
        touch "$many_dir/file_$(printf '%03d' $i)"
    done

    local many_files_list=""
    for i in $(seq 1 100); do
        many_files_list="$many_files_list '$many_dir/file_$(printf '%03d' $i)'"
    done

    run_benchmark "chmod 644 on 100 files" \
        "eval $GNU_TOOL 644 $many_files_list && eval $GNU_TOOL 755 $many_files_list" \
        "eval $F_TOOL 644 $many_files_list && eval $F_TOOL 755 $many_files_list"

    # --- Recursive deep directory benchmark ---
    echo ""
    echo "=== chmod recursive deep ==="

    local deep_dir="$bench_dir/deep"
    mkdir -p "$deep_dir/l1/l2/l3/l4/l5"
    for d in "$deep_dir" "$deep_dir/l1" "$deep_dir/l1/l2" "$deep_dir/l1/l2/l3" "$deep_dir/l1/l2/l3/l4" "$deep_dir/l1/l2/l3/l4/l5"; do
        for i in $(seq 1 10); do
            touch "$d/file_$i"
        done
    done

    run_benchmark "chmod -R 755 on deep tree" \
        "$GNU_TOOL -R 755 '$deep_dir' && $GNU_TOOL -R 644 '$deep_dir'" \
        "$F_TOOL -R 755 '$deep_dir' && $F_TOOL -R 644 '$deep_dir'"

    # Cleanup
    rm -f /tmp/bench_chmod_gnu_$$ /tmp/bench_chmod_f_$$
    rm -f /tmp/bench_chmod_ux_gnu_$$ /tmp/bench_chmod_ux_f_$$
    rm -rf "$bench_dir"

    save_benchmark_results
}

run_chmod_benchmarks
