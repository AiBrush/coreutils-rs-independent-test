#!/usr/bin/env bash
# Compatibility tests for fpaste vs GNU paste
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="paste"
F_TOOL="fpaste"

run_paste_tests() {
    init_test_suite "paste"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"paste","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/paste_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU paste not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Paste (default tab delimiter) ==="

    run_test "two files" \
        "$GNU_TOOL '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'"

    run_test "three files" \
        "$GNU_TOOL '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt' '$TEST_DATA_DIR/paste_file3.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt' '$TEST_DATA_DIR/paste_file3.txt'"

    run_test "single file" \
        "$GNU_TOOL '$TEST_DATA_DIR/paste_file1.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/paste_file1.txt'"

    run_test "unequal length files" \
        "$GNU_TOOL '$TEST_DATA_DIR/paste_short.txt' '$TEST_DATA_DIR/paste_long.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/paste_short.txt' '$TEST_DATA_DIR/paste_long.txt'"

    run_test "unequal reversed" \
        "$GNU_TOOL '$TEST_DATA_DIR/paste_long.txt' '$TEST_DATA_DIR/paste_short.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/paste_long.txt' '$TEST_DATA_DIR/paste_short.txt'"

    run_test "empty file with non-empty" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/paste_file1.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/paste_file1.txt'"

    run_test "two empty files" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt' '$TEST_DATA_DIR/empty.txt'"

    echo ""
    echo "=== Custom Delimiter (-d) ==="

    run_test "-d comma" \
        "$GNU_TOOL -d, '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'" \
        "$F_TOOL -d, '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'"

    run_test "-d colon" \
        "$GNU_TOOL -d: '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'" \
        "$F_TOOL -d: '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'"

    run_test "-d pipe" \
        "$GNU_TOOL -d'|' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'" \
        "$F_TOOL -d'|' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'"

    run_test "-d space" \
        "$GNU_TOOL -d' ' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'" \
        "$F_TOOL -d' ' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'"

    run_test "-d empty (no delimiter)" \
        "$GNU_TOOL -d '' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'" \
        "$F_TOOL -d '' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'"

    echo ""
    echo "=== Multi-Character Delimiter (rotating) ==="

    run_test "-d ',;:' rotating delimiters" \
        "$GNU_TOOL -d ',;:' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt' '$TEST_DATA_DIR/paste_file3.txt' '$TEST_DATA_DIR/paste_short.txt'" \
        "$F_TOOL -d ',;:' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt' '$TEST_DATA_DIR/paste_file3.txt' '$TEST_DATA_DIR/paste_short.txt'"

    echo ""
    echo "=== Serial Mode (-s) ==="

    run_test "-s single file" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/paste_file1.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/paste_file1.txt'"

    run_test "-s two files" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'"

    run_test "-s three files" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt' '$TEST_DATA_DIR/paste_file3.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt' '$TEST_DATA_DIR/paste_file3.txt'"

    run_test "-s -d comma" \
        "$GNU_TOOL -s -d, '$TEST_DATA_DIR/paste_file1.txt'" \
        "$F_TOOL -s -d, '$TEST_DATA_DIR/paste_file1.txt'"

    run_test "-s empty file" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/empty.txt'"

    run_test "-s single line file" \
        "$GNU_TOOL -s '$TEST_DATA_DIR/with_trailing_newline.txt'" \
        "$F_TOOL -s '$TEST_DATA_DIR/with_trailing_newline.txt'"

    echo ""
    echo "=== Stdin (-) ==="

    run_test "stdin as one input" \
        "printf 'X\nY\nZ\n' | $GNU_TOOL - '$TEST_DATA_DIR/paste_file2.txt'" \
        "printf 'X\nY\nZ\n' | $F_TOOL - '$TEST_DATA_DIR/paste_file2.txt'"

    run_test "stdin twice (split lines)" \
        "printf '1\n2\n3\n4\n5\n6\n' | $GNU_TOOL - -" \
        "printf '1\n2\n3\n4\n5\n6\n' | $F_TOOL - -"

    run_test "stdin three times" \
        "printf '1\n2\n3\n4\n5\n6\n7\n8\n9\n' | $GNU_TOOL - - -" \
        "printf '1\n2\n3\n4\n5\n6\n7\n8\n9\n' | $F_TOOL - - -"

    run_test "stdin + file + stdin" \
        "printf 'a\nb\nc\nd\ne\n' | $GNU_TOOL - '$TEST_DATA_DIR/paste_file2.txt' -" \
        "printf 'a\nb\nc\nd\ne\n' | $F_TOOL - '$TEST_DATA_DIR/paste_file2.txt' -"

    echo ""
    echo "=== Delimiter Edge Cases ==="

    run_test "-d with newline escape" \
        "$GNU_TOOL -d '\n' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'" \
        "$F_TOOL -d '\n' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'"

    run_test "-d with tab escape" \
        "$GNU_TOOL -d '\t' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'" \
        "$F_TOOL -d '\t' '$TEST_DATA_DIR/paste_file1.txt' '$TEST_DATA_DIR/paste_file2.txt'"

    echo ""
    echo "=== Line Endings ==="

    run_test "dos endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/dos_endings.txt' '$TEST_DATA_DIR/unix_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/dos_endings.txt' '$TEST_DATA_DIR/unix_endings.txt'"

    echo ""
    echo "=== Unicode ==="

    run_test "CJK text" \
        "printf 'hello\nworld\n' | $GNU_TOOL - '$TEST_DATA_DIR/cjk.txt'" \
        "printf 'hello\nworld\n' | $F_TOOL - '$TEST_DATA_DIR/cjk.txt'"

    echo ""
    echo "=== Large Files ==="

    if [[ -f "$TEST_DATA_DIR/paste_bench_col1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/paste_bench_col2_10m.txt" ]]; then
        run_test "two 10MB files" \
            "$GNU_TOOL '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt' | md5sum" \
            "$F_TOOL '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt' | md5sum"
    fi

    echo ""
    echo "=== No Trailing Newline ==="

    run_test "file without trailing newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt' '$TEST_DATA_DIR/with_trailing_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/no_trailing_newline.txt' '$TEST_DATA_DIR/with_trailing_newline.txt'"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"

    finish_test_suite
}

run_paste_tests
