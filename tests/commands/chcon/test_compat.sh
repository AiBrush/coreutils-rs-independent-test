#!/usr/bin/env bash
# Compatibility tests for fchcon vs GNU chcon
# Includes scenarios from GNU coreutils upstream tests
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

GNU_TOOL=$(resolve_gnu_tool "chcon")
F_TOOL="fchcon"

run_chcon_tests() {
    init_test_suite "chcon"

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chcon","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chcon_results.json"
        return 0
    fi

    if ! check_tool_exists "$GNU_TOOL"; then
        echo "GNU chcon not found, cannot compare" >&2
        return 1
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_chcon_$$_XXXXXX)
    register_temp "$test_dir"

    # Check if SELinux is available
    local selinux_available=false
    if command -v getenforce >/dev/null 2>&1; then
        if [[ "$(getenforce 2>/dev/null)" != "Disabled" ]]; then
            selinux_available=true
        fi
    fi

    # ════════════════════════════════════════════════════════════════════════
    # Section 1: Argument Validation / Error Handling (no SELinux needed)
    # ════════════════════════════════════════════════════════════════════════
    echo ""
    echo "=== Argument Validation ==="

    # Test 1: chcon_no_args — no arguments should fail
    run_exit_code_test "chcon_no_args" \
        "$GNU_TOOL 2>&1" \
        "$F_TOOL 2>&1"

    # Test 2: chcon_help — --help exit code
    run_exit_code_test "chcon_help" \
        "$GNU_TOOL --help 2>&1" \
        "$F_TOOL --help 2>&1"

    # Test 3: chcon_version — --version exit code
    run_exit_code_test "chcon_version" \
        "$GNU_TOOL --version 2>&1" \
        "$F_TOOL --version 2>&1"

    # Test 4: chcon_nonexistent — chcon on nonexistent file
    run_exit_code_test "chcon_nonexistent" \
        "$GNU_TOOL system_u:object_r:tmp_t:s0 /tmp/nonexistent_chcon_$$ 2>&1" \
        "$F_TOOL system_u:object_r:tmp_t:s0 /tmp/nonexistent_chcon_$$ 2>&1"

    # Test 5: chcon_context_no_file — context but no file
    run_exit_code_test "chcon_context_no_file" \
        "$GNU_TOOL CON 2>&1" \
        "$F_TOOL CON 2>&1"

    # Test 6: chcon_reference_no_target — --reference with file but no target
    echo "test" > "$test_dir/ref_file"
    run_exit_code_test "chcon_reference_no_target" \
        "$GNU_TOOL --reference='$test_dir/ref_file' 2>&1" \
        "$F_TOOL --reference='$test_dir/ref_file' 2>&1"

    # Test 7: chcon_user_no_file — -u without file
    run_exit_code_test "chcon_user_no_file" \
        "$GNU_TOOL -u anyone 2>&1" \
        "$F_TOOL -u anyone 2>&1"

    # Test 8: chcon_role_no_file — -r without file
    run_exit_code_test "chcon_role_no_file" \
        "$GNU_TOOL -r role_r 2>&1" \
        "$F_TOOL -r role_r 2>&1"

    # Test 9: chcon_type_no_file — -t without file
    run_exit_code_test "chcon_type_no_file" \
        "$GNU_TOOL -t tmp_t 2>&1" \
        "$F_TOOL -t tmp_t 2>&1"

    # Test 10: chcon_range_no_file — -l without file
    run_exit_code_test "chcon_range_no_file" \
        "$GNU_TOOL -l s0 2>&1" \
        "$F_TOOL -l s0 2>&1"

    # Test 11: chcon_invalid_context — apply invalid context to file
    echo "test" > "$test_dir/target_file"
    run_exit_code_test "chcon_invalid_context" \
        "$GNU_TOOL 'invalid:::context' '$test_dir/target_file' 2>&1" \
        "$F_TOOL 'invalid:::context' '$test_dir/target_file' 2>&1"

    # Test 12: chcon_multiple_nonexistent — multiple nonexistent files
    run_exit_code_test "chcon_multiple_nonexistent" \
        "$GNU_TOOL system_u:object_r:tmp_t:s0 /tmp/nofile1_$$ /tmp/nofile2_$$ 2>&1" \
        "$F_TOOL system_u:object_r:tmp_t:s0 /tmp/nofile1_$$ /tmp/nofile2_$$ 2>&1"

    # Test 13: chcon_recursive_nonexistent — -R on nonexistent directory
    run_exit_code_test "chcon_recursive_nonexistent" \
        "$GNU_TOOL -R system_u:object_r:tmp_t:s0 /tmp/nodir_$$ 2>&1" \
        "$F_TOOL -R system_u:object_r:tmp_t:s0 /tmp/nodir_$$ 2>&1"

    # Test 14: chcon_conflicting_reference_and_context — --reference with context
    # Some versions may reject this combination
    echo "test" > "$test_dir/conflict_ref"
    echo "test" > "$test_dir/conflict_target"
    run_exit_code_test "chcon_reference_with_context" \
        "$GNU_TOOL --reference='$test_dir/conflict_ref' system_u:object_r:tmp_t:s0 '$test_dir/conflict_target' 2>&1" \
        "$F_TOOL --reference='$test_dir/conflict_ref' system_u:object_r:tmp_t:s0 '$test_dir/conflict_target' 2>&1"

    # Test 15: chcon_verbose_nonexistent — -v on nonexistent file
    run_exit_code_test "chcon_verbose_nonexistent" \
        "$GNU_TOOL -v system_u:object_r:tmp_t:s0 /tmp/nofile_verbose_$$ 2>&1" \
        "$F_TOOL -v system_u:object_r:tmp_t:s0 /tmp/nofile_verbose_$$ 2>&1"

    # ════════════════════════════════════════════════════════════════════════
    # Section 2: SELinux Operations (require SELinux)
    # ════════════════════════════════════════════════════════════════════════
    echo ""
    echo "=== SELinux Operations ==="

    if ! $selinux_available; then
        skip_test "chcon_set_context" "SELinux not available"
        skip_test "chcon_type_only" "SELinux not available"
        skip_test "chcon_user_only" "SELinux not available"
        skip_test "chcon_role_only" "SELinux not available"
        skip_test "chcon_range_only" "SELinux not available"
        skip_test "chcon_recursive" "SELinux not available"
        skip_test "chcon_reference" "SELinux not available"
        skip_test "chcon_verbose" "SELinux not available"
        skip_test "chcon_dereference" "SELinux not available"
    else
        # Create test files for SELinux tests
        echo "selinux test content" > "$test_dir/se_target"

        # Get current context for reference
        local current_ctx
        current_ctx=$(ls -Z "$test_dir/se_target" 2>/dev/null | awk '{print $1}' || true)

        if [[ -n "$current_ctx" ]]; then
            # Test: chcon_set_context — set full context
            run_test "chcon_set_context" \
                "$GNU_TOOL '$current_ctx' '$test_dir/se_target' 2>&1 && ls -Z '$test_dir/se_target'" \
                "$F_TOOL '$current_ctx' '$test_dir/se_target' 2>&1 && ls -Z '$test_dir/se_target'"

            # Test: chcon_type_only — set only type
            run_exit_code_test "chcon_type_only" \
                "$GNU_TOOL -t tmp_t '$test_dir/se_target' 2>&1" \
                "$F_TOOL -t tmp_t '$test_dir/se_target' 2>&1"

            # Test: chcon_user_only — set only user
            run_exit_code_test "chcon_user_only" \
                "$GNU_TOOL -u system_u '$test_dir/se_target' 2>&1" \
                "$F_TOOL -u system_u '$test_dir/se_target' 2>&1"

            # Test: chcon_role_only — set only role
            run_exit_code_test "chcon_role_only" \
                "$GNU_TOOL -r object_r '$test_dir/se_target' 2>&1" \
                "$F_TOOL -r object_r '$test_dir/se_target' 2>&1"

            # Test: chcon_range_only — set only range
            run_exit_code_test "chcon_range_only" \
                "$GNU_TOOL -l s0 '$test_dir/se_target' 2>&1" \
                "$F_TOOL -l s0 '$test_dir/se_target' 2>&1"

            # Test: chcon_recursive — recursive context change
            mkdir -p "$test_dir/se_dir/subdir"
            echo "file1" > "$test_dir/se_dir/file1"
            echo "file2" > "$test_dir/se_dir/subdir/file2"
            run_exit_code_test "chcon_recursive" \
                "$GNU_TOOL -R '$current_ctx' '$test_dir/se_dir' 2>&1" \
                "$F_TOOL -R '$current_ctx' '$test_dir/se_dir' 2>&1"

            # Test: chcon_reference — copy context from reference file
            echo "ref content" > "$test_dir/se_ref"
            echo "target content" > "$test_dir/se_ref_target"
            run_exit_code_test "chcon_reference" \
                "$GNU_TOOL --reference='$test_dir/se_ref' '$test_dir/se_ref_target' 2>&1" \
                "$F_TOOL --reference='$test_dir/se_ref' '$test_dir/se_ref_target' 2>&1"

            # Test: chcon_verbose — verbose output
            run_exit_code_test "chcon_verbose" \
                "$GNU_TOOL -v '$current_ctx' '$test_dir/se_target' 2>&1" \
                "$F_TOOL -v '$current_ctx' '$test_dir/se_target' 2>&1"

            # Test: chcon_dereference — follow symlinks
            ln -sf "$test_dir/se_target" "$test_dir/se_link"
            run_exit_code_test "chcon_dereference" \
                "$GNU_TOOL --dereference '$current_ctx' '$test_dir/se_link' 2>&1" \
                "$F_TOOL --dereference '$current_ctx' '$test_dir/se_link' 2>&1"
        else
            skip_test "chcon_set_context" "Could not determine current SELinux context"
            skip_test "chcon_type_only" "Could not determine current SELinux context"
            skip_test "chcon_user_only" "Could not determine current SELinux context"
            skip_test "chcon_role_only" "Could not determine current SELinux context"
            skip_test "chcon_range_only" "Could not determine current SELinux context"
            skip_test "chcon_recursive" "Could not determine current SELinux context"
            skip_test "chcon_reference" "Could not determine current SELinux context"
            skip_test "chcon_verbose" "Could not determine current SELinux context"
            skip_test "chcon_dereference" "Could not determine current SELinux context"
        fi
    fi

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_chcon_tests
