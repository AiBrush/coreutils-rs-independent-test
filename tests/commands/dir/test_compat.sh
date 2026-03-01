#!/usr/bin/env bash
# Compatibility tests for fdir vs GNU dir
# dir is equivalent to ls -C -b
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "dir")
F_TOOL="fdir"

run_dir_tests() {
    init_test_suite "dir"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"dir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/dir_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU dir not found, cannot compare" >&2
        return 1
    fi

    # Create a deterministic test directory
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_dir_XXXXXX)
    register_temp "$test_dir"

    # Create various file types for testing
    echo "file1 content" > "$test_dir/file1.txt"
    echo "file2 longer content here" > "$test_dir/file2.txt"
    echo "short" > "$test_dir/file3.dat"
    touch "$test_dir/.hidden_file"
    touch "$test_dir/.another_hidden"
    mkdir "$test_dir/dir1"
    mkdir "$test_dir/dir2"
    mkdir "$test_dir/.hidden_dir"
    echo "inside" > "$test_dir/dir1/inner.txt"
    echo "also inside" > "$test_dir/dir2/deep.txt"
    ln -s file1.txt "$test_dir/link1" 2>/dev/null || true
    ln -s /nonexistent "$test_dir/broken_link" 2>/dev/null || true

    # Set deterministic permissions and timestamps
    chmod 755 "$test_dir/file1.txt"
    chmod 644 "$test_dir/file2.txt"
    chmod 600 "$test_dir/file3.dat"
    touch -t 202401010000 "$test_dir/file1.txt" 2>/dev/null || true
    touch -t 202401020000 "$test_dir/file2.txt" 2>/dev/null || true
    touch -t 202401030000 "$test_dir/file3.dat" 2>/dev/null || true
    touch -t 202401010000 "$test_dir/dir1" 2>/dev/null || true
    touch -t 202401020000 "$test_dir/dir2" 2>/dev/null || true

    # Create files for size sorting
    dd if=/dev/zero of="$test_dir/big_file" bs=1024 count=100 2>/dev/null
    dd if=/dev/zero of="$test_dir/small_file" bs=1 count=10 2>/dev/null

    # Use COLUMNS=80 and disable color for deterministic output
    local DIR_ENV="COLUMNS=80 LC_ALL=C"

    # === Section 1: Basic Listing ===
    echo ""
    echo "=== Basic Listing ==="

    # Empty directory
    mkdir "$test_dir/empty_dir"
    run_stdout_test "dir_empty_directory" \
        "$DIR_ENV $GNU_TOOL --color=never '$test_dir/empty_dir'" \
        "$DIR_ENV $F_TOOL --color=never '$test_dir/empty_dir'"

    run_stdout_test "dir_single_file" \
        "$DIR_ENV $GNU_TOOL --color=never '$test_dir/file1.txt'" \
        "$DIR_ENV $F_TOOL --color=never '$test_dir/file1.txt'"

    run_stdout_test "dir_multiple_files" \
        "$DIR_ENV $GNU_TOOL --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL --color=never '$test_dir'"

    run_stdout_test "dir_hidden_files" \
        "$DIR_ENV $GNU_TOOL -a --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -a --color=never '$test_dir'"

    run_stdout_test "dir_all_except_dots" \
        "$DIR_ENV $GNU_TOOL -A --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -A --color=never '$test_dir'"

    # === Section 2: Formatting ===
    echo ""
    echo "=== Formatting ==="

    run_stdout_test "dir_long_format" \
        "$DIR_ENV $GNU_TOOL -l --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -l --color=never '$test_dir'"

    run_stdout_test "dir_reverse" \
        "$DIR_ENV $GNU_TOOL -r --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -r --color=never '$test_dir'"

    run_stdout_test "dir_sort_by_time" \
        "$DIR_ENV $GNU_TOOL -t --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -t --color=never '$test_dir'"

    run_stdout_test "dir_sort_by_size" \
        "$DIR_ENV $GNU_TOOL -S --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -S --color=never '$test_dir'"

    run_stdout_test "dir_recursive" \
        "$DIR_ENV $GNU_TOOL -R --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -R --color=never '$test_dir'"

    run_stdout_test "dir_one_per_line" \
        "$DIR_ENV $GNU_TOOL -1 --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -1 --color=never '$test_dir'"

    run_stdout_test "dir_classify" \
        "$DIR_ENV $GNU_TOOL -F --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -F --color=never '$test_dir'"

    run_stdout_test "dir_human_readable" \
        "$DIR_ENV $GNU_TOOL -lh --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -lh --color=never '$test_dir'"

    run_stdout_test "dir_inode" \
        "$DIR_ENV $GNU_TOOL -i --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -i --color=never '$test_dir'"

    run_stdout_test "dir_no_group" \
        "$DIR_ENV $GNU_TOOL -lG --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -lG --color=never '$test_dir'"

    run_stdout_test "dir_color_never" \
        "$DIR_ENV $GNU_TOOL --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL --color=never '$test_dir'"

    run_stdout_test "dir_quote_name" \
        "$DIR_ENV $GNU_TOOL -Q --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -Q --color=never '$test_dir'"

    # === Section 3: Escape Characters ===
    echo ""
    echo "=== Escape Characters ==="

    # dir uses -b by default; test with special filenames
    local special_dir
    special_dir=$(mktemp -d /tmp/fcoreutils_dir_special_XXXXXX)
    register_temp "$special_dir"
    touch "$special_dir/normal_file"
    touch "$special_dir/file with spaces"
    touch "$special_dir/file	with	tabs" 2>/dev/null || true

    run_stdout_test "dir_escape_chars" \
        "$DIR_ENV $GNU_TOOL --color=never '$special_dir'" \
        "$DIR_ENV $F_TOOL --color=never '$special_dir'"

    run_stdout_test "dir_escape_chars_long" \
        "$DIR_ENV $GNU_TOOL -l --color=never '$special_dir'" \
        "$DIR_ENV $F_TOOL -l --color=never '$special_dir'"

    rm -rf "$special_dir"

    # === Section 4: Column Output ===
    echo ""
    echo "=== Column Output ==="

    run_stdout_test "dir_column_output" \
        "$DIR_ENV $GNU_TOOL --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL --color=never '$test_dir'"

    run_stdout_test "dir_column_width" \
        "COLUMNS=80 LC_ALL=C $GNU_TOOL -w 80 --color=never '$test_dir'" \
        "COLUMNS=80 LC_ALL=C $F_TOOL -w 80 --color=never '$test_dir'"

    run_stdout_test "dir_column_narrow" \
        "COLUMNS=40 LC_ALL=C $GNU_TOOL -w 40 --color=never '$test_dir'" \
        "COLUMNS=40 LC_ALL=C $F_TOOL -w 40 --color=never '$test_dir'"

    # === Section 5: Symlinks ===
    echo ""
    echo "=== Symlinks ==="

    run_stdout_test "dir_symlinks" \
        "$DIR_ENV $GNU_TOOL -l --color=never '$test_dir/link1'" \
        "$DIR_ENV $F_TOOL -l --color=never '$test_dir/link1'"

    run_stdout_test "dir_dereference" \
        "$DIR_ENV $GNU_TOOL -L --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -L --color=never '$test_dir'"

    run_stdout_test "dir_directories_only" \
        "$DIR_ENV $GNU_TOOL -d --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -d --color=never '$test_dir'"

    run_stdout_test "dir_directories_only_long" \
        "$DIR_ENV $GNU_TOOL -ld --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -ld --color=never '$test_dir'"

    # === Section 6: Sort Options ===
    echo ""
    echo "=== Sort Options ==="

    run_stdout_test "dir_sort_none" \
        "$DIR_ENV $GNU_TOOL -U --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -U --color=never '$test_dir'"

    run_stdout_test "dir_sort_extension" \
        "$DIR_ENV $GNU_TOOL -X --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -X --color=never '$test_dir'"

    # === Section 7: Size Display ===
    echo ""
    echo "=== Size Display ==="

    run_stdout_test "dir_size" \
        "$DIR_ENV $GNU_TOOL -s --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -s --color=never '$test_dir'"

    # === Section 8: Comma-Separated ===
    echo ""
    echo "=== Comma-Separated ==="

    run_stdout_test "dir_comma_separated" \
        "$DIR_ENV $GNU_TOOL -m --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -m --color=never '$test_dir'"

    # === Section 9: Numeric IDs ===
    echo ""
    echo "=== Numeric IDs ==="

    run_stdout_test "dir_numeric_uid_gid" \
        "$DIR_ENV $GNU_TOOL -n --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -n --color=never '$test_dir'"

    # === Section 10: Combined Flags ===
    echo ""
    echo "=== Combined Flags ==="

    run_stdout_test "dir_combined_lahS" \
        "$DIR_ENV $GNU_TOOL -lahS --color=never '$test_dir' | grep -v ' \.\.\$'" \
        "$DIR_ENV $F_TOOL -lahS --color=never '$test_dir' | grep -v ' \.\.\$'"

    run_stdout_test "dir_combined_1aR" \
        "$DIR_ENV $GNU_TOOL -1aR --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -1aR --color=never '$test_dir'"

    run_stdout_test "dir_combined_lhtr" \
        "$DIR_ENV $GNU_TOOL -lhtr --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -lhtr --color=never '$test_dir'"

    run_stdout_test "dir_combined_lSr" \
        "$DIR_ENV $GNU_TOOL -lSr --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -lSr --color=never '$test_dir'"

    run_stdout_test "dir_combined_1AF" \
        "$DIR_ENV $GNU_TOOL -1AF --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -1AF --color=never '$test_dir'"

    # === Section 11: Quoting Styles ===
    echo ""
    echo "=== Quoting Styles ==="

    run_stdout_test "dir_quoting_shell_escape" \
        "$DIR_ENV $GNU_TOOL -1 --quoting-style=shell-escape --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -1 --quoting-style=shell-escape --color=never '$test_dir'"

    run_stdout_test "dir_quoting_c" \
        "$DIR_ENV $GNU_TOOL -1 --quoting-style=c --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -1 --quoting-style=c --color=never '$test_dir'"

    run_stdout_test "dir_quoting_escape" \
        "$DIR_ENV $GNU_TOOL -1 --quoting-style=escape --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -1 --quoting-style=escape --color=never '$test_dir'"

    # === Section 12: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "dir_nonexistent" \
        "$GNU_TOOL /tmp/nonexistent_dir_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_dir_$$ 2>&1"

    # Permission denied test
    local noread_dir
    noread_dir=$(mktemp -d /tmp/fcoreutils_dir_noread_XXXXXX)
    register_temp "$noread_dir"
    touch "$noread_dir/secret"
    chmod 000 "$noread_dir"

    run_exit_code_test "dir_permission_denied" \
        "$GNU_TOOL '$noread_dir' 2>&1" \
        "$F_TOOL '$noread_dir' 2>&1"

    chmod 755 "$noread_dir"
    rm -rf "$noread_dir"

    # === Section 13: Help and Version ===
    echo ""
    echo "=== Help and Version ==="

    run_exit_code_test "dir_help" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    run_exit_code_test "dir_version" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    # === Section 14: Horizontal Listing (-x) ===
    echo ""
    echo "=== Horizontal Listing ==="

    run_stdout_test "dir_horizontal" \
        "$DIR_ENV $GNU_TOOL -x --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -x --color=never '$test_dir'"

    # === Section 15: Append Indicator (-p) ===
    echo ""
    echo "=== Append Indicator ==="

    run_stdout_test "dir_append_slash" \
        "$DIR_ENV $GNU_TOOL -p --color=never '$test_dir'" \
        "$DIR_ENV $F_TOOL -p --color=never '$test_dir'"

    rm -rf "$test_dir"

    finish_test_suite
}

run_dir_tests
