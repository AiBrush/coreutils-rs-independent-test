#!/usr/bin/env bash
# Compatibility tests for fstat vs GNU stat
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

GNU_TOOL="stat"
F_TOOL="fstat"

run_stat_tests() {
    init_test_suite "stat"
    ensure_test_data

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"stat","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/stat_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU stat not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_stat_XXXXXX)
    register_temp "$test_dir"

    # Create test fixtures
    echo "test content" > "$test_dir/regular_file"
    chmod 644 "$test_dir/regular_file"
    mkdir "$test_dir/a_directory"
    ln -s "$test_dir/regular_file" "$test_dir/a_symlink"
    mkfifo "$test_dir/a_pipe" 2>/dev/null || true

    # === Section 1: Default Output ===
    echo ""
    echo "=== Default Output ==="

    run_stdout_test "default stat regular file" \
        "$GNU_TOOL '$test_dir/regular_file'" \
        "$F_TOOL '$test_dir/regular_file'"

    run_stdout_test "default stat directory" \
        "$GNU_TOOL '$test_dir/a_directory'" \
        "$F_TOOL '$test_dir/a_directory'"

    # === Section 2: Format Specifiers (-c) ===
    echo ""
    echo "=== Format Specifiers (-c) ==="

    run_stdout_test "%s file size" \
        "$GNU_TOOL -c '%s' '$test_dir/regular_file'" \
        "$F_TOOL -c '%s' '$test_dir/regular_file'"

    run_stdout_test "%a octal permissions" \
        "$GNU_TOOL -c '%a' '$test_dir/regular_file'" \
        "$F_TOOL -c '%a' '$test_dir/regular_file'"

    run_stdout_test "%A human permissions" \
        "$GNU_TOOL -c '%A' '$test_dir/regular_file'" \
        "$F_TOOL -c '%A' '$test_dir/regular_file'"

    run_stdout_test "%u owner UID" \
        "$GNU_TOOL -c '%u' '$test_dir/regular_file'" \
        "$F_TOOL -c '%u' '$test_dir/regular_file'"

    run_stdout_test "%U owner name" \
        "$GNU_TOOL -c '%U' '$test_dir/regular_file'" \
        "$F_TOOL -c '%U' '$test_dir/regular_file'"

    run_stdout_test "%g group GID" \
        "$GNU_TOOL -c '%g' '$test_dir/regular_file'" \
        "$F_TOOL -c '%g' '$test_dir/regular_file'"

    run_stdout_test "%G group name" \
        "$GNU_TOOL -c '%G' '$test_dir/regular_file'" \
        "$F_TOOL -c '%G' '$test_dir/regular_file'"

    run_stdout_test "%h hard link count" \
        "$GNU_TOOL -c '%h' '$test_dir/regular_file'" \
        "$F_TOOL -c '%h' '$test_dir/regular_file'"

    run_stdout_test "%i inode" \
        "$GNU_TOOL -c '%i' '$test_dir/regular_file'" \
        "$F_TOOL -c '%i' '$test_dir/regular_file'"

    run_stdout_test "%F file type" \
        "$GNU_TOOL -c '%F' '$test_dir/regular_file'" \
        "$F_TOOL -c '%F' '$test_dir/regular_file'"

    run_stdout_test "%n file name" \
        "$GNU_TOOL -c '%n' '$test_dir/regular_file'" \
        "$F_TOOL -c '%n' '$test_dir/regular_file'"

    run_stdout_test "%d device number" \
        "$GNU_TOOL -c '%d' '$test_dir/regular_file'" \
        "$F_TOOL -c '%d' '$test_dir/regular_file'"

    run_stdout_test "%b blocks allocated" \
        "$GNU_TOOL -c '%b' '$test_dir/regular_file'" \
        "$F_TOOL -c '%b' '$test_dir/regular_file'"

    run_stdout_test "%o optimal block size" \
        "$GNU_TOOL -c '%o' '$test_dir/regular_file'" \
        "$F_TOOL -c '%o' '$test_dir/regular_file'"

    # Combined format
    run_stdout_test "combined format %s %a %U:%G" \
        "$GNU_TOOL -c '%s %a %U:%G' '$test_dir/regular_file'" \
        "$F_TOOL -c '%s %a %U:%G' '$test_dir/regular_file'"

    # === Section 3: File Types ===
    echo ""
    echo "=== File Types ==="

    run_stdout_test "%F for directory" \
        "$GNU_TOOL -c '%F' '$test_dir/a_directory'" \
        "$F_TOOL -c '%F' '$test_dir/a_directory'"

    run_stdout_test "%F for symlink" \
        "$GNU_TOOL -c '%F' '$test_dir/a_symlink'" \
        "$F_TOOL -c '%F' '$test_dir/a_symlink'"

    run_stdout_test "%F for /dev/null (char device)" \
        "$GNU_TOOL -c '%F' /dev/null" \
        "$F_TOOL -c '%F' /dev/null"

    if [[ -p "$test_dir/a_pipe" ]]; then
        run_stdout_test "%F for pipe" \
            "$GNU_TOOL -c '%F' '$test_dir/a_pipe'" \
            "$F_TOOL -c '%F' '$test_dir/a_pipe'"
    else
        skip_test "%F for pipe" "pipe not available"
    fi

    # === Section 4: Filesystem Mode (-f) ===
    echo ""
    echo "=== Filesystem Mode (-f) ==="

    run_stdout_test "-f / filesystem info" \
        "$GNU_TOOL -f /" \
        "$F_TOOL -f /"

    run_stdout_test "-f -c %T filesystem type" \
        "$GNU_TOOL -f -c '%T' /" \
        "$F_TOOL -f -c '%T' /"

    # === Section 5: Terse Mode (-t) ===
    echo ""
    echo "=== Terse Mode (-t) ==="

    run_stdout_test "-t terse output" \
        "$GNU_TOOL -t '$test_dir/regular_file'" \
        "$F_TOOL -t '$test_dir/regular_file'"

    # === Section 6: Dereference (-L) ===
    echo ""
    echo "=== Dereference (-L) ==="

    run_stdout_test "-L dereference symlink" \
        "$GNU_TOOL -L '$test_dir/a_symlink'" \
        "$F_TOOL -L '$test_dir/a_symlink'"

    run_stdout_test "symlink without -L" \
        "$GNU_TOOL '$test_dir/a_symlink'" \
        "$F_TOOL '$test_dir/a_symlink'"

    run_stdout_test "-L -c %F (should be regular file)" \
        "$GNU_TOOL -L -c '%F' '$test_dir/a_symlink'" \
        "$F_TOOL -L -c '%F' '$test_dir/a_symlink'"

    # === Section 7: Error Handling ===
    echo ""
    echo "=== Error Handling ==="

    run_exit_code_test "nonexistent file" \
        "$GNU_TOOL /tmp/nonexistent_$$ 2>&1" \
        "$F_TOOL /tmp/nonexistent_$$ 2>&1"

    run_exit_code_test "--help" \
        "$GNU_TOOL --help" \
        "$F_TOOL --help"

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_stat_tests
