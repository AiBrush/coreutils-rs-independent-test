#!/usr/bin/env bash
# Compatibility tests for fdu vs GNU du
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "du")
F_TOOL="fdu"

run_du_tests() {
    init_test_suite "du"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"du","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/du_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU du not found, cannot compare" >&2
        return 1
    fi

    # Create test directory structure
    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_du_XXXXXX)
    register_temp "$test_dir"

    mkdir -p "$test_dir/a/b/c"
    dd if=/dev/zero of="$test_dir/a/file1" bs=1024 count=10 2>/dev/null
    dd if=/dev/zero of="$test_dir/a/b/file2" bs=1024 count=20 2>/dev/null
    dd if=/dev/zero of="$test_dir/a/b/c/file3" bs=1024 count=5 2>/dev/null
    echo "small" > "$test_dir/a/small.txt"
    touch "$test_dir/a/empty.txt"
    echo "tmp content" > "$test_dir/a/temp.tmp"
    echo "another tmp" > "$test_dir/a/b/other.tmp"

    # === Section 1: Default ===
    echo ""
    echo "=== Default ==="

    run_stdout_test "default du" \
        "$GNU_TOOL '$test_dir'" \
        "$F_TOOL '$test_dir'"

    # === Section 2: Summarize (-s) ===
    echo ""
    echo "=== Summarize (-s) ==="

    run_stdout_test "-s summarize" \
        "$GNU_TOOL -s '$test_dir'" \
        "$F_TOOL -s '$test_dir'"

    # === Section 3: Human Readable (-h) ===
    echo ""
    echo "=== Human Readable (-h) ==="

    run_stdout_test "-sh summary human" \
        "$GNU_TOOL -sh '$test_dir'" \
        "$F_TOOL -sh '$test_dir'"

    run_stdout_test "-h all" \
        "$GNU_TOOL -h '$test_dir'" \
        "$F_TOOL -h '$test_dir'"

    # === Section 4: All Files (-a) ===
    echo ""
    echo "=== All Files (-a) ==="

    run_stdout_test "-a all files" \
        "$GNU_TOOL -a '$test_dir'" \
        "$F_TOOL -a '$test_dir'"

    # === Section 5: Max Depth (-d) ===
    echo ""
    echo "=== Max Depth (-d) ==="

    run_stdout_test "-d 0 (same as -s)" \
        "$GNU_TOOL -d 0 '$test_dir'" \
        "$F_TOOL -d 0 '$test_dir'"

    run_stdout_test "-d 1" \
        "$GNU_TOOL -d 1 '$test_dir'" \
        "$F_TOOL -d 1 '$test_dir'"

    run_stdout_test "-d 2" \
        "$GNU_TOOL -d 2 '$test_dir'" \
        "$F_TOOL -d 2 '$test_dir'"

    # === Section 6: Apparent Size ===
    echo ""
    echo "=== Apparent Size ==="

    run_stdout_test "--apparent-size" \
        "$GNU_TOOL --apparent-size '$test_dir'" \
        "$F_TOOL --apparent-size '$test_dir'"

    run_stdout_test "-b (bytes, apparent)" \
        "$GNU_TOOL -b '$test_dir/a/file1'" \
        "$F_TOOL -b '$test_dir/a/file1'"

    # === Section 7: Total (-c) ===
    echo ""
    echo "=== Total (-c) ==="

    run_stdout_test "-c total" \
        "$GNU_TOOL -c '$test_dir/a' '$test_dir/a/b'" \
        "$F_TOOL -c '$test_dir/a' '$test_dir/a/b'"

    run_stdout_test "-cs total summarized" \
        "$GNU_TOOL -cs '$test_dir/a' '$test_dir/a/b'" \
        "$F_TOOL -cs '$test_dir/a' '$test_dir/a/b'"

    # === Section 8: Block Size ===
    echo ""
    echo "=== Block Size ==="

    run_stdout_test "-k kilobytes" \
        "$GNU_TOOL -k '$test_dir'" \
        "$F_TOOL -k '$test_dir'"

    run_stdout_test "-m megabytes" \
        "$GNU_TOOL -m '$test_dir'" \
        "$F_TOOL -m '$test_dir'"

    run_stdout_test "-B 1 (byte blocks)" \
        "$GNU_TOOL -B 1 '$test_dir/a/file1'" \
        "$F_TOOL -B 1 '$test_dir/a/file1'"

    # === Section 9: Exclude ===
    echo ""
    echo "=== Exclude ==="

    run_stdout_test "--exclude=*.tmp" \
        "$GNU_TOOL --exclude='*.tmp' '$test_dir'" \
        "$F_TOOL --exclude='*.tmp' '$test_dir'"

    # === Section 10: One File System (-x) ===
    echo ""
    echo "=== One File System (-x) ==="

    run_stdout_test "-x stay on one filesystem" \
        "$GNU_TOOL -x '$test_dir'" \
        "$F_TOOL -x '$test_dir'"

    # === Section 11: Separate Dirs (-S) ===
    echo ""
    echo "=== Separate Dirs (-S) ==="

    run_stdout_test "-S separate dirs" \
        "$GNU_TOOL -S '$test_dir'" \
        "$F_TOOL -S '$test_dir'"

    # === Section 12: Null-Terminated (-0) ===
    echo ""
    echo "=== Null-Terminated (-0) ==="

    run_stdout_test "-0 null terminated" \
        "$GNU_TOOL -0 -s '$test_dir'" \
        "$F_TOOL -0 -s '$test_dir'"

    # === GNU Upstream: Basic Directory Size (basic.sh) ===
    echo ""
    echo "=== GNU Upstream: Basic Directory Size ==="

    # From basic.sh: create test structure similar to upstream
    local gnu_test_dir
    gnu_test_dir=$(mktemp -d /tmp/fcoreutils_du_gnu_XXXXXX)
    register_temp "$gnu_test_dir"
    mkdir -p "$gnu_test_dir/a/b" "$gnu_test_dir/d/sub"
    printf '%257s' 'make-sure-the-file-is-non-empty' > "$gnu_test_dir/a/b/F"
    printf '%4096s' 'x' > "$gnu_test_dir/d/1"
    cp "$gnu_test_dir/d/1" "$gnu_test_dir/d/sub/2"

    # Compare du -a output (paths listed in the output)
    run_stdout_test "GNU basic: du -a lists all entries" \
        "$GNU_TOOL -a '$gnu_test_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL -a '$gnu_test_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # Compare du -a -S output (separate dirs, paths only)
    run_stdout_test "GNU basic: du -a -S separate dirs" \
        "$GNU_TOOL -a -S '$gnu_test_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL -a -S '$gnu_test_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # Compare du -s output (just summary path)
    run_stdout_test "GNU basic: du -s summary" \
        "$GNU_TOOL -s '$gnu_test_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//'" \
        "$F_TOOL -s '$gnu_test_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//'"

    # Compare actual sizes match between GNU and F
    run_stdout_test "GNU basic: du -a sizes match" \
        "$GNU_TOOL -a '$gnu_test_dir/a' 2>/dev/null" \
        "$F_TOOL -a '$gnu_test_dir/a' 2>/dev/null"

    # === GNU Upstream: Apparent Size (apparent.sh) ===
    echo ""
    echo "=== GNU Upstream: Apparent Size ==="

    # From apparent.sh: create 100 small files, check -b vs -A -B 1
    local apparent_dir
    apparent_dir=$(mktemp -d /tmp/fcoreutils_du_apparent_XXXXXX)
    register_temp "$apparent_dir"
    mkdir -p "$apparent_dir/d"
    for f in $(seq 1 20); do
        echo foo > "$apparent_dir/d/$f"
    done

    # Check that -b and --apparent-size --block-size=1 produce the same output
    run_stdout_test "GNU apparent: -b matches --apparent-size -B 1" \
        "$GNU_TOOL -b '$apparent_dir/d' 2>/dev/null" \
        "$F_TOOL -b '$apparent_dir/d' 2>/dev/null"

    run_stdout_test "GNU apparent: -A -B 1 matches -b" \
        "$GNU_TOOL -A -B 1 '$apparent_dir/d' 2>/dev/null" \
        "$F_TOOL -A -B 1 '$apparent_dir/d' 2>/dev/null"

    # === GNU Upstream: Max Depth (max-depth.sh) ===
    echo ""
    echo "=== GNU Upstream: Max Depth ==="

    # From max-depth.sh: create deep hierarchy
    local maxdepth_dir
    maxdepth_dir=$(mktemp -d /tmp/fcoreutils_du_maxdepth_XXXXXX)
    register_temp "$maxdepth_dir"
    mkdir -p "$maxdepth_dir/a/b/c/d/e"

    # --max-depth=2 should list only down to level 2
    run_stdout_test "GNU max-depth: --max-depth=2 path listing" \
        "$GNU_TOOL --max-depth=2 '$maxdepth_dir/a' 2>/dev/null | cut -f2- | sort" \
        "$F_TOOL --max-depth=2 '$maxdepth_dir/a' 2>/dev/null | cut -f2- | sort"

    # -d 1 should list only one level deep
    run_stdout_test "GNU max-depth: -d 1 path listing" \
        "$GNU_TOOL -d 1 '$maxdepth_dir/a' 2>/dev/null | cut -f2- | sort" \
        "$F_TOOL -d 1 '$maxdepth_dir/a' 2>/dev/null | cut -f2- | sort"

    # === GNU Upstream: Exclude (exclude.sh) ===
    echo ""
    echo "=== GNU Upstream: Exclude ==="

    # From exclude.sh: create test structure with multiple subdirs
    local exclude_dir
    exclude_dir=$(mktemp -d /tmp/fcoreutils_du_exclude_XXXXXX)
    register_temp "$exclude_dir"
    mkdir -p "$exclude_dir/a/b/c" "$exclude_dir/a/x/y" "$exclude_dir/a/u/v"

    # --exclude=x should omit x and its children
    run_stdout_test "GNU exclude: --exclude=x omits x subtree" \
        "$GNU_TOOL --exclude=x '$exclude_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL --exclude=x '$exclude_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # --exclude-from with file
    local excl_file
    excl_file=$(mktemp /tmp/fcoreutils_test_XXXXXX)
    register_temp "$excl_file"
    printf 'b\n' > "$excl_file"

    run_stdout_test "GNU exclude: --exclude-from omits b subtree" \
        "$GNU_TOOL --exclude-from='$excl_file' '$exclude_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL --exclude-from='$excl_file' '$exclude_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # Exclude entire hierarchy
    run_stdout_test "GNU exclude: --exclude=a excludes everything" \
        "$GNU_TOOL --exclude=a '$exclude_dir/a' 2>/dev/null" \
        "$F_TOOL --exclude=a '$exclude_dir/a' 2>/dev/null"

    # Multiple excludes
    run_stdout_test "GNU exclude: multiple --exclude options" \
        "$GNU_TOOL --exclude='$exclude_dir/a/u' --exclude='$exclude_dir/a/b' '$exclude_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL --exclude='$exclude_dir/a/u' --exclude='$exclude_dir/a/b' '$exclude_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # === GNU Upstream: Trailing Slash (trailing-slash.sh) ===
    echo ""
    echo "=== GNU Upstream: Trailing Slash ==="

    # From trailing-slash.sh: symlink with trailing slash
    local trail_dir
    trail_dir=$(mktemp -d /tmp/fcoreutils_du_trail_XXXXXX)
    register_temp "$trail_dir"
    mkdir -p "$trail_dir/dir/1/2"
    ln -s dir "$trail_dir/slink"

    # du slink/ should follow the symlink and show paths with slink/ prefix
    run_stdout_test "GNU trailing-slash: du slink/ path listing" \
        "$GNU_TOOL '$trail_dir/slink/' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL '$trail_dir/slink/' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # du -L slink (without trailing slash) should also follow
    run_stdout_test "GNU trailing-slash: du -L slink path listing" \
        "$GNU_TOOL -L '$trail_dir/slink' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL -L '$trail_dir/slink' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # === GNU Upstream: Two Arguments (two-args.sh) ===
    echo ""
    echo "=== GNU Upstream: Two Arguments ==="

    # From two-args.sh: du d/1 d/2 should work
    local twoargs_dir
    twoargs_dir=$(mktemp -d /tmp/fcoreutils_du_twoargs_XXXXXX)
    register_temp "$twoargs_dir"
    mkdir -p "$twoargs_dir/t/1" "$twoargs_dir/t/2"

    run_exit_code_test "GNU two-args: du t/1 t/2 succeeds" \
        "$GNU_TOOL '$twoargs_dir/t/1' '$twoargs_dir/t/2' 2>&1" \
        "$F_TOOL '$twoargs_dir/t/1' '$twoargs_dir/t/2' 2>&1"

    # du . t should also work
    run_exit_code_test "GNU two-args: du . t succeeds" \
        "$GNU_TOOL '$twoargs_dir' '$twoargs_dir/t' 2>&1" \
        "$F_TOOL '$twoargs_dir' '$twoargs_dir/t' 2>&1"

    # Compare path listing for multiple args
    run_stdout_test "GNU two-args: du t/1 t/2 path listing" \
        "$GNU_TOOL '$twoargs_dir/t/1' '$twoargs_dir/t/2' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL '$twoargs_dir/t/1' '$twoargs_dir/t/2' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # === GNU Upstream: Hard Links (hard-link.sh) ===
    echo ""
    echo "=== GNU Upstream: Hard Links ==="

    # From hard-link.sh: hard-linked files counted once by default
    local hardlink_dir
    hardlink_dir=$(mktemp -d /tmp/fcoreutils_du_hardlink_XXXXXX)
    register_temp "$hardlink_dir"
    mkdir -p "$hardlink_dir/dir/sub"
    echo 'non-empty' > "$hardlink_dir/dir/f1"
    ln "$hardlink_dir/dir/f1" "$hardlink_dir/dir/f2"
    echo 'non-empty' > "$hardlink_dir/dir/sub/F"

    # With -a --exclude=sub, hard links should be counted once
    # (only one of f1/f2 listed in normal mode)
    run_stdout_test "GNU hard-link: -a --exclude=sub dedup" \
        "$GNU_TOOL -a --exclude=sub '$hardlink_dir/dir' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sed 's/f[12]/f_/' | sort" \
        "$F_TOOL -a --exclude=sub '$hardlink_dir/dir' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sed 's/f[12]/f_/' | sort"

    # With --count-links (-l), hard-linked files counted separately
    local gnu_normal f_normal gnu_countlinks f_countlinks
    gnu_normal=$($GNU_TOOL "$hardlink_dir/dir" 2>/dev/null | head -1 | cut -f1)
    f_normal=$($F_TOOL "$hardlink_dir/dir" 2>/dev/null | head -1 | cut -f1)
    gnu_countlinks=$($GNU_TOOL -l "$hardlink_dir/dir" 2>/dev/null | head -1 | cut -f1)
    f_countlinks=$($F_TOOL -l "$hardlink_dir/dir" 2>/dev/null | head -1 | cut -f1)

    TESTS_RUN=$((TESTS_RUN + 1))
    # Both tools should agree that -l produces >= normal size
    if [[ "$gnu_countlinks" -ge "$gnu_normal" ]] && [[ "$f_countlinks" -ge "$f_normal" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: GNU hard-link: --count-links increases size"
        record_result "GNU hard-link: --count-links increases size" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: GNU hard-link: --count-links increases size"
        record_result "GNU hard-link: --count-links increases size" "FAIL" "GNU: normal=$gnu_normal countlinks=$gnu_countlinks; F: normal=$f_normal countlinks=$f_countlinks" "" ""
    fi

    # === GNU Upstream: Dereference (deref.sh) ===
    echo ""
    echo "=== GNU Upstream: Dereference ==="

    # From deref.sh: -L on dangling symlink should fail
    local deref_dir
    deref_dir=$(mktemp -d /tmp/fcoreutils_du_deref_XXXXXX)
    register_temp "$deref_dir"
    mkdir -p "$deref_dir/a/sub"
    ln -s nowhere "$deref_dir/dangle"

    run_exit_code_test "GNU deref: -L on dangling symlink fails" \
        "$GNU_TOOL -L '$deref_dir/dangle' 2>&1" \
        "$F_TOOL -L '$deref_dir/dangle' 2>&1"

    # === GNU Upstream: Dereference Args (deref-args.sh) ===
    echo ""
    echo "=== GNU Upstream: Dereference Args ==="

    # From deref-args.sh: -D follows symlink for argument
    local derefargs_dir
    derefargs_dir=$(mktemp -d /tmp/fcoreutils_du_derefargs_XXXXXX)
    register_temp "$derefargs_dir"
    mkdir -p "$derefargs_dir/dir/a"
    ln -s dir "$derefargs_dir/slink"

    # -D slink should show slink/a and slink
    run_stdout_test "GNU deref-args: -D slink path listing" \
        "$GNU_TOOL -D '$derefargs_dir/slink' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL -D '$derefargs_dir/slink' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # -D slink/ with trailing slash should also work
    run_stdout_test "GNU deref-args: -D slink/ path listing" \
        "$GNU_TOOL -D '$derefargs_dir/slink/' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL -D '$derefargs_dir/slink/' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # === GNU Upstream: Slash in Args (slash.sh) ===
    echo ""
    echo "=== GNU Upstream: Slash in Args ==="

    # From slash.sh: du / should preserve the / path in output
    # We use --exclude to limit traversal and just check the path format
    run_stdout_test "GNU slash: du --exclude='[^/]*' -x -s / path" \
        "$GNU_TOOL --exclude='[^/]*' -x -s / 2>/dev/null | sed 's/^[0-9][0-9]*	//'" \
        "$F_TOOL --exclude='[^/]*' -x -s / 2>/dev/null | sed 's/^[0-9][0-9]*	//'"

    # === GNU Upstream: Threshold (threshold.sh) ===
    echo ""
    echo "=== GNU Upstream: Threshold ==="

    # From threshold.sh: invalid threshold argument should fail
    run_exit_code_test "GNU threshold: invalid --threshold=SIZE fails" \
        "$GNU_TOOL --threshold=SIZE '$gnu_test_dir/a' 2>&1" \
        "$F_TOOL --threshold=SIZE '$gnu_test_dir/a' 2>&1"

    run_exit_code_test "GNU threshold: invalid -t SIZE fails" \
        "$GNU_TOOL -t SIZE '$gnu_test_dir/a' 2>&1" \
        "$F_TOOL -t SIZE '$gnu_test_dir/a' 2>&1"

    run_exit_code_test "GNU threshold: --threshold=-0 fails" \
        "$GNU_TOOL --threshold=-0 '$gnu_test_dir/a' 2>&1" \
        "$F_TOOL --threshold=-0 '$gnu_test_dir/a' 2>&1"

    run_exit_code_test "GNU threshold: empty --threshold= fails" \
        "$GNU_TOOL --threshold= '$gnu_test_dir/a' 2>&1" \
        "$F_TOOL --threshold= '$gnu_test_dir/a' 2>&1"

    # From threshold.sh: positive threshold filters small entries
    # Use apparent size for deterministic comparison
    local thresh_dir
    thresh_dir=$(mktemp -d /tmp/fcoreutils_du_thresh_XXXXXX)
    register_temp "$thresh_dir"
    mkdir -p "$thresh_dir/a/b" "$thresh_dir/a/c"
    touch "$thresh_dir/a/b/0"
    printf 'x' > "$thresh_dir/a/b/1"
    printf 'xx' > "$thresh_dir/a/b/2"
    printf 'xxx' > "$thresh_dir/a/b/3"

    # With --apparent-size -t 2 (threshold 2 bytes), small files should be filtered
    run_stdout_test "GNU threshold: --apparent-size --threshold=2 path listing" \
        "$GNU_TOOL --apparent-size -B1 -a --threshold=2 '$thresh_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL --apparent-size -B1 -a --threshold=2 '$thresh_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # Negative threshold: show entries smaller than the value
    run_stdout_test "GNU threshold: negative --threshold path listing" \
        "$GNU_TOOL --apparent-size -B1 -a --threshold=-2 '$thresh_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort" \
        "$F_TOOL --apparent-size -B1 -a --threshold=-2 '$thresh_dir/a' 2>/dev/null | sed 's/^[0-9][0-9]*	//' | sort"

    # Cleanup GNU test directories
    rm -rf "$gnu_test_dir" "$apparent_dir" "$maxdepth_dir" "$exclude_dir" \
           "$trail_dir" "$twoargs_dir" "$hardlink_dir" "$deref_dir" \
           "$derefargs_dir" "$thresh_dir"

    # === Section 13: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent path" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    echo ""
    echo "=== Additional du Tests ==="

    run_stdout_test "max depth 1" \
        "$GNU_TOOL --max-depth=1 /tmp 2>/dev/null | wc -l" \
        "$F_TOOL --max-depth=1 /tmp 2>/dev/null | wc -l"

    run_stdout_test "apparent size" \
        "echo 'hello' > /tmp/du_apparent_test.txt && $GNU_TOOL --apparent-size /tmp/du_apparent_test.txt 2>/dev/null | awk '{print \$1}'" \
        "echo 'hello' > /tmp/du_apparent_test.txt && $F_TOOL --apparent-size /tmp/du_apparent_test.txt 2>/dev/null | awk '{print \$1}'"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_du_tests
