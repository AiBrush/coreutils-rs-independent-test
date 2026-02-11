#!/usr/bin/env bash
# Compatibility tests for fmd5sum vs GNU md5sum
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="md5sum"
F_TOOL="fmd5sum"

run_md5sum_tests() {
    init_test_suite "md5sum"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"md5sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/md5sum_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU md5sum not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Hash Tests ==="

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
    echo "=== Known MD5 Test Vectors ==="

    # MD5("") = d41d8cd98f00b204e9800998ecf8427e
    run_stdout_test "empty string known hash" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    # MD5("abc") = 900150983cd24fb0d6963f7d28e17f72
    run_stdout_test "abc known hash" \
        "printf 'abc' | $GNU_TOOL" \
        "printf 'abc' | $F_TOOL"

    # MD5("The quick brown fox jumps over the lazy dog") = 9e107d9d372bb6826bd81d3542a419d6
    run_stdout_test "fox known hash" \
        "printf 'The quick brown fox jumps over the lazy dog' | $GNU_TOOL" \
        "printf 'The quick brown fox jumps over the lazy dog' | $F_TOOL"

    echo ""
    echo "=== Stdin ==="

    run_stdout_test "stdin hash" \
        "echo 'hello world' | $GNU_TOOL" \
        "echo 'hello world' | $F_TOOL"

    run_stdout_test "stdin binary data" \
        "cat '$TEST_DATA_DIR/random_1k.bin' | $GNU_TOOL" \
        "cat '$TEST_DATA_DIR/random_1k.bin' | $F_TOOL"

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
    checkfile=$(mktemp /tmp/fcoreutils_md5check_XXXXXX)
    register_temp "$checkfile"
    $GNU_TOOL "$TEST_DATA_DIR/checksum_abc.txt" "$TEST_DATA_DIR/checksum_fox.txt" > "$checkfile"

    run_test "-c check valid" \
        "$GNU_TOOL -c '$checkfile'" \
        "$F_TOOL -c '$checkfile'"

    run_test "-c --quiet" \
        "$GNU_TOOL -c --quiet '$checkfile'" \
        "$F_TOOL -c --quiet '$checkfile'"

    run_test "-c --status" \
        "$GNU_TOOL -c --status '$checkfile'" \
        "$F_TOOL -c --status '$checkfile'"

    # Wrong hash
    local bad_checkfile
    bad_checkfile=$(mktemp /tmp/fcoreutils_md5bad_XXXXXX)
    register_temp "$bad_checkfile"
    echo "00000000000000000000000000000000  $TEST_DATA_DIR/checksum_abc.txt" > "$bad_checkfile"

    run_exit_code_test "-c with FAILED checksum" \
        "$GNU_TOOL -c '$bad_checkfile' 2>&1" \
        "$F_TOOL -c '$bad_checkfile' 2>&1"

    # Missing file
    local missing_checkfile
    missing_checkfile=$(mktemp /tmp/fcoreutils_md5missing_XXXXXX)
    register_temp "$missing_checkfile"
    echo "900150983cd24fb0d6963f7d28e17f72  /tmp/nonexistent_file_$$" > "$missing_checkfile"

    run_exit_code_test "-c with missing file" \
        "$GNU_TOOL -c '$missing_checkfile' 2>&1" \
        "$F_TOOL -c '$missing_checkfile' 2>&1"

    run_test "-c --ignore-missing" \
        "$GNU_TOOL -c --ignore-missing '$missing_checkfile'" \
        "$F_TOOL -c --ignore-missing '$missing_checkfile'"

    # Malformed
    local malformed_checkfile
    malformed_checkfile=$(mktemp /tmp/fcoreutils_md5malformed_XXXXXX)
    register_temp "$malformed_checkfile"
    printf 'not a valid checksum line\n' > "$malformed_checkfile"

    run_exit_code_test "-c with malformed" \
        "$GNU_TOOL -c '$malformed_checkfile' 2>&1" \
        "$F_TOOL -c '$malformed_checkfile' 2>&1"

    echo ""
    echo "=== --strict and --warn ==="

    run_exit_code_test "-c --strict with malformed" \
        "$GNU_TOOL -c --strict '$malformed_checkfile' 2>&1" \
        "$F_TOOL -c --strict '$malformed_checkfile' 2>&1"

    run_exit_code_test "-c -w with malformed" \
        "$GNU_TOOL -c -w '$malformed_checkfile' 2>&1" \
        "$F_TOOL -c -w '$malformed_checkfile' 2>&1"

    echo ""
    echo "=== Zero-terminated (-z) ==="

    run_test "-z output" \
        "$GNU_TOOL -z '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL -z '$TEST_DATA_DIR/checksum_abc.txt'"

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

run_md5sum_tests
