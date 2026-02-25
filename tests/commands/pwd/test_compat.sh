#!/usr/bin/env bash
# Compatibility tests for fpwd vs GNU pwd
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "pwd")
F_TOOL="fpwd"

run_pwd_tests() {
    init_test_suite "pwd"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"pwd","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/pwd_results.json"
        return 0
    fi

    # pwd is a shell builtin, we need the GNU version
    local GNU_PWD
    GNU_PWD=$(command -v pwd 2>/dev/null || which pwd 2>/dev/null)
    if [[ -z "$GNU_PWD" ]]; then
        echo "GNU pwd not found, cannot compare" >&2
        return 1
    fi

    echo ""
    echo "=== Basic Usage ==="

    run_test "default current directory" \
        "$GNU_TOOL" \
        "$F_TOOL"

    run_test "from /tmp" \
        "cd /tmp && $GNU_TOOL && cd -" \
        "cd /tmp && $F_TOOL && cd -"

    run_test "from root" \
        "cd / && $GNU_TOOL && cd -" \
        "cd / && $F_TOOL && cd -"

    echo ""
    echo "=== Logical (-L) ==="

    run_test "-L logical path" \
        "$GNU_TOOL -L" \
        "$F_TOOL -L"

    echo ""
    echo "=== Physical (-P) ==="

    run_test "-P physical path" \
        "$GNU_TOOL -P" \
        "$F_TOOL -P"

    echo ""
    echo "=== Symlinked Directories ==="

    local WORK_DIR
    WORK_DIR=$(mktemp -d /tmp/fcoreutils_pwd_test_XXXXXX)
    register_temp "$WORK_DIR"
    mkdir -p "$WORK_DIR/real_dir"
    ln -sf "$WORK_DIR/real_dir" "$WORK_DIR/link_dir" 2>/dev/null || true

    if [[ -L "$WORK_DIR/link_dir" ]]; then
        run_test "-P through symlink" \
            "cd '$WORK_DIR/link_dir' && $GNU_TOOL -P && cd -" \
            "cd '$WORK_DIR/link_dir' && $F_TOOL -P && cd -"
    fi

    rm -rf "$WORK_DIR"

    echo ""
    echo "=== Exit Code ==="

    run_test "exit code 0" \
        "$GNU_TOOL > /dev/null && echo 'EXIT_OK'" \
        "$F_TOOL > /dev/null && echo 'EXIT_OK'"

    echo ""
    echo "=== GNU Upstream: pwd-option (Logical vs Physical) ==="

    # From pwd-option.sh: test -L, -P, --logical, --physical through symlinks
    local PWD_WORK
    PWD_WORK=$(mktemp -d /tmp/fcoreutils_pwd_opt_XXXXXX)
    register_temp "$PWD_WORK"
    mkdir -p "$PWD_WORK/a/b" 2>/dev/null || true
    ln -sf "$PWD_WORK/a/b" "$PWD_WORK/c" 2>/dev/null || true

    if [[ -L "$PWD_WORK/c" ]]; then
        run_test "-P resolves symlink" \
            "cd '$PWD_WORK/c' && $GNU_TOOL -P && cd -" \
            "cd '$PWD_WORK/c' && $F_TOOL -P && cd -"

        run_test "--physical resolves symlink" \
            "cd '$PWD_WORK/c' && $GNU_TOOL --physical && cd -" \
            "cd '$PWD_WORK/c' && $F_TOOL --physical && cd -"

        # Test that --logical -P uses last option (should be -P)
        run_test "--logical -P last option wins" \
            "cd '$PWD_WORK/c' && $GNU_TOOL --logical -P && cd -" \
            "cd '$PWD_WORK/c' && $F_TOOL --logical -P && cd -"
    fi

    rm -rf "$PWD_WORK"

    # From pwd-option.sh: test that bogus PWD values fall back to -P
    run_test "PWD=bogus falls back to physical" \
        "env PWD=bogus $GNU_TOOL -L" \
        "env PWD=bogus $F_TOOL -L"

    echo ""
    echo "=== GNU Upstream: pwd Default Behavior ==="

    # From pwd-option.sh: default pwd (no flags) uses -P
    run_test "default pwd output" \
        "$GNU_TOOL" \
        "$F_TOOL"

    echo ""
    echo "=== GNU Upstream: pwd POSIXLY_CORRECT ==="

    # From pwd-option.sh: POSIXLY_CORRECT=1 makes pwd use -L by default
    run_test "POSIXLY_CORRECT=1 pwd" \
        "POSIXLY_CORRECT=1 $GNU_TOOL" \
        "POSIXLY_CORRECT=1 $F_TOOL"

    echo ""
    echo "=== GNU Upstream: pwd Bogus PWD Variants ==="

    # From pwd-option.sh: PWD with trailing /. falls back to physical
    run_test "PWD with trailing dot falls back to physical" \
        "env PWD=\"\$(pwd)/.\" $GNU_TOOL -L" \
        "env PWD=\"\$(pwd)/.\" $F_TOOL -L"

    # From pwd-option.sh: PWD with parent ref (..) falls back to physical
    local PWD_BOGUS_WORK
    PWD_BOGUS_WORK=$(mktemp -d /tmp/fcoreutils_pwd_bogus_XXXXXX)
    register_temp "$PWD_BOGUS_WORK"
    mkdir -p "$PWD_BOGUS_WORK/a/b" 2>/dev/null || true

    run_test "PWD with parent ref falls back to physical" \
        "cd '$PWD_BOGUS_WORK/a/b' && env PWD='$PWD_BOGUS_WORK/a/../a/b' $GNU_TOOL -L && cd -" \
        "cd '$PWD_BOGUS_WORK/a/b' && env PWD='$PWD_BOGUS_WORK/a/../a/b' $F_TOOL -L && cd -"

    rm -rf "$PWD_BOGUS_WORK"

    # pwd-long.sh: skipped (requires perl, strace, and very deep directory trees)
    skip_test "pwd with very long path" "Requires perl and strace"

    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "invalid option" \
        "$GNU_TOOL --invalid-option 2>&1" \
        "$F_TOOL --invalid-option 2>&1"


    finish_test_suite
}

run_pwd_tests
