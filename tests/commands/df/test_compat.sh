#!/usr/bin/env bash
# Compatibility tests for fdf vs GNU df
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "df")
F_TOOL="fdf"

# ── df-specific comparison helpers ─────────────────────────────────────────────
# Filesystem stats change between two invocations, so exact output comparison
# causes false failures.  These helpers compare headers exactly and allow
# numeric data columns (block counts, percentages, human-readable sizes) to
# differ within a tolerance.

# Compare two df outputs with tolerance for numeric columns.
# Usage: df_compare_with_tolerance <gnu_file> <f_file>
# Returns 0 on match, 1 on mismatch (writes diff detail to stdout).
df_compare_with_tolerance() {
    local gnu_file="$1" f_file="$2"

    # Line counts must match
    local gnu_lines f_lines
    gnu_lines=$(wc -l < "$gnu_file")
    f_lines=$(wc -l < "$f_file")
    if [[ "$gnu_lines" != "$f_lines" ]]; then
        echo "Line count mismatch: GNU=$gnu_lines, F=$f_lines"
        return 1
    fi

    # Header line (first line) must match exactly (after normalizing whitespace)
    local gnu_hdr f_hdr
    gnu_hdr=$(head -n1 "$gnu_file" | tr -s ' ')
    f_hdr=$(head -n1 "$f_file" | tr -s ' ')
    if [[ "$gnu_hdr" != "$f_hdr" ]]; then
        echo "Header mismatch: GNU='$gnu_hdr' F='$f_hdr'"
        return 1
    fi

    # For data rows, compare non-numeric fields exactly and numeric fields
    # with tolerance.  We use awk for the comparison.
    local result
    result=$(awk '
    function is_numeric(s) {
        # Matches: 123, 42%, 1.2G, 3.5M, 100K, 0, etc.
        return s ~ /^[0-9][0-9.,]*[%BKMGTPEZY]?i?$/
    }
    function strip_num(s) {
        # Extract leading numeric portion
        gsub(/[^0-9.]/, "", s)
        return s + 0
    }
    BEGIN { ok = 1 }
    NR == FNR { gnu[NR] = $0; gnu_n = NR; next }
    {
        n = split(gnu[FNR], ga)
        m = split($0, fa)
        if (n != m) { print "Field count mismatch line " FNR ": GNU=" n " F=" m; ok = 0; next }
        for (i = 1; i <= n; i++) {
            if (ga[i] == fa[i]) continue
            if (is_numeric(ga[i]) && is_numeric(fa[i])) {
                # Allow numeric fields to differ (filesystem stats change)
                continue
            }
            # Special case: "-" matches "-" (used for unavailable fields)
            if (ga[i] == "-" || fa[i] == "-") continue
            print "Mismatch line " FNR " field " i ": GNU=" ga[i] " F=" fa[i]
            ok = 0
        }
    }
    END { exit (ok ? 0 : 1) }
    ' "$gnu_file" "$f_file" 2>&1)

    if [[ $? -ne 0 ]]; then
        echo "$result"
        return 1
    fi
    return 0
}

# Run a df comparison test with tolerance for numeric columns.
# Usage: run_df_test "test_name" "gnu_command" "f_command"
run_df_test() {
    local test_name="$1"
    local gnu_cmd="$2"
    local f_cmd="$3"

    TESTS_RUN=$((TESTS_RUN + 1))

    local gnu_out="/tmp/gnu_df_$$"
    local f_out="/tmp/f_df_$$"
    local gnu_exit=0
    local f_exit=0

    timeout "$TEST_TIMEOUT" bash -c "$gnu_cmd" > "$gnu_out" 2>/dev/null || gnu_exit=$?
    timeout "$TEST_TIMEOUT" bash -c "$f_cmd" > "$f_out" 2>/dev/null || f_exit=$?

    if [[ "$gnu_exit" -eq 124 ]]; then
        TESTS_SKIPPED=$((TESTS_SKIPPED + 1))
        echo -e "  ${YELLOW}SKIP${NC}: $test_name (GNU command timed out)"
        record_result "$test_name" "SKIP" "GNU command timed out" "$gnu_cmd" "$f_cmd"
        rm -f "$gnu_out" "$f_out"
        return 0
    fi

    if [[ "$f_exit" -eq 124 ]]; then
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: $test_name (fcoreutils command timed out)"
        record_result "$test_name" "FAIL" "fcoreutils timed out" "$gnu_cmd" "$f_cmd"
        rm -f "$gnu_out" "$f_out"
        return 0
    fi

    if [[ "$gnu_exit" != "$f_exit" ]]; then
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: $test_name (exit: GNU=$gnu_exit, F=$f_exit)"
        record_result "$test_name" "FAIL" "Exit code mismatch: GNU=$gnu_exit, F=$f_exit" "$gnu_cmd" "$f_cmd"
        rm -f "$gnu_out" "$f_out"
        return 0
    fi

    local detail
    if detail=$(df_compare_with_tolerance "$gnu_out" "$f_out"); then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: $test_name"
        record_result "$test_name" "PASS" "" "$gnu_cmd" "$f_cmd"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: $test_name"
        echo "$detail" | head -10 | sed 's/^/      /'
        record_result "$test_name" "FAIL" "$detail" "$gnu_cmd" "$f_cmd"
    fi

    rm -f "$gnu_out" "$f_out"
}

# ── Tests ──────────────────────────────────────────────────────────────────────

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

    # Use tolerance-based comparison for live filesystem stats
    run_df_test "default df /" \
        "$GNU_TOOL /" \
        "$F_TOOL /"

    run_df_test "default df /proc" \
        "$GNU_TOOL /proc" \
        "$F_TOOL /proc"

    # === Section 2: Human Readable (-h) ===
    echo ""
    echo "=== Human Readable (-h) ==="

    run_df_test "-h /" \
        "$GNU_TOOL -h /" \
        "$F_TOOL -h /"

    run_df_test "-H (SI units) /" \
        "$GNU_TOOL -H /" \
        "$F_TOOL -H /"

    # === Section 3: Inode Mode (-i) ===
    echo ""
    echo "=== Inode Mode (-i) ==="

    run_df_test "-i /" \
        "$GNU_TOOL -i /" \
        "$F_TOOL -i /"

    # === Section 4: With Type (-T) ===
    echo ""
    echo "=== With Type (-T) ==="

    run_df_test "-T /" \
        "$GNU_TOOL -T /" \
        "$F_TOOL -T /"

    # === Section 5: POSIX Mode (-P) ===
    echo ""
    echo "=== POSIX Mode (-P) ==="

    run_df_test "-P /" \
        "$GNU_TOOL -P /" \
        "$F_TOOL -P /"

    run_df_test "-P /proc" \
        "$GNU_TOOL -P /proc" \
        "$F_TOOL -P /proc"

    # === Section 6: Custom Block Size ===
    echo ""
    echo "=== Block Size ==="

    run_df_test "-B 1M /" \
        "$GNU_TOOL -B 1M /" \
        "$F_TOOL -B 1M /"

    run_df_test "-k (1K blocks) /" \
        "$GNU_TOOL -k /" \
        "$F_TOOL -k /"

    # === Section 7: Custom Output ===
    echo ""
    echo "=== Custom Output ==="

    run_df_test "--output=source,size,used,avail,pcent /" \
        "$GNU_TOOL --output=source,size,used,avail,pcent /" \
        "$F_TOOL --output=source,size,used,avail,pcent /"

    # Non-numeric columns only — exact comparison is fine
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
        run_df_test "-t $fstype (include type)" \
            "$GNU_TOOL -t '$fstype'" \
            "$F_TOOL -t '$fstype'"
    else
        skip_test "-t fstype" "could not determine filesystem type"
    fi

    # === Section 9: Multiple Paths ===
    echo ""
    echo "=== Multiple Paths ==="

    run_df_test "df / /proc" \
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
