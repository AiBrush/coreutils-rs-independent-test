#!/usr/bin/env bash
# Compatibility tests for fnumfmt vs GNU numfmt
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="numfmt"
F_TOOL="fnumfmt"

run_numfmt_tests() {
    init_test_suite "numfmt"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"numfmt","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/numfmt_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU numfmt not found, cannot compare" >&2
        return 1
    fi

    # === Section 1: --to=si Conversions ===
    echo ""
    echo "=== --to=si Conversions ==="

    run_stdout_test "--to=si 1000" \
        "echo 1000 | $GNU_TOOL --to=si" \
        "echo 1000 | $F_TOOL --to=si"

    run_stdout_test "--to=si 1000000" \
        "echo 1000000 | $GNU_TOOL --to=si" \
        "echo 1000000 | $F_TOOL --to=si"

    run_stdout_test "--to=si 1000000000" \
        "echo 1000000000 | $GNU_TOOL --to=si" \
        "echo 1000000000 | $F_TOOL --to=si"

    run_stdout_test "--to=si 500" \
        "echo 500 | $GNU_TOOL --to=si" \
        "echo 500 | $F_TOOL --to=si"

    run_stdout_test "--to=si 0" \
        "echo 0 | $GNU_TOOL --to=si" \
        "echo 0 | $F_TOOL --to=si"

    # === Section 2: --to=iec Conversions ===
    echo ""
    echo "=== --to=iec Conversions ==="

    run_stdout_test "--to=iec 1048576" \
        "echo 1048576 | $GNU_TOOL --to=iec" \
        "echo 1048576 | $F_TOOL --to=iec"

    run_stdout_test "--to=iec 1073741824" \
        "echo 1073741824 | $GNU_TOOL --to=iec" \
        "echo 1073741824 | $F_TOOL --to=iec"

    run_stdout_test "--to=iec 1024" \
        "echo 1024 | $GNU_TOOL --to=iec" \
        "echo 1024 | $F_TOOL --to=iec"

    # === Section 3: --to=iec-i Conversions ===
    echo ""
    echo "=== --to=iec-i Conversions ==="

    run_stdout_test "--to=iec-i 1048576" \
        "echo 1048576 | $GNU_TOOL --to=iec-i" \
        "echo 1048576 | $F_TOOL --to=iec-i"

    run_stdout_test "--to=iec-i 1024" \
        "echo 1024 | $GNU_TOOL --to=iec-i" \
        "echo 1024 | $F_TOOL --to=iec-i"

    # === Section 4: --from Conversions ===
    echo ""
    echo "=== --from Conversions ==="

    run_stdout_test "--from=si 1.5K" \
        "echo 1.5K | $GNU_TOOL --from=si" \
        "echo 1.5K | $F_TOOL --from=si"

    run_stdout_test "--from=si 1M" \
        "echo 1M | $GNU_TOOL --from=si" \
        "echo 1M | $F_TOOL --from=si"

    run_stdout_test "--from=iec 1K" \
        "echo 1K | $GNU_TOOL --from=iec" \
        "echo 1K | $F_TOOL --from=iec"

    run_stdout_test "--from=iec-i 1.5Ki" \
        "echo 1.5Ki | $GNU_TOOL --from=iec-i" \
        "echo 1.5Ki | $F_TOOL --from=iec-i"

    run_stdout_test "--from=si 2.5G" \
        "echo 2.5G | $GNU_TOOL --from=si" \
        "echo 2.5G | $F_TOOL --from=si"

    # === Section 5: --field Selection ===
    echo ""
    echo "=== --field Selection ==="

    run_stdout_test "--field=2 --to=si" \
        "echo 'file 1000 bytes' | $GNU_TOOL --field=2 --to=si" \
        "echo 'file 1000 bytes' | $F_TOOL --field=2 --to=si"

    run_stdout_test "--field=1 --to=si" \
        "echo '1000 file' | $GNU_TOOL --field=1 --to=si" \
        "echo '1000 file' | $F_TOOL --field=1 --to=si"

    # === Section 6: --padding ===
    echo ""
    echo "=== --padding ==="

    run_stdout_test "--to=si --padding=10" \
        "echo 1000 | $GNU_TOOL --to=si --padding=10" \
        "echo 1000 | $F_TOOL --to=si --padding=10"

    run_stdout_test "--to=si --padding=-10 (left align)" \
        "echo 1000 | $GNU_TOOL --to=si --padding=-10" \
        "echo 1000 | $F_TOOL --to=si --padding=-10"

    # === Section 7: --header ===
    echo ""
    echo "=== --header ==="

    local header_input
    header_input=$(make_temp_printf "SIZE\n1000\n2000\n3000\n")
    register_temp "$header_input"

    run_stdout_test "--header=1 --to=si" \
        "$GNU_TOOL --header=1 --to=si" \
        "$F_TOOL --header=1 --to=si" \
        "$header_input"

    # === Section 8: --round ===
    echo ""
    echo "=== --round ==="

    run_stdout_test "--to=si --round=up" \
        "echo 1500 | $GNU_TOOL --to=si --round=up" \
        "echo 1500 | $F_TOOL --to=si --round=up"

    run_stdout_test "--to=si --round=down" \
        "echo 1500 | $GNU_TOOL --to=si --round=down" \
        "echo 1500 | $F_TOOL --to=si --round=down"

    run_stdout_test "--to=si --round=nearest" \
        "echo 1500 | $GNU_TOOL --to=si --round=nearest" \
        "echo 1500 | $F_TOOL --to=si --round=nearest"

    # === Section 9: --format ===
    echo ""
    echo "=== --format ==="

    run_stdout_test "--to=si --format='%10f'" \
        "echo 1000 | $GNU_TOOL --to=si --format='%10f'" \
        "echo 1000 | $F_TOOL --to=si --format='%10f'"

    # === Section 10: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "invalid input" \
        "echo 'notanumber' | $GNU_TOOL --to=si 2>&1" \
        "echo 'notanumber' | $F_TOOL --to=si 2>&1"

    run_exit_code_test "no input no args" \
        "echo '' | $GNU_TOOL 2>&1" \
        "echo '' | $F_TOOL 2>&1"

    # === Section 11: Multiple Lines ===
    echo ""
    echo "=== Multiple Lines ==="

    local multi_input
    multi_input=$(make_temp_printf "1000\n2000000\n3000000000\n")
    register_temp "$multi_input"

    run_stdout_test "multiple lines --to=si" \
        "$GNU_TOOL --to=si" \
        "$F_TOOL --to=si" \
        "$multi_input"

    finish_test_suite
}

run_numfmt_tests
