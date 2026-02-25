#!/usr/bin/env bash
# Compatibility tests for fnproc vs GNU nproc
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "nproc")
F_TOOL="fnproc"

run_nproc_tests() {
    init_test_suite "nproc"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"nproc","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/nproc_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU nproc not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    run_test "default processor count" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "output is positive integer" \
        "$GNU_TOOL | grep -cE '^[1-9][0-9]*$'" \
        "$F_TOOL | grep -cE '^[1-9][0-9]*$'"

    run_test "exit code 0" \
        "$GNU_TOOL > /dev/null && echo 'EXIT_OK'" \
        "$F_TOOL > /dev/null && echo 'EXIT_OK'"

    echo ""
    echo "=== All Processors (--all) ==="

    run_test "--all processors" \
        "$GNU_TOOL --all" \
        "$F_TOOL --all"

    echo ""
    echo "=== Ignore (--ignore) ==="

    run_test "--ignore=0" \
        "$GNU_TOOL --ignore=0" \
        "$F_TOOL --ignore=0"

    run_test "--ignore=1" \
        "$GNU_TOOL --ignore=1" \
        "$F_TOOL --ignore=1"

    # Ignore more than available (should return 1)
    run_test "--ignore=9999 (clamp to 1)" \
        "$GNU_TOOL --ignore=9999" \
        "$F_TOOL --ignore=9999"

    echo ""
    echo "=== GNU Upstream: nproc-avail (Available <= All) ==="

    # From nproc-avail.sh: ensure nproc <= nproc --all
    run_test "available le all" \
        "test \$(OMP_NUM_THREADS= $GNU_TOOL) -le \$($GNU_TOOL --all) && echo OK" \
        "test \$(OMP_NUM_THREADS= $F_TOOL) -le \$($F_TOOL --all) && echo OK"

    echo ""
    echo "=== GNU Upstream: nproc-positive (Always Positive) ==="

    # From nproc-positive.sh: ensure nproc always returns a positive number
    run_test "default is positive" \
        "test \$($GNU_TOOL) -gt 0 && echo OK" \
        "test \$($F_TOOL) -gt 0 && echo OK"

    run_test "--all is positive" \
        "test \$($GNU_TOOL --all) -gt 0 && echo OK" \
        "test \$($F_TOOL --all) -gt 0 && echo OK"

    # From nproc-positive.sh: OMP_NUM_THREADS edge cases always return positive
    run_test "OMP_NUM_THREADS=0 still positive" \
        "test \$(OMP_NUM_THREADS=0 $GNU_TOOL) -gt 0 && echo OK" \
        "test \$(OMP_NUM_THREADS=0 $F_TOOL) -gt 0 && echo OK"

    run_test "OMP_NUM_THREADS=1 still positive" \
        "test \$(OMP_NUM_THREADS=1 $GNU_TOOL) -gt 0 && echo OK" \
        "test \$(OMP_NUM_THREADS=1 $F_TOOL) -gt 0 && echo OK"

    # From nproc-positive.sh: --ignore with valid/invalid values
    run_test "--ignore=0 is positive" \
        "test \$($GNU_TOOL --ignore=0) -gt 0 && echo OK" \
        "test \$($F_TOOL --ignore=0) -gt 0 && echo OK"

    run_test "--ignore=1000 is positive" \
        "test \$($GNU_TOOL --ignore=1000) -gt 0 && echo OK" \
        "test \$($F_TOOL --ignore=1000) -gt 0 && echo OK"

    run_exit_code_test "--ignore=-1 is error" \
        "$GNU_TOOL --ignore=-1 2>&1" \
        "$F_TOOL --ignore=-1 2>&1"

    run_exit_code_test "--ignore=N is error" \
        "$GNU_TOOL --ignore=N 2>&1" \
        "$F_TOOL --ignore=N 2>&1"

    # From nproc-positive.sh: OMP_NUM_THREADS with --ignore
    run_test "OMP_NUM_THREADS=42 --ignore=40 equals 2" \
        "OMP_NUM_THREADS=42 $GNU_TOOL --ignore=40" \
        "OMP_NUM_THREADS=42 $F_TOOL --ignore=40"

    echo ""
    echo "=== GNU Upstream: nproc-override (OMP Environment) ==="

    # From nproc-override.sh: test OMP_NUM_THREADS override behavior
    run_test "OMP_NUM_THREADS=2 override" \
        "OMP_NUM_THREADS=2 $GNU_TOOL" \
        "OMP_NUM_THREADS=2 $F_TOOL"

    run_test "OMP_NUM_THREADS=2,2,1 nested" \
        "OMP_NUM_THREADS=2,2,1 $GNU_TOOL" \
        "OMP_NUM_THREADS=2,2,1 $F_TOOL"

    run_test "OMP_NUM_THREADS=2,ignored" \
        "OMP_NUM_THREADS=2,ignored $GNU_TOOL" \
        "OMP_NUM_THREADS=2,ignored $F_TOOL"

    run_test "OMP_THREAD_LIMIT=1 with OMP_NUM_THREADS=2" \
        "OMP_THREAD_LIMIT=1 OMP_NUM_THREADS=2,2,1 $GNU_TOOL" \
        "OMP_THREAD_LIMIT=1 OMP_NUM_THREADS=2,2,1 $F_TOOL"

    run_test "OMP_THREAD_LIMIT=0 is ignored" \
        "OMP_THREAD_LIMIT=0 OMP_NUM_THREADS=2,2,1 $GNU_TOOL" \
        "OMP_THREAD_LIMIT=0 OMP_NUM_THREADS=2,2,1 $F_TOOL"

    run_test "bad OMP_NUM_THREADS ignored" \
        "OMP_NUM_THREADS=2bad $GNU_TOOL" \
        "OMP_NUM_THREADS=2bad $F_TOOL"

    run_test "negative OMP_NUM_THREADS ignored" \
        "OMP_NUM_THREADS=-2 $GNU_TOOL" \
        "OMP_NUM_THREADS=-2 $F_TOOL"

    # From nproc-override.sh: OMP_THREAD_LIMIT without OMP_NUM_THREADS
    run_test "OMP_THREAD_LIMIT=1 alone" \
        "OMP_THREAD_LIMIT=1 OMP_NUM_THREADS= $GNU_TOOL" \
        "OMP_THREAD_LIMIT=1 OMP_NUM_THREADS= $F_TOOL"

    # From nproc-override.sh: OMP_NUM_THREADS=0 uses available count
    run_test "OMP_NUM_THREADS=0 returns available" \
        "OMP_NUM_THREADS=0 $GNU_TOOL" \
        "OMP_NUM_THREADS=0 $F_TOOL"

    # From nproc-override.sh: OMP_THREAD_LIMIT=1 OMP_NUM_THREADS=0
    run_test "OMP_THREAD_LIMIT=1 OMP_NUM_THREADS=0" \
        "OMP_THREAD_LIMIT=1 OMP_NUM_THREADS=0 $GNU_TOOL" \
        "OMP_THREAD_LIMIT=1 OMP_NUM_THREADS=0 $F_TOOL"

    # From nproc-override.sh: OMP_THREAD_LIMIT with bad value treated as unset
    run_test "OMP_THREAD_LIMIT=1bad ignored" \
        "OMP_THREAD_LIMIT=1bad OMP_NUM_THREADS=2,2,1 $GNU_TOOL" \
        "OMP_THREAD_LIMIT=1bad OMP_NUM_THREADS=2,2,1 $F_TOOL"

    # nproc-quota-systemd.sh: skipped (requires root and systemd-run)
    skip_test "nproc cgroup quota systemd" "Requires root and systemd"

    # nproc-quota.sh: skipped (requires root, gcc, chroot, LD_PRELOAD)
    skip_test "nproc cgroup quota" "Requires root, gcc, and chroot"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "invalid option" \
        "$GNU_TOOL --invalid-option 2>&1" \
        "$F_TOOL --invalid-option 2>&1"


    finish_test_suite
}

run_nproc_tests
