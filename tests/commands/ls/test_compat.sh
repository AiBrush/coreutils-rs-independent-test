#!/usr/bin/env bash
# Compatibility tests for fls vs GNU ls
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "ls")
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

    # Exclude the '..' entry since its parent dir (/tmp) size changes between runs
    run_stdout_test "-lahS combined" \
        "$LS_ENV $GNU_TOOL -lahS --color=never '$test_dir' | grep -v ' \.\.$'" \
        "$LS_ENV $F_TOOL -lahS --color=never '$test_dir' | grep -v ' \.\.$'"

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

    # ── GNU Upstream Test Scenarios ──────────────────────────────────────────

    # Create a separate test directory for GNU upstream scenarios
    local gnu_test_dir
    gnu_test_dir=$(mktemp -d /tmp/fcoreutils_ls_gnu_XXXXXX)
    register_temp "$gnu_test_dir"

    echo ""
    echo "=== GNU Upstream: -a Option ==="

    # From a-option.sh: ls -aA on empty dir produces no output
    mkdir "$gnu_test_dir/empty_aA"

    run_stdout_test "gnu: -aA empty dir (no output)" \
        "$LS_ENV $GNU_TOOL -aA '$gnu_test_dir/empty_aA'" \
        "$LS_ENV $F_TOOL -aA '$gnu_test_dir/empty_aA'"

    echo ""
    echo "=== GNU Upstream: Classify (--classify) ==="

    # From classify.sh: --classify shows indicators for file types
    mkdir "$gnu_test_dir/classify_dir"
    mkdir "$gnu_test_dir/classify_dir/dir"
    touch "$gnu_test_dir/classify_dir/regular"
    touch "$gnu_test_dir/classify_dir/executable"
    chmod a+x "$gnu_test_dir/classify_dir/executable"
    ln -s regular "$gnu_test_dir/classify_dir/slink-reg" 2>/dev/null || true
    ln -s dir "$gnu_test_dir/classify_dir/slink-dir" 2>/dev/null || true
    ln -s nowhere "$gnu_test_dir/classify_dir/slink-dangle" 2>/dev/null || true

    run_stdout_test "gnu: --classify shows indicators" \
        "$LS_ENV $GNU_TOOL --classify '$gnu_test_dir/classify_dir'" \
        "$LS_ENV $F_TOOL --classify '$gnu_test_dir/classify_dir'"

    run_stdout_test "gnu: --classify=always" \
        "$LS_ENV $GNU_TOOL --classify=always '$gnu_test_dir/classify_dir'" \
        "$LS_ENV $F_TOOL --classify=always '$gnu_test_dir/classify_dir'"

    run_stdout_test "gnu: --classify=never no indicators" \
        "$LS_ENV $GNU_TOOL --classify=never '$gnu_test_dir/classify_dir'" \
        "$LS_ENV $F_TOOL --classify=never '$gnu_test_dir/classify_dir'"

    # From classify.sh: --classify=invalid should fail
    run_exit_code_test "gnu: --classify=invalid fails" \
        "$GNU_TOOL --classify=invalid 2>&1" \
        "$F_TOOL --classify=invalid 2>&1"

    echo ""
    echo "=== GNU Upstream: -m Option (Comma-Separated) ==="

    # From m-option.sh: -m with narrow width
    mkdir "$gnu_test_dir/m_dir"
    touch "$gnu_test_dir/m_dir/a" "$gnu_test_dir/m_dir/b"

    run_stdout_test "gnu: -w2 -m narrow comma list" \
        "COLUMNS=2 LC_ALL=C $GNU_TOOL -w2 -m '$gnu_test_dir/m_dir'" \
        "COLUMNS=2 LC_ALL=C $F_TOOL -w2 -m '$gnu_test_dir/m_dir'"

    run_stdout_test "gnu: -m comma-separated" \
        "$LS_ENV $GNU_TOOL -m '$gnu_test_dir/m_dir'" \
        "$LS_ENV $F_TOOL -m '$gnu_test_dir/m_dir'"

    echo ""
    echo "=== GNU Upstream: No Arguments ==="

    # From no-arg.sh: ls -1 in a known directory
    local gnu_noarg_dir
    gnu_noarg_dir=$(mktemp -d /tmp/fcoreutils_ls_noarg_XXXXXX)
    register_temp "$gnu_noarg_dir"

    mkdir -p "$gnu_noarg_dir/dir/subdir"
    touch "$gnu_noarg_dir/dir/subdir/file2"
    ln -s f "$gnu_noarg_dir/symlink" 2>/dev/null || true
    touch "$gnu_noarg_dir/afile"

    run_stdout_test "gnu: ls -1 lists current dir contents" \
        "cd '$gnu_noarg_dir' && $LS_ENV $GNU_TOOL -1" \
        "cd '$gnu_noarg_dir' && $LS_ENV $F_TOOL -1"

    # From no-arg.sh: ls -R1 lists recursively from cwd
    run_stdout_test "gnu: ls -R1 recursive from cwd" \
        "cd '$gnu_noarg_dir' && $LS_ENV $GNU_TOOL -R1" \
        "cd '$gnu_noarg_dir' && $LS_ENV $F_TOOL -R1"

    echo ""
    echo "=== GNU Upstream: Recursive Blank Lines ==="

    # From recursive.sh: -R includes blank lines between directory groups
    local gnu_rec_dir
    gnu_rec_dir=$(mktemp -d /tmp/fcoreutils_ls_rec_XXXXXX)
    register_temp "$gnu_rec_dir"

    mkdir -p "$gnu_rec_dir/a/1" "$gnu_rec_dir/a/2" "$gnu_rec_dir/a/3" \
             "$gnu_rec_dir/b" "$gnu_rec_dir/c"
    touch "$gnu_rec_dir/a/1/I" "$gnu_rec_dir/a/1/II"

    run_stdout_test "gnu: -R1 blank lines between groups" \
        "$LS_ENV $GNU_TOOL -R1 '$gnu_rec_dir/a' '$gnu_rec_dir/b' '$gnu_rec_dir/c'" \
        "$LS_ENV $F_TOOL -R1 '$gnu_rec_dir/a' '$gnu_rec_dir/b' '$gnu_rec_dir/c'"

    # From recursive.sh: -R with mix of files and dirs
    touch "$gnu_rec_dir/f"
    mkdir "$gnu_rec_dir/x" "$gnu_rec_dir/y"

    run_stdout_test "gnu: -R1 mixed files and dirs" \
        "$LS_ENV $GNU_TOOL -R1 '$gnu_rec_dir/x' '$gnu_rec_dir/y' '$gnu_rec_dir/f'" \
        "$LS_ENV $F_TOOL -R1 '$gnu_rec_dir/x' '$gnu_rec_dir/y' '$gnu_rec_dir/f'"

    echo ""
    echo "=== GNU Upstream: --time-style Diagnostics ==="

    # From time-style-diag.sh: invalid --time-style argument should fail with exit 2
    run_exit_code_test "gnu: --time-style=XX invalid" \
        "$GNU_TOOL -l --time-style=XX 2>&1" \
        "$F_TOOL -l --time-style=XX 2>&1"

    echo ""
    echo "=== GNU Upstream: -x Option (Horizontal Sort) ==="

    # From x-option.sh: -x lists entries in rows
    mkdir "$gnu_test_dir/x_dir"
    touch "$gnu_test_dir/x_dir/b" "$gnu_test_dir/x_dir/a"

    run_stdout_test "gnu: -x horizontal listing" \
        "$LS_ENV $GNU_TOOL -x '$gnu_test_dir/x_dir'" \
        "$LS_ENV $F_TOOL -x '$gnu_test_dir/x_dir'"

    run_stdout_test "gnu: -rx reverse horizontal listing" \
        "$LS_ENV $GNU_TOOL -rx '$gnu_test_dir/x_dir'" \
        "$LS_ENV $F_TOOL -rx '$gnu_test_dir/x_dir'"

    echo ""
    echo "=== GNU Upstream: Hex/Octal Width and Tab Options ==="

    # From hex-option.sh: -T and -w accept hex and octal numbers
    run_exit_code_test "gnu: -x -T0x10 -w010 accepts hex/oct" \
        "$GNU_TOOL -x -T0x10 -w010 2>&1" \
        "$F_TOOL -x -T0x10 -w010 2>&1"

    echo ""
    echo "=== GNU Upstream: --zero Option ==="

    # From zero-option.sh: --zero produces NUL-terminated output
    mkdir "$gnu_test_dir/zero_dir"
    touch "$gnu_test_dir/zero_dir/a" "$gnu_test_dir/zero_dir/b" "$gnu_test_dir/zero_dir/cc"

    run_stdout_test "gnu: --zero NUL-terminated output" \
        "LC_ALL=C $GNU_TOOL --zero '$gnu_test_dir/zero_dir'" \
        "LC_ALL=C $F_TOOL --zero '$gnu_test_dir/zero_dir'"

    # From zero-option.sh: --zero overrides -x -m -C
    run_stdout_test "gnu: --zero overrides -x -m -C" \
        "LC_ALL=C $GNU_TOOL -x -m -C --zero '$gnu_test_dir/zero_dir'" \
        "LC_ALL=C $F_TOOL -x -m -C --zero '$gnu_test_dir/zero_dir'"

    # From zero-option.sh: -l --zero is allowed
    run_exit_code_test "gnu: -l --zero is allowed" \
        "LC_ALL=C $GNU_TOOL -l --zero '$gnu_test_dir/zero_dir' 2>&1" \
        "LC_ALL=C $F_TOOL -l --zero '$gnu_test_dir/zero_dir' 2>&1"

    echo ""
    echo "=== GNU Upstream: -w Option (Width) ==="

    # From w-option.sh: -w with 0 means no limit
    mkdir "$gnu_test_dir/w_dir"
    touch "$gnu_test_dir/w_dir/a" "$gnu_test_dir/w_dir/b"
    chmod a+x "$gnu_test_dir/w_dir/a"

    run_stdout_test "gnu: -w0 -x unlimited width" \
        "$LS_ENV $GNU_TOOL -w0 -x -T1 '$gnu_test_dir/w_dir'" \
        "$LS_ENV $F_TOOL -w0 -x -T1 '$gnu_test_dir/w_dir'"

    run_stdout_test "gnu: -w4 -x narrow width" \
        "$LS_ENV $GNU_TOOL -w4 -x -T0 '$gnu_test_dir/w_dir'" \
        "$LS_ENV $F_TOOL -w4 -x -T0 '$gnu_test_dir/w_dir'"

    # From w-option.sh: negative -w is invalid
    run_exit_code_test "gnu: -w-1 negative width fails" \
        "$GNU_TOOL -w-1 2>&1" \
        "$F_TOOL -w-1 2>&1"

    echo ""
    echo "=== GNU Upstream: Quote Alignment ==="

    # From quote-align.sh: --quoting-style with special chars in name
    mkdir "$gnu_test_dir/quote_dir"
    touch "$gnu_test_dir/quote_dir/a b" "$gnu_test_dir/quote_dir/normal"

    run_stdout_test "gnu: -1 --quoting-style=shell-escape" \
        "$LS_ENV $GNU_TOOL -1 --quoting-style=shell-escape '$gnu_test_dir/quote_dir'" \
        "$LS_ENV $F_TOOL -1 --quoting-style=shell-escape '$gnu_test_dir/quote_dir'"

    run_stdout_test "gnu: -1 --quoting-style=c" \
        "$LS_ENV $GNU_TOOL -1 --quoting-style=c '$gnu_test_dir/quote_dir'" \
        "$LS_ENV $F_TOOL -1 --quoting-style=c '$gnu_test_dir/quote_dir'"

    run_stdout_test "gnu: -1 --quoting-style=escape" \
        "$LS_ENV $GNU_TOOL -1 --quoting-style=escape '$gnu_test_dir/quote_dir'" \
        "$LS_ENV $F_TOOL -1 --quoting-style=escape '$gnu_test_dir/quote_dir'"

    # Cleanup GNU upstream test dirs
    rm -rf "$gnu_test_dir"

    # === Section 19: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent path" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    echo ""
    echo "=== Additional ls Tests ==="

    run_stdout_test "sort by size -S" \
        "$LS_ENV $GNU_TOOL -S /tmp 2>/dev/null | head -5" \
        "$LS_ENV $F_TOOL -S /tmp 2>/dev/null | head -5"

    run_stdout_test "no color output" \
        "$LS_ENV $GNU_TOOL --color=never /tmp 2>/dev/null | head -5" \
        "$LS_ENV $F_TOOL --color=never /tmp 2>/dev/null | head -5"

    run_stdout_test "numeric uid/gid -n" \
        "$LS_ENV $GNU_TOOL -n '$test_dir' 2>/dev/null" \
        "$LS_ENV $F_TOOL -n '$test_dir' 2>/dev/null"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_ls_tests
