#!/usr/bin/env bash
# Compatibility tests for fsha256sum vs GNU sha256sum
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="sha256sum"
F_TOOL="fsha256sum"

run_sha256sum_tests() {
    init_test_suite "sha256sum"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha256sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha256sum_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU sha256sum not found, cannot compare" >&2
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

    run_test "UTF-8 file hash" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    run_test "file with null bytes" \
        "$GNU_TOOL '$TEST_DATA_DIR/null_bytes.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/null_bytes.bin'"

    echo ""
    echo "=== Known Test Vectors ==="

    # SHA-256("") = e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
    run_stdout_test "empty string known hash" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    # SHA-256("abc") = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
    run_stdout_test "abc known hash" \
        "printf 'abc' | $GNU_TOOL" \
        "printf 'abc' | $F_TOOL"

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

    # Check marker: binary mode uses *, text mode uses space
    run_stdout_test "binary marker (*)" \
        "$GNU_TOOL -b '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL -b '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Tag Format (BSD style) ==="

    run_test "--tag format" \
        "$GNU_TOOL --tag '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL --tag '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "--tag multiple files" \
        "$GNU_TOOL --tag '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL --tag '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'"

    echo ""
    echo "=== Check Mode (-c) ==="

    # Create checksum file for check mode
    local checkfile
    checkfile=$(mktemp /tmp/fcoreutils_checksums_XXXXXX)
    register_temp "$checkfile"
    $GNU_TOOL "$TEST_DATA_DIR/checksum_abc.txt" "$TEST_DATA_DIR/checksum_fox.txt" > "$checkfile"

    run_test "-c check valid checksums" \
        "$GNU_TOOL -c '$checkfile'" \
        "$F_TOOL -c '$checkfile'"

    # Check with --quiet
    run_test "-c --quiet valid checksums" \
        "$GNU_TOOL -c --quiet '$checkfile'" \
        "$F_TOOL -c --quiet '$checkfile'"

    # Check with --status
    run_test "-c --status valid checksums" \
        "$GNU_TOOL -c --status '$checkfile'" \
        "$F_TOOL -c --status '$checkfile'"

    # Create checksum file with a wrong hash
    local bad_checkfile
    bad_checkfile=$(mktemp /tmp/fcoreutils_badcheck_XXXXXX)
    register_temp "$bad_checkfile"
    echo "0000000000000000000000000000000000000000000000000000000000000000  $TEST_DATA_DIR/checksum_abc.txt" > "$bad_checkfile"

    run_exit_code_test "-c with FAILED checksum" \
        "$GNU_TOOL -c '$bad_checkfile' 2>&1" \
        "$F_TOOL -c '$bad_checkfile' 2>&1"

    # Check with missing file in checksum file
    local missing_checkfile
    missing_checkfile=$(mktemp /tmp/fcoreutils_missingcheck_XXXXXX)
    register_temp "$missing_checkfile"
    echo "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad  /tmp/nonexistent_file_$$" > "$missing_checkfile"

    run_exit_code_test "-c with missing file" \
        "$GNU_TOOL -c '$missing_checkfile' 2>&1" \
        "$F_TOOL -c '$missing_checkfile' 2>&1"

    # --ignore-missing
    run_test "-c --ignore-missing" \
        "$GNU_TOOL -c --ignore-missing '$missing_checkfile'" \
        "$F_TOOL -c --ignore-missing '$missing_checkfile'"

    # Malformed checksum file
    local malformed_checkfile
    malformed_checkfile=$(mktemp /tmp/fcoreutils_malformed_XXXXXX)
    register_temp "$malformed_checkfile"
    printf 'this is not a valid checksum line\n' > "$malformed_checkfile"

    run_exit_code_test "-c with malformed checksum" \
        "$GNU_TOOL -c '$malformed_checkfile' 2>&1" \
        "$F_TOOL -c '$malformed_checkfile' 2>&1"

    echo ""
    echo "=== --strict and --warn ==="

    run_exit_code_test "-c --strict with malformed" \
        "$GNU_TOOL -c --strict '$malformed_checkfile' 2>&1" \
        "$F_TOOL -c --strict '$malformed_checkfile' 2>&1"

    run_exit_code_test "-c -w (warn) with malformed" \
        "$GNU_TOOL -c -w '$malformed_checkfile' 2>&1" \
        "$F_TOOL -c -w '$malformed_checkfile' 2>&1"

    echo ""
    echo "=== Zero-terminated output (-z) ==="

    run_test "-z output" \
        "$GNU_TOOL -z '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL -z '$TEST_DATA_DIR/checksum_abc.txt'"

    echo ""
    echo "=== Large File ==="

    run_test "10MB file hash" \
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

    if [[ -f "$TEST_DATA_DIR/unreadable.txt" ]]; then
        run_exit_code_test "permission denied" \
            "$GNU_TOOL '$TEST_DATA_DIR/unreadable.txt' 2>&1" \
            "$F_TOOL '$TEST_DATA_DIR/unreadable.txt' 2>&1"
    fi

    echo ""
    echo "=== Symlinks ==="

    if [[ -L "$TEST_DATA_DIR/symlink_to_csv" ]]; then
        run_test "symlink file hash" \
            "$GNU_TOOL '$TEST_DATA_DIR/symlink_to_csv'" \
            "$F_TOOL '$TEST_DATA_DIR/symlink_to_csv'"
    else
        skip_test "symlink file hash" "symlinks not available"
    fi

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

run_sha256sum_tests
