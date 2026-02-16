#!/usr/bin/env bash
# Compatibility tests for funexpand vs GNU unexpand
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="unexpand"
F_TOOL="funexpand"

run_unexpand_tests() {
    init_test_suite "unexpand"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"unexpand","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/unexpand_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU unexpand not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Space-to-Tab (default: leading only, 8-space) ==="

    run_test "8 leading spaces to tab" \
        "printf '        hello\n' | $GNU_TOOL" \
        "printf '        hello\n' | $F_TOOL"

    run_test "16 leading spaces to 2 tabs" \
        "printf '                hello\n' | $GNU_TOOL" \
        "printf '                hello\n' | $F_TOOL"

    run_test "4 leading spaces (not enough for tab)" \
        "printf '    hello\n' | $GNU_TOOL" \
        "printf '    hello\n' | $F_TOOL"

    run_test "spaces file" \
        "$GNU_TOOL '$TEST_DATA_DIR/unexpand_spaces.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/unexpand_spaces.txt'"

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "no spaces (passthrough)" \
        "$GNU_TOOL '$TEST_DATA_DIR/unsorted.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/unsorted.txt'"

    run_test "stdin" \
        "printf '        word1        word2\n' | $GNU_TOOL" \
        "printf '        word1        word2\n' | $F_TOOL"

    echo ""
    echo "=== All Spaces (-a) ==="

    run_test "-a convert all spaces" \
        "printf '        word1        word2        word3\n' | $GNU_TOOL -a" \
        "printf '        word1        word2        word3\n' | $F_TOOL -a"

    run_test "-a multi-stop file" \
        "$GNU_TOOL -a '$TEST_DATA_DIR/unexpand_multi_stops.txt'" \
        "$F_TOOL -a '$TEST_DATA_DIR/unexpand_multi_stops.txt'"

    run_test "-a with mixed content" \
        "printf '    four    eight        sixteen\n' | $GNU_TOOL -a" \
        "printf '    four    eight        sixteen\n' | $F_TOOL -a"

    echo ""
    echo "=== Custom Tab Stop (-t N) ==="

    run_test "-t 4" \
        "printf '    hello    world\n' | $GNU_TOOL -t 4" \
        "printf '    hello    world\n' | $F_TOOL -t 4"

    run_test "-t 2" \
        "printf '  hi  there  friend\n' | $GNU_TOOL -t 2" \
        "printf '  hi  there  friend\n' | $F_TOOL -t 2"

    run_test "-t 4 file" \
        "$GNU_TOOL -t 4 '$TEST_DATA_DIR/unexpand_spaces.txt'" \
        "$F_TOOL -t 4 '$TEST_DATA_DIR/unexpand_spaces.txt'"

    echo ""
    echo "=== Tab Stop List (-t N,M,...) ==="

    run_test "-t 4,8,12 (tab stop list)" \
        "printf '    four    eight    twelve  end\n' | $GNU_TOOL -t 4,8,12" \
        "printf '    four    eight    twelve  end\n' | $F_TOOL -t 4,8,12"

    echo ""
    echo "=== First Only (--first-only) ==="

    run_test "--first-only" \
        "printf '        leading        middle        trailing\n' | $GNU_TOOL --first-only" \
        "printf '        leading        middle        trailing\n' | $F_TOOL --first-only"

    echo ""
    echo "=== Edge Cases ==="

    run_test "single space" \
        "printf ' a\n' | $GNU_TOOL" \
        "printf ' a\n' | $F_TOOL"

    run_test "7 spaces (not full tab)" \
        "printf '       x\n' | $GNU_TOOL" \
        "printf '       x\n' | $F_TOOL"

    run_test "9 spaces (tab + 1)" \
        "printf '         x\n' | $GNU_TOOL" \
        "printf '         x\n' | $F_TOOL"

    run_test "only spaces" \
        "printf '        \n' | $GNU_TOOL" \
        "printf '        \n' | $F_TOOL"

    run_test "mixed tabs and spaces" \
        "$GNU_TOOL '$TEST_DATA_DIR/expand_mixed.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/expand_mixed.txt'"

    run_test "no trailing newline" \
        "printf '        hello' | $GNU_TOOL" \
        "printf '        hello' | $F_TOOL"

    echo ""
    echo "=== Line Endings ==="

    run_test "dos endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/dos_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/dos_endings.txt'"

    echo ""
    echo "=== Unicode ==="

    run_test "CJK with leading spaces" \
        "printf '        世界你好\n' | $GNU_TOOL" \
        "printf '        世界你好\n' | $F_TOOL"

    echo ""
    echo "=== Large Files ==="

    if [[ -f "$TEST_DATA_DIR/tabbed_10m.txt" ]]; then
        # Expand then unexpand should be identity-ish
        run_test "large expanded file" \
            "expand '$TEST_DATA_DIR/tabbed_10m.txt' | $GNU_TOOL -a | md5sum" \
            "expand '$TEST_DATA_DIR/tabbed_10m.txt' | $F_TOOL -a | md5sum"
    fi

    echo ""
    echo "=== Multiple Files ==="

    run_test "two files" \
        "$GNU_TOOL '$TEST_DATA_DIR/unexpand_spaces.txt' '$TEST_DATA_DIR/unexpand_multi_stops.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/unexpand_spaces.txt' '$TEST_DATA_DIR/unexpand_multi_stops.txt'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    finish_test_suite
}

run_unexpand_tests
