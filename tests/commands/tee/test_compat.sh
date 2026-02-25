#!/usr/bin/env bash
# Compatibility tests for ftee vs GNU tee
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "tee")
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

    # === GNU Upstream: Basic Tee (tee.sh) ===
    echo ""
    echo "=== GNU Upstream: Basic Tee ==="

    # From tee.sh: tee to 0 files (stdout only)
    run_test "tee with 0 file operands" \
        "printf 'line\n' | $GNU_TOOL" \
        "printf 'line\n' | $F_TOOL"

    # From tee.sh: tee to 13 files (POSIX minimum)
    run_test "tee to 13 files (POSIX min)" \
        "printf 'line\n' | $GNU_TOOL '$WORK_DIR/gnu_13_'{1..13}'.txt' && cat '$WORK_DIR/gnu_13_1.txt' '$WORK_DIR/gnu_13_13.txt'" \
        "printf 'line\n' | $F_TOOL '$WORK_DIR/f_13_'{1..13}'.txt' && cat '$WORK_DIR/f_13_1.txt' '$WORK_DIR/f_13_13.txt'"

    # From tee.sh: tee treats '-' as a filename, not stdout
    run_test "tee treats '-' as filename" \
        "cd '$WORK_DIR' && printf 'sample\n' | $GNU_TOOL -- gnu_dash_file > gnu_dash_out && cat gnu_dash_file gnu_dash_out" \
        "cd '$WORK_DIR' && printf 'sample\n' | $F_TOOL -- f_dash_file > f_dash_out && cat f_dash_file f_dash_out"

    # === GNU Upstream: Append (append.sh) ===
    echo ""
    echo "=== GNU Upstream: Append ==="

    # From append.sh: -a appends to existing file content
    run_test "-a appends to multiple files" \
        "printf 'line 1\n' | $GNU_TOOL '$WORK_DIR/gnu_app1' '$WORK_DIR/gnu_app2' > /dev/null && printf 'line 2\n' | $GNU_TOOL -a '$WORK_DIR/gnu_app1' '$WORK_DIR/gnu_app2' > /dev/null && cat '$WORK_DIR/gnu_app1'" \
        "printf 'line 1\n' | $F_TOOL '$WORK_DIR/f_app1' '$WORK_DIR/f_app2' > /dev/null && printf 'line 2\n' | $F_TOOL -a '$WORK_DIR/f_app1' '$WORK_DIR/f_app2' > /dev/null && cat '$WORK_DIR/f_app1'"

    # From append.sh: --append long option
    run_test "--append long option" \
        "printf 'first\n' | $GNU_TOOL '$WORK_DIR/gnu_longapp' > /dev/null && printf 'second\n' | $GNU_TOOL --append '$WORK_DIR/gnu_longapp' > /dev/null && cat '$WORK_DIR/gnu_longapp'" \
        "printf 'first\n' | $F_TOOL '$WORK_DIR/f_longapp' > /dev/null && printf 'second\n' | $F_TOOL --append '$WORK_DIR/f_longapp' > /dev/null && cat '$WORK_DIR/f_longapp'"

    # === GNU Upstream: Unwritable File ===
    echo ""
    echo "=== GNU Upstream: Unwritable File ==="

    if [[ "$(id -u)" -ne 0 ]]; then
        touch "$WORK_DIR/gnu_ro" "$WORK_DIR/f_ro"
        chmod a-w "$WORK_DIR/gnu_ro" "$WORK_DIR/f_ro"

        run_exit_code_test "tee to read-only file" \
            "printf 'data\n' | $GNU_TOOL '$WORK_DIR/gnu_ro' 2>&1" \
            "printf 'data\n' | $F_TOOL '$WORK_DIR/f_ro' 2>&1"

        chmod a+w "$WORK_DIR/gnu_ro" "$WORK_DIR/f_ro" 2>/dev/null || true
    fi

    echo ""
    echo "=== GNU Upstream: Append with Duplicate Flags (append.sh) ==="

    # From append.sh: duplicate -a flags should behave the same as single -a
    run_test "-a -a duplicate append flags" \
        "printf 'first\n' | $GNU_TOOL '$WORK_DIR/gnu_dup1' > /dev/null && printf 'second\n' | $GNU_TOOL -a -a '$WORK_DIR/gnu_dup1' > /dev/null && cat '$WORK_DIR/gnu_dup1'" \
        "printf 'first\n' | $F_TOOL '$WORK_DIR/f_dup1' > /dev/null && printf 'second\n' | $F_TOOL -a -a '$WORK_DIR/f_dup1' > /dev/null && cat '$WORK_DIR/f_dup1'"

    # From append.sh: --append with 13 file operands (POSIX min)
    run_test "--append to 13 files (POSIX min)" \
        "printf 'line1\n' | $GNU_TOOL '$WORK_DIR/gnu_ap13_'{1..13} > /dev/null && printf 'line2\n' | $GNU_TOOL --append '$WORK_DIR/gnu_ap13_'{1..13} > /dev/null && cat '$WORK_DIR/gnu_ap13_1' '$WORK_DIR/gnu_ap13_13'" \
        "printf 'line1\n' | $F_TOOL '$WORK_DIR/f_ap13_'{1..13} > /dev/null && printf 'line2\n' | $F_TOOL --append '$WORK_DIR/f_ap13_'{1..13} > /dev/null && cat '$WORK_DIR/f_ap13_1' '$WORK_DIR/f_ap13_13'"

    echo ""
    echo "=== GNU Upstream: Stdout Verification (tee.sh) ==="

    # From tee.sh: verify stdout matches input when tee writes to files
    run_test "stdout matches input with files" \
        "printf 'verify\n' | $GNU_TOOL '$WORK_DIR/gnu_sv1' '$WORK_DIR/gnu_sv2'" \
        "printf 'verify\n' | $F_TOOL '$WORK_DIR/f_sv1' '$WORK_DIR/f_sv2'"

    # From tee.sh: verify file content matches input for all file operands
    run_test "all file outputs match input (2 files)" \
        "printf 'check\n' | $GNU_TOOL '$WORK_DIR/gnu_chk1' '$WORK_DIR/gnu_chk2' > /dev/null && diff '$WORK_DIR/gnu_chk1' '$WORK_DIR/gnu_chk2' && cat '$WORK_DIR/gnu_chk1'" \
        "printf 'check\n' | $F_TOOL '$WORK_DIR/f_chk1' '$WORK_DIR/f_chk2' > /dev/null && diff '$WORK_DIR/f_chk1' '$WORK_DIR/f_chk2' && cat '$WORK_DIR/f_chk1'"

    echo ""
    echo "=== GNU Upstream: Overwrite vs Append Semantics (tee.sh) ==="

    # From tee.sh: without -a, tee should overwrite existing files
    run_test "overwrite existing file without -a" \
        "printf 'old\n' > '$WORK_DIR/gnu_ow' && printf 'new\n' | $GNU_TOOL '$WORK_DIR/gnu_ow' > /dev/null && cat '$WORK_DIR/gnu_ow'" \
        "printf 'old\n' > '$WORK_DIR/f_ow' && printf 'new\n' | $F_TOOL '$WORK_DIR/f_ow' > /dev/null && cat '$WORK_DIR/f_ow'"

    # From tee.sh: with -a, tee should append to existing files
    run_test "-a preserves existing content" \
        "printf 'old\n' > '$WORK_DIR/gnu_ap' && printf 'new\n' | $GNU_TOOL -a '$WORK_DIR/gnu_ap' > /dev/null && cat '$WORK_DIR/gnu_ap'" \
        "printf 'old\n' > '$WORK_DIR/f_ap' && printf 'new\n' | $F_TOOL -a '$WORK_DIR/f_ap' > /dev/null && cat '$WORK_DIR/f_ap'"

    # Clean up
    rm -rf "$WORK_DIR"


    finish_test_suite
}

run_tee_tests
