#!/usr/bin/env bash
# Compatibility tests for ftouch vs GNU touch
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="touch"
F_TOOL="ftouch"

run_touch_tests() {
    init_test_suite "touch"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"touch","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/touch_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU touch not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_touch_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic File Creation ==="

    run_test "create new file" \
        "$GNU_TOOL '$WORK_DIR/gnu_new.txt' && test -e '$WORK_DIR/gnu_new.txt' && echo 'EXISTS'" \
        "$F_TOOL '$WORK_DIR/f_new.txt' && test -e '$WORK_DIR/f_new.txt' && echo 'EXISTS'"

    run_test "create multiple files" \
        "$GNU_TOOL '$WORK_DIR/gnu_a.txt' '$WORK_DIR/gnu_b.txt' '$WORK_DIR/gnu_c.txt' && ls '$WORK_DIR'/gnu_*.txt | wc -l" \
        "$F_TOOL '$WORK_DIR/f_a.txt' '$WORK_DIR/f_b.txt' '$WORK_DIR/f_c.txt' && ls '$WORK_DIR'/f_*.txt | wc -l"

    run_test "touch existing file (no error)" \
        "echo 'data' > '$WORK_DIR/gnu_exist.txt' && $GNU_TOOL '$WORK_DIR/gnu_exist.txt' && echo 'OK'" \
        "echo 'data' > '$WORK_DIR/f_exist.txt' && $F_TOOL '$WORK_DIR/f_exist.txt' && echo 'OK'"

    run_test "existing file content unchanged" \
        "echo 'preserve me' > '$WORK_DIR/gnu_content.txt' && $GNU_TOOL '$WORK_DIR/gnu_content.txt' && cat '$WORK_DIR/gnu_content.txt'" \
        "echo 'preserve me' > '$WORK_DIR/f_content.txt' && $F_TOOL '$WORK_DIR/f_content.txt' && cat '$WORK_DIR/f_content.txt'"

    echo ""
    echo "=== No Create (-c) ==="

    run_test "-c nonexistent (no create)" \
        "$GNU_TOOL -c '$WORK_DIR/gnu_nocreate.txt'; test -e '$WORK_DIR/gnu_nocreate.txt' && echo 'EXISTS' || echo 'NOT_EXISTS'" \
        "$F_TOOL -c '$WORK_DIR/f_nocreate.txt'; test -e '$WORK_DIR/f_nocreate.txt' && echo 'EXISTS' || echo 'NOT_EXISTS'"

    run_test "-c existing file (updates time)" \
        "echo 'x' > '$WORK_DIR/gnu_c_exist.txt' && $GNU_TOOL -c '$WORK_DIR/gnu_c_exist.txt' && echo 'OK'" \
        "echo 'x' > '$WORK_DIR/f_c_exist.txt' && $F_TOOL -c '$WORK_DIR/f_c_exist.txt' && echo 'OK'"

    echo ""
    echo "=== Specific Timestamp (-t) ==="

    run_test "-t set specific time" \
        "$GNU_TOOL -t 202301011200.00 '$WORK_DIR/gnu_t1.txt' && stat -c '%Y' '$WORK_DIR/gnu_t1.txt'" \
        "$F_TOOL -t 202301011200.00 '$WORK_DIR/f_t1.txt' && stat -c '%Y' '$WORK_DIR/f_t1.txt'"

    run_test "-t set another time" \
        "$GNU_TOOL -t 199912312359.59 '$WORK_DIR/gnu_t2.txt' && stat -c '%Y' '$WORK_DIR/gnu_t2.txt'" \
        "$F_TOOL -t 199912312359.59 '$WORK_DIR/f_t2.txt' && stat -c '%Y' '$WORK_DIR/f_t2.txt'"

    run_test "-t epoch time" \
        "$GNU_TOOL -t 197001010000.00 '$WORK_DIR/gnu_epoch.txt' && stat -c '%Y' '$WORK_DIR/gnu_epoch.txt'" \
        "$F_TOOL -t 197001010000.00 '$WORK_DIR/f_epoch.txt' && stat -c '%Y' '$WORK_DIR/f_epoch.txt'"

    echo ""
    echo "=== Date String (-d) ==="

    run_test "-d ISO date" \
        "$GNU_TOOL -d '2023-06-15 10:30:00' '$WORK_DIR/gnu_d1.txt' && stat -c '%Y' '$WORK_DIR/gnu_d1.txt'" \
        "$F_TOOL -d '2023-06-15 10:30:00' '$WORK_DIR/f_d1.txt' && stat -c '%Y' '$WORK_DIR/f_d1.txt'"

    run_test "-d relative date (yesterday)" \
        "$GNU_TOOL -d 'yesterday' '$WORK_DIR/gnu_d2.txt' && stat -c '%Y' '$WORK_DIR/gnu_d2.txt'" \
        "$F_TOOL -d 'yesterday' '$WORK_DIR/f_d2.txt' && stat -c '%Y' '$WORK_DIR/f_d2.txt'"

    run_test "-d epoch" \
        "$GNU_TOOL -d '@0' '$WORK_DIR/gnu_d_epoch.txt' && stat -c '%Y' '$WORK_DIR/gnu_d_epoch.txt'" \
        "$F_TOOL -d '@0' '$WORK_DIR/f_d_epoch.txt' && stat -c '%Y' '$WORK_DIR/f_d_epoch.txt'"

    run_test "-d epoch with value" \
        "$GNU_TOOL -d '@1000000' '$WORK_DIR/gnu_d_epoch2.txt' && stat -c '%Y' '$WORK_DIR/gnu_d_epoch2.txt'" \
        "$F_TOOL -d '@1000000' '$WORK_DIR/f_d_epoch2.txt' && stat -c '%Y' '$WORK_DIR/f_d_epoch2.txt'"

    echo ""
    echo "=== Access Time Only (-a) ==="

    run_test "-a only access time" \
        "echo 'x' > '$WORK_DIR/gnu_a.txt' && sleep 0.1 && $GNU_TOOL -a '$WORK_DIR/gnu_a.txt' && stat -c '%X' '$WORK_DIR/gnu_a.txt'" \
        "echo 'x' > '$WORK_DIR/f_a.txt' && sleep 0.1 && $F_TOOL -a '$WORK_DIR/f_a.txt' && stat -c '%X' '$WORK_DIR/f_a.txt'"

    echo ""
    echo "=== Modification Time Only (-m) ==="

    run_test "-m only modification time" \
        "$GNU_TOOL -m -t 202306150000.00 '$WORK_DIR/gnu_m.txt' && stat -c '%Y' '$WORK_DIR/gnu_m.txt'" \
        "$F_TOOL -m -t 202306150000.00 '$WORK_DIR/f_m.txt' && stat -c '%Y' '$WORK_DIR/f_m.txt'"

    echo ""
    echo "=== Reference File (-r) ==="

    $GNU_TOOL -t 202001010000.00 "$WORK_DIR/ref_file.txt"

    run_test "-r reference file" \
        "$GNU_TOOL -r '$WORK_DIR/ref_file.txt' '$WORK_DIR/gnu_ref.txt' && stat -c '%Y' '$WORK_DIR/gnu_ref.txt'" \
        "$F_TOOL -r '$WORK_DIR/ref_file.txt' '$WORK_DIR/f_ref.txt' && stat -c '%Y' '$WORK_DIR/f_ref.txt'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent directory" \
        "$GNU_TOOL '/nonexistent_dir_$$/file.txt' 2>&1" \
        "$F_TOOL '/nonexistent_dir_$$/file.txt' 2>&1"

    run_exit_code_test "invalid timestamp" \
        "$GNU_TOOL -t 'notadate' '$WORK_DIR/gnu_invalid.txt' 2>&1" \
        "$F_TOOL -t 'notadate' '$WORK_DIR/f_invalid.txt' 2>&1"

    run_exit_code_test "nonexistent reference file" \
        "$GNU_TOOL -r '/tmp/nonexistent_$$' '$WORK_DIR/gnu_badref.txt' 2>&1" \
        "$F_TOOL -r '/tmp/nonexistent_$$' '$WORK_DIR/f_badref.txt' 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "file with spaces in name" \
        "$GNU_TOOL '$WORK_DIR/gnu file with spaces.txt' && test -e '$WORK_DIR/gnu file with spaces.txt' && echo 'EXISTS'" \
        "$F_TOOL '$WORK_DIR/f file with spaces.txt' && test -e '$WORK_DIR/f file with spaces.txt' && echo 'EXISTS'"

    run_test "touch empty file preserves zero size" \
        "> '$WORK_DIR/gnu_zero.txt' && $GNU_TOOL '$WORK_DIR/gnu_zero.txt' && stat -c '%s' '$WORK_DIR/gnu_zero.txt'" \
        "> '$WORK_DIR/f_zero.txt' && $F_TOOL '$WORK_DIR/f_zero.txt' && stat -c '%s' '$WORK_DIR/f_zero.txt'"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_touch_tests
