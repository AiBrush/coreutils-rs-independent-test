#!/usr/bin/env bash
# Compatibility tests for ftruncate vs GNU truncate
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "truncate")
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

    # === GNU Upstream: Parameter Validation ===
    echo ""
    echo "=== GNU Upstream: Parameter Validation ==="

    # From truncate-parameters.sh: must specify at least 1 file
    run_exit_code_test "GNU: size without file fails" \
        "$GNU_TOOL --size=0 2>&1" \
        "$F_TOOL --size=0 2>&1"

    # From truncate-parameters.sh: must specify size, don't default to 0
    run_exit_code_test "GNU: file without size fails" \
        "$GNU_TOOL '$WORK_DIR/gnu_param_f' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_param_f' 2>&1"

    # From truncate-parameters.sh: mixture of absolute size & reference not allowed
    run_exit_code_test "GNU: --size and --reference conflict" \
        "$GNU_TOOL --size=0 --reference='$WORK_DIR/gnu_param_f' '$WORK_DIR/gnu_param_f' 2>&1" \
        "$F_TOOL --size=0 --reference='$WORK_DIR/f_param_f' '$WORK_DIR/f_param_f' 2>&1"

    # From truncate-parameters.sh: must specify valid numbers
    run_exit_code_test "GNU: invalid size string" \
        "$GNU_TOOL --size='invalid' '$WORK_DIR/gnu_inv.txt' 2>&1" \
        "$F_TOOL --size='invalid' '$WORK_DIR/f_inv.txt' 2>&1"

    # From truncate-parameters.sh: spaces around size value
    run_test "GNU: space before relative size ' +1'" \
        "$GNU_TOOL --size=' >1' '$WORK_DIR/gnu_sp1.txt' && $GNU_TOOL --size=' +1' '$WORK_DIR/gnu_sp1.txt' && stat -c '%s' '$WORK_DIR/gnu_sp1.txt'" \
        "$F_TOOL --size=' >1' '$WORK_DIR/f_sp1.txt' && $F_TOOL --size=' +1' '$WORK_DIR/f_sp1.txt' && stat -c '%s' '$WORK_DIR/f_sp1.txt'"

    # From truncate-parameters.sh: reference allowed with relative size
    run_test "GNU: reference with relative size +1" \
        "$GNU_TOOL --size=3 '$WORK_DIR/gnu_refrel.txt' && $GNU_TOOL --size='+1' -r '$WORK_DIR/gnu_refrel.txt' '$WORK_DIR/gnu_refrel.txt' && stat -c '%s' '$WORK_DIR/gnu_refrel.txt'" \
        "$F_TOOL --size=3 '$WORK_DIR/f_refrel.txt' && $F_TOOL --size='+1' -r '$WORK_DIR/f_refrel.txt' '$WORK_DIR/f_refrel.txt' && stat -c '%s' '$WORK_DIR/f_refrel.txt'"

    # From truncate-parameters.sh: reference alone
    run_test "GNU: reference file alone copies size" \
        "$GNU_TOOL --size=3 '$WORK_DIR/gnu_refonly.txt' && $GNU_TOOL -r '$WORK_DIR/gnu_refonly.txt' '$WORK_DIR/gnu_refonly2.txt' && stat -c '%s' '$WORK_DIR/gnu_refonly2.txt'" \
        "$F_TOOL --size=3 '$WORK_DIR/f_refonly.txt' && $F_TOOL -r '$WORK_DIR/f_refonly.txt' '$WORK_DIR/f_refonly2.txt' && stat -c '%s' '$WORK_DIR/f_refonly2.txt'"

    # From truncate-parameters.sh: -s -1 (separated argument not parsed as option)
    run_test "GNU: separated negative size -s -1" \
        "$GNU_TOOL --size=3 '$WORK_DIR/gnu_sep.txt' && $GNU_TOOL -s -1 '$WORK_DIR/gnu_sep.txt' && stat -c '%s' '$WORK_DIR/gnu_sep.txt'" \
        "$F_TOOL --size=3 '$WORK_DIR/f_sep.txt' && $F_TOOL -s -1 '$WORK_DIR/f_sep.txt' && stat -c '%s' '$WORK_DIR/f_sep.txt'"

    # === GNU Upstream: Relative Size Validation ===
    echo ""
    echo "=== GNU Upstream: Relative Size Validation ==="

    # From truncate-relative.sh: mixture of relative modifiers not allowed
    run_exit_code_test "GNU: reject '+>0' mixed modifiers" \
        "$GNU_TOOL --size='+>0' '$WORK_DIR/gnu_relmod.txt' 2>&1" \
        "$F_TOOL --size='+>0' '$WORK_DIR/f_relmod.txt' 2>&1"

    run_exit_code_test "GNU: reject '>+0' mixed modifiers" \
        "$GNU_TOOL --size='>+0' '$WORK_DIR/gnu_relmod2.txt' 2>&1" \
        "$F_TOOL --size='>+0' '$WORK_DIR/f_relmod2.txt' 2>&1"

    # From truncate-relative.sh: division by zero
    run_exit_code_test "GNU: reject '/0' division by zero" \
        "$GNU_TOOL --size='/0' '$WORK_DIR/gnu_divz.txt' 2>&1" \
        "$F_TOOL --size='/0' '$WORK_DIR/f_divz.txt' 2>&1"

    run_exit_code_test "GNU: reject '%%0' modulo by zero" \
        "$GNU_TOOL --size='%0' '$WORK_DIR/gnu_modz.txt' 2>&1" \
        "$F_TOOL --size='%0' '$WORK_DIR/f_modz.txt' 2>&1"

    # === GNU Upstream: Directory Fail ===
    echo ""
    echo "=== GNU Upstream: Directory Fail ==="

    # From truncate-dir-fail.sh: truncate on directory not allowed
    run_exit_code_test "GNU: truncate on directory fails" \
        "$GNU_TOOL -s+0 . 2>&1" \
        "$F_TOOL -s+0 . 2>&1"

    # === GNU Upstream: No Create Missing ===
    echo ""
    echo "=== GNU Upstream: No Create Missing ==="

    # From truncate-no-create-missing.sh: truncate -c no-such-file should not fail
    run_exit_code_test "GNU: -c on missing file succeeds" \
        "$GNU_TOOL -s0 -c '$WORK_DIR/gnu_no_create_$$' 2>&1" \
        "$F_TOOL -s0 -c '$WORK_DIR/f_no_create_$$' 2>&1"

    run_test "GNU: -c does not create file" \
        "$GNU_TOOL -s0 -c '$WORK_DIR/gnu_nc_check_$$' 2>&1; test -e '$WORK_DIR/gnu_nc_check_$$' && echo EXISTS || echo NOT_EXISTS" \
        "$F_TOOL -s0 -c '$WORK_DIR/f_nc_check_$$' 2>&1; test -e '$WORK_DIR/f_nc_check_$$' && echo EXISTS || echo NOT_EXISTS"

    # === GNU Upstream: Dangling Symlink ===
    echo ""
    echo "=== GNU Upstream: Dangling Symlink ==="

    # From truncate-dangling-symlink.sh: truncate through dangling symlink creates target
    ln -s "$WORK_DIR/gnu_dangle_target" "$WORK_DIR/gnu_dangle_link"
    ln -s "$WORK_DIR/f_dangle_target" "$WORK_DIR/f_dangle_link"

    run_test "GNU: truncate through dangling symlink" \
        "$GNU_TOOL -s0 '$WORK_DIR/gnu_dangle_link' && test -f '$WORK_DIR/gnu_dangle_target' && echo OK" \
        "$F_TOOL -s0 '$WORK_DIR/f_dangle_link' && test -f '$WORK_DIR/f_dangle_target' && echo OK"

    # === GNU Upstream: Fail Diagnostics ===
    echo ""
    echo "=== GNU Upstream: Fail Diagnostics ==="

    # From truncate-fail-diag.sh: truncate into non-existent directory
    run_exit_code_test "GNU: truncate in nonexistent dir fails" \
        "$GNU_TOOL -s0 'no_such_dir_$$/file' 2>&1" \
        "$F_TOOL -s0 'no_such_dir_$$/file' 2>&1"

    # From truncate-fail-diag.sh: truncate on path with trailing slash (not a directory)
    run_exit_code_test "GNU: truncate on 'no/' (trailing slash) fails" \
        "$GNU_TOOL -s0 '$WORK_DIR/gnu_failslash/' 2>&1" \
        "$F_TOOL -s0 '$WORK_DIR/f_failslash/' 2>&1"

    # === GNU Upstream: Parameter Validation Extended ===
    echo ""
    echo "=== GNU Upstream: Parameter Validation Extended ==="

    # From truncate-parameters.sh: --io-blocks without --size is invalid
    run_exit_code_test "GNU: --io-blocks without --size fails" \
        "echo x > '$WORK_DIR/gnu_iobl.txt' && $GNU_TOOL --io-blocks --reference='$WORK_DIR/gnu_iobl.txt' '$WORK_DIR/gnu_iobl.txt' 2>&1" \
        "echo x > '$WORK_DIR/f_iobl.txt' && $F_TOOL --io-blocks --reference='$WORK_DIR/f_iobl.txt' '$WORK_DIR/f_iobl.txt' 2>&1"

    # From truncate-parameters.sh: spaces with invalid relative size "> -1"
    run_exit_code_test "GNU: reject '> -1' invalid relative size" \
        "$GNU_TOOL --size='> -1' '$WORK_DIR/gnu_negrel.txt' 2>&1" \
        "$F_TOOL --size='> -1' '$WORK_DIR/f_negrel.txt' 2>&1"

    # === GNU Upstream: Shrink Below Zero via Negative Relative ===
    echo ""
    echo "=== GNU Upstream: Shrink Below Zero ==="

    # From truncate-overflow.sh (portable subset): -=1 on empty file clamps to 0
    run_test "GNU: -s-1 on new file clamps to 0" \
        "$GNU_TOOL -s-1 '$WORK_DIR/gnu_clamp0.txt' && stat -c '%s' '$WORK_DIR/gnu_clamp0.txt'" \
        "$F_TOOL -s-1 '$WORK_DIR/f_clamp0.txt' && stat -c '%s' '$WORK_DIR/f_clamp0.txt'"

    # truncate-fifo.sh: SKIP (requires mkfifo)
    skip_test "GNU: truncate on FIFO" "Requires mkfifo"

    # truncate-overflow.sh: SKIP (requires getlimits for OFF_T_OFLOW/OFF_T_MAX)
    skip_test "GNU: truncate integer overflow" "Requires getlimits"

    # truncate-owned-by-other.sh: SKIP (requires root access)
    skip_test "GNU: truncate on file owned by other" "Requires root access"

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
