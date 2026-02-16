#!/usr/bin/env bash
# Compatibility tests for fdate vs GNU date
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="date"
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

    finish_test_suite
}

run_date_tests
