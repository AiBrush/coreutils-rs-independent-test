#!/usr/bin/env bash
# Compatibility tests for fdf vs GNU df
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="df"
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

    run_stdout_test "default df /tmp" \
        "$GNU_TOOL /tmp" \
        "$F_TOOL /tmp"

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

    run_stdout_test "-P /tmp" \
        "$GNU_TOOL -P /tmp" \
        "$F_TOOL -P /tmp"

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

    run_stdout_test "df / /tmp" \
        "$GNU_TOOL / /tmp" \
        "$F_TOOL / /tmp"

    # === Section 10: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent path" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    finish_test_suite
}

run_df_tests
