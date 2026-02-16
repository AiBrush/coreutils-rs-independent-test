#!/usr/bin/env bash
# Compatibility tests for fcomm vs GNU comm
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="comm"
F_TOOL="fcomm"

run_comm_tests() {
    init_test_suite "comm"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"comm","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/comm_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU comm not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic 3-Column Output ==="

    run_test "overlapping files" \
        "$GNU_TOOL '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    run_test "disjoint files" \
        "$GNU_TOOL '$TEST_DATA_DIR/comm_disjoint1.txt' '$TEST_DATA_DIR/comm_disjoint2.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/comm_disjoint1.txt' '$TEST_DATA_DIR/comm_disjoint2.txt'"

    run_test "identical files" \
        "$GNU_TOOL '$TEST_DATA_DIR/comm_identical.txt' '$TEST_DATA_DIR/comm_identical.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/comm_identical.txt' '$TEST_DATA_DIR/comm_identical.txt'"

    run_test "first file empty" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    run_test "second file empty" \
        "$GNU_TOOL '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/empty.txt'"

    run_test "both files empty" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/empty.txt'"

    echo ""
    echo "=== Suppress Columns ==="

    run_test "-1 (suppress unique to file1)" \
        "$GNU_TOOL -1 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL -1 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    run_test "-2 (suppress unique to file2)" \
        "$GNU_TOOL -2 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL -2 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    run_test "-3 (suppress common)" \
        "$GNU_TOOL -3 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL -3 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    run_test "-12 (only common lines)" \
        "$GNU_TOOL -12 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL -12 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    run_test "-13 (only unique to file2)" \
        "$GNU_TOOL -13 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL -13 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    run_test "-23 (only unique to file1)" \
        "$GNU_TOOL -23 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL -23 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    run_test "-123 (suppress all, no output)" \
        "$GNU_TOOL -123 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL -123 '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    echo ""
    echo "=== Suppress with Disjoint Files ==="

    run_test "-12 disjoint (no common = empty)" \
        "$GNU_TOOL -12 '$TEST_DATA_DIR/comm_disjoint1.txt' '$TEST_DATA_DIR/comm_disjoint2.txt'" \
        "$F_TOOL -12 '$TEST_DATA_DIR/comm_disjoint1.txt' '$TEST_DATA_DIR/comm_disjoint2.txt'"

    run_test "-3 disjoint (no common to suppress)" \
        "$GNU_TOOL -3 '$TEST_DATA_DIR/comm_disjoint1.txt' '$TEST_DATA_DIR/comm_disjoint2.txt'" \
        "$F_TOOL -3 '$TEST_DATA_DIR/comm_disjoint1.txt' '$TEST_DATA_DIR/comm_disjoint2.txt'"

    echo ""
    echo "=== Suppress with Identical Files ==="

    run_test "-12 identical" \
        "$GNU_TOOL -12 '$TEST_DATA_DIR/comm_identical.txt' '$TEST_DATA_DIR/comm_identical.txt'" \
        "$F_TOOL -12 '$TEST_DATA_DIR/comm_identical.txt' '$TEST_DATA_DIR/comm_identical.txt'"

    run_test "-3 identical (all suppressed)" \
        "$GNU_TOOL -3 '$TEST_DATA_DIR/comm_identical.txt' '$TEST_DATA_DIR/comm_identical.txt'" \
        "$F_TOOL -3 '$TEST_DATA_DIR/comm_identical.txt' '$TEST_DATA_DIR/comm_identical.txt'"

    run_test "-23 identical" \
        "$GNU_TOOL -23 '$TEST_DATA_DIR/comm_identical.txt' '$TEST_DATA_DIR/comm_identical.txt'" \
        "$F_TOOL -23 '$TEST_DATA_DIR/comm_identical.txt' '$TEST_DATA_DIR/comm_identical.txt'"

    echo ""
    echo "=== Output Delimiter (--output-delimiter) ==="

    run_stdout_test "--output-delimiter comma" \
        "$GNU_TOOL --output-delimiter=',' '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL --output-delimiter=',' '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    run_stdout_test "--output-delimiter pipe" \
        "$GNU_TOOL --output-delimiter='|' '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'" \
        "$F_TOOL --output-delimiter='|' '$TEST_DATA_DIR/comm_file1.txt' '$TEST_DATA_DIR/comm_file2.txt'"

    echo ""
    echo "=== Stdin ==="

    run_test "stdin as file1" \
        "printf 'apple\nbanana\ncherry\n' | $GNU_TOOL - '$TEST_DATA_DIR/comm_file2.txt'" \
        "printf 'apple\nbanana\ncherry\n' | $F_TOOL - '$TEST_DATA_DIR/comm_file2.txt'"

    run_test "stdin as file2" \
        "printf 'banana\ncherry\ndate\n' | $GNU_TOOL '$TEST_DATA_DIR/comm_file1.txt' -" \
        "printf 'banana\ncherry\ndate\n' | $F_TOOL '$TEST_DATA_DIR/comm_file1.txt' -"

    echo ""
    echo "=== Single Line Files ==="

    run_test "single matching line" \
        "printf 'same\n' | $GNU_TOOL - <(printf 'same\n')" \
        "printf 'same\n' | $F_TOOL - <(printf 'same\n')"

    run_test "single different lines" \
        "$GNU_TOOL <(printf 'alpha\n') <(printf 'beta\n')" \
        "$F_TOOL <(printf 'alpha\n') <(printf 'beta\n')"

    echo ""
    echo "=== Unicode ==="

    run_test "CJK sorted files" \
        "$GNU_TOOL <(printf 'apple\nbanana\n世界\n') <(printf 'banana\ncherry\n世界\n')" \
        "$F_TOOL <(printf 'apple\nbanana\n世界\n') <(printf 'banana\ncherry\n世界\n')"

    echo ""
    echo "=== Large Files ==="

    if [[ -f "$TEST_DATA_DIR/comm_bench_file1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/comm_bench_file2_10m.txt" ]]; then
        run_test "10MB sorted files" \
            "$GNU_TOOL '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' | md5sum" \
            "$F_TOOL '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' | md5sum"

        run_test "-12 10MB (common only)" \
            "$GNU_TOOL -12 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' | md5sum" \
            "$F_TOOL -12 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' | md5sum"

        run_test "-23 10MB (unique to file1)" \
            "$GNU_TOOL -23 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' | md5sum" \
            "$F_TOOL -23 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' | md5sum"
    fi

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ '$TEST_DATA_DIR/comm_file2.txt' 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ '$TEST_DATA_DIR/comm_file2.txt' 2>&1"

    echo ""
    echo "=== No Trailing Newline ==="

    run_test "no trailing newline" \
        "$GNU_TOOL <(printf 'apple\nbanana') <(printf 'banana\ncherry')" \
        "$F_TOOL <(printf 'apple\nbanana') <(printf 'banana\ncherry')"

    finish_test_suite
}

run_comm_tests
