#!/usr/bin/env bash
# Compatibility tests for ftee vs GNU tee
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="tee"
F_TOOL="ftee"

run_tee_tests() {
    init_test_suite "tee"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"tee","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/tee_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU tee not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_tee_test_XXXXXX)
    register_temp "$WORK_DIR"

    echo ""
    echo "=== Basic Tee (stdout + file) ==="

    run_test "tee to single file" \
        "printf 'hello world\n' | $GNU_TOOL '$WORK_DIR/gnu_out1.txt' && cat '$WORK_DIR/gnu_out1.txt'" \
        "printf 'hello world\n' | $F_TOOL '$WORK_DIR/f_out1.txt' && cat '$WORK_DIR/f_out1.txt'"

    run_test "stdout passthrough" \
        "printf 'passthrough\n' | $GNU_TOOL '$WORK_DIR/gnu_pass.txt'" \
        "printf 'passthrough\n' | $F_TOOL '$WORK_DIR/f_pass.txt'"

    run_test "multiline input" \
        "printf 'line1\nline2\nline3\n' | $GNU_TOOL '$WORK_DIR/gnu_multi.txt' && cat '$WORK_DIR/gnu_multi.txt'" \
        "printf 'line1\nline2\nline3\n' | $F_TOOL '$WORK_DIR/f_multi.txt' && cat '$WORK_DIR/f_multi.txt'"

    run_test "empty input" \
        "printf '' | $GNU_TOOL '$WORK_DIR/gnu_empty.txt' && cat '$WORK_DIR/gnu_empty.txt' && stat -c '%s' '$WORK_DIR/gnu_empty.txt'" \
        "printf '' | $F_TOOL '$WORK_DIR/f_empty.txt' && cat '$WORK_DIR/f_empty.txt' && stat -c '%s' '$WORK_DIR/f_empty.txt'"

    echo ""
    echo "=== Multiple Output Files ==="

    run_test "tee to two files" \
        "printf 'two files\n' | $GNU_TOOL '$WORK_DIR/gnu_two1.txt' '$WORK_DIR/gnu_two2.txt' && cat '$WORK_DIR/gnu_two1.txt' '$WORK_DIR/gnu_two2.txt'" \
        "printf 'two files\n' | $F_TOOL '$WORK_DIR/f_two1.txt' '$WORK_DIR/f_two2.txt' && cat '$WORK_DIR/f_two1.txt' '$WORK_DIR/f_two2.txt'"

    run_test "tee to three files" \
        "printf 'three\n' | $GNU_TOOL '$WORK_DIR/gnu_t1.txt' '$WORK_DIR/gnu_t2.txt' '$WORK_DIR/gnu_t3.txt' && cat '$WORK_DIR/gnu_t1.txt' '$WORK_DIR/gnu_t2.txt' '$WORK_DIR/gnu_t3.txt'" \
        "printf 'three\n' | $F_TOOL '$WORK_DIR/f_t1.txt' '$WORK_DIR/f_t2.txt' '$WORK_DIR/f_t3.txt' && cat '$WORK_DIR/f_t1.txt' '$WORK_DIR/f_t2.txt' '$WORK_DIR/f_t3.txt'"

    echo ""
    echo "=== Append Mode (-a) ==="

    run_test "-a append to existing file" \
        "printf 'first\n' > '$WORK_DIR/gnu_append.txt' && printf 'second\n' | $GNU_TOOL -a '$WORK_DIR/gnu_append.txt' > /dev/null && cat '$WORK_DIR/gnu_append.txt'" \
        "printf 'first\n' > '$WORK_DIR/f_append.txt' && printf 'second\n' | $F_TOOL -a '$WORK_DIR/f_append.txt' > /dev/null && cat '$WORK_DIR/f_append.txt'"

    run_test "-a to new file" \
        "printf 'new\n' | $GNU_TOOL -a '$WORK_DIR/gnu_anew.txt' > /dev/null && cat '$WORK_DIR/gnu_anew.txt'" \
        "printf 'new\n' | $F_TOOL -a '$WORK_DIR/f_anew.txt' > /dev/null && cat '$WORK_DIR/f_anew.txt'"

    run_test "-a multiple appends" \
        "printf 'line1\n' | $GNU_TOOL -a '$WORK_DIR/gnu_ma.txt' > /dev/null && printf 'line2\n' | $GNU_TOOL -a '$WORK_DIR/gnu_ma.txt' > /dev/null && printf 'line3\n' | $GNU_TOOL -a '$WORK_DIR/gnu_ma.txt' > /dev/null && cat '$WORK_DIR/gnu_ma.txt'" \
        "printf 'line1\n' | $F_TOOL -a '$WORK_DIR/f_ma.txt' > /dev/null && printf 'line2\n' | $F_TOOL -a '$WORK_DIR/f_ma.txt' > /dev/null && printf 'line3\n' | $F_TOOL -a '$WORK_DIR/f_ma.txt' > /dev/null && cat '$WORK_DIR/f_ma.txt'"

    echo ""
    echo "=== No Files (stdout only) ==="

    run_test "no file args - pure passthrough" \
        "printf 'just stdout\n' | $GNU_TOOL" \
        "printf 'just stdout\n' | $F_TOOL"

    echo ""
    echo "=== Binary Data ==="

    run_test "binary data passthrough" \
        "printf '\x00\x01\x02\xff' | $GNU_TOOL '$WORK_DIR/gnu_bin.txt' | od -A x -t x1z && od -A x -t x1z '$WORK_DIR/gnu_bin.txt'" \
        "printf '\x00\x01\x02\xff' | $F_TOOL '$WORK_DIR/f_bin.txt' | od -A x -t x1z && od -A x -t x1z '$WORK_DIR/f_bin.txt'"

    echo ""
    echo "=== Large Data ==="

    # Strip filenames from md5sum output to avoid false diff on gnu_/f_ prefix
    run_test "large input checksum" \
        "cat '$TEST_DATA_DIR/text_1m.txt' | $GNU_TOOL '$WORK_DIR/gnu_large.txt' | md5sum | cut -d' ' -f1 && md5sum '$WORK_DIR/gnu_large.txt' | cut -d' ' -f1" \
        "cat '$TEST_DATA_DIR/text_1m.txt' | $F_TOOL '$WORK_DIR/f_large.txt' | md5sum | cut -d' ' -f1 && md5sum '$WORK_DIR/f_large.txt' | cut -d' ' -f1"

    echo ""
    echo "=== Unicode ==="

    run_test "unicode passthrough" \
        "printf '日本語テスト\n' | $GNU_TOOL '$WORK_DIR/gnu_unicode.txt' && cat '$WORK_DIR/gnu_unicode.txt'" \
        "printf '日本語テスト\n' | $F_TOOL '$WORK_DIR/f_unicode.txt' && cat '$WORK_DIR/f_unicode.txt'"

    echo ""
    echo "=== Error Handling ==="

    run_stdout_test "nonexistent directory (partial success)" \
        "printf 'data\n' | $GNU_TOOL '/nonexistent_$$/file.txt' '$WORK_DIR/gnu_partial.txt' 2>/dev/null; cat '$WORK_DIR/gnu_partial.txt' 2>/dev/null || true" \
        "printf 'data\n' | $F_TOOL '/nonexistent_$$/file.txt' '$WORK_DIR/f_partial.txt' 2>/dev/null; cat '$WORK_DIR/f_partial.txt' 2>/dev/null || true"

    echo ""
    echo "=== Pipe Chain ==="

    run_test "tee in pipeline" \
        "printf 'a\nb\nc\nd\ne\n' | $GNU_TOOL '$WORK_DIR/gnu_pipe.txt' | wc -l && cat '$WORK_DIR/gnu_pipe.txt'" \
        "printf 'a\nb\nc\nd\ne\n' | $F_TOOL '$WORK_DIR/f_pipe.txt' | wc -l && cat '$WORK_DIR/f_pipe.txt'"

    # Clean up
    rm -rf "$WORK_DIR"

    finish_test_suite
}

run_tee_tests
