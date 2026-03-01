#!/usr/bin/env bash
# Compatibility tests for fsha1sum vs GNU sha1sum
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "sha1sum")
F_TOOL="fsha1sum"

run_sha1sum_tests() {
    init_test_suite "sha1sum"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"sha1sum","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/sha1sum_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU sha1sum not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Hashing ==="

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_empty.txt'"

    run_test "abc" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt'"

    run_test "fox string" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_fox.txt'"

    run_test "single byte" \
        "$GNU_TOOL '$TEST_DATA_DIR/single_byte.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/single_byte.txt'"

    run_test "binary file" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Stdin ==="

    run_test "stdin simple" \
        "printf 'hello' | $GNU_TOOL" \
        "printf 'hello' | $F_TOOL"

    run_test "stdin empty" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    run_test "stdin binary" \
        "printf '\x00\x01\xff' | $GNU_TOOL" \
        "printf '\x00\x01\xff' | $F_TOOL"

    echo ""
    echo "=== Multiple Files ==="

    run_test "multiple files" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt' '$TEST_DATA_DIR/checksum_empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt' '$TEST_DATA_DIR/checksum_empty.txt'"

    echo ""
    echo "=== Check Mode (-c) ==="

    run_test "check mode" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_abc.txt' > /tmp/sha1_gnu_check_$$ && $GNU_TOOL -c /tmp/sha1_gnu_check_$$ && rm -f /tmp/sha1_gnu_check_$$" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_abc.txt' > /tmp/sha1_f_check_$$ && $F_TOOL -c /tmp/sha1_f_check_$$ && rm -f /tmp/sha1_f_check_$$"

    echo ""
    echo "=== Binary Mode (-b) ==="

    run_test "-b binary mode" \
        "$GNU_TOOL -b '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL -b '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Large Files ==="

    run_test "1MB file" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_1m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_1m.txt'"

    echo ""
    echo "=== Edge Cases ==="

    run_test "null bytes" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'"

    run_test "unicode" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    echo ""
    echo "=== Known Hash Test Vectors ==="

    run_stdout_test "empty string known hash" \
        "printf '' | $GNU_TOOL" \
        "printf '' | $F_TOOL"

    run_stdout_test "abc known hash" \
        "printf 'abc' | $GNU_TOOL" \
        "printf 'abc' | $F_TOOL"

    run_stdout_test "fox known hash" \
        "printf 'The quick brown fox jumps over the lazy dog' | $GNU_TOOL" \
        "printf 'The quick brown fox jumps over the lazy dog' | $F_TOOL"

    echo ""
    echo "=== Stdin via Dash ==="

    run_test "stdin dash" \
        "echo 'test' | $GNU_TOOL -" \
        "echo 'test' | $F_TOOL -"

    echo ""
    echo "=== Binary vs Text Mode ==="

    run_test "-t text mode" \
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
    echo "=== Check Mode (expanded) ==="

    local checkfile
    checkfile=$(mktemp /tmp/fcoreutils_sha1check_XXXXXX)
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
    bad_checkfile=$(mktemp /tmp/fcoreutils_sha1bad_XXXXXX)
    register_temp "$bad_checkfile"
    echo "0000000000000000000000000000000000000000  $TEST_DATA_DIR/checksum_abc.txt" > "$bad_checkfile"

    run_exit_code_test "-c with FAILED checksum" \
        "$GNU_TOOL -c '$bad_checkfile' 2>&1" \
        "$F_TOOL -c '$bad_checkfile' 2>&1"

    # Missing file in checksum
    local missing_checkfile
    missing_checkfile=$(mktemp /tmp/fcoreutils_sha1missing_XXXXXX)
    register_temp "$missing_checkfile"
    echo "da39a3ee5e6b4b0d3255bfef95601890afd80709  /tmp/nonexistent_file_$$" > "$missing_checkfile"

    run_exit_code_test "-c with missing file" \
        "$GNU_TOOL -c '$missing_checkfile' 2>&1" \
        "$F_TOOL -c '$missing_checkfile' 2>&1"

    # Malformed checksum file
    local malformed_checkfile
    malformed_checkfile=$(mktemp /tmp/fcoreutils_sha1malformed_XXXXXX)
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
    echo "=== Binary Data with Null Bytes ==="

    run_test "binary data with nulls" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'"

    echo ""
    echo "=== Unicode and Special Filenames ==="

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_sha1sum_XXXXXX)
    register_temp "$test_dir"

    echo "unicode content" > "$test_dir/файл_тест.txt"
    run_test "unicode filename" \
        "$GNU_TOOL '$test_dir/файл_тест.txt'" \
        "$F_TOOL '$test_dir/файл_тест.txt'"

    echo "space content" > "$test_dir/file with spaces.txt"
    run_test "space in filename" \
        "$GNU_TOOL '$test_dir/file with spaces.txt'" \
        "$F_TOOL '$test_dir/file with spaces.txt'"

    echo ""
    echo "=== Symlink ==="

    ln -sf "$TEST_DATA_DIR/checksum_abc.txt" "$test_dir/symlink_abc"
    run_test "symlink" \
        "$GNU_TOOL '$test_dir/symlink_abc'" \
        "$F_TOOL '$test_dir/symlink_abc'"

    echo ""
    echo "=== No Args Reads Stdin ==="

    run_test "no args stdin" \
        "printf 'hello' | $GNU_TOOL" \
        "printf 'hello' | $F_TOOL"

    echo ""
    echo "=== Three Files ==="

    run_test "three files" \
        "$GNU_TOOL '$TEST_DATA_DIR/checksum_empty.txt' '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/checksum_empty.txt' '$TEST_DATA_DIR/checksum_abc.txt' '$TEST_DATA_DIR/checksum_fox.txt'"

    echo ""
    echo "=== Directory Error ==="

    run_exit_code_test "directory error" \
        "$GNU_TOOL '$test_dir' 2>&1" \
        "$F_TOOL '$test_dir' 2>&1"

    echo ""
    echo "=== --help and --version ==="

    run_exit_code_test "--help exit code" \
        "$GNU_TOOL --help > /dev/null 2>&1" \
        "$F_TOOL --help > /dev/null 2>&1"

    run_exit_code_test "--version exit code" \
        "$GNU_TOOL --version > /dev/null 2>&1" \
        "$F_TOOL --version > /dev/null 2>&1"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Large Files ==="

    run_test "10MB text hash" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt'"

    run_test "10MB binary hash" \
        "$GNU_TOOL '$TEST_DATA_DIR/random_10m.bin'" \
        "$F_TOOL '$TEST_DATA_DIR/random_10m.bin'"

    echo ""
    echo "=== Many Files ==="

    local many_args=""
    for f in "$TEST_DATA_DIR/many_files"/file_*.txt; do
        many_args="$many_args '$f'"
    done

    run_test "100 files" \
        "eval $GNU_TOOL $many_args" \
        "eval $F_TOOL $many_args"

    rm -rf "$test_dir"

    finish_test_suite
}

run_sha1sum_tests
