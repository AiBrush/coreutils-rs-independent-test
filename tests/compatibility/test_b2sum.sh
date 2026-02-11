#!/usr/bin/env bash
# Compatibility tests for fb2sum vs GNU b2sum
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="b2sum"
F_TOOL="fb2sum"

run_b2sum_tests() {
    init_test_suite "b2sum"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"b2sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/b2sum_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU b2sum not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Hash Tests (Default 512-bit) ==="

    run_test "empty file hash" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_empty.txt'"

    run_test "abc hash" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "fox hash" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_fox.txt'"

    run_test "CSV file hash" \
        "$GNU_TOOL '$TEST_DATA_DIR/simple.csv'" \
        "$F_TOOL '$TEST_DATA_DIR/simple.csv'"

    run_test "binary file hash" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Stdin ==="

    run_stdout_test "empty string stdin" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    run_stdout_test "abc stdin" \
        "printf 'abc' | $GNU_TOOL" \
        "printf 'abc' | $F_TOOL"

    run_stdout_test "stdin hash" \
        "echo 'hello world' | $GNU_TOOL" \
        "echo 'hello world' | $F_TOOL"

    echo ""
    echo "=== Variable Length Output (-l) ==="

    run_test "-l 256 (256-bit output)" \
        "$GNU_TOOL -l 256 '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL -l 256 '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "-l 128 (128-bit output)" \
        "$GNU_TOOL -l 128 '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL -l 128 '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "-l 512 (default 512-bit)" \
        "$GNU_TOOL -l 512 '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL -l 512 '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "-l 64 (64-bit output)" \
        "$GNU_TOOL -l 64 '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL -l 64 '$TEST_DATA_DIR/checksum_abc.txt'"

    echo ""
    echo "=== Multiple Files ==="

    run_test "two files" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'"

    run_test "three files" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_empty.txt' '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_empty.txt' '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'"

    echo ""
    echo "=== Binary vs Text Mode ==="

    run_test "-b (binary mode)" \
        "$GNU_TOOL -b '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL -b '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "-t (text mode)" \
        "$GNU_TOOL -t '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL -t '$TEST_DATA_DIR/checksum_abc.txt'"

    echo ""
    echo "=== Tag Format ==="

    run_test "--tag format" \
        "$GNU_TOOL --tag '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL --tag '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "--tag multiple files" \
        "$GNU_TOOL --tag '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL --tag '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'"

    echo ""
    echo "=== Check Mode (-c) ==="

    local checkfile
    checkfile=$(mktemp /tmp/fcoreutils_b2check_XXXXXX)
    register_temp "$checkfile"
    $GNU_TOOL "$TEST_DATA_DIR/checksum_abc.txt" "$TEST_DATA_DIR/checksum_fox.txt" > "$checkfile"

    run_test "-c check valid" \
        "$GNU_TOOL -c '$checkfile'" \
        "$F_TOOL -c '$checkfile'"

    # Wrong hash
    local bad_checkfile
    bad_checkfile=$(mktemp /tmp/fcoreutils_b2bad_XXXXXX)
    register_temp "$bad_checkfile"
    echo "$(printf '0%.0s' {1..128})  $TEST_DATA_DIR/checksum_abc.txt" > "$bad_checkfile"

    run_exit_code_test "-c with FAILED checksum" \
        "$GNU_TOOL -c '$bad_checkfile' 2>&1" \
        "$F_TOOL -c '$bad_checkfile' 2>&1"

    # Malformed
    local malformed_checkfile
    malformed_checkfile=$(mktemp /tmp/fcoreutils_b2malformed_XXXXXX)
    register_temp "$malformed_checkfile"
    printf 'not a valid checksum line\n' > "$malformed_checkfile"

    run_exit_code_test "-c with malformed" \
        "$GNU_TOOL -c '$malformed_checkfile' 2>&1" \
        "$F_TOOL -c '$malformed_checkfile' 2>&1"

    echo ""
    echo "=== Large Files ==="

    run_test "10MB text hash" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'"

    run_test "10MB binary hash" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_10m.bin'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Many Files ==="

    local many_args=""
    for f in "$TEST_DATA_DIR/many_files"/file_*.txt; do
        many_args="$many_args '$f'"
    done

    run_test "100 files" \
        "eval $GNU_TOOL $many_args" \
        "eval $F_TOOL $many_args"

    finish_test_suite
}

run_b2sum_tests
