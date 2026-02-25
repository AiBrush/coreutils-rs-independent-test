#!/usr/bin/env bash
# Compatibility tests for freadlink vs GNU readlink
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "readlink")
F_TOOL="freadlink"

run_readlink_tests() {
    init_test_suite "readlink"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"readlink","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/readlink_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU readlink not found, cannot compare" >&2
        return 1
    fi

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_readlink_test_XXXXXX)
    register_temp "$WORK_DIR"

    # Setup test symlinks
    echo "target content" > "$WORK_DIR/target.txt"
    ln -sf "$WORK_DIR/target.txt" "$WORK_DIR/link1" 2>/dev/null || true
    ln -sf "$WORK_DIR/link1" "$WORK_DIR/link2" 2>/dev/null || true
    ln -sf "relative_target.txt" "$WORK_DIR/rellink" 2>/dev/null || true
    echo "rel target" > "$WORK_DIR/relative_target.txt"
    ln -sf "/nonexistent/path_$$" "$WORK_DIR/broken" 2>/dev/null || true

    echo ""
    echo "=== Basic Readlink ==="

    run_test "read symlink target" \
        "$GNU_TOOL '$WORK_DIR/link1'" \
        "$F_TOOL '$WORK_DIR/link1'"

    run_test "read chained symlink (one level)" \
        "$GNU_TOOL '$WORK_DIR/link2'" \
        "$F_TOOL '$WORK_DIR/link2'"

    run_test "relative symlink" \
        "$GNU_TOOL '$WORK_DIR/rellink'" \
        "$F_TOOL '$WORK_DIR/rellink'"

    run_test "broken symlink (read target)" \
        "$GNU_TOOL '$WORK_DIR/broken'" \
        "$F_TOOL '$WORK_DIR/broken'"

    echo ""
    echo "=== Canonicalize (-f) ==="

    run_test "-f resolve fully" \
        "$GNU_TOOL -f '$WORK_DIR/link1'" \
        "$F_TOOL -f '$WORK_DIR/link1'"

    run_test "-f chained symlinks" \
        "$GNU_TOOL -f '$WORK_DIR/link2'" \
        "$F_TOOL -f '$WORK_DIR/link2'"

    run_test "-f regular file" \
        "$GNU_TOOL -f '$WORK_DIR/target.txt'" \
        "$F_TOOL -f '$WORK_DIR/target.txt'"

    run_test "-f directory" \
        "$GNU_TOOL -f '$WORK_DIR'" \
        "$F_TOOL -f '$WORK_DIR'"

    echo ""
    echo "=== Canonicalize Existing (-e) ==="

    run_test "-e existing file" \
        "$GNU_TOOL -e '$WORK_DIR/link1'" \
        "$F_TOOL -e '$WORK_DIR/link1'"

    run_exit_code_test "-e nonexistent target" \
        "$GNU_TOOL -e '$WORK_DIR/broken' 2>&1" \
        "$F_TOOL -e '$WORK_DIR/broken' 2>&1"

    echo ""
    echo "=== Canonicalize Missing (-m) ==="

    run_test "-m with nonexistent final component" \
        "$GNU_TOOL -m '$WORK_DIR/nonexistent_file'" \
        "$F_TOOL -m '$WORK_DIR/nonexistent_file'"

    echo ""
    echo "=== No Newline (-n) ==="

    run_test "-n no trailing newline" \
        "$GNU_TOOL -n '$WORK_DIR/link1' | od -c" \
        "$F_TOOL -n '$WORK_DIR/link1' | od -c"

    echo ""
    echo "=== Zero Terminated (-z) ==="

    run_test "-z null terminated" \
        "$GNU_TOOL -z '$WORK_DIR/link1' | od -c" \
        "$F_TOOL -z '$WORK_DIR/link1' | od -c"

    echo ""
    echo "=== Verbose (-v) ==="

    run_stdout_test "-v verbose" \
        "$GNU_TOOL -v '$WORK_DIR/link1'" \
        "$F_TOOL -v '$WORK_DIR/link1'"

    echo ""
    echo "=== Non-Symlink (should fail) ==="

    run_exit_code_test "regular file (no -f)" \
        "$GNU_TOOL '$WORK_DIR/target.txt' 2>&1" \
        "$F_TOOL '$WORK_DIR/target.txt' 2>&1"

    run_exit_code_test "directory (no -f)" \
        "$GNU_TOOL '$WORK_DIR' 2>&1" \
        "$F_TOOL '$WORK_DIR' 2>&1"

    echo ""
    echo "=== Multiple Files ==="

    run_test "multiple symlinks" \
        "$GNU_TOOL '$WORK_DIR/link1' '$WORK_DIR/link2'" \
        "$F_TOOL '$WORK_DIR/link1' '$WORK_DIR/link2'"

    # === GNU Upstream: Basic Readlink (rl-1) ===
    echo ""
    echo "=== GNU Upstream: Basic Readlink (rl-1) ==="

    # From rl-1.sh: readlink on symlink to missing target still succeeds
    ln -sf "missing_target_$$" "$WORK_DIR/link_to_missing" 2>/dev/null || true
    run_test "readlink symlink to missing" \
        "$GNU_TOOL '$WORK_DIR/link_to_missing'" \
        "$F_TOOL '$WORK_DIR/link_to_missing'"

    # readlink on a directory should fail
    mkdir -p "$WORK_DIR/rl_subdir"
    run_exit_code_test "readlink on directory" \
        "$GNU_TOOL '$WORK_DIR/rl_subdir' 2>&1" \
        "$F_TOOL '$WORK_DIR/rl_subdir' 2>&1"

    # readlink on a missing file should fail
    run_exit_code_test "readlink on missing file" \
        "$GNU_TOOL '$WORK_DIR/truly_missing_$$' 2>&1" \
        "$F_TOOL '$WORK_DIR/truly_missing_$$' 2>&1"

    # === GNU Upstream: Canonicalize -e ===
    echo ""
    echo "=== GNU Upstream: Canonicalize -e ==="

    # From can-e.sh: -e on regular file
    run_test "-e on regular file" \
        "$GNU_TOOL -e '$WORK_DIR/target.txt'" \
        "$F_TOOL -e '$WORK_DIR/target.txt'"

    # -e on regfile/ should fail (trailing slash on non-directory)
    run_exit_code_test "-e regfile/ (trailing slash)" \
        "$GNU_TOOL -e '$WORK_DIR/target.txt/' 2>&1" \
        "$F_TOOL -e '$WORK_DIR/target.txt/' 2>&1"

    # -e on symlink to missing should fail
    run_exit_code_test "-e on broken link" \
        "$GNU_TOOL -e '$WORK_DIR/broken' 2>&1" \
        "$F_TOOL -e '$WORK_DIR/broken' 2>&1"

    # -e on a symlink to a dir with trailing slash
    mkdir -p "$WORK_DIR/rl_dir"
    ln -sf "$WORK_DIR/rl_dir" "$WORK_DIR/link_to_dir" 2>/dev/null || true
    run_test "-e symlink to dir with slash" \
        "$GNU_TOOL -e '$WORK_DIR/link_to_dir/'" \
        "$F_TOOL -e '$WORK_DIR/link_to_dir/'"

    # === GNU Upstream: Canonicalize -f ===
    echo ""
    echo "=== GNU Upstream: Canonicalize -f ==="

    # From can-f.sh: -f on missing file resolves to expected path
    run_test "-f on missing path" \
        "$GNU_TOOL -f '$WORK_DIR/missing_file_$$'" \
        "$F_TOOL -f '$WORK_DIR/missing_file_$$'"

    # -f on symlink to missing resolves to missing path
    ln -sf "missing_$$" "$WORK_DIR/link3" 2>/dev/null || true
    run_test "-f symlink to missing" \
        "$GNU_TOOL -f '$WORK_DIR/link3'" \
        "$F_TOOL -f '$WORK_DIR/link3'"

    # -f on self-referencing symlink should fail
    ln -sf "$WORK_DIR/link_self" "$WORK_DIR/link_self" 2>/dev/null || true
    run_exit_code_test "-f self-referencing symlink" \
        "$GNU_TOOL -f '$WORK_DIR/link_self' 2>&1" \
        "$F_TOOL -f '$WORK_DIR/link_self' 2>&1"

    # === GNU Upstream: Canonicalize -m ===
    echo ""
    echo "=== GNU Upstream: Canonicalize -m ==="

    # From can-m.sh: -m on missing path always succeeds
    run_test "-m on deep missing path" \
        "$GNU_TOOL -m '$WORK_DIR/missing/more'" \
        "$F_TOOL -m '$WORK_DIR/missing/more'"

    # -m resolves through symlinks even with missing final component
    run_test "-m through symlink to dir" \
        "$GNU_TOOL -m '$WORK_DIR/link_to_dir/nonexist'" \
        "$F_TOOL -m '$WORK_DIR/link_to_dir/nonexist'"

    # === GNU Upstream: Multiple Args ===
    echo ""
    echo "=== GNU Upstream: Multiple Args ==="

    # From multi.sh: multiple readlink calls
    run_test "readlink two valid links" \
        "$GNU_TOOL '$WORK_DIR/link1' '$WORK_DIR/link1'" \
        "$F_TOOL '$WORK_DIR/link1' '$WORK_DIR/link1'"

    # one good + one bad -> exit code 1
    run_exit_code_test "one valid one invalid" \
        "$GNU_TOOL '$WORK_DIR/link1' '$WORK_DIR/nonexist_$$' 2>&1" \
        "$F_TOOL '$WORK_DIR/link1' '$WORK_DIR/nonexist_$$' 2>&1"

    # -m with multiple args always succeeds
    run_test "-m multiple args" \
        "$GNU_TOOL -m '$WORK_DIR/link1' '$WORK_DIR/nonexist_$$'" \
        "$F_TOOL -m '$WORK_DIR/link1' '$WORK_DIR/nonexist_$$'"

    # === GNU Upstream: Symlink Loop Detection ===
    echo ""
    echo "=== GNU Upstream: Symlink Loop Detection ==="

    # From readlink-fp-loop.sh: trivial loop detection
    ln -sf "$WORK_DIR/loop_link" "$WORK_DIR/loop_link" 2>/dev/null || true
    run_exit_code_test "-e on trivial symlink loop" \
        "$GNU_TOOL -e '$WORK_DIR/loop_link' 2>&1" \
        "$F_TOOL -e '$WORK_DIR/loop_link' 2>&1"

    # === GNU Upstream: Root Path Canonicalization ===
    echo ""
    echo "=== GNU Upstream: Root Path Canonicalization ==="

    # From readlink-root.sh: canonicalize / variants
    run_test "-e on /" \
        "$GNU_TOOL -e /" \
        "$F_TOOL -e /"

    run_test "-e on ///" \
        "$GNU_TOOL -e ///" \
        "$F_TOOL -e ///"

    run_test "-e on /dev" \
        "$GNU_TOOL -e /dev" \
        "$F_TOOL -e /dev"

    # From readlink-root.sh: canonicalize with dot-dot through root
    run_test "-e on /./.." \
        "$GNU_TOOL -e /./.. " \
        "$F_TOOL -e /./.. "

    run_test "-f on /dev" \
        "$GNU_TOOL -f /dev" \
        "$F_TOOL -f /dev"

    # === GNU Upstream: Canonicalize -e Edge Cases ===
    echo ""
    echo "=== GNU Upstream: Canonicalize -e Edge Cases ==="

    # From can-e.sh: -e on link to file with trailing slash should fail
    run_exit_code_test "-e link-to-file with trailing slash" \
        "$GNU_TOOL -e '$WORK_DIR/link1/' 2>&1" \
        "$F_TOOL -e '$WORK_DIR/link1/' 2>&1"

    # From can-e.sh: -e on link-to-file/more should fail
    run_exit_code_test "-e link-to-file/more" \
        "$GNU_TOOL -e '$WORK_DIR/link1/more' 2>&1" \
        "$F_TOOL -e '$WORK_DIR/link1/more' 2>&1"

    # From can-e.sh: -e on ./subdir/ with trailing slash
    run_test "-e subdir with trailing slash" \
        "$GNU_TOOL -e '$WORK_DIR/rl_dir/'" \
        "$F_TOOL -e '$WORK_DIR/rl_dir/'"

    # From can-e.sh: -e on link to subdir with /more (missing inside real dir)
    run_exit_code_test "-e link-to-dir/missing-child" \
        "$GNU_TOOL -e '$WORK_DIR/link_to_dir/nonexistent_$$' 2>&1" \
        "$F_TOOL -e '$WORK_DIR/link_to_dir/nonexistent_$$' 2>&1"

    # === GNU Upstream: Canonicalize -f Edge Cases ===
    echo ""
    echo "=== GNU Upstream: Canonicalize -f Edge Cases ==="

    # From can-f.sh: -f on regfile/ with trailing slash should fail
    run_exit_code_test "-f regfile with trailing slash" \
        "$GNU_TOOL -f '$WORK_DIR/target.txt/' 2>&1" \
        "$F_TOOL -f '$WORK_DIR/target.txt/' 2>&1"

    # From can-f.sh: -f on subdir/missing resolves to expected path
    run_test "-f subdir/nonexist" \
        "$GNU_TOOL -f '$WORK_DIR/rl_dir/nonexist'" \
        "$F_TOOL -f '$WORK_DIR/rl_dir/nonexist'"

    # From can-f.sh: -f on link-to-dir/nonexist resolves through symlink
    run_test "-f link-to-dir/nonexist" \
        "$GNU_TOOL -f '$WORK_DIR/link_to_dir/nonexist'" \
        "$F_TOOL -f '$WORK_DIR/link_to_dir/nonexist'"

    # From can-f.sh: -f on link-to-file with trailing slash should fail
    run_exit_code_test "-f link-to-file with trailing slash" \
        "$GNU_TOOL -f '$WORK_DIR/link1/' 2>&1" \
        "$F_TOOL -f '$WORK_DIR/link1/' 2>&1"

    # From can-f.sh: -f on symlink to subdir/missing (link4 equivalent)
    ln -sf "$WORK_DIR/rl_dir/missing_sub_$$" "$WORK_DIR/link4" 2>/dev/null || true
    run_test "-f link to subdir/missing" \
        "$GNU_TOOL -f '$WORK_DIR/link4'" \
        "$F_TOOL -f '$WORK_DIR/link4'"

    # === GNU Upstream: Canonicalize -m Edge Cases ===
    echo ""
    echo "=== GNU Upstream: Canonicalize -m Edge Cases ==="

    # From can-m.sh: -m on regfile/ with trailing slash (always succeeds)
    run_test "-m regfile with trailing slash" \
        "$GNU_TOOL -m '$WORK_DIR/target.txt/'" \
        "$F_TOOL -m '$WORK_DIR/target.txt/'"

    # From can-m.sh: -m on regfile/more (always succeeds)
    run_test "-m regfile/more" \
        "$GNU_TOOL -m '$WORK_DIR/target.txt/more'" \
        "$F_TOOL -m '$WORK_DIR/target.txt/more'"

    # From can-m.sh: -m on subdir/more/more2 (deeply nested missing)
    run_test "-m subdir/more/more2" \
        "$GNU_TOOL -m '$WORK_DIR/rl_dir/more/more2'" \
        "$F_TOOL -m '$WORK_DIR/rl_dir/more/more2'"

    # From can-m.sh: -m on link to missing with /more
    run_test "-m link-to-missing/more" \
        "$GNU_TOOL -m '$WORK_DIR/link_to_missing/more'" \
        "$F_TOOL -m '$WORK_DIR/link_to_missing/more'"

    # === GNU Upstream: POSIXLY_CORRECT Behavior ===
    echo ""
    echo "=== GNU Upstream: POSIXLY_CORRECT Behavior ==="

    # From readlink-posix.sh: POSIXLY_CORRECT readlink on non-symlink should error
    run_exit_code_test "POSIXLY_CORRECT readlink on regular file" \
        "POSIXLY_CORRECT=1 $GNU_TOOL '$WORK_DIR/target.txt' 2>&1" \
        "POSIXLY_CORRECT=1 $F_TOOL '$WORK_DIR/target.txt' 2>&1"

    # From readlink-posix.sh: POSIXLY_CORRECT readlink on symlink succeeds
    run_test "POSIXLY_CORRECT readlink on symlink" \
        "POSIXLY_CORRECT=1 $GNU_TOOL '$WORK_DIR/link1'" \
        "POSIXLY_CORRECT=1 $F_TOOL '$WORK_DIR/link1'"

    # From readlink-posix.sh: -f/-e/-m still work under POSIXLY_CORRECT
    run_test "POSIXLY_CORRECT -f on regular file" \
        "POSIXLY_CORRECT=1 $GNU_TOOL -f '$WORK_DIR/target.txt'" \
        "POSIXLY_CORRECT=1 $F_TOOL -f '$WORK_DIR/target.txt'"

    run_test "POSIXLY_CORRECT -e on regular file" \
        "POSIXLY_CORRECT=1 $GNU_TOOL -e '$WORK_DIR/target.txt'" \
        "POSIXLY_CORRECT=1 $F_TOOL -e '$WORK_DIR/target.txt'"

    run_test "POSIXLY_CORRECT -m on regular file" \
        "POSIXLY_CORRECT=1 $GNU_TOOL -m '$WORK_DIR/target.txt'" \
        "POSIXLY_CORRECT=1 $F_TOOL -m '$WORK_DIR/target.txt'"

    # === GNU Upstream: Multi Args with --zero ===
    echo ""
    echo "=== GNU Upstream: Multi Args with --zero ==="

    # From multi.sh: readlink -m --zero outputs NUL-separated paths
    run_test "-m --zero with multiple args" \
        "$GNU_TOOL -m --zero /tmp /tmp | od -c" \
        "$F_TOOL -m --zero /tmp /tmp | od -c"

    # From multi.sh: three args with mixed valid/invalid
    run_exit_code_test "three args: valid invalid valid" \
        "$GNU_TOOL '$WORK_DIR/link1' '$WORK_DIR/nonexist_3arg_$$' '$WORK_DIR/link1' 2>&1" \
        "$F_TOOL '$WORK_DIR/link1' '$WORK_DIR/nonexist_3arg_$$' '$WORK_DIR/link1' 2>&1"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL '/tmp/nonexistent_$$' 2>&1" \
        "$F_TOOL '/tmp/nonexistent_$$' 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # Clean up
    rm -rf "$WORK_DIR"


    finish_test_suite
}

run_readlink_tests
