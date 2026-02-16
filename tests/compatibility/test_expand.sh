#!/usr/bin/env bash
# Compatibility tests for fexpand vs GNU expand
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="expand"
F_TOOL="fexpand"

run_expand_tests() {
    init_test_suite "expand"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"expand","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/expand_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU expand not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Tab Expansion (default 8) ==="

    run_test "simple tabs" \
        "$GNU_TOOL '$TEST_DATA_DIR/expand_simple.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/expand_simple.txt'"

    run_test "leading tab" \
        "$GNU_TOOL '$TEST_DATA_DIR/expand_leading.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/expand_leading.txt'"

    run_test "multiple tabs" \
        "$GNU_TOOL '$TEST_DATA_DIR/expand_multi.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/expand_multi.txt'"

    run_test "consecutive tabs" \
        "$GNU_TOOL '$TEST_DATA_DIR/expand_consecutive.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/expand_consecutive.txt'"

    run_test "alignment test" \
        "$GNU_TOOL '$TEST_DATA_DIR/expand_alignment.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/expand_alignment.txt'"

    run_test "mixed tabs and spaces" \
        "$GNU_TOOL '$TEST_DATA_DIR/expand_mixed.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/expand_mixed.txt'"

    run_test "only tabs" \
        "$GNU_TOOL '$TEST_DATA_DIR/expand_only_tabs.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/expand_only_tabs.txt'"

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "no tabs (passthrough)" \
        "$GNU_TOOL '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/unsorted.txt'"

    run_test "stdin" \
        "printf 'a\tb\tc\n' | $GNU_TOOL" \
        "printf 'a\tb\tc\n' | $F_TOOL"

    echo ""
    echo "=== Custom Tab Stop (-t N) ==="

    run_test "-t 4 (4-space tabs)" \
        "$GNU_TOOL -t 4 '$TEST_DATA_DIR/expand_simple.txt'" \
        "$F_TOOL -t 4 '$TEST_DATA_DIR/expand_simple.txt'"

    run_test "-t 2 (2-space tabs)" \
        "$GNU_TOOL -t 2 '$TEST_DATA_DIR/expand_multi.txt'" \
        "$F_TOOL -t 2 '$TEST_DATA_DIR/expand_multi.txt'"

    run_test "-t 1 (1-space tabs)" \
        "$GNU_TOOL -t 1 '$TEST_DATA_DIR/expand_multi.txt'" \
        "$F_TOOL -t 1 '$TEST_DATA_DIR/expand_multi.txt'"

    run_test "-t 16 (16-space tabs)" \
        "$GNU_TOOL -t 16 '$TEST_DATA_DIR/expand_simple.txt'" \
        "$F_TOOL -t 16 '$TEST_DATA_DIR/expand_simple.txt'"

    echo ""
    echo "=== Tab Stop List (-t N,M,...) ==="

    run_test "-t 4,8,12 (tab stop list)" \
        "printf '\tone\t\ttwo\tthree\n' | $GNU_TOOL -t 4,8,12" \
        "printf '\tone\t\ttwo\tthree\n' | $F_TOOL -t 4,8,12"

    run_test "-t 2,5,10 (irregular stops)" \
        "printf '\ta\tb\tc\td\n' | $GNU_TOOL -t 2,5,10" \
        "printf '\ta\tb\tc\td\n' | $F_TOOL -t 2,5,10"

    run_test "-t 3,6,9,12 (regular stops)" \
        "printf 'a\tb\tc\td\te\n' | $GNU_TOOL -t 3,6,9,12" \
        "printf 'a\tb\tc\td\te\n' | $F_TOOL -t 3,6,9,12"

    echo ""
    echo "=== Initial Only (--initial) ==="

    run_test "--initial (only leading tabs)" \
        "printf '\tleading\ttab\there\n' | $GNU_TOOL --initial" \
        "printf '\tleading\ttab\there\n' | $F_TOOL --initial"

    run_test "--initial with no leading tabs" \
        "printf 'no\ttabs\tat\tstart\n' | $GNU_TOOL --initial" \
        "printf 'no\ttabs\tat\tstart\n' | $F_TOOL --initial"

    run_test "--initial with -t 4" \
        "printf '\t\tindented\ttabs\there\n' | $GNU_TOOL --initial -t 4" \
        "printf '\t\tindented\ttabs\there\n' | $F_TOOL --initial -t 4"

    echo ""
    echo "=== Tab at Various Positions ==="

    run_test "tab at position 1" \
        "printf '\tword\n' | $GNU_TOOL" \
        "printf '\tword\n' | $F_TOOL"

    run_test "tab at position 4" \
        "printf 'abc\tword\n' | $GNU_TOOL" \
        "printf 'abc\tword\n' | $F_TOOL"

    run_test "tab at position 7" \
        "printf 'abcdef\tword\n' | $GNU_TOOL" \
        "printf 'abcdef\tword\n' | $F_TOOL"

    run_test "tab at position 8" \
        "printf 'abcdefg\tword\n' | $GNU_TOOL" \
        "printf 'abcdefg\tword\n' | $F_TOOL"

    run_test "tab at position 9" \
        "printf 'abcdefgh\tword\n' | $GNU_TOOL" \
        "printf 'abcdefgh\tword\n' | $F_TOOL"

    echo ""
    echo "=== Line Endings ==="

    run_test "dos endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/dos_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/dos_endings.txt'"

    run_test "mixed endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/mixed_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/mixed_endings.txt'"

    echo ""
    echo "=== Unicode ==="

    run_test "CJK text with tabs" \
        "printf '\t世界\t你好\n' | $GNU_TOOL" \
        "printf '\t世界\t你好\n' | $F_TOOL"

    echo ""
    echo "=== TSV Data ==="

    run_test "TSV data" \
        "$GNU_TOOL '$TEST_DATA_DIR/tsv_data.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tsv_data.txt'"

    echo ""
    echo "=== Large Files ==="

    if [[ -f "$TEST_DATA_DIR/tabbed_10m.txt" ]]; then
        run_test "10MB tabbed file" \
            "$GNU_TOOL '$TEST_DATA_DIR/tabbed_10m.txt' | md5sum" \
            "$F_TOOL '$TEST_DATA_DIR/tabbed_10m.txt' | md5sum"
    fi

    echo ""
    echo "=== Multiple Files ==="

    run_test "two files" \
        "$GNU_TOOL '$TEST_DATA_DIR/expand_simple.txt' '$TEST_DATA_DIR/expand_multi.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/expand_simple.txt' '$TEST_DATA_DIR/expand_multi.txt'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    echo ""
    echo "=== Round Trip (expand | unexpand) ==="

    if command -v unexpand &>/dev/null && command -v funexpand &>/dev/null; then
        run_test "expand then unexpand round trip" \
            "$GNU_TOOL '$TEST_DATA_DIR/expand_multi.txt' | unexpand" \
            "$F_TOOL '$TEST_DATA_DIR/expand_multi.txt' | funexpand"
    else
        skip_test "round trip" "unexpand or funexpand not available"
    fi

    finish_test_suite
}

run_expand_tests
