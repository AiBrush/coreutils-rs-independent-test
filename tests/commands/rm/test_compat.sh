#!/usr/bin/env bash
# Compatibility tests for frm vs GNU rm
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "rm")
F_TOOL="frm"

run_rm_tests() {
    init_test_suite "rm"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"rm","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/rm_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU rm not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_rm_XXXXXX)
    register_temp "$test_dir"

    # === Section 1: Simple Remove ===
    echo ""
    echo "=== Simple Remove ==="

    echo "delete me" > "$test_dir/gnu_file1"
    echo "delete me" > "$test_dir/f_file1"

    $GNU_TOOL "$test_dir/gnu_file1"
    $F_TOOL "$test_dir/f_file1"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -f "$test_dir/gnu_file1" ]] && [[ ! -f "$test_dir/f_file1" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: simple remove"
        record_result "simple remove" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: file not removed"
        record_result "simple remove" "FAIL" "file still exists" "" ""
    fi

    # === Section 2: Force (-f) ===
    echo ""
    echo "=== Force (-f) ==="

    run_exit_code_test "rm -f nonexistent (no error)" \
        "$GNU_TOOL -f /tmp/nonexistent_$$" \
        "$F_TOOL -f /tmp/nonexistent_$$"

    # Verify exit 0
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_exit=0 f_exit=0
    $GNU_TOOL -f /tmp/nonexistent_$$ 2>/dev/null || gnu_exit=$?
    $F_TOOL -f /tmp/nonexistent_$$ 2>/dev/null || f_exit=$?
    if [[ "$gnu_exit" -eq 0 ]] && [[ "$f_exit" -eq 0 ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: rm -f nonexistent exits 0"
        record_result "rm -f exit 0" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: rm -f exit codes (GNU=$gnu_exit F=$f_exit)"
        record_result "rm -f exit 0" "FAIL" "GNU=$gnu_exit F=$f_exit" "" ""
    fi

    # === Section 3: Directory Error ===
    echo ""
    echo "=== Directory Error ==="

    mkdir -p "$test_dir/a_dir_gnu" "$test_dir/a_dir_f"

    run_exit_code_test "rm dir without -r (error)" \
        "$GNU_TOOL '$test_dir/a_dir_gnu' 2>&1" \
        "$F_TOOL '$test_dir/a_dir_f' 2>&1"

    # === Section 4: Remove Empty Dir (-d) ===
    echo ""
    echo "=== Remove Empty Dir (-d) ==="

    mkdir "$test_dir/gnu_emptydir"
    mkdir "$test_dir/f_emptydir"

    $GNU_TOOL -d "$test_dir/gnu_emptydir" 2>/dev/null || true
    $F_TOOL -d "$test_dir/f_emptydir" 2>/dev/null || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_exists=0 f_exists=0
    [[ -d "$test_dir/gnu_emptydir" ]] && gnu_exists=1
    [[ -d "$test_dir/f_emptydir" ]] && f_exists=1
    if [[ "$gnu_exists" == "$f_exists" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: rm -d empty dir"
        record_result "rm -d empty dir" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: rm -d mismatch"
        record_result "rm -d empty dir" "FAIL" "mismatch" "" ""
    fi

    # === Section 5: Recursive (-r) ===
    echo ""
    echo "=== Recursive (-r) ==="

    mkdir -p "$test_dir/gnu_tree/sub1/sub2"
    echo "a" > "$test_dir/gnu_tree/file1"
    echo "b" > "$test_dir/gnu_tree/sub1/file2"
    echo "c" > "$test_dir/gnu_tree/sub1/sub2/file3"
    cp -r "$test_dir/gnu_tree" "$test_dir/f_tree"

    $GNU_TOOL -rf "$test_dir/gnu_tree"
    $F_TOOL -rf "$test_dir/f_tree"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -d "$test_dir/gnu_tree" ]] && [[ ! -d "$test_dir/f_tree" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: rm -rf removes tree"
        record_result "rm -rf tree" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: rm -rf did not remove tree"
        record_result "rm -rf tree" "FAIL" "tree still exists" "" ""
    fi

    # === Section 6: Verbose (-v) ===
    echo ""
    echo "=== Verbose (-v) ==="

    echo "verbose" > "$test_dir/gnu_vfile"
    echo "verbose" > "$test_dir/f_vfile"

    run_exit_code_test "rm -v" \
        "$GNU_TOOL -v '$test_dir/gnu_vfile' 2>&1" \
        "$F_TOOL -v '$test_dir/f_vfile' 2>&1"

    # === Section 7: Multiple Files ===
    echo ""
    echo "=== Multiple Files ==="

    echo "a" > "$test_dir/gnu_m1"
    echo "b" > "$test_dir/gnu_m2"
    echo "c" > "$test_dir/gnu_m3"
    echo "a" > "$test_dir/f_m1"
    echo "b" > "$test_dir/f_m2"
    echo "c" > "$test_dir/f_m3"

    $GNU_TOOL "$test_dir/gnu_m1" "$test_dir/gnu_m2" "$test_dir/gnu_m3"
    $F_TOOL "$test_dir/f_m1" "$test_dir/f_m2" "$test_dir/f_m3"

    TESTS_RUN=$((TESTS_RUN + 1))
    if [[ ! -f "$test_dir/gnu_m1" ]] && [[ ! -f "$test_dir/f_m1" ]] && \
       [[ ! -f "$test_dir/gnu_m2" ]] && [[ ! -f "$test_dir/f_m2" ]] && \
       [[ ! -f "$test_dir/gnu_m3" ]] && [[ ! -f "$test_dir/f_m3" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: multiple files removed"
        record_result "multiple files" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: not all files removed"
        record_result "multiple files" "FAIL" "files remain" "" ""
    fi

    # === Section 8: Preserve Root ===
    echo ""
    echo "=== Preserve Root ==="

    run_exit_code_test "rm --preserve-root=all -rf /" \
        "$GNU_TOOL --preserve-root=all -rf / 2>&1" \
        "$F_TOOL --preserve-root=all -rf / 2>&1"

    # === GNU Upstream: Recursive Verbose ===
    echo ""
    echo "=== GNU Upstream: Recursive Verbose ==="

    # From r-1.sh: rm --verbose -r removes tree and prints expected output
    local rvdir
    rvdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$rvdir"
    mkdir -p "$rvdir/gnu/a/a" "$rvdir/f/a/a"
    touch "$rvdir/gnu/b" "$rvdir/f/b"

    # Normalize paths: replace the work-directory prefix so that the different
    # subdirectory names (gnu/ vs f/) do not cause a false diff.
    run_stdout_test "GNU r-1: rm --verbose -r tree and file" \
        "$GNU_TOOL --verbose -r '$rvdir/gnu/a' '$rvdir/gnu/b' | sed 's|$rvdir/gnu|WORK|g'" \
        "$F_TOOL --verbose -r '$rvdir/f/a' '$rvdir/f/b' | sed 's|$rvdir/f|WORK|g'"

    # Verify everything was removed
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_gone=1 f_gone=1
    [[ -e "$rvdir/gnu/a" ]] && gnu_gone=0
    [[ -e "$rvdir/gnu/b" ]] && gnu_gone=0
    [[ -e "$rvdir/f/a" ]] && f_gone=0
    [[ -e "$rvdir/f/b" ]] && f_gone=0
    if [[ "$gnu_gone" == "$f_gone" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: recursive verbose removal complete (gone=$gnu_gone)"
        record_result "GNU r-1: tree removed" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: recursive removal mismatch (GNU gone=$gnu_gone F gone=$f_gone)"
        record_result "GNU r-1: tree removed" "FAIL" "GNU=$gnu_gone F=$f_gone" "" ""
    fi

    # === GNU Upstream: Force Nonexistent ===
    echo ""
    echo "=== GNU Upstream: Force Nonexistent ==="

    # From f-1.sh: rm -f dir/no-such-file should exit 0
    local ffdir
    ffdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$ffdir"
    mkdir -p "$ffdir/gnu/d" "$ffdir/f/d"

    run_exit_code_test "GNU f-1: rm -f dir/nonexistent exits 0" \
        "$GNU_TOOL -f '$ffdir/gnu/d/no-such-file'" \
        "$F_TOOL -f '$ffdir/f/d/no-such-file'"

    # === GNU Upstream: Interactive Remove ===
    echo ""
    echo "=== GNU Upstream: Interactive Remove ==="

    # From i-1.sh: rm -i with 'n' input should NOT remove the file
    local iidir
    iidir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$iidir"
    mkdir -p "$iidir/gnu" "$iidir/f"
    echo "data" > "$iidir/gnu/a"
    echo "data" > "$iidir/f/a"
    echo "n" > "$iidir/in_n"
    echo "y" > "$iidir/in_y"

    # Answer 'n' - file should remain
    echo "n" | $GNU_TOOL -i "$iidir/gnu/a" > /dev/null 2>&1 || true
    echo "n" | $F_TOOL -i "$iidir/f/a" > /dev/null 2>&1 || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_kept=0 f_kept=0
    [[ -f "$iidir/gnu/a" ]] && gnu_kept=1
    [[ -f "$iidir/f/a" ]] && f_kept=1
    if [[ "$gnu_kept" == "$f_kept" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: rm -i 'n' keeps file (kept=$gnu_kept)"
        record_result "GNU i-1: rm -i n keeps file" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: rm -i 'n' mismatch (GNU kept=$gnu_kept F kept=$f_kept)"
        record_result "GNU i-1: rm -i n keeps file" "FAIL" "GNU=$gnu_kept F=$f_kept" "" ""
    fi

    # Answer 'y' - file should be removed
    echo "y" | $GNU_TOOL -i "$iidir/gnu/a" > /dev/null 2>&1 || true
    echo "y" | $F_TOOL -i "$iidir/f/a" > /dev/null 2>&1 || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_removed=1 f_removed=1
    [[ -f "$iidir/gnu/a" ]] && gnu_removed=0
    [[ -f "$iidir/f/a" ]] && f_removed=0
    if [[ "$gnu_removed" == "$f_removed" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: rm -i 'y' removes file (removed=$gnu_removed)"
        record_result "GNU i-1: rm -i y removes file" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: rm -i 'y' mismatch (GNU removed=$gnu_removed F removed=$f_removed)"
        record_result "GNU i-1: rm -i y removes file" "FAIL" "GNU=$gnu_removed F=$f_removed" "" ""
    fi

    # === GNU Upstream: Remove Empty Dir (-d) ===
    echo ""
    echo "=== GNU Upstream: Remove Empty Dir (-d) ==="

    # From d-1.sh: rm --verbose --dir removes empty dir and file
    local dddir
    dddir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$dddir"
    mkdir -p "$dddir/gnu/a" "$dddir/f/a"
    touch "$dddir/gnu/b" "$dddir/f/b"

    run_stdout_test "GNU d-1: rm --verbose --dir empty dir and file" \
        "$GNU_TOOL --verbose --dir '$dddir/gnu/a' '$dddir/gnu/b' | sed 's|$dddir/gnu|WORK|g'" \
        "$F_TOOL --verbose --dir '$dddir/f/a' '$dddir/f/b' | sed 's|$dddir/f|WORK|g'"

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_d1_gone=1 f_d1_gone=1
    [[ -e "$dddir/gnu/a" ]] && gnu_d1_gone=0
    [[ -e "$dddir/gnu/b" ]] && gnu_d1_gone=0
    [[ -e "$dddir/f/a" ]] && f_d1_gone=0
    [[ -e "$dddir/f/b" ]] && f_d1_gone=0
    if [[ "$gnu_d1_gone" == "$f_d1_gone" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: --dir removes empty dir+file (gone=$gnu_d1_gone)"
        record_result "GNU d-1: --dir removes empty dir" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: --dir removal mismatch (GNU=$gnu_d1_gone F=$f_d1_gone)"
        record_result "GNU d-1: --dir removes empty dir" "FAIL" "GNU=$gnu_d1_gone F=$f_d1_gone" "" ""
    fi

    # From d-2.sh: rm -d on non-empty dir should fail
    local d2dir
    d2dir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$d2dir"
    mkdir -p "$d2dir/gnu/d" "$d2dir/f/d"
    touch "$d2dir/gnu/d/a" "$d2dir/f/d/a"

    run_exit_code_test "GNU d-2: rm -d non-empty dir fails" \
        "$GNU_TOOL -d '$d2dir/gnu/d' 2>&1" \
        "$F_TOOL -d '$d2dir/f/d' 2>&1"

    # Verify the non-empty dir still exists
    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_d2_exists=0 f_d2_exists=0
    [[ -d "$d2dir/gnu/d" ]] && gnu_d2_exists=1
    [[ -d "$d2dir/f/d" ]] && f_d2_exists=1
    if [[ "$gnu_d2_exists" == "$f_d2_exists" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -d non-empty dir preserved (exists=$gnu_d2_exists)"
        record_result "GNU d-2: non-empty dir preserved" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -d non-empty dir mismatch (GNU=$gnu_d2_exists F=$f_d2_exists)"
        record_result "GNU d-2: non-empty dir preserved" "FAIL" "GNU=$gnu_d2_exists F=$f_d2_exists" "" ""
    fi

    # From d-3.sh: rm -i -d with 'y' should remove empty dir
    local d3dir
    d3dir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$d3dir"
    mkdir -p "$d3dir/gnu/d" "$d3dir/f/d"

    echo "y" | $GNU_TOOL -i -d "$d3dir/gnu/d" > /dev/null 2>&1 || true
    echo "y" | $F_TOOL -i -d "$d3dir/f/d" > /dev/null 2>&1 || true

    TESTS_RUN=$((TESTS_RUN + 1))
    local gnu_d3_gone=1 f_d3_gone=1
    [[ -e "$d3dir/gnu/d" ]] && gnu_d3_gone=0
    [[ -e "$d3dir/f/d" ]] && f_d3_gone=0
    if [[ "$gnu_d3_gone" == "$f_d3_gone" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: -i -d 'y' removes empty dir (gone=$gnu_d3_gone)"
        record_result "GNU d-3: interactive -d removes empty dir" "PASS" "" "" ""
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: -i -d mismatch (GNU gone=$gnu_d3_gone F gone=$f_d3_gone)"
        record_result "GNU d-3: interactive -d removes empty dir" "FAIL" "GNU=$gnu_d3_gone F=$f_d3_gone" "" ""
    fi

    # === GNU Upstream: Ignorable Errors ===
    echo ""
    echo "=== GNU Upstream: Ignorable Errors ==="

    # From ignorable.sh: rm -f existing-non-dir/f should exit 0
    local igdir
    igdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$igdir"
    touch "$igdir/gnu_file" "$igdir/f_file"

    run_exit_code_test "GNU ignorable: rm -f non-dir/child exits 0" \
        "$GNU_TOOL -f '$igdir/gnu_file/f' 2>&1" \
        "$F_TOOL -f '$igdir/f_file/f' 2>&1"

    # === GNU Upstream: Verbose Slash ===
    echo ""
    echo "=== GNU Upstream: Verbose Slash ==="

    # From v-slash.sh: rm --verbose -r a/// should avoid extra slashes in output
    local vsdir
    vsdir=$(mktemp -d /tmp/fcoreutils_test_XXXXXX)
    register_temp "$vsdir"
    mkdir -p "$vsdir/gnu/a" "$vsdir/f/a"
    touch "$vsdir/gnu/a/x" "$vsdir/f/a/x"

    run_stdout_test "GNU v-slash: rm -rv with trailing slashes" \
        "$GNU_TOOL --verbose -r '$vsdir/gnu/a///' | sed 's|$vsdir/gnu|WORK|g'" \
        "$F_TOOL --verbose -r '$vsdir/f/a///' | sed 's|$vsdir/f|WORK|g'"

    # === Section 9: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "rm nonexistent (error)" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    run_exit_code_test "no arguments" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # Cleanup
    rm -rf "$test_dir"


    finish_test_suite
}

run_rm_tests
