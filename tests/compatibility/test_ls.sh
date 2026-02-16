#!/usr/bin/env bash
# Compatibility tests for fls vs GNU ls
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="ls"
F_TOOL="fls"

run_ls_tests() {
    init_test_suite "ls"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"ls","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/ls_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU ls not found, cannot compare" >&2
        return 1
    fi

    # Create a deterministic test directory
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_ls_XXXXXX)
    register_temp "$test_dir"

    # Create various file types
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
    mkfifo "$test_dir/pipe1" 2>/dev/null || true

    # Set deterministic permissions and timestamps
    chmod 755 "$test_dir/file1.txt"
    chmod 644 "$test_dir/file2.txt"
    chmod 600 "$test_dir/file3.dat"

    # Set deterministic timestamps
    touch -t 202401010000 "$test_dir/file1.txt" 2>/dev/null || true
    touch -t 202401020000 "$test_dir/file2.txt" 2>/dev/null || true
    touch -t 202401030000 "$test_dir/file3.dat" 2>/dev/null || true
    touch -t 202401010000 "$test_dir/dir1" 2>/dev/null || true
    touch -t 202401020000 "$test_dir/dir2" 2>/dev/null || true

    # Create a larger file for size sorting
    dd if=/dev/zero of="$test_dir/big_file" bs=1024 count=100 2>/dev/null
    dd if=/dev/zero of="$test_dir/small_file" bs=1 count=10 2>/dev/null

    # Use COLUMNS=80 and disable color for deterministic output
    local LS_ENV="COLUMNS=80 LC_ALL=C"

    # === Section 1: One Per Line (-1) ===
    echo ""
    echo "=== One Per Line (-1) ==="

    run_stdout_test "-1 one per line" \
        "$LS_ENV $GNU_TOOL -1 '$test_dir'" \
        "$LS_ENV $F_TOOL -1 '$test_dir'"

    run_stdout_test "-1 with --color=never" \
        "$LS_ENV $GNU_TOOL -1 --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1 --color=never '$test_dir'"

    # === Section 2: Long Format (-l) ===
    echo ""
    echo "=== Long Format (-l) ==="

    run_stdout_test "-l long format" \
        "$LS_ENV $GNU_TOOL -l --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -l --color=never '$test_dir'"

    run_stdout_test "-l single file" \
        "$LS_ENV $GNU_TOOL -l --color=never '$test_dir/file1.txt'" \
        "$LS_ENV $F_TOOL -l --color=never '$test_dir/file1.txt'"

    run_stdout_test "-l directory" \
        "$LS_ENV $GNU_TOOL -l --color=never '$test_dir/dir1'" \
        "$LS_ENV $F_TOOL -l --color=never '$test_dir/dir1'"

    # === Section 3: All (-a) ===
    echo ""
    echo "=== All (-a) ==="

    run_stdout_test "-a (includes . and ..)" \
        "$LS_ENV $GNU_TOOL -1a --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1a --color=never '$test_dir'"

    # === Section 4: Almost All (-A) ===
    echo ""
    echo "=== Almost All (-A) ==="

    run_stdout_test "-A (hidden but not . and ..)" \
        "$LS_ENV $GNU_TOOL -1A --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1A --color=never '$test_dir'"

    # === Section 5: Human Sizes (-h) ===
    echo ""
    echo "=== Human Sizes (-lh) ==="

    run_stdout_test "-lh human sizes" \
        "$LS_ENV $GNU_TOOL -lh --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -lh --color=never '$test_dir'"

    # === Section 6: Sort by Size (-S) ===
    echo ""
    echo "=== Sort by Size (-S) ==="

    run_stdout_test "-lS sort by size" \
        "$LS_ENV $GNU_TOOL -lS --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -lS --color=never '$test_dir'"

    run_stdout_test "-1S one-per-line sorted by size" \
        "$LS_ENV $GNU_TOOL -1S --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1S --color=never '$test_dir'"

    # === Section 7: Sort by Time (-t) ===
    echo ""
    echo "=== Sort by Time (-t) ==="

    run_stdout_test "-lt sort by time" \
        "$LS_ENV $GNU_TOOL -lt --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -lt --color=never '$test_dir'"

    run_stdout_test "-1t one-per-line sorted by time" \
        "$LS_ENV $GNU_TOOL -1t --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1t --color=never '$test_dir'"

    # === Section 8: Reverse (-r) ===
    echo ""
    echo "=== Reverse (-r) ==="

    run_stdout_test "-1r reverse" \
        "$LS_ENV $GNU_TOOL -1r --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1r --color=never '$test_dir'"

    run_stdout_test "-lrS reverse size" \
        "$LS_ENV $GNU_TOOL -lrS --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -lrS --color=never '$test_dir'"

    run_stdout_test "-lrt reverse time" \
        "$LS_ENV $GNU_TOOL -lrt --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -lrt --color=never '$test_dir'"

    # === Section 9: Recursive (-R) ===
    echo ""
    echo "=== Recursive (-R) ==="

    run_stdout_test "-1R recursive" \
        "$LS_ENV $GNU_TOOL -1R --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1R --color=never '$test_dir'"

    run_stdout_test "-lR recursive long" \
        "$LS_ENV $GNU_TOOL -lR --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -lR --color=never '$test_dir'"

    # === Section 10: Directory Entries (-d) ===
    echo ""
    echo "=== Directory Entries (-d) ==="

    run_stdout_test "-d directory itself" \
        "$LS_ENV $GNU_TOOL -d --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -d --color=never '$test_dir'"

    run_stdout_test "-ld directory itself long" \
        "$LS_ENV $GNU_TOOL -ld --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -ld --color=never '$test_dir'"

    # === Section 11: Indicators (-F) ===
    echo ""
    echo "=== Indicators (-F) ==="

    run_stdout_test "-1F classify" \
        "$LS_ENV $GNU_TOOL -1F --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1F --color=never '$test_dir'"

    run_stdout_test "-p append / to dirs" \
        "$LS_ENV $GNU_TOOL -1p --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1p --color=never '$test_dir'"

    # === Section 12: Inode (-i) ===
    echo ""
    echo "=== Inode (-i) ==="

    run_stdout_test "-1i show inodes" \
        "$LS_ENV $GNU_TOOL -1i --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1i --color=never '$test_dir'"

    run_stdout_test "-li long with inodes" \
        "$LS_ENV $GNU_TOOL -li --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -li --color=never '$test_dir'"

    # === Section 13: Numeric IDs (-n) ===
    echo ""
    echo "=== Numeric IDs (-n) ==="

    run_stdout_test "-n numeric uid/gid" \
        "$LS_ENV $GNU_TOOL -n --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -n --color=never '$test_dir'"

    # === Section 14: Block Size (-s) ===
    echo ""
    echo "=== Block Size (-s) ==="

    run_stdout_test "-1s allocated blocks" \
        "$LS_ENV $GNU_TOOL -1s --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1s --color=never '$test_dir'"

    # === Section 15: Column Output (default) ===
    echo ""
    echo "=== Column Output ==="

    run_stdout_test "default column output (COLUMNS=80)" \
        "$LS_ENV $GNU_TOOL --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL --color=never '$test_dir'"

    # === Section 16: Combined Flags ===
    echo ""
    echo "=== Combined Flags ==="

    run_stdout_test "-lahS combined" \
        "$LS_ENV $GNU_TOOL -lahS --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -lahS --color=never '$test_dir'"

    run_stdout_test "-1aR recursive all" \
        "$LS_ENV $GNU_TOOL -1aR --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1aR --color=never '$test_dir'"

    run_stdout_test "-lhtr time reverse human" \
        "$LS_ENV $GNU_TOOL -lhtr --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -lhtr --color=never '$test_dir'"

    run_stdout_test "-lSr size reverse long" \
        "$LS_ENV $GNU_TOOL -lSr --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -lSr --color=never '$test_dir'"

    run_stdout_test "-1AF classify almost all" \
        "$LS_ENV $GNU_TOOL -1AF --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1AF --color=never '$test_dir'"

    # === Section 17: Sort Options ===
    echo ""
    echo "=== Sort Options ==="

    run_stdout_test "--sort=size" \
        "$LS_ENV $GNU_TOOL -1 --sort=size --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1 --sort=size --color=never '$test_dir'"

    run_stdout_test "--sort=time" \
        "$LS_ENV $GNU_TOOL -1 --sort=time --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1 --sort=time --color=never '$test_dir'"

    run_stdout_test "--sort=none (-U)" \
        "$LS_ENV $GNU_TOOL -1U --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1U --color=never '$test_dir'"

    run_stdout_test "--sort=extension (-X)" \
        "$LS_ENV $GNU_TOOL -1X --color=never '$test_dir'" \
        "$LS_ENV $F_TOOL -1X --color=never '$test_dir'"

    # === Section 18: Empty Directory ===
    echo ""
    echo "=== Empty Directory ==="

    mkdir "$test_dir/empty_dir"
    run_stdout_test "empty directory" \
        "$LS_ENV $GNU_TOOL -1 --color=never '$test_dir/empty_dir'" \
        "$LS_ENV $F_TOOL -1 --color=never '$test_dir/empty_dir'"

    run_stdout_test "-la empty directory" \
        "$LS_ENV $GNU_TOOL -la --color=never '$test_dir/empty_dir'" \
        "$LS_ENV $F_TOOL -la --color=never '$test_dir/empty_dir'"

    # === Section 19: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent path" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_ls_tests
