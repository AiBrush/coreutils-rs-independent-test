#!/usr/bin/env bash
# Compatibility tests for ftruncate vs GNU truncate
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="truncate"
F_TOOL="ftruncate"

run_truncate_tests() {
    init_test_suite "truncate"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"truncate","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/truncate_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU truncate not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_truncate_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Set Exact Size (-s N) ==="

    run_test "truncate to 0 bytes" \
        "echo 'hello world' > '$WORK_DIR/gnu_zero.txt' && $GNU_TOOL -s 0 '$WORK_DIR/gnu_zero.txt' && stat -c '%s' '$WORK_DIR/gnu_zero.txt'" \
        "echo 'hello world' > '$WORK_DIR/f_zero.txt' && $F_TOOL -s 0 '$WORK_DIR/f_zero.txt' && stat -c '%s' '$WORK_DIR/f_zero.txt'"

    run_test "truncate to 100 bytes (extend)" \
        "echo 'short' > '$WORK_DIR/gnu_extend.txt' && $GNU_TOOL -s 100 '$WORK_DIR/gnu_extend.txt' && stat -c '%s' '$WORK_DIR/gnu_extend.txt'" \
        "echo 'short' > '$WORK_DIR/f_extend.txt' && $F_TOOL -s 100 '$WORK_DIR/f_extend.txt' && stat -c '%s' '$WORK_DIR/f_extend.txt'"

    run_test "truncate to exact current size (no change)" \
        "printf 'hello' > '$WORK_DIR/gnu_same.txt' && $GNU_TOOL -s 5 '$WORK_DIR/gnu_same.txt' && stat -c '%s' '$WORK_DIR/gnu_same.txt' && cat '$WORK_DIR/gnu_same.txt'" \
        "printf 'hello' > '$WORK_DIR/f_same.txt' && $F_TOOL -s 5 '$WORK_DIR/f_same.txt' && stat -c '%s' '$WORK_DIR/f_same.txt' && cat '$WORK_DIR/f_same.txt'"

    run_test "truncate to 3 bytes (shrink)" \
        "printf 'hello world' > '$WORK_DIR/gnu_shrink.txt' && $GNU_TOOL -s 3 '$WORK_DIR/gnu_shrink.txt' && stat -c '%s' '$WORK_DIR/gnu_shrink.txt' && cat '$WORK_DIR/gnu_shrink.txt'" \
        "printf 'hello world' > '$WORK_DIR/f_shrink.txt' && $F_TOOL -s 3 '$WORK_DIR/f_shrink.txt' && stat -c '%s' '$WORK_DIR/f_shrink.txt' && cat '$WORK_DIR/f_shrink.txt'"

    run_test "create new file with specified size" \
        "$GNU_TOOL -s 50 '$WORK_DIR/gnu_new.txt' && stat -c '%s' '$WORK_DIR/gnu_new.txt'" \
        "$F_TOOL -s 50 '$WORK_DIR/f_new.txt' && stat -c '%s' '$WORK_DIR/f_new.txt'"

    echo ""
    echo "=== Size Suffixes ==="

    run_test "truncate -s 1K" \
        "$GNU_TOOL -s 1K '$WORK_DIR/gnu_1k.txt' && stat -c '%s' '$WORK_DIR/gnu_1k.txt'" \
        "$F_TOOL -s 1K '$WORK_DIR/f_1k.txt' && stat -c '%s' '$WORK_DIR/f_1k.txt'"

    run_test "truncate -s 1M" \
        "$GNU_TOOL -s 1M '$WORK_DIR/gnu_1m.txt' && stat -c '%s' '$WORK_DIR/gnu_1m.txt'" \
        "$F_TOOL -s 1M '$WORK_DIR/f_1m.txt' && stat -c '%s' '$WORK_DIR/f_1m.txt'"

    run_test "truncate -s 1KB" \
        "$GNU_TOOL -s 1KB '$WORK_DIR/gnu_1kb.txt' && stat -c '%s' '$WORK_DIR/gnu_1kb.txt'" \
        "$F_TOOL -s 1KB '$WORK_DIR/f_1kb.txt' && stat -c '%s' '$WORK_DIR/f_1kb.txt'"

    echo ""
    echo "=== Relative Size Modes ==="

    run_test "extend by +50 bytes" \
        "printf 'hello' > '$WORK_DIR/gnu_plus.txt' && $GNU_TOOL -s +50 '$WORK_DIR/gnu_plus.txt' && stat -c '%s' '$WORK_DIR/gnu_plus.txt'" \
        "printf 'hello' > '$WORK_DIR/f_plus.txt' && $F_TOOL -s +50 '$WORK_DIR/f_plus.txt' && stat -c '%s' '$WORK_DIR/f_plus.txt'"

    run_test "shrink by -3 bytes" \
        "printf 'hello world' > '$WORK_DIR/gnu_minus.txt' && $GNU_TOOL -s -3 '$WORK_DIR/gnu_minus.txt' && stat -c '%s' '$WORK_DIR/gnu_minus.txt'" \
        "printf 'hello world' > '$WORK_DIR/f_minus.txt' && $F_TOOL -s -3 '$WORK_DIR/f_minus.txt' && stat -c '%s' '$WORK_DIR/f_minus.txt'"

    run_test "shrink below 0 (clamp to 0)" \
        "printf 'hi' > '$WORK_DIR/gnu_underflow.txt' && $GNU_TOOL -s -100 '$WORK_DIR/gnu_underflow.txt' && stat -c '%s' '$WORK_DIR/gnu_underflow.txt'" \
        "printf 'hi' > '$WORK_DIR/f_underflow.txt' && $F_TOOL -s -100 '$WORK_DIR/f_underflow.txt' && stat -c '%s' '$WORK_DIR/f_underflow.txt'"

    echo ""
    echo "=== Round Down (/) and Round Up (%) ==="

    run_test "round down to multiple of 10" \
        "printf 'AAAAAAAAAAAAAAA' > '$WORK_DIR/gnu_rdown.txt' && $GNU_TOOL -s /10 '$WORK_DIR/gnu_rdown.txt' && stat -c '%s' '$WORK_DIR/gnu_rdown.txt'" \
        "printf 'AAAAAAAAAAAAAAA' > '$WORK_DIR/f_rdown.txt' && $F_TOOL -s /10 '$WORK_DIR/f_rdown.txt' && stat -c '%s' '$WORK_DIR/f_rdown.txt'"

    run_test "round up to multiple of 10" \
        "printf 'AAAAAAAAAAAAAAA' > '$WORK_DIR/gnu_rup.txt' && $GNU_TOOL -s '%10' '$WORK_DIR/gnu_rup.txt' && stat -c '%s' '$WORK_DIR/gnu_rup.txt'" \
        "printf 'AAAAAAAAAAAAAAA' > '$WORK_DIR/f_rup.txt' && $F_TOOL -s '%10' '$WORK_DIR/f_rup.txt' && stat -c '%s' '$WORK_DIR/f_rup.txt'"

    echo ""
    echo "=== At Most (<) and At Least (>) ==="

    run_test "at most 3 (shrink if larger)" \
        "printf 'hello world' > '$WORK_DIR/gnu_atmost.txt' && $GNU_TOOL -s '<3' '$WORK_DIR/gnu_atmost.txt' && stat -c '%s' '$WORK_DIR/gnu_atmost.txt'" \
        "printf 'hello world' > '$WORK_DIR/f_atmost.txt' && $F_TOOL -s '<3' '$WORK_DIR/f_atmost.txt' && stat -c '%s' '$WORK_DIR/f_atmost.txt'"

    run_test "at least 100 (extend if smaller)" \
        "printf 'hi' > '$WORK_DIR/gnu_atleast.txt' && $GNU_TOOL -s '>100' '$WORK_DIR/gnu_atleast.txt' && stat -c '%s' '$WORK_DIR/gnu_atleast.txt'" \
        "printf 'hi' > '$WORK_DIR/f_atleast.txt' && $F_TOOL -s '>100' '$WORK_DIR/f_atleast.txt' && stat -c '%s' '$WORK_DIR/f_atleast.txt'"

    run_test "at most when already smaller (no change)" \
        "printf 'hi' > '$WORK_DIR/gnu_noop.txt' && $GNU_TOOL -s '<100' '$WORK_DIR/gnu_noop.txt' && stat -c '%s' '$WORK_DIR/gnu_noop.txt'" \
        "printf 'hi' > '$WORK_DIR/f_noop.txt' && $F_TOOL -s '<100' '$WORK_DIR/f_noop.txt' && stat -c '%s' '$WORK_DIR/f_noop.txt'"

    echo ""
    echo "=== Reference File (-r) ==="

    printf 'reference content here' > "$WORK_DIR/ref_file.txt"

    run_test "reference file size" \
        "$GNU_TOOL -r '$WORK_DIR/ref_file.txt' '$WORK_DIR/gnu_ref.txt' && stat -c '%s' '$WORK_DIR/gnu_ref.txt'" \
        "$F_TOOL -r '$WORK_DIR/ref_file.txt' '$WORK_DIR/f_ref.txt' && stat -c '%s' '$WORK_DIR/f_ref.txt'"

    run_test "reference + extend" \
        "$GNU_TOOL -r '$WORK_DIR/ref_file.txt' -s +10 '$WORK_DIR/gnu_refext.txt' && stat -c '%s' '$WORK_DIR/gnu_refext.txt'" \
        "$F_TOOL -r '$WORK_DIR/ref_file.txt' -s +10 '$WORK_DIR/f_refext.txt' && stat -c '%s' '$WORK_DIR/f_refext.txt'"

    echo ""
    echo "=== Multiple Files ==="

    run_test "truncate multiple files" \
        "$GNU_TOOL -s 42 '$WORK_DIR/gnu_multi1.txt' '$WORK_DIR/gnu_multi2.txt' && stat -c '%s' '$WORK_DIR/gnu_multi1.txt' '$WORK_DIR/gnu_multi2.txt'" \
        "$F_TOOL -s 42 '$WORK_DIR/f_multi1.txt' '$WORK_DIR/f_multi2.txt' && stat -c '%s' '$WORK_DIR/f_multi1.txt' '$WORK_DIR/f_multi2.txt'"

    echo ""
    echo "=== No Create (-c) ==="

    run_test "-c nonexistent file (no create)" \
        "$GNU_TOOL -c -s 10 '$WORK_DIR/gnu_nc.txt'; test -e '$WORK_DIR/gnu_nc.txt' && echo 'EXISTS' || echo 'NOT_EXISTS'" \
        "$F_TOOL -c -s 10 '$WORK_DIR/f_nc.txt'; test -e '$WORK_DIR/f_nc.txt' && echo 'EXISTS' || echo 'NOT_EXISTS'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    run_exit_code_test "missing size" \
        "$GNU_TOOL '$WORK_DIR/gnu_nosize.txt' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_nosize.txt' 2>&1"

    run_exit_code_test "invalid size" \
        "$GNU_TOOL -s 'abc' '$WORK_DIR/gnu_invalid.txt' 2>&1" \
        "$F_TOOL -s 'abc' '$WORK_DIR/f_invalid.txt' 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "truncate to 0 then extend" \
        "printf 'data' > '$WORK_DIR/gnu_0ext.txt' && $GNU_TOOL -s 0 '$WORK_DIR/gnu_0ext.txt' && $GNU_TOOL -s 10 '$WORK_DIR/gnu_0ext.txt' && stat -c '%s' '$WORK_DIR/gnu_0ext.txt'" \
        "printf 'data' > '$WORK_DIR/f_0ext.txt' && $F_TOOL -s 0 '$WORK_DIR/f_0ext.txt' && $F_TOOL -s 10 '$WORK_DIR/f_0ext.txt' && stat -c '%s' '$WORK_DIR/f_0ext.txt'"

    run_test "extended region contains null bytes" \
        "printf 'AB' > '$WORK_DIR/gnu_nullext.txt' && $GNU_TOOL -s 10 '$WORK_DIR/gnu_nullext.txt' && od -A x -t x1z '$WORK_DIR/gnu_nullext.txt'" \
        "printf 'AB' > '$WORK_DIR/f_nullext.txt' && $F_TOOL -s 10 '$WORK_DIR/f_nullext.txt' && od -A x -t x1z '$WORK_DIR/f_nullext.txt'"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_truncate_tests
