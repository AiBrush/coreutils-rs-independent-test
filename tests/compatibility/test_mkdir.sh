#!/usr/bin/env bash
# Compatibility tests for fmkdir vs GNU mkdir
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="mkdir"
F_TOOL="fmkdir"

run_mkdir_tests() {
    init_test_suite "mkdir"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"mkdir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/mkdir_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU mkdir not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_mkdir_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic Directory Creation ==="

    run_test "create single directory" \
        "$GNU_TOOL '$WORK_DIR/gnu_dir1' && test -d '$WORK_DIR/gnu_dir1' && echo 'IS_DIR'" \
        "$F_TOOL '$WORK_DIR/f_dir1' && test -d '$WORK_DIR/f_dir1' && echo 'IS_DIR'"

    run_test "create multiple directories" \
        "$GNU_TOOL '$WORK_DIR/gnu_d1' '$WORK_DIR/gnu_d2' '$WORK_DIR/gnu_d3' && ls -d '$WORK_DIR'/gnu_d* | wc -l" \
        "$F_TOOL '$WORK_DIR/f_d1' '$WORK_DIR/f_d2' '$WORK_DIR/f_d3' && ls -d '$WORK_DIR'/f_d* | wc -l"

    echo ""
    echo "=== Parent Directories (-p) ==="

    run_test "-p create parent chain" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_deep/level2/level3' && test -d '$WORK_DIR/gnu_deep/level2/level3' && echo 'DEEP_OK'" \
        "$F_TOOL -p '$WORK_DIR/f_deep/level2/level3' && test -d '$WORK_DIR/f_deep/level2/level3' && echo 'DEEP_OK'"

    run_test "-p existing directory (no error)" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_dir1' && echo 'OK'" \
        "$F_TOOL -p '$WORK_DIR/f_dir1' && echo 'OK'"

    run_test "-p deeply nested" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_nest/a/b/c/d/e/f' && test -d '$WORK_DIR/gnu_nest/a/b/c/d/e/f' && echo 'NESTED_OK'" \
        "$F_TOOL -p '$WORK_DIR/f_nest/a/b/c/d/e/f' && test -d '$WORK_DIR/f_nest/a/b/c/d/e/f' && echo 'NESTED_OK'"

    echo ""
    echo "=== Mode (-m) ==="

    run_test "-m 755" \
        "$GNU_TOOL -m 755 '$WORK_DIR/gnu_m755' && stat -c '%a' '$WORK_DIR/gnu_m755'" \
        "$F_TOOL -m 755 '$WORK_DIR/f_m755' && stat -c '%a' '$WORK_DIR/f_m755'"

    run_test "-m 700" \
        "$GNU_TOOL -m 700 '$WORK_DIR/gnu_m700' && stat -c '%a' '$WORK_DIR/gnu_m700'" \
        "$F_TOOL -m 700 '$WORK_DIR/f_m700' && stat -c '%a' '$WORK_DIR/f_m700'"

    run_test "-m 777" \
        "$GNU_TOOL -m 777 '$WORK_DIR/gnu_m777' && stat -c '%a' '$WORK_DIR/gnu_m777'" \
        "$F_TOOL -m 777 '$WORK_DIR/f_m777' && stat -c '%a' '$WORK_DIR/f_m777'"

    run_test "-m 000" \
        "$GNU_TOOL -m 000 '$WORK_DIR/gnu_m000' && stat -c '%a' '$WORK_DIR/gnu_m000'" \
        "$F_TOOL -m 000 '$WORK_DIR/f_m000' && stat -c '%a' '$WORK_DIR/f_m000'"

    echo ""
    echo "=== Verbose (-v) ==="

    # Normalize directory names in verbose output to avoid false diff on gnu_/f_ prefix
    run_test "-v create directory" \
        "$GNU_TOOL -v '$WORK_DIR/gnu_verbose_dir' 2>&1 | sed 's|gnu_verbose_dir|_verbose_dir|g'" \
        "$F_TOOL -v '$WORK_DIR/f_verbose_dir' 2>&1 | sed 's|f_verbose_dir|_verbose_dir|g'"

    run_test "-pv create nested" \
        "$GNU_TOOL -pv '$WORK_DIR/gnu_vp/sub1/sub2' 2>&1 | sed 's|gnu_vp|_vp|g'" \
        "$F_TOOL -pv '$WORK_DIR/f_vp/sub1/sub2' 2>&1 | sed 's|f_vp|_vp|g'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "existing directory (no -p)" \
        "$GNU_TOOL '$WORK_DIR/gnu_dir1' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_dir1' 2>&1"

    run_exit_code_test "no parent without -p" \
        "$GNU_TOOL '$WORK_DIR/gnu_noparent/child' 2>&1" \
        "$F_TOOL '$WORK_DIR/f_noparent/child' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    echo ""
    echo "=== Edge Cases ==="

    run_test "directory name with spaces" \
        "$GNU_TOOL '$WORK_DIR/gnu dir with spaces' && test -d '$WORK_DIR/gnu dir with spaces' && echo 'SPACE_OK'" \
        "$F_TOOL '$WORK_DIR/f dir with spaces' && test -d '$WORK_DIR/f dir with spaces' && echo 'SPACE_OK'"

    run_test "-p with trailing slash" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_trailing/' && test -d '$WORK_DIR/gnu_trailing' && echo 'TRAIL_OK'" \
        "$F_TOOL -p '$WORK_DIR/f_trailing/' && test -d '$WORK_DIR/f_trailing' && echo 'TRAIL_OK'"

    run_test "-p with multiple slashes" \
        "$GNU_TOOL -p '$WORK_DIR/gnu_multi///slashes' && test -d '$WORK_DIR/gnu_multi/slashes' && echo 'MULTI_OK'" \
        "$F_TOOL -p '$WORK_DIR/f_multi///slashes' && test -d '$WORK_DIR/f_multi/slashes' && echo 'MULTI_OK'"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_mkdir_tests
