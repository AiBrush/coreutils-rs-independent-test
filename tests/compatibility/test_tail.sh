#!/usr/bin/env bash
# Compatibility tests for ftail vs GNU tail
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tail"
F_TOOL="ftail"

run_tail_tests() {
    init_test_suite "tail"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tail","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tail_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU tail not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Default (last 10 lines) ==="

    run_test "default 100-line file" \
        "$GNU_TOOL '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "default on short file (5 lines)" \
        "$GNU_TOOL '$TEST_DATA_DIR/tac_simple.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/tac_simple.txt'"

    run_test "default on empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "default on single line with newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/with_trailing_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/with_trailing_newline.txt'"

    run_test "default on single line no newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt'"

    run_test "default via stdin" \
        "printf 'a\nb\nc\nd\ne\nf\ng\nh\ni\nj\nk\nl\n' | $GNU_TOOL" \
        "printf 'a\nb\nc\nd\ne\nf\ng\nh\ni\nj\nk\nl\n' | $F_TOOL"

    echo ""
    echo "=== Line Count (-n N) ==="

    run_test "-n 1 (last line)" \
        "$GNU_TOOL -n 1 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -n 1 '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-n 5" \
        "$GNU_TOOL -n 5 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -n 5 '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-n 50" \
        "$GNU_TOOL -n 50 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -n 50 '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-n 100 (all lines)" \
        "$GNU_TOOL -n 100 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -n 100 '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-n 200 (more than file)" \
        "$GNU_TOOL -n 200 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -n 200 '$TEST_DATA_DIR/numbered_100.txt'"

    echo ""
    echo "=== From Start (+N: -n +N) ==="

    run_test "-n +1 (from first line, all)" \
        "$GNU_TOOL -n +1 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -n +1 '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-n +50 (from line 50)" \
        "$GNU_TOOL -n +50 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -n +50 '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-n +100 (from last line)" \
        "$GNU_TOOL -n +100 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -n +100 '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-n +200 (beyond file)" \
        "$GNU_TOOL -n +200 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -n +200 '$TEST_DATA_DIR/numbered_100.txt'"

    echo ""
    echo "=== Byte Count (-c N) ==="

    run_test "-c 10 (last 10 bytes)" \
        "$GNU_TOOL -c 10 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -c 10 '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-c 1 (last byte)" \
        "$GNU_TOOL -c 1 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -c 1 '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-c 100000 (more than file)" \
        "$GNU_TOOL -c 100000 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -c 100000 '$TEST_DATA_DIR/numbered_100.txt'"

    echo ""
    echo "=== From Start Byte (+N: -c +N) ==="

    run_test "-c +1 (from start)" \
        "$GNU_TOOL -c +1 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -c +1 '$TEST_DATA_DIR/numbered_100.txt'"

    run_test "-c +100 (from byte 100)" \
        "$GNU_TOOL -c +100 '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -c +100 '$TEST_DATA_DIR/numbered_100.txt'"

    echo ""
    echo "=== Multiple Files ==="

    run_test "two files (headers)" \
        "$GNU_TOOL '$TEST_DATA_DIR/numbered_100.txt' '$TEST_DATA_DIR/tac_simple.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/numbered_100.txt' '$TEST_DATA_DIR/tac_simple.txt'"

    run_test "three files" \
        "$GNU_TOOL '$TEST_DATA_DIR/numbered_100.txt' '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/tac_simple.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/numbered_100.txt' '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/tac_simple.txt'"

    run_test "-n 3 multiple files" \
        "$GNU_TOOL -n 3 '$TEST_DATA_DIR/numbered_100.txt' '$TEST_DATA_DIR/tac_simple.txt'" \
        "$F_TOOL -n 3 '$TEST_DATA_DIR/numbered_100.txt' '$TEST_DATA_DIR/tac_simple.txt'"

    echo ""
    echo "=== Quiet Mode (-q) ==="

    run_test "-q multiple files (no headers)" \
        "$GNU_TOOL -q '$TEST_DATA_DIR/numbered_100.txt' '$TEST_DATA_DIR/tac_simple.txt'" \
        "$F_TOOL -q '$TEST_DATA_DIR/numbered_100.txt' '$TEST_DATA_DIR/tac_simple.txt'"

    echo ""
    echo "=== Verbose Mode (-v) ==="

    run_test "-v single file (force header)" \
        "$GNU_TOOL -v '$TEST_DATA_DIR/numbered_100.txt'" \
        "$F_TOOL -v '$TEST_DATA_DIR/numbered_100.txt'"

    echo ""
    echo "=== Line Endings ==="

    run_test "unix endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/unix_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/unix_endings.txt'"

    run_test "dos endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/dos_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/dos_endings.txt'"

    run_test "mixed endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/mixed_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/mixed_endings.txt'"

    echo ""
    echo "=== Unicode / Multibyte ==="

    run_test "CJK text" \
        "$GNU_TOOL '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/cjk.txt'"

    run_test "emoji" \
        "$GNU_TOOL '$TEST_DATA_DIR/emoji.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/emoji.txt'"

    echo ""
    echo "=== Binary Data ==="

    run_test "binary with nulls" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/text_with_nulls.txt'"

    run_test "-c 50 binary file" \
        "$GNU_TOOL -c 50 '$TEST_DATA_DIR/random_1k.bin'" \
        "$F_TOOL -c 50 '$TEST_DATA_DIR/random_1k.bin'"

    echo ""
    echo "=== Long Lines ==="

    run_test "10KB line" \
        "$GNU_TOOL '$TEST_DATA_DIR/long_line_10k.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/long_line_10k.txt'"

    echo ""
    echo "=== Large Files ==="

    run_test "10MB file default" \
        "$GNU_TOOL '$TEST_DATA_DIR/text_10m.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/text_10m.txt' | md5sum"

    run_test "-n 1000 large file" \
        "$GNU_TOOL -n 1000 '$TEST_DATA_DIR/text_10m.txt' | md5sum" \
        "$F_TOOL -n 1000 '$TEST_DATA_DIR/text_10m.txt' | md5sum"

    run_test "-c 1000000 large file" \
        "$GNU_TOOL -c 1000000 '$TEST_DATA_DIR/text_10m.txt' | md5sum" \
        "$F_TOOL -c 1000000 '$TEST_DATA_DIR/text_10m.txt' | md5sum"

    run_test "-n +100000 large file" \
        "$GNU_TOOL -n +100000 '$TEST_DATA_DIR/text_10m.txt' | md5sum" \
        "$F_TOOL -n +100000 '$TEST_DATA_DIR/text_10m.txt' | md5sum"

    echo ""
    echo "=== Edge Cases ==="

    run_test "only newlines" \
        "$GNU_TOOL '$TEST_DATA_DIR/only_newlines.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/only_newlines.txt'"

    run_test "single newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/single_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/single_newline.txt'"

    run_test "whitespace only" \
        "$GNU_TOOL '$TEST_DATA_DIR/whitespace_only.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/whitespace_only.txt'"

    echo ""
    echo "=== Stdin ==="

    run_test "stdin pipe" \
        "cat '$TEST_DATA_DIR/numbered_100.txt' | $GNU_TOOL -n 5" \
        "cat '$TEST_DATA_DIR/numbered_100.txt' | $F_TOOL -n 5"

    run_test "stdin -c" \
        "cat '$TEST_DATA_DIR/numbered_100.txt' | $GNU_TOOL -c 50" \
        "cat '$TEST_DATA_DIR/numbered_100.txt' | $F_TOOL -c 50"

    run_test "stdin -n +" \
        "cat '$TEST_DATA_DIR/numbered_100.txt' | $GNU_TOOL -n +90" \
        "cat '$TEST_DATA_DIR/numbered_100.txt' | $F_TOOL -n +90"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    finish_test_suite
}

run_tail_tests
