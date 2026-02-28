#!/usr/bin/env bash
# Compatibility tests for fdf vs GNU df
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "df")
F_TOOL="fdf"

run_df_tests() {
    init_test_suite "df"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"df","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/df_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU df not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: Default Output ===
    echo ""
    echo "=== Default Output ==="

    run_stdout_test "default df /" \
        "$GNU_TOOL /" \
        "$F_TOOL /"

    run_stdout_test "default df /proc" \
        "$GNU_TOOL /proc" \
        "$F_TOOL /proc"

    # === Section 2: Human Readable (-h) ===
    echo ""
    echo "=== Human Readable (-h) ==="

    run_stdout_test "-h /" \
        "$GNU_TOOL -h /" \
        "$F_TOOL -h /"

    run_stdout_test "-H (SI units) /" \
        "$GNU_TOOL -H /" \
        "$F_TOOL -H /"

    # === Section 3: Inode Mode (-i) ===
    echo ""
    echo "=== Inode Mode (-i) ==="

    run_stdout_test "-i /" \
        "$GNU_TOOL -i /" \
        "$F_TOOL -i /"

    # === Section 4: With Type (-T) ===
    echo ""
    echo "=== With Type (-T) ==="

    run_stdout_test "-T /" \
        "$GNU_TOOL -T /" \
        "$F_TOOL -T /"

    # === Section 5: POSIX Mode (-P) ===
    echo ""
    echo "=== POSIX Mode (-P) ==="

    run_stdout_test "-P /" \
        "$GNU_TOOL -P /" \
        "$F_TOOL -P /"

    run_stdout_test "-P /proc" \
        "$GNU_TOOL -P /proc" \
        "$F_TOOL -P /proc"

    # === Section 6: Custom Block Size ===
    echo ""
    echo "=== Block Size ==="

    run_stdout_test "-B 1M /" \
        "$GNU_TOOL -B 1M /" \
        "$F_TOOL -B 1M /"

    run_stdout_test "-k (1K blocks) /" \
        "$GNU_TOOL -k /" \
        "$F_TOOL -k /"

    # === Section 7: Custom Output ===
    echo ""
    echo "=== Custom Output ==="

    run_stdout_test "--output=source,size,used,avail,pcent /" \
        "$GNU_TOOL --output=source,size,used,avail,pcent /" \
        "$F_TOOL --output=source,size,used,avail,pcent /"

    run_stdout_test "--output=target,fstype /" \
        "$GNU_TOOL --output=target,fstype /" \
        "$F_TOOL --output=target,fstype /"

    # === Section 8: Filter by Filesystem Type ===
    echo ""
    echo "=== Filter by Type ==="

    # Get current fs type for /
    local fstype
    fstype=$($GNU_TOOL -T / | tail -1 | awk '{print $2}')

    if [[ -n "$fstype" ]]; then
        run_stdout_test "-t $fstype (include type)" \
            "$GNU_TOOL -t '$fstype'" \
            "$F_TOOL -t '$fstype'"
    else
        skip_test "-t fstype" "could not determine filesystem type"
    fi

    # === Section 9: Multiple Paths ===
    echo ""
    echo "=== Multiple Paths ==="

    run_stdout_test "df / /proc" \
        "$GNU_TOOL / /proc" \
        "$F_TOOL / /proc"

    # === GNU Upstream: POSIX Output (df-P.sh) ===
    echo ""
    echo "=== GNU Upstream: POSIX Output ==="

    # From df-P.sh: df -P should not be affected by BLOCK_SIZE settings.
    # Compare only the header line (block size label), since filesystem
    # utilization may change between the two invocations.
    run_stdout_test "GNU df-P: -P header ignores BLOCK_SIZE" \
        "$GNU_TOOL -P . 2>/dev/null | head -n1 | tr -s ' '" \
        "$F_TOOL -P . 2>/dev/null | head -n1 | tr -s ' '"

    run_stdout_test "GNU df-P: BLOCK_SIZE=1M -P header unchanged" \
        "BLOCK_SIZE=1M $GNU_TOOL -P . 2>/dev/null | head -n1 | tr -s ' '" \
        "BLOCK_SIZE=1M $F_TOOL -P . 2>/dev/null | head -n1 | tr -s ' '"

    # === GNU Upstream: Header Output (header.sh) ===
    echo ""
    echo "=== GNU Upstream: Header Output ==="

    # From header.sh: df . should output at least 2 lines (header + data).
    # We check line count matches between GNU and F tool.
    run_stdout_test "GNU header: df . produces header plus data" \
        "$GNU_TOOL . 2>/dev/null | wc -l | tr -d ' '" \
        "$F_TOOL . 2>/dev/null | wc -l | tr -d ' '"

    # === GNU Upstream: --output Option (df-output.sh) ===
    echo ""
    echo "=== GNU Upstream: --output Option ==="

    # From df-output.sh: --output is mutually exclusive with -i
    run_exit_code_test "GNU df-output: --output conflicts with -i" \
        "$GNU_TOOL -i --output . 2>&1" \
        "$F_TOOL -i --output . 2>&1"

    # From df-output.sh: --output is mutually exclusive with -P
    run_exit_code_test "GNU df-output: --output conflicts with -P" \
        "$GNU_TOOL -P --output . 2>&1" \
        "$F_TOOL -P --output . 2>&1"

    # From df-output.sh: --output is mutually exclusive with -T
    run_exit_code_test "GNU df-output: --output conflicts with -T" \
        "$GNU_TOOL -T --output . 2>&1" \
        "$F_TOOL -T --output . 2>&1"

    # From df-output.sh: duplicate field in --output should error
    run_exit_code_test "GNU df-output: duplicate field in --output" \
        "$GNU_TOOL --output=target,source,target . 2>&1" \
        "$F_TOOL --output=target,source,target . 2>&1"

    # From df-output.sh: --output full field list header format
    run_stdout_test "GNU df-output: full --output header fields" \
        "$GNU_TOOL -h --output . 2>/dev/null | head -n1 | tr -s ' '" \
        "$F_TOOL -h --output . 2>/dev/null | head -n1 | tr -s ' '"

    # From df-output.sh: --output with block size shows correct label
    run_stdout_test "GNU df-output: -B1K --output=size header" \
        "$GNU_TOOL -B1K --output=size . 2>/dev/null | head -n1 | tr -d ' '" \
        "$F_TOOL -B1K --output=size . 2>/dev/null | head -n1 | tr -d ' '"

    # From df-output.sh: --output=file shows the argument path
    run_stdout_test "GNU df-output: --output=file shows argument" \
        "$GNU_TOOL --output=file . 2>/dev/null | tail -n1 | tr -d ' '" \
        "$F_TOOL --output=file . 2>/dev/null | tail -n1 | tr -d ' '"

    # === Section 10: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent path" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"


    finish_test_suite
}

run_df_tests
