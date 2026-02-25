#!/usr/bin/env bash
# Compatibility tests for ffold vs GNU fold
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "fold")
F_TOOL="ffold"

run_fold_tests() {
    init_test_suite "fold"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"fold","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/fold_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU fold not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Folding (default width 80) ==="

    run_test "long line (200 chars)" \
        "$GNU_TOOL '$TEST_DATA_DIR/fold_long_line.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/fold_long_line.txt'"

    run_test "short lines (no folding)" \
        "$GNU_TOOL '$TEST_DATA_DIR/fold_short.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/fold_short.txt'"

    run_test "empty file" \
        "$GNU_TOOL '$TEST_DATA_DIR/empty.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/empty.txt'"

    run_test "stdin" \
        "printf 'This is a long line that should be folded at eighty characters which is the default width setting for the fold command\n' | $GNU_TOOL" \
        "printf 'This is a long line that should be folded at eighty characters which is the default width setting for the fold command\n' | $F_TOOL"

    run_test "no trailing newline" \
        "printf 'short' | $GNU_TOOL" \
        "printf 'short' | $F_TOOL"

    echo ""
    echo "=== Custom Width (-w N) ==="

    run_test "-w 20" \
        "$GNU_TOOL -w 20 '$TEST_DATA_DIR/fold_long_line.txt'" \
        "$F_TOOL -w 20 '$TEST_DATA_DIR/fold_long_line.txt'"

    run_test "-w 40" \
        "$GNU_TOOL -w 40 '$TEST_DATA_DIR/fold_words.txt'" \
        "$F_TOOL -w 40 '$TEST_DATA_DIR/fold_words.txt'"

    run_test "-w 10" \
        "printf 'abcdefghijklmnopqrstuvwxyz\n' | $GNU_TOOL -w 10" \
        "printf 'abcdefghijklmnopqrstuvwxyz\n' | $F_TOOL -w 10"

    run_test "-w 1 (every char)" \
        "printf 'abcdef\n' | $GNU_TOOL -w 1" \
        "printf 'abcdef\n' | $F_TOOL -w 1"

    run_test "-w 5" \
        "$GNU_TOOL -w 5 '$TEST_DATA_DIR/fold_alphabet.txt'" \
        "$F_TOOL -w 5 '$TEST_DATA_DIR/fold_alphabet.txt'"

    run_test "-w 200 (wider than line)" \
        "$GNU_TOOL -w 200 '$TEST_DATA_DIR/fold_long_line.txt'" \
        "$F_TOOL -w 200 '$TEST_DATA_DIR/fold_long_line.txt'"

    echo ""
    echo "=== Break at Spaces (-s) ==="

    run_test "-s -w 20 (break at words)" \
        "$GNU_TOOL -s -w 20 '$TEST_DATA_DIR/fold_words.txt'" \
        "$F_TOOL -s -w 20 '$TEST_DATA_DIR/fold_words.txt'"

    run_test "-s -w 40 (break at words)" \
        "$GNU_TOOL -s -w 40 '$TEST_DATA_DIR/fold_words.txt'" \
        "$F_TOOL -s -w 40 '$TEST_DATA_DIR/fold_words.txt'"

    run_test "-s -w 10" \
        "printf 'the quick brown fox jumps over the lazy dog\n' | $GNU_TOOL -s -w 10" \
        "printf 'the quick brown fox jumps over the lazy dog\n' | $F_TOOL -s -w 10"

    run_test "-s -w 15" \
        "printf 'one two three four five six seven eight nine ten\n' | $GNU_TOOL -s -w 15" \
        "printf 'one two three four five six seven eight nine ten\n' | $F_TOOL -s -w 15"

    run_test "-s word longer than width" \
        "printf 'superlongwordthatcannotbreak short\n' | $GNU_TOOL -s -w 10" \
        "printf 'superlongwordthatcannotbreak short\n' | $F_TOOL -s -w 10"

    run_test "-s no spaces in line" \
        "printf 'abcdefghijklmnopqrstuvwxyz\n' | $GNU_TOOL -s -w 10" \
        "printf 'abcdefghijklmnopqrstuvwxyz\n' | $F_TOOL -s -w 10"

    run_test "-s multiple spaces" \
        "printf 'word1   word2   word3   word4\n' | $GNU_TOOL -s -w 12" \
        "printf 'word1   word2   word3   word4\n' | $F_TOOL -s -w 12"

    echo ""
    echo "=== Byte Count (-b) ==="

    run_test "-b -w 10" \
        "printf 'abcdefghijklmnopqrstuvwxyz\n' | $GNU_TOOL -b -w 10" \
        "printf 'abcdefghijklmnopqrstuvwxyz\n' | $F_TOOL -b -w 10"

    run_test "-b with tabs" \
        "$GNU_TOOL -b -w 20 '$TEST_DATA_DIR/fold_tabs.txt'" \
        "$F_TOOL -b -w 20 '$TEST_DATA_DIR/fold_tabs.txt'"

    run_test "-bs combined" \
        "printf 'the quick brown fox\n' | $GNU_TOOL -bs -w 8" \
        "printf 'the quick brown fox\n' | $F_TOOL -bs -w 8"

    echo ""
    echo "=== Tab Handling ==="

    run_test "tabs (column counting)" \
        "$GNU_TOOL -w 20 '$TEST_DATA_DIR/fold_tabs.txt'" \
        "$F_TOOL -w 20 '$TEST_DATA_DIR/fold_tabs.txt'"

    run_test "tabs with -s" \
        "$GNU_TOOL -s -w 20 '$TEST_DATA_DIR/fold_tabs.txt'" \
        "$F_TOOL -s -w 20 '$TEST_DATA_DIR/fold_tabs.txt'"

    echo ""
    echo "=== Multiple Lines ==="

    run_test "multiple lines different lengths" \
        "printf 'short\nabcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz\nmedium length line here\n' | $GNU_TOOL -w 20" \
        "printf 'short\nabcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz\nmedium length line here\n' | $F_TOOL -w 20"

    run_test "blank lines preserved" \
        "printf 'line1\n\n\nline4\n' | $GNU_TOOL -w 20" \
        "printf 'line1\n\n\nline4\n' | $F_TOOL -w 20"

    echo ""
    echo "=== Line Endings ==="

    run_test "dos endings" \
        "$GNU_TOOL '$TEST_DATA_DIR/dos_endings.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/dos_endings.txt'"

    echo ""
    echo "=== Unicode ==="

    run_test "CJK text" \
        "$GNU_TOOL -w 10 '$TEST_DATA_DIR/cjk.txt'" \
        "$F_TOOL -w 10 '$TEST_DATA_DIR/cjk.txt'"

    run_test "emoji" \
        "$GNU_TOOL -w 5 '$TEST_DATA_DIR/emoji.txt'" \
        "$F_TOOL -w 5 '$TEST_DATA_DIR/emoji.txt'"

    echo ""
    echo "=== Edge Cases ==="

    run_test "only newlines" \
        "$GNU_TOOL '$TEST_DATA_DIR/only_newlines.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/only_newlines.txt'"

    run_test "single newline" \
        "$GNU_TOOL '$TEST_DATA_DIR/single_newline.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/single_newline.txt'"

    run_test "10KB line at width 80" \
        "$GNU_TOOL '$TEST_DATA_DIR/long_line_10k.txt' | md5sum" \
        "$F_TOOL '$TEST_DATA_DIR/long_line_10k.txt' | md5sum"

    echo ""
    echo "=== Large Files ==="

    if [[ -f "$TEST_DATA_DIR/wide_lines_10m.txt" ]]; then
        run_test "10MB wide lines" \
            "$GNU_TOOL -w 60 '$TEST_DATA_DIR/wide_lines_10m.txt' | md5sum" \
            "$F_TOOL -w 60 '$TEST_DATA_DIR/wide_lines_10m.txt' | md5sum"

        run_test "10MB wide lines with -s" \
            "$GNU_TOOL -s -w 60 '$TEST_DATA_DIR/wide_lines_10m.txt' | md5sum" \
            "$F_TOOL -s -w 60 '$TEST_DATA_DIR/wide_lines_10m.txt' | md5sum"
    fi

    echo ""
    echo "=== Multiple Files ==="

    run_test "two files" \
        "$GNU_TOOL '$TEST_DATA_DIR/fold_long_line.txt' '$TEST_DATA_DIR/fold_words.txt'" \
        "$F_TOOL '$TEST_DATA_DIR/fold_long_line.txt' '$TEST_DATA_DIR/fold_words.txt'"

    # === GNU Upstream: Fold Perl Test Vectors ===
    echo ""
    echo "=== GNU Upstream: Fold Perl Test Vectors ==="

    # From fold.pl: -w2 -s with tab
    run_test "fold.pl s1: -w2 -s with tab" \
        "printf 'a\t' | $GNU_TOOL -w2 -s" \
        "printf 'a\t' | $F_TOOL -w2 -s"

    # From fold.pl: -w4 -s
    run_test "fold.pl s2: -w4 -s" \
        "printf 'abcdef d\n' | $GNU_TOOL -w4 -s" \
        "printf 'abcdef d\n' | $F_TOOL -w4 -s"

    # From fold.pl: -w4 -s with spaces
    run_test "fold.pl s3: -w4 -s spaces" \
        "printf 'a cd fgh\n' | $GNU_TOOL -w4 -s" \
        "printf 'a cd fgh\n' | $F_TOOL -w4 -s"

    # From fold.pl: -w4 -s mid-word break
    run_test "fold.pl s4: -w4 -s mid-word" \
        "printf 'abc ef\n' | $GNU_TOOL -w4 -s" \
        "printf 'abc ef\n' | $F_TOOL -w4 -s"

    # From fold.pl: -b -w 4 with newlines
    run_test "fold.pl bw1: -b -w 4" \
        "printf 'abcdef\nghijkl' | $GNU_TOOL -b -w 4" \
        "printf 'abcdef\nghijkl' | $F_TOOL -b -w 4"

    # From fold.pl: -b -w 6 multiline
    run_test "fold.pl bw2: -b -w 6" \
        "printf '1234567890\nabcdefghij\n1234567890' | $GNU_TOOL -b -w 6" \
        "printf '1234567890\nabcdefghij\n1234567890' | $F_TOOL -b -w 6"

    # === GNU Upstream: Multiple Files with Missing ===
    echo ""
    echo "=== GNU Upstream: Multiple Files with Missing ==="

    # From multiple-files.sh: fold processes all files even if some are missing
    local fold_tmpdir
    fold_tmpdir=$(mktemp -d /tmp/fcoreutils_fold_XXXXXX)
    register_temp "$fold_tmpdir"

    echo "a" > "$fold_tmpdir/file1"
    echo "b" > "$fold_tmpdir/file2"

    run_exit_code_test "continue on missing file" \
        "$GNU_TOOL '$fold_tmpdir/file1' '$fold_tmpdir/missing_$$' '$fold_tmpdir/file2' 2>&1" \
        "$F_TOOL '$fold_tmpdir/file1' '$fold_tmpdir/missing_$$' '$fold_tmpdir/file2' 2>&1"

    run_stdout_test "output despite missing file" \
        "$GNU_TOOL '$fold_tmpdir/file1' '$fold_tmpdir/missing_$$' '$fold_tmpdir/file2' 2>/dev/null" \
        "$F_TOOL '$fold_tmpdir/file1' '$fold_tmpdir/missing_$$' '$fold_tmpdir/file2' 2>/dev/null"

    rm -rf "$fold_tmpdir"

    # === GNU Upstream: Fold -s Word Break Edge Cases ===
    echo ""
    echo "=== GNU Upstream: Fold -s Word Break Edge Cases ==="

    # From fold.pl s1: -w2 -s with tab at boundary
    run_test "gnu fold.pl s1: -w2 -s tab" \
        "printf 'a\t' | $GNU_TOOL -w2 -s" \
        "printf 'a\t' | $F_TOOL -w2 -s"

    # From fold.pl s2: -w4 -s
    run_test "gnu fold.pl s2: -w4 -s" \
        "printf 'abcdef d\n' | $GNU_TOOL -w4 -s" \
        "printf 'abcdef d\n' | $F_TOOL -w4 -s"

    # From fold.pl s3: -w4 -s with spaces
    run_test "gnu fold.pl s3: -w4 -s spaces" \
        "printf 'a cd fgh\n' | $GNU_TOOL -w4 -s" \
        "printf 'a cd fgh\n' | $F_TOOL -w4 -s"

    # From fold.pl s4: -w4 -s mid-word break
    run_test "gnu fold.pl s4: -w4 -s mid-word" \
        "printf 'abc ef\n' | $GNU_TOOL -w4 -s" \
        "printf 'abc ef\n' | $F_TOOL -w4 -s"

    # === GNU Upstream: Fold -b Byte-Count Mode ===
    echo ""
    echo "=== GNU Upstream: Fold -b Byte-Count Mode ==="

    # From fold.pl bw1: -b -w 4 with newlines
    run_test "gnu fold.pl bw1: -b -w 4" \
        "printf 'abcdef\nghijkl' | $GNU_TOOL -b -w 4" \
        "printf 'abcdef\nghijkl' | $F_TOOL -b -w 4"

    # From fold.pl bw2: -b -w 6 multiline
    run_test "gnu fold.pl bw2: -b -w 6" \
        "printf '1234567890\nabcdefghij\n1234567890' | $GNU_TOOL -b -w 6" \
        "printf '1234567890\nabcdefghij\n1234567890' | $F_TOOL -b -w 6"

    # === GNU Upstream: Nonexistent File Continues Processing ===
    echo ""
    echo "=== GNU Upstream: Nonexistent File Continues Processing ==="

    # From multiple-files.sh: fold processes all files even if some are missing
    local fold_tmpdir2
    fold_tmpdir2=$(mktemp -d /tmp/fcoreutils_fold2_XXXXXX)
    register_temp "$fold_tmpdir2"

    echo "a" > "$fold_tmpdir2/file1"
    echo "b" > "$fold_tmpdir2/file2"

    run_exit_code_test "gnu multiple-files: continue on missing file" \
        "$GNU_TOOL '$fold_tmpdir2/file1' '$fold_tmpdir2/missing_$$' '$fold_tmpdir2/file2' 2>&1" \
        "$F_TOOL '$fold_tmpdir2/file1' '$fold_tmpdir2/missing_$$' '$fold_tmpdir2/file2' 2>&1"

    run_stdout_test "gnu multiple-files: output despite missing file" \
        "$GNU_TOOL '$fold_tmpdir2/file1' '$fold_tmpdir2/missing_$$' '$fold_tmpdir2/file2' 2>/dev/null" \
        "$F_TOOL '$fold_tmpdir2/file1' '$fold_tmpdir2/missing_$$' '$fold_tmpdir2/file2' 2>/dev/null"

    rm -rf "$fold_tmpdir2"

    # === GNU Upstream: Fold Nonexistent File Exit Code ===
    echo ""
    echo "=== GNU Upstream: Fold Nonexistent File Exit Code ==="

    # From fold.pl enoent: nonexistent file returns exit code 1
    run_exit_code_test "gnu fold.pl enoent: missing file exits 1" \
        "$GNU_TOOL /tmp/nonexistent_enoent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_enoent_$$ 2>&1"

    # === GNU Upstream: Zero-Width and NUL Byte Handling ===
    echo ""
    echo "=== GNU Upstream: Zero-Width and NUL Byte Handling ==="

    # From fold-zero-width.sh: NUL bytes have zero column width
    # Fold counts by columns by default; NUL bytes are zero-width so no folding
    run_test "gnu fold-zero-width: NUL bytes no fold" \
        "printf '\0\0\0\0\0\0\0\0\0\0' | $GNU_TOOL | wc -l" \
        "printf '\0\0\0\0\0\0\0\0\0\0' | $F_TOOL | wc -l"

    # From fold-zero-width.sh: --characters counts NUL as character
    run_test "gnu fold-zero-width: NUL with --characters -w 5" \
        "printf '\0\0\0\0\0\0\0\0\0\0' | $GNU_TOOL --characters -w 5 | wc -l" \
        "printf '\0\0\0\0\0\0\0\0\0\0' | $F_TOOL --characters -w 5 | wc -l"

    # fold-characters.sh: skipped (requires LOCALE_FR_UTF8 special locale)
    skip_test "fold characters wide-char" "Requires French UTF-8 locale (LOCALE_FR_UTF8)"

    # fold-nbsp.sh: skipped (requires LOCALE_FR_UTF8 special locale)
    skip_test "fold non-breaking space" "Requires French UTF-8 locale (LOCALE_FR_UTF8)"

    # fold-spaces.sh: skipped (requires LOCALE_FR_UTF8 and Unicode blank detection)
    skip_test "fold Unicode breaking spaces" "Requires French UTF-8 locale (LOCALE_FR_UTF8)"

    # fold-zero-width.sh bounded-memory test: skipped (requires ulimit -v and /dev/full)
    skip_test "fold bounded memory" "Requires ulimit -v and /dev/full"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_file_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_file_$$ 2>&1"


    finish_test_suite
}

run_fold_tests
