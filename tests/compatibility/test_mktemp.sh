#!/usr/bin/env bash
# Compatibility tests for fmktemp vs GNU mktemp
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mktemp"
F_TOOL="fmktemp"

run_mktemp_tests() {
    init_test_suite "mktemp"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mktemp","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mktemp_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU mktemp not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_mktemp_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic Temp File Creation ==="

    # We can't compare exact output (random names), so compare behavior
    run_test "creates file that exists" \
        "f=\$($GNU_TOOL) && test -f \"\$f\" && echo 'FILE_EXISTS' && rm -f \"\$f\"" \
        "f=\$($F_TOOL) && test -f \"\$f\" && echo 'FILE_EXISTS' && rm -f \"\$f\""

    run_test "exit code 0 on success" \
        "$GNU_TOOL >/dev/null && echo 'EXIT_OK'" \
        "$F_TOOL >/dev/null && echo 'EXIT_OK'"

    run_test "outputs path to stdout" \
        "f=\$($GNU_TOOL) && test -n \"\$f\" && echo 'HAS_PATH' && rm -f \"\$f\"" \
        "f=\$($F_TOOL) && test -n \"\$f\" && echo 'HAS_PATH' && rm -f \"\$f\""

    echo ""
    echo "=== Directory Creation (-d) ==="

    run_test "-d creates directory" \
        "d=\$($GNU_TOOL -d) && test -d \"\$d\" && echo 'IS_DIR' && rmdir \"\$d\"" \
        "d=\$($F_TOOL -d) && test -d \"\$d\" && echo 'IS_DIR' && rmdir \"\$d\""

    echo ""
    echo "=== Custom Template ==="

    run_test "template with XXXXXX" \
        "f=\$($GNU_TOOL '$WORK_DIR/gnu_XXXXXX') && test -f \"\$f\" && basename \"\$f\" | grep -c '^gnu_' && rm -f \"\$f\"" \
        "f=\$($F_TOOL '$WORK_DIR/f_XXXXXX') && test -f \"\$f\" && basename \"\$f\" | grep -c '^f_' && rm -f \"\$f\""

    run_test "template with suffix" \
        "f=\$($GNU_TOOL '$WORK_DIR/gnu_XXXXXX' --suffix=.tmp) && test -f \"\$f\" && echo \"\$f\" | grep -c '\.tmp$' && rm -f \"\$f\"" \
        "f=\$($F_TOOL '$WORK_DIR/f_XXXXXX' --suffix=.tmp) && test -f \"\$f\" && echo \"\$f\" | grep -c '\.tmp$' && rm -f \"\$f\""

    echo ""
    echo "=== Custom Directory (-p / --tmpdir) ==="

    run_test "-p custom directory" \
        "f=\$($GNU_TOOL -p '$WORK_DIR') && dirname \"\$f\" | grep -c '$WORK_DIR' && rm -f \"\$f\"" \
        "f=\$($F_TOOL -p '$WORK_DIR') && dirname \"\$f\" | grep -c '$WORK_DIR' && rm -f \"\$f\""

    run_test "--tmpdir custom directory" \
        "f=\$($GNU_TOOL --tmpdir='$WORK_DIR' tmp.XXXXXX) && dirname \"\$f\" | grep -c '$WORK_DIR' && rm -f \"\$f\"" \
        "f=\$($F_TOOL --tmpdir='$WORK_DIR' tmp.XXXXXX) && dirname \"\$f\" | grep -c '$WORK_DIR' && rm -f \"\$f\""

    echo ""
    echo "=== Dry Run (-u) ==="

    run_test "-u returns path but doesn't create" \
        "f=\$($GNU_TOOL -u) && test ! -e \"\$f\" && echo 'NOT_CREATED'" \
        "f=\$($F_TOOL -u) && test ! -e \"\$f\" && echo 'NOT_CREATED'"

    echo ""
    echo "=== Quiet (-q) ==="

    run_exit_code_test "-q suppresses errors" \
        "$GNU_TOOL -q -p /nonexistent_dir_$$ 2>&1; echo \$?" \
        "$F_TOOL -q -p /nonexistent_dir_$$ 2>&1; echo \$?"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "too few X in template" \
        "$GNU_TOOL '$WORK_DIR/bad_XX' 2>&1" \
        "$F_TOOL '$WORK_DIR/bad_XX' 2>&1"

    run_exit_code_test "nonexistent parent directory" \
        "$GNU_TOOL -p '/nonexistent_$$' 2>&1" \
        "$F_TOOL -p '/nonexistent_$$' 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "multiple files unique" \
        "f1=\$($GNU_TOOL) && f2=\$($GNU_TOOL) && test \"\$f1\" != \"\$f2\" && echo 'UNIQUE' && rm -f \"\$f1\" \"\$f2\"" \
        "f1=\$($F_TOOL) && f2=\$($F_TOOL) && test \"\$f1\" != \"\$f2\" && echo 'UNIQUE' && rm -f \"\$f1\" \"\$f2\""

    run_test "file permissions are 600" \
        "f=\$($GNU_TOOL) && stat -c '%a' \"\$f\" && rm -f \"\$f\"" \
        "f=\$($F_TOOL) && stat -c '%a' \"\$f\" && rm -f \"\$f\""

    run_test "directory permissions are 700" \
        "d=\$($GNU_TOOL -d) && stat -c '%a' \"\$d\" && rmdir \"\$d\"" \
        "d=\$($F_TOOL -d) && stat -c '%a' \"\$d\" && rmdir \"\$d\""

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_mktemp_tests
