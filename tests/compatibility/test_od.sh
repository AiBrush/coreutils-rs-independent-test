#!/usr/bin/env bash
# Compatibility tests for fod vs GNU od
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="od"
F_TOOL="fod"

run_od_tests() {
    init_test_suite "od"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"od","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/od_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU od not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_od_XXXXXX)
    register_temp "$test_dir"

    # Create binary test file
    printf '\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f' > "$test_dir/hex16.bin"
    printf '\x41\x42\x43\x44\x45\x46\x47\x48' > "$test_dir/abc.bin"
    printf 'Hello, World!\n' > "$test_dir/hello.txt"
    dd if=/dev/zero bs=64 count=1 of="$test_dir/zeros64.bin" 2>/dev/null
    printf '\xff\xfe\xfd\xfc\xfb\xfa' > "$test_dir/highbytes.bin"

    # === Section 1: Default (Octal) Output ===
    echo ""
    echo "=== Default (Octal) Output ==="

    run_stdout_test "default octal dump" \
        "echo 'Hello' | $GNU_TOOL" \
        "echo 'Hello' | $F_TOOL"

    run_stdout_test "empty file" \
        "$GNU_TOOL /dev/null" \
        "$F_TOOL /dev/null"

    run_stdout_test "hex16 default" \
        "$GNU_TOOL '$test_dir/hex16.bin'" \
        "$F_TOOL '$test_dir/hex16.bin'"

    run_stdout_test "hello default" \
        "$GNU_TOOL '$test_dir/hello.txt'" \
        "$F_TOOL '$test_dir/hello.txt'"

    # === Section 2: Format Types (-t) ===
    echo ""
    echo "=== Format Types (-t) ==="

    run_stdout_test "-t x1 hex bytes" \
        "echo 'Hello' | $GNU_TOOL -t x1" \
        "echo 'Hello' | $F_TOOL -t x1"

    run_stdout_test "-t d1 signed decimal bytes" \
        "echo 'Hello' | $GNU_TOOL -t d1" \
        "echo 'Hello' | $F_TOOL -t d1"

    run_stdout_test "-t c characters" \
        "echo 'Hello' | $GNU_TOOL -t c" \
        "echo 'Hello' | $F_TOOL -t c"

    run_stdout_test "-t a named characters" \
        "echo 'Hello' | $GNU_TOOL -t a" \
        "echo 'Hello' | $F_TOOL -t a"

    run_stdout_test "-t o1 octal bytes" \
        "echo 'Hello' | $GNU_TOOL -t o1" \
        "echo 'Hello' | $F_TOOL -t o1"

    run_stdout_test "-t u1 unsigned decimal" \
        "echo 'Hello' | $GNU_TOOL -t u1" \
        "echo 'Hello' | $F_TOOL -t u1"

    run_stdout_test "-t x2 hex 2-byte words" \
        "$GNU_TOOL -t x2 '$test_dir/hex16.bin'" \
        "$F_TOOL -t x2 '$test_dir/hex16.bin'"

    run_stdout_test "-t x4 hex 4-byte words" \
        "$GNU_TOOL -t x4 '$test_dir/hex16.bin'" \
        "$F_TOOL -t x4 '$test_dir/hex16.bin'"

    run_stdout_test "-t d2 signed 2-byte" \
        "$GNU_TOOL -t d2 '$test_dir/hex16.bin'" \
        "$F_TOOL -t d2 '$test_dir/hex16.bin'"

    run_stdout_test "-t fF float" \
        "$GNU_TOOL -t fF '$test_dir/hex16.bin'" \
        "$F_TOOL -t fF '$test_dir/hex16.bin'"

    # === Section 3: Address Radix (-A) ===
    echo ""
    echo "=== Address Radix (-A) ==="

    run_stdout_test "-A x hex addresses" \
        "echo 'Hello' | $GNU_TOOL -A x" \
        "echo 'Hello' | $F_TOOL -A x"

    run_stdout_test "-A d decimal addresses" \
        "echo 'Hello' | $GNU_TOOL -A d" \
        "echo 'Hello' | $F_TOOL -A d"

    run_stdout_test "-A n no addresses" \
        "echo 'Hello' | $GNU_TOOL -A n" \
        "echo 'Hello' | $F_TOOL -A n"

    run_stdout_test "-A o octal addresses (default)" \
        "echo 'Hello' | $GNU_TOOL -A o" \
        "echo 'Hello' | $F_TOOL -A o"

    # === Section 4: Skip and Limit ===
    echo ""
    echo "=== Skip and Limit ==="

    run_stdout_test "-j 3 skip 3 bytes" \
        "$GNU_TOOL -j 3 '$test_dir/hex16.bin'" \
        "$F_TOOL -j 3 '$test_dir/hex16.bin'"

    run_stdout_test "-N 5 limit to 5 bytes" \
        "$GNU_TOOL -N 5 '$test_dir/hex16.bin'" \
        "$F_TOOL -N 5 '$test_dir/hex16.bin'"

    run_stdout_test "-j 3 -N 5 combined" \
        "$GNU_TOOL -j 3 -N 5 '$test_dir/hex16.bin'" \
        "$F_TOOL -j 3 -N 5 '$test_dir/hex16.bin'"

    run_stdout_test "-N 16 -t x1" \
        "$GNU_TOOL -N 16 -t x1 '$test_dir/hello.txt'" \
        "$F_TOOL -N 16 -t x1 '$test_dir/hello.txt'"

    # === Section 5: Width (-w) ===
    echo ""
    echo "=== Width (-w) ==="

    run_stdout_test "-w8 8 bytes per line" \
        "echo 'Hello World' | $GNU_TOOL -w8 -t x1" \
        "echo 'Hello World' | $F_TOOL -w8 -t x1"

    run_stdout_test "-w16 16 bytes per line" \
        "$GNU_TOOL -w16 -t x1 '$test_dir/hex16.bin'" \
        "$F_TOOL -w16 -t x1 '$test_dir/hex16.bin'"

    run_stdout_test "-w4 narrow" \
        "$GNU_TOOL -w4 -t x1 '$test_dir/abc.bin'" \
        "$F_TOOL -w4 -t x1 '$test_dir/abc.bin'"

    # === Section 6: Duplicate Suppression ===
    echo ""
    echo "=== Duplicate Suppression ==="

    run_stdout_test "zeros with duplicate suppression" \
        "$GNU_TOOL '$test_dir/zeros64.bin'" \
        "$F_TOOL '$test_dir/zeros64.bin'"

    run_stdout_test "-v show all (no suppression)" \
        "$GNU_TOOL -v '$test_dir/zeros64.bin'" \
        "$F_TOOL -v '$test_dir/zeros64.bin'"

    # === Section 7: Binary/High-Byte Data ===
    echo ""
    echo "=== Binary Data ==="

    run_stdout_test "high bytes -t x1" \
        "$GNU_TOOL -t x1 '$test_dir/highbytes.bin'" \
        "$F_TOOL -t x1 '$test_dir/highbytes.bin'"

    run_stdout_test "null bytes -t x1" \
        "printf '\\x00\\x01\\x02\\xff' | $GNU_TOOL -t x1" \
        "printf '\\x00\\x01\\x02\\xff' | $F_TOOL -t x1"

    run_stdout_test "binary file -t c" \
        "$GNU_TOOL -t c '$test_dir/highbytes.bin'" \
        "$F_TOOL -t c '$test_dir/highbytes.bin'"

    # === Section 8: Traditional Options ===
    echo ""
    echo "=== Traditional Options ==="

    run_stdout_test "-b (octal bytes)" \
        "echo 'Hello' | $GNU_TOOL -b" \
        "echo 'Hello' | $F_TOOL -b"

    run_stdout_test "-c (characters)" \
        "echo 'Hello' | $GNU_TOOL -c" \
        "echo 'Hello' | $F_TOOL -c"

    run_stdout_test "-x (hex shorts)" \
        "echo 'Hello' | $GNU_TOOL -x" \
        "echo 'Hello' | $F_TOOL -x"

    # === Section 9: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_od_tests
