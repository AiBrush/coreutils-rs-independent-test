#!/usr/bin/env bash
# Compatibility tests for fdate vs GNU date
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "date")
F_TOOL="fdate"

run_date_tests() {
    init_test_suite "date"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"date","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/date_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU date not found, cannot compare" >&2
        return 1
    fi

    # Use fixed epoch timestamps to get deterministic results
    # Always use -u (UTC) to avoid timezone issues

    # === Section 1: Format Strings with Fixed Epoch ===
    echo ""
    echo "=== Format Strings (Fixed Epoch) ==="

    run_stdout_test "+%Y-%m-%d from epoch 0" \
        "$GNU_TOOL -u -d '@0' '+%Y-%m-%d'" \
        "$F_TOOL -u -d '@0' '+%Y-%m-%d'"

    run_stdout_test "+%H:%M:%S from epoch 0" \
        "$GNU_TOOL -u -d '@0' '+%H:%M:%S'" \
        "$F_TOOL -u -d '@0' '+%H:%M:%S'"

    run_stdout_test "+%A weekday from epoch 0" \
        "$GNU_TOOL -u -d '@0' '+%A'" \
        "$F_TOOL -u -d '@0' '+%A'"

    run_stdout_test "+%B month from epoch 0" \
        "$GNU_TOOL -u -d '@0' '+%B'" \
        "$F_TOOL -u -d '@0' '+%B'"

    run_stdout_test "+%Y from epoch 1705312200" \
        "$GNU_TOOL -u -d '@1705312200' '+%Y-%m-%d'" \
        "$F_TOOL -u -d '@1705312200' '+%Y-%m-%d'"

    run_stdout_test "+%s from epoch 0" \
        "$GNU_TOOL -u -d '@0' '+%s'" \
        "$F_TOOL -u -d '@0' '+%s'"

    run_stdout_test "complex format from epoch" \
        "$GNU_TOOL -u -d '@86400' '+%Y-%m-%d %H:%M:%S %Z'" \
        "$F_TOOL -u -d '@86400' '+%Y-%m-%d %H:%M:%S %Z'"

    run_stdout_test "+%j day of year from epoch 86400" \
        "$GNU_TOOL -u -d '@86400' '+%j'" \
        "$F_TOOL -u -d '@86400' '+%j'"

    run_stdout_test "+%u day of week (1=Monday)" \
        "$GNU_TOOL -u -d '@0' '+%u'" \
        "$F_TOOL -u -d '@0' '+%u'"

    run_stdout_test "+%V ISO week number" \
        "$GNU_TOOL -u -d '@0' '+%V'" \
        "$F_TOOL -u -d '@0' '+%V'"

    # === Section 2: UTC Mode (-u) ===
    echo ""
    echo "=== UTC Mode (-u) ==="

    run_stdout_test "-u +%Z is UTC" \
        "$GNU_TOOL -u -d '@0' '+%Z'" \
        "$F_TOOL -u -d '@0' '+%Z'"

    run_stdout_test "-u full default format" \
        "$GNU_TOOL -u -d '@0'" \
        "$F_TOOL -u -d '@0'"

    run_stdout_test "-u epoch 1000000000" \
        "$GNU_TOOL -u -d '@1000000000'" \
        "$F_TOOL -u -d '@1000000000'"

    # === Section 3: Date String Input (-d) ===
    echo ""
    echo "=== Date String Input (-d) ==="

    run_stdout_test "-d '2024-01-15' weekday" \
        "$GNU_TOOL -u -d '2024-01-15' '+%A'" \
        "$F_TOOL -u -d '2024-01-15' '+%A'"

    run_stdout_test "-d '2024-01-15 12:30:00' full" \
        "$GNU_TOOL -u -d '2024-01-15 12:30:00' '+%Y-%m-%d %H:%M:%S'" \
        "$F_TOOL -u -d '2024-01-15 12:30:00' '+%Y-%m-%d %H:%M:%S'"

    run_stdout_test "-d '@86400' (epoch seconds)" \
        "$GNU_TOOL -u -d '@86400' '+%Y-%m-%d'" \
        "$F_TOOL -u -d '@86400' '+%Y-%m-%d'"

    # === Section 4: ISO 8601 (-I) ===
    echo ""
    echo "=== ISO 8601 (-I) ==="

    run_stdout_test "-I date only from epoch" \
        "$GNU_TOOL -u -d '@0' -I" \
        "$F_TOOL -u -d '@0' -I"

    run_stdout_test "-Iseconds from epoch" \
        "$GNU_TOOL -u -d '@0' -Iseconds" \
        "$F_TOOL -u -d '@0' -Iseconds"

    run_stdout_test "-Iminutes from epoch" \
        "$GNU_TOOL -u -d '@0' -Iminutes" \
        "$F_TOOL -u -d '@0' -Iminutes"

    # === Section 5: RFC Formats ===
    echo ""
    echo "=== RFC Formats ==="

    run_stdout_test "-R RFC 5322 from epoch" \
        "$GNU_TOOL -u -d '@0' -R" \
        "$F_TOOL -u -d '@0' -R"

    run_stdout_test "--rfc-3339=seconds from epoch" \
        "$GNU_TOOL -u -d '@0' --rfc-3339=seconds" \
        "$F_TOOL -u -d '@0' --rfc-3339=seconds"

    run_stdout_test "--rfc-3339=date from epoch" \
        "$GNU_TOOL -u -d '@0' --rfc-3339=date" \
        "$F_TOOL -u -d '@0' --rfc-3339=date"

    # === Section 6: File Reference (-r) ===
    echo ""
    echo "=== File Reference (-r) ==="

    local ref_file
    ref_file=$(mktemp /tmp/fcoreutils_dateref_XXXXXX)
    register_temp "$ref_file"
    touch -t 202401150000 "$ref_file" 2>/dev/null || touch "$ref_file"

    run_stdout_test "-r file reference" \
        "$GNU_TOOL -r '$ref_file' '+%Y-%m-%d'" \
        "$F_TOOL -r '$ref_file' '+%Y-%m-%d'"

    # === Section 7: Padding Modifiers ===
    echo ""
    echo "=== Padding Modifiers ==="

    run_stdout_test "%-d no-pad day" \
        "$GNU_TOOL -u -d '@86400' '+%-d'" \
        "$F_TOOL -u -d '@86400' '+%-d'"

    run_stdout_test "%_d space-pad day" \
        "$GNU_TOOL -u -d '@86400' '+%_d'" \
        "$F_TOOL -u -d '@86400' '+%_d'"

    echo ""
    echo "=== GNU Upstream: Seconds Zeroing ==="

    # From date-sec.sh: ensure --date with time+offset always zeroes seconds
    run_stdout_test "gnu: --date time+offset seconds zero" \
        "$GNU_TOOL --date='21:04 +0100' +%S" \
        "$F_TOOL --date='21:04 +0100' +%S"

    echo ""
    echo "=== GNU Upstream: Percent-Percent Format ==="

    # From percent-percent.sh: %% should produce literal %
    run_stdout_test "gnu: %% literal percent" \
        "$GNU_TOOL -u -d '@0' '+%%'" \
        "$F_TOOL -u -d '@0' '+%%'"

    run_stdout_test "gnu: %%Y produces literal %Y" \
        "$GNU_TOOL -u -d '@0' '+%%Y'" \
        "$F_TOOL -u -d '@0' '+%%Y'"

    run_stdout_test "gnu: %%H%%M literal percents" \
        "$GNU_TOOL -u -d '@0' '+%%H%%M'" \
        "$F_TOOL -u -d '@0' '+%%H%%M'"

    # Mixed: %Y followed by %%
    run_stdout_test "gnu: mixed %Y and %%" \
        "$GNU_TOOL -u -d '@0' '+%Y%%'" \
        "$F_TOOL -u -d '@0' '+%Y%%'"

    # All time specifiers preceded by %%
    run_stdout_test "gnu: %%H%%I%%M%%S pattern" \
        "$GNU_TOOL -u -d '@86400' '+%%H%%I%%M%%S'" \
        "$F_TOOL -u -d '@86400' '+%%H%%I%%M%%S'"

    echo ""
    echo "=== GNU Upstream: Timezone Processing ==="

    # From date-tz.sh: TZ environment variable processing
    run_stdout_test "gnu: TZ=UTC0 epoch format" \
        "TZ=UTC0 $GNU_TOOL -d '@0' '+%Y-%m-%d %H:%M:%S %Z'" \
        "TZ=UTC0 $F_TOOL -d '@0' '+%Y-%m-%d %H:%M:%S %Z'"

    run_stdout_test "gnu: TZ=America/New_York" \
        "TZ=America/New_York $GNU_TOOL -d '@0' '+%Y-%m-%d %H:%M:%S %Z'" \
        "TZ=America/New_York $F_TOOL -d '@0' '+%Y-%m-%d %H:%M:%S %Z'"

    run_stdout_test "gnu: TZ=Asia/Tokyo" \
        "TZ=Asia/Tokyo $GNU_TOOL -d '@0' '+%Y-%m-%d %H:%M:%S %Z'" \
        "TZ=Asia/Tokyo $F_TOOL -d '@0' '+%Y-%m-%d %H:%M:%S %Z'"

    run_stdout_test "gnu: TZ=Europe/London epoch 1000000000" \
        "TZ=Europe/London $GNU_TOOL -d '@1000000000' '+%Y-%m-%d %H:%M:%S %Z'" \
        "TZ=Europe/London $F_TOOL -d '@1000000000' '+%Y-%m-%d %H:%M:%S %Z'"

    run_stdout_test "gnu: TZ=Pacific/Auckland" \
        "TZ=Pacific/Auckland $GNU_TOOL -d '@86400' '+%Y-%m-%d %H:%M:%S %Z'" \
        "TZ=Pacific/Auckland $F_TOOL -d '@86400' '+%Y-%m-%d %H:%M:%S %Z'"

    echo ""
    echo "=== GNU Upstream: Reference File ==="

    # From reference.sh: --reference tests
    local tmp_ref_dir=$(mktemp -d /tmp/fcoreutils_dateref_XXXXXX)
    register_temp "$tmp_ref_dir"

    touch -d "2025-10-23 03:00" "$tmp_ref_dir/ref_a" 2>/dev/null || \
        touch -t 202510230300 "$tmp_ref_dir/ref_a" 2>/dev/null || \
        touch "$tmp_ref_dir/ref_a"
    touch -d "2025-10-23 04:00" "$tmp_ref_dir/ref_b" 2>/dev/null || \
        touch -t 202510230400 "$tmp_ref_dir/ref_b" 2>/dev/null || \
        touch "$tmp_ref_dir/ref_b"

    run_stdout_test "gnu: -r reference file a" \
        "TZ=UTC0 $GNU_TOOL -r '$tmp_ref_dir/ref_a' '+%Y-%m-%d %H:%M'" \
        "TZ=UTC0 $F_TOOL -r '$tmp_ref_dir/ref_a' '+%Y-%m-%d %H:%M'"

    run_stdout_test "gnu: -r reference file b" \
        "TZ=UTC0 $GNU_TOOL -r '$tmp_ref_dir/ref_b' '+%Y-%m-%d %H:%M'" \
        "TZ=UTC0 $F_TOOL -r '$tmp_ref_dir/ref_b' '+%Y-%m-%d %H:%M'"

    # --reference with missing/invalid args should fail
    run_exit_code_test "gnu: --reference no arg" \
        "$GNU_TOOL --reference 2>&1" \
        "$F_TOOL --reference 2>&1"

    run_exit_code_test "gnu: --reference= empty" \
        "$GNU_TOOL --reference= 2>&1" \
        "$F_TOOL --reference= 2>&1"

    run_exit_code_test "gnu: --reference=missing file" \
        "$GNU_TOOL --reference=/tmp/no_such_file_$$ 2>&1" \
        "$F_TOOL --reference=/tmp/no_such_file_$$ 2>&1"

    rm -rf "$tmp_ref_dir"

    # === Section 8: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "invalid date string" \
        "$GNU_TOOL -d 'not a date' 2>&1" \
        "$F_TOOL -d 'not a date' 2>&1"

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    run_exit_code_test "--version" \
        "$GNU_TOOL --version" \
        "$F_TOOL --version"

    echo ""
    echo "=== Format Specifiers ==="

    run_stdout_test "year format %Y" \
        "$GNU_TOOL -u +%Y 2>/dev/null | grep -E '^[0-9]{4}$'" \
        "$F_TOOL -u +%Y 2>/dev/null | grep -E '^[0-9]{4}$'"

    run_stdout_test "ISO 8601 format" \
        "$GNU_TOOL -u +%Y-%m-%d 2>/dev/null | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'" \
        "$F_TOOL -u +%Y-%m-%d 2>/dev/null | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'"

    run_stdout_test "time format %H:%M:%S" \
        "$GNU_TOOL -u +%H:%M:%S 2>/dev/null | grep -E '^[0-9]{2}:[0-9]{2}:[0-9]{2}$'" \
        "$F_TOOL -u +%H:%M:%S 2>/dev/null | grep -E '^[0-9]{2}:[0-9]{2}:[0-9]{2}$'"

    run_stdout_test "Unix timestamp" \
        "$GNU_TOOL -u +%s 2>/dev/null | grep -E '^[0-9]+$'" \
        "$F_TOOL -u +%s 2>/dev/null | grep -E '^[0-9]+$'"


    finish_test_suite
}

run_date_tests
