#!/usr/bin/env bash
# Compatibility tests for fvdir vs GNU vdir
# vdir is equivalent to ls -l -b
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "vdir")
F_TOOL="fvdir"

run_vdir_tests() {
    init_test_suite "vdir"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"vdir","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/vdir_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU vdir not found, cannot compare" >&2
        return 1
    fi

    # Create a deterministic test directory
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_vdir_XXXXXX)
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
    local VDIR_ENV="COLUMNS=80 LC_ALL=C"

    # === Section 1: Basic Listing ===
    echo ""
    echo "=== Basic Listing ==="

    # Empty directory
    mkdir "$test_dir/empty_dir"
    run_stdout_test "vdir_empty_directory" \
        "$VDIR_ENV $GNU_TOOL --color=never '$test_dir/empty_dir'" \
        "$VDIR_ENV $F_TOOL --color=never '$test_dir/empty_dir'"

    run_stdout_test "vdir_single_file" \
        "$VDIR_ENV $GNU_TOOL --color=never '$test_dir/file1.txt'" \
        "$VDIR_ENV $F_TOOL --color=never '$test_dir/file1.txt'"

    run_stdout_test "vdir_multiple_files" \
        "$VDIR_ENV $GNU_TOOL --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL --color=never '$test_dir'"

    run_stdout_test "vdir_hidden_files" \
        "$VDIR_ENV $GNU_TOOL -a --color=never '$test_dir' | grep -v ' \\.\\.\$'" \
        "$VDIR_ENV $F_TOOL -a --color=never '$test_dir' | grep -v ' \\.\\.\$'"

    run_stdout_test "vdir_all_except_dots" \
        "$VDIR_ENV $GNU_TOOL -A --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -A --color=never '$test_dir'"

    # === Section 2: Long Format Specifics ===
    echo ""
    echo "=== Long Format Specifics ==="

    # vdir defaults to long format (ls -l -b), so basic output is already long
    run_stdout_test "vdir_permissions_format" \
        "$VDIR_ENV $GNU_TOOL --color=never '$test_dir/file1.txt'" \
        "$VDIR_ENV $F_TOOL --color=never '$test_dir/file1.txt'"

    run_stdout_test "vdir_owner_group" \
        "$VDIR_ENV $GNU_TOOL --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL --color=never '$test_dir'"

    run_stdout_test "vdir_file_size" \
        "$VDIR_ENV $GNU_TOOL --color=never '$test_dir/big_file'" \
        "$VDIR_ENV $F_TOOL --color=never '$test_dir/big_file'"

    run_stdout_test "vdir_symlink_arrow" \
        "$VDIR_ENV $GNU_TOOL --color=never '$test_dir/link1'" \
        "$VDIR_ENV $F_TOOL --color=never '$test_dir/link1'"

    run_stdout_test "vdir_numeric_uid_gid" \
        "$VDIR_ENV $GNU_TOOL -n --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -n --color=never '$test_dir'"

    run_stdout_test "vdir_block_size" \
        "$VDIR_ENV $GNU_TOOL --block-size=1K --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL --block-size=1K --color=never '$test_dir'"

    run_stdout_test "vdir_total_line" \
        "$VDIR_ENV $GNU_TOOL --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL --color=never '$test_dir'"

    run_stdout_test "vdir_alignment" \
        "$VDIR_ENV $GNU_TOOL --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL --color=never '$test_dir'"

    # === Section 3: Sorting ===
    echo ""
    echo "=== Sorting ==="

    run_stdout_test "vdir_reverse" \
        "$VDIR_ENV $GNU_TOOL -r --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -r --color=never '$test_dir'"

    run_stdout_test "vdir_sort_by_time" \
        "$VDIR_ENV $GNU_TOOL -t --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -t --color=never '$test_dir'"

    run_stdout_test "vdir_sort_by_size" \
        "$VDIR_ENV $GNU_TOOL -S --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -S --color=never '$test_dir'"

    run_stdout_test "vdir_sort_none" \
        "$VDIR_ENV $GNU_TOOL -U --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -U --color=never '$test_dir'"

    run_stdout_test "vdir_sort_extension" \
        "$VDIR_ENV $GNU_TOOL -X --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -X --color=never '$test_dir'"

    run_stdout_test "vdir_reverse_time" \
        "$VDIR_ENV $GNU_TOOL -rt --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -rt --color=never '$test_dir'"

    run_stdout_test "vdir_reverse_size" \
        "$VDIR_ENV $GNU_TOOL -rS --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -rS --color=never '$test_dir'"

    # === Section 4: Recursive ===
    echo ""
    echo "=== Recursive ==="

    run_stdout_test "vdir_recursive" \
        "$VDIR_ENV $GNU_TOOL -R --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -R --color=never '$test_dir'"

    # === Section 5: Display Options ===
    echo ""
    echo "=== Display Options ==="

    run_stdout_test "vdir_human_readable" \
        "$VDIR_ENV $GNU_TOOL -h --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -h --color=never '$test_dir'"

    run_stdout_test "vdir_inode" \
        "$VDIR_ENV $GNU_TOOL -i --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -i --color=never '$test_dir'"

    run_stdout_test "vdir_no_group" \
        "$VDIR_ENV $GNU_TOOL -G --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -G --color=never '$test_dir'"

    run_stdout_test "vdir_color_never" \
        "$VDIR_ENV $GNU_TOOL --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL --color=never '$test_dir'"

    run_stdout_test "vdir_classify" \
        "$VDIR_ENV $GNU_TOOL -F --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -F --color=never '$test_dir'"

    run_stdout_test "vdir_dereference" \
        "$VDIR_ENV $GNU_TOOL -L --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -L --color=never '$test_dir'"

    run_stdout_test "vdir_size_blocks" \
        "$VDIR_ENV $GNU_TOOL -s --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -s --color=never '$test_dir'"

    # === Section 6: Escape Characters ===
    echo ""
    echo "=== Escape Characters ==="

    local special_dir
    special_dir=$(mktemp -d /tmp/fcoreutils_vdir_special_XXXXXX)
    register_temp "$special_dir"
    touch "$special_dir/normal_file"
    touch "$special_dir/file with spaces"
    touch "$special_dir/file	with	tabs" 2>/dev/null || true

    run_stdout_test "vdir_escape_chars" \
        "$VDIR_ENV $GNU_TOOL --color=never '$special_dir'" \
        "$VDIR_ENV $F_TOOL --color=never '$special_dir'"

    rm -rf "$special_dir"

    # === Section 7: Combined Flags ===
    echo ""
    echo "=== Combined Flags ==="

    run_stdout_test "vdir_combined_ahS" \
        "$VDIR_ENV $GNU_TOOL -ahS --color=never '$test_dir' | grep -v ' \\.\\.\$'" \
        "$VDIR_ENV $F_TOOL -ahS --color=never '$test_dir' | grep -v ' \\.\\.\$'"

    run_stdout_test "vdir_combined_aR" \
        "$VDIR_ENV $GNU_TOOL -aR --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -aR --color=never '$test_dir'"

    run_stdout_test "vdir_combined_htr" \
        "$VDIR_ENV $GNU_TOOL -htr --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -htr --color=never '$test_dir'"

    run_stdout_test "vdir_combined_iF" \
        "$VDIR_ENV $GNU_TOOL -iF --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -iF --color=never '$test_dir'"

    # === Section 8: Quoting Styles ===
    echo ""
    echo "=== Quoting Styles ==="

    run_stdout_test "vdir_quote_name" \
        "$VDIR_ENV $GNU_TOOL -Q --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -Q --color=never '$test_dir'"

    run_stdout_test "vdir_quoting_c" \
        "$VDIR_ENV $GNU_TOOL --quoting-style=c --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL --quoting-style=c --color=never '$test_dir'"

    run_stdout_test "vdir_quoting_shell_escape" \
        "$VDIR_ENV $GNU_TOOL --quoting-style=shell-escape --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL --quoting-style=shell-escape --color=never '$test_dir'"

    # === Section 9: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "vdir_nonexistent" \
        "$GNU_TOOL /tmp/nonexistent_vdir_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_vdir_$$ 2>&1"

    # Permission denied test
    local noread_dir
    noread_dir=$(mktemp -d /tmp/fcoreutils_vdir_noread_XXXXXX)
    register_temp "$noread_dir"
    touch "$noread_dir/secret"
    chmod 000 "$noread_dir"

    run_exit_code_test "vdir_permission_denied" \
        "$GNU_TOOL '$noread_dir' 2>&1" \
        "$F_TOOL '$noread_dir' 2>&1"

    chmod 755 "$noread_dir"
    rm -rf "$noread_dir"

    # === Section 10: Help and Version ===
    echo ""
    echo "=== Help and Version ==="

    run_exit_code_test "vdir_help" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    run_exit_code_test "vdir_version" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    # === Section 11: Directory Entry (-d) ===
    echo ""
    echo "=== Directory Entry ==="

    run_stdout_test "vdir_directory_only" \
        "$VDIR_ENV $GNU_TOOL -d --color=never '$test_dir'" \
        "$VDIR_ENV $F_TOOL -d --color=never '$test_dir'"

    rm -rf "$test_dir"

    finish_test_suite
}

run_vdir_tests
