#!/usr/bin/env bash
# Compatibility tests for ftail vs GNU tail
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "tail")
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
    echo "=== GNU Upstream: Byte Count (tail -c) ==="

    # From tail-c.sh: tail -c on piped input
    run_test "-c3 from pipe (gnu tail-c)" \
        "printf '123456' | $GNU_TOOL -c3" \
        "printf '123456' | $F_TOOL -c3"

    # From tail-c.sh: tail -c with last byte
    run_test "-c -1 last byte from pipe" \
        "printf 'abcdef' | $GNU_TOOL -c -1" \
        "printf 'abcdef' | $F_TOOL -c -1"

    # From tail-c.sh: tail -c on a file with known content
    local tailc_tmp
    tailc_tmp=$(make_temp "abcdefghijklmnopqrstuvwxyz")
    register_temp "$tailc_tmp"
    run_test "-c 5 last 5 bytes of file" \
        "$GNU_TOOL -c 5 '$tailc_tmp'" \
        "$F_TOOL -c 5 '$tailc_tmp'"

    run_test "-c +20 from byte 20 of file" \
        "$GNU_TOOL -c +20 '$tailc_tmp'" \
        "$F_TOOL -c +20 '$tailc_tmp'"

    # Skipped: tail -c on /dev/zero hangs if the implementation reads
    # sequentially instead of seeking, causing CI to stall indefinitely.

    echo ""
    echo "=== GNU Upstream: Start From Middle ==="

    # From start-middle.sh: tail reads from non-beginning of file
    # The test pipes "1\n2\n" and reads first line, then tails the rest
    local mid_tmp
    mid_tmp=$(make_temp_printf '1\n2\n')
    register_temp "$mid_tmp"
    run_test "start-middle: read after seek" \
        "sh -c 'read x; $GNU_TOOL' < '$mid_tmp'" \
        "sh -c 'read x; $F_TOOL' < '$mid_tmp'"

    # Additional start-from-middle cases
    local mid5_tmp
    mid5_tmp=$(make_temp_printf '1\n2\n3\n4\n5\n')
    register_temp "$mid5_tmp"
    run_test "start-middle: tail after reading 2 lines" \
        "sh -c 'read x; read x; $GNU_TOOL' < '$mid5_tmp'" \
        "sh -c 'read x; read x; $F_TOOL' < '$mid5_tmp'"

    echo ""
    echo "=== GNU Upstream: Overlay Headers ==="

    # From overlay-headers.sh: multiple file headers are correctly printed
    local hdr1_tmp
    hdr1_tmp=$(make_temp_printf 'line1\nline2\nline3\n')
    register_temp "$hdr1_tmp"
    local hdr2_tmp
    hdr2_tmp=$(make_temp_printf 'alpha\nbeta\ngamma\n')
    register_temp "$hdr2_tmp"

    run_test "multi-file headers default" \
        "$GNU_TOOL '$hdr1_tmp' '$hdr2_tmp'" \
        "$F_TOOL '$hdr1_tmp' '$hdr2_tmp'"

    run_test "multi-file headers -n1" \
        "$GNU_TOOL -n1 '$hdr1_tmp' '$hdr2_tmp'" \
        "$F_TOOL -n1 '$hdr1_tmp' '$hdr2_tmp'"

    run_test "multi-file headers -q suppressed" \
        "$GNU_TOOL -q '$hdr1_tmp' '$hdr2_tmp'" \
        "$F_TOOL -q '$hdr1_tmp' '$hdr2_tmp'"

    # Three files with empty middle
    local hdr_empty_tmp
    hdr_empty_tmp=$(make_temp "")
    register_temp "$hdr_empty_tmp"
    run_test "multi-file with empty middle file" \
        "$GNU_TOOL '$hdr1_tmp' '$hdr_empty_tmp' '$hdr2_tmp'" \
        "$F_TOOL '$hdr1_tmp' '$hdr_empty_tmp' '$hdr2_tmp'"

    echo ""
    echo "=== GNU Upstream: Symlink Handling ==="

    # From symlink.sh: tail reads through symlinks correctly (non-follow mode)
    local sym_target_tmp
    sym_target_tmp=$(make_temp_printf 'sym_line1\nsym_line2\nsym_line3\nsym_line4\nsym_line5\n')
    register_temp "$sym_target_tmp"
    local sym_link_tmp="/tmp/fcoreutils_symlink_test_$$"
    ln -sf "$sym_target_tmp" "$sym_link_tmp"
    register_temp "$sym_link_tmp"

    run_test "tail through symlink" \
        "$GNU_TOOL '$sym_link_tmp'" \
        "$F_TOOL '$sym_link_tmp'"

    run_test "-n 2 through symlink" \
        "$GNU_TOOL -n 2 '$sym_link_tmp'" \
        "$F_TOOL -n 2 '$sym_link_tmp'"

    run_test "-c 10 through symlink" \
        "$GNU_TOOL -c 10 '$sym_link_tmp'" \
        "$F_TOOL -c 10 '$sym_link_tmp'"

    echo ""
    echo "=== GNU Upstream: Basic Seek ==="

    # From basic-seek.sh: tail -n on a file with many identical lines
    local seek_tmp
    seek_tmp=$(mktemp /tmp/fcoreutils_seek_XXXXXX)
    register_temp "$seek_tmp"
    # Use printf loop instead of `yes | head` to avoid SIGPIPE hang on Windows
    for _ in $(seq 1000); do printf '=================================\n'; done > "$seek_tmp"

    run_test "-n 200 from repeated-line file (seek)" \
        "$GNU_TOOL -n200 '$seek_tmp' | wc -l" \
        "$F_TOOL -n200 '$seek_tmp' | wc -l"

    run_test "-n 200 content from repeated-line file" \
        "$GNU_TOOL -n200 '$seek_tmp'" \
        "$F_TOOL -n200 '$seek_tmp'"

    # Verify tail -n +N on seekable file
    run_test "-n +900 from repeated-line file" \
        "$GNU_TOOL -n +900 '$seek_tmp' | wc -l" \
        "$F_TOOL -n +900 '$seek_tmp' | wc -l"

    echo ""
    echo "=== GNU Upstream: Byte/Line Count Variations (tail.pl) ==="

    # From tail.pl: obs-c3 - last 1 byte
    run_test "gnu obs-c3: -c1 last byte" \
        "printf 'abcd' | $GNU_TOOL -c 1" \
        "printf 'abcd' | $F_TOOL -c 1"

    # From tail.pl: obs-c4 - more bytes than input
    run_test "gnu obs-c4: -c9 on 4-byte input" \
        "printf 'abcd' | $GNU_TOOL -c 9" \
        "printf 'abcd' | $F_TOOL -c 9"

    # From tail.pl: c-2 - tail -c 2 on 'abcd\n'
    run_test "gnu c-2: -c 2 on abcd newline" \
        "printf 'abcd\n' | $GNU_TOOL -c 2" \
        "printf 'abcd\n' | $F_TOOL -c 2"

    # From tail.pl: obs-l1 - last 1 line, single char no newline
    run_test "gnu obs-l1: -n1 single char no newline" \
        "printf 'x' | $GNU_TOOL -n 1" \
        "printf 'x' | $F_TOOL -n 1"

    # From tail.pl: obs-l2 - last 1 line with newlines
    run_test "gnu obs-l2: -n1 on two lines" \
        "printf 'x\ny\n' | $GNU_TOOL -n 1" \
        "printf 'x\ny\n' | $F_TOOL -n 1"

    # From tail.pl: obs-l3 - last 1 line no trailing newline
    run_test "gnu obs-l3: -n1 two lines no trailing newline" \
        "printf 'x\ny' | $GNU_TOOL -n 1" \
        "printf 'x\ny' | $F_TOOL -n 1"

    echo ""
    echo "=== GNU Upstream: Plus-N From Start (tail.pl) ==="

    # From tail.pl: obs-plus-l4 - +1 line, all content
    run_test "gnu obs-plus-l4: -n +1 all content" \
        "printf 'x\ny\n' | $GNU_TOOL -n +1" \
        "printf 'x\ny\n' | $F_TOOL -n +1"

    # From tail.pl: obs-plus-l5 - +2 lines
    run_test "gnu obs-plus-l5: -n +2 from second line" \
        "printf 'x\ny\n' | $GNU_TOOL -n +2" \
        "printf 'x\ny\n' | $F_TOOL -n +2"

    # From tail.pl: obs-plus-c1 - +2 bytes
    run_test "gnu obs-plus-c1: -c +2 from second byte" \
        "printf 'abcd' | $GNU_TOOL -c +2" \
        "printf 'abcd' | $F_TOOL -c +2"

    # From tail.pl: obs-plus-c2 - +8 bytes on 4-byte input (empty output)
    run_test "gnu obs-plus-c2: -c +8 beyond input" \
        "printf 'abcd' | $GNU_TOOL -c +8" \
        "printf 'abcd' | $F_TOOL -c +8"

    echo ""
    echo "=== GNU Upstream: Zero and Negative Line Counts (tail.pl) ==="

    # From tail.pl: n-4 - +0 is synonym for +1 (all lines)
    run_test "gnu n-4: -n +0 synonym for +1" \
        "printf 'y\ny\ny\ny\ny\n' | $GNU_TOOL -n +0" \
        "printf 'y\ny\ny\ny\ny\n' | $F_TOOL -n +0"

    # From tail.pl: n-5 - -0 outputs nothing
    run_test "gnu n-5: -n -0 outputs nothing" \
        "printf 'y\ny\ny\ny\ny\n' | $GNU_TOOL -n -0" \
        "printf 'y\ny\ny\ny\ny\n' | $F_TOOL -n -0"

    # From tail.pl: n-5a - -1 outputs last line
    run_test "gnu n-5a: -n -1 last line only" \
        "printf 'y\ny\ny\ny\ny\n' | $GNU_TOOL -n -1" \
        "printf 'y\ny\ny\ny\ny\n' | $F_TOOL -n -1"

    # From tail.pl: n-5b - 0 same as -0 (nothing)
    run_test "gnu n-5b: -n 0 outputs nothing" \
        "printf 'y\ny\ny\ny\ny\n' | $GNU_TOOL -n 0" \
        "printf 'y\ny\ny\ny\ny\n' | $F_TOOL -n 0"

    echo ""
    echo "=== GNU Upstream: N-Lines with Many Lines (tail.pl) ==="

    # From tail.pl: n-1 - default 10 lines on 12 lines of input
    run_test "gnu n-1: -n 10 on 12-line input" \
        "printf 'x\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\nz' | $GNU_TOOL -n 10" \
        "printf 'x\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\nz' | $F_TOOL -n 10"

    # From tail.pl: n-2 - explicit -n -10
    run_test "gnu n-2: -n -10 same as -n 10" \
        "printf 'x\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\nz' | $GNU_TOOL -n -10" \
        "printf 'x\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\nz' | $F_TOOL -n -10"

    # From tail.pl: n-3 - +10 from 10th line
    run_test "gnu n-3: -n +10 from 10th line" \
        "printf 'x\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\nz' | $GNU_TOOL -n +10" \
        "printf 'x\ny\ny\ny\ny\ny\ny\ny\ny\ny\ny\nz' | $F_TOOL -n +10"

    echo ""
    echo "=== GNU Upstream: Zero-Terminated (tail.pl) ==="

    # From tail.pl: zero-1 - -z -n 1 with NUL separator
    run_test "gnu zero-1: -z -n 1 last NUL-delimited record" \
        "printf 'x\0y' | $GNU_TOOL -z -n 1" \
        "printf 'x\0y' | $F_TOOL -z -n 1"

    # From tail.pl: zero-2 - -z -n 2 with NUL separator
    run_test "gnu zero-2: -z -n 2 both NUL-delimited records" \
        "printf 'x\0y' | $GNU_TOOL -z -n 2" \
        "printf 'x\0y' | $F_TOOL -z -n 2"

    echo ""
    echo "=== GNU Upstream: Large Byte Counts (tail.pl) ==="

    # From tail.pl: big-c - very large byte count should not error
    run_test "gnu big-c: -c with huge number" \
        "printf '' | $GNU_TOOL -c 99999999999999999999" \
        "printf '' | $F_TOOL -c 99999999999999999999"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"


    finish_test_suite
}

run_tail_tests
