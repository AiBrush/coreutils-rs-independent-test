#!/usr/bin/env bash
# Functional tests for fchcon (no GNU comparison needed)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common.sh"

F_TOOL="fchcon"

run_chcon_functional_tests() {
    init_test_suite "chcon"

    if ! check_tool_exists "$F_TOOL"; then
        echo '{"tool":"chcon","status":"NOT_IMPLEMENTED","tests":[]}' > "$RESULTS_DIR/chcon_results.json"
        return 0
    fi

    local test_dir
    test_dir=$(mktemp -d /tmp/fcoreutils_chcon_func_$$_XXXXXX)
    register_temp "$test_dir"

    # ── Error cases (work on any platform) ──

    run_expected_exit_test "no args fails" "$F_TOOL 2>/dev/null" 1

    run_expected_exit_test "help exits 0" "$F_TOOL --help >/dev/null 2>&1" 0

    run_expected_exit_test "version exits 0" "$F_TOOL --version >/dev/null 2>&1" 0

    run_expected_exit_test "nonexistent file fails" \
        "$F_TOOL system_u:object_r:tmp_t:s0 /tmp/nonexistent_chcon_func_$$ 2>/dev/null" 1

    run_expected_exit_test "context but no file fails" \
        "$F_TOOL CON 2>/dev/null" 1

    echo "test" > "$test_dir/ref_file"
    run_expected_exit_test "reference without target fails" \
        "$F_TOOL --reference='$test_dir/ref_file' 2>/dev/null" 1

    run_expected_exit_test "user without file fails" \
        "$F_TOOL -u anyone 2>/dev/null" 1

    run_expected_exit_test "role without file fails" \
        "$F_TOOL -r role_r 2>/dev/null" 1

    run_expected_exit_test "type without file fails" \
        "$F_TOOL -t tmp_t 2>/dev/null" 1

    run_expected_exit_test "range without file fails" \
        "$F_TOOL -l s0 2>/dev/null" 1

    # ── SELinux-dependent tests ──

    local selinux_available=false
    if command -v getenforce >/dev/null 2>&1; then
        if [[ "$(getenforce 2>/dev/null)" != "Disabled" ]]; then
            selinux_available=true
        fi
    fi

    if ! $selinux_available; then
        skip_test "set context on file" "SELinux not available"
        skip_test "recursive context change" "SELinux not available"
        skip_test "reference context copy" "SELinux not available"
        skip_test "verbose context change" "SELinux not available"
    else
        echo "selinux content" > "$test_dir/se_file"
        local current_ctx
        current_ctx=$(ls -Z "$test_dir/se_file" 2>/dev/null | awk '{print $1}' || true)

        if [[ -n "$current_ctx" ]]; then
            run_expected_exit_test "set context on file" \
                "$F_TOOL '$current_ctx' '$test_dir/se_file' 2>/dev/null" 0

            mkdir -p "$test_dir/se_dir"
            echo "nested" > "$test_dir/se_dir/nested"
            run_expected_exit_test "recursive context change" \
                "$F_TOOL -R '$current_ctx' '$test_dir/se_dir' 2>/dev/null" 0

            echo "ref" > "$test_dir/se_ref"
            echo "tgt" > "$test_dir/se_tgt"
            run_expected_exit_test "reference context copy" \
                "$F_TOOL --reference='$test_dir/se_ref' '$test_dir/se_tgt' 2>/dev/null" 0

            run_expected_exit_test "verbose context change" \
                "$F_TOOL -v '$current_ctx' '$test_dir/se_file' 2>/dev/null" 0
        else
            skip_test "set context on file" "Could not determine current SELinux context"
            skip_test "recursive context change" "Could not determine current SELinux context"
            skip_test "reference context copy" "Could not determine current SELinux context"
            skip_test "verbose context change" "Could not determine current SELinux context"
        fi
    fi

    # Cleanup
    rm -rf "$test_dir"

    finish_test_suite
}

run_chcon_functional_tests
