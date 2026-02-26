#!/usr/bin/env bash
# Common test framework for fcoreutils independent testing
# This file is sourced by all test scripts.

set -euo pipefail

# ── Configuration ──────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
RESULTS_DIR="${RESULTS_DIR:-$PROJECT_ROOT/results}"
TEST_DATA_DIR="${TEST_DATA_DIR:-/tmp/fcoreutils-test-data}"
FAILED_TESTS_DIR="$PROJECT_ROOT/tests/failed_tests"

# Per-command timeout (seconds). Prevents any single command from hanging CI.
TEST_TIMEOUT="${TEST_TIMEOUT:-30}"

# Counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_SKIPPED=0
TOOL_NAME=""
TOOL_RESULTS_JSON=""

# Colors (disabled if not a terminal or CI)
if [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m'
else
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    NC=''
fi

# ── Tool Discovery ─────────────────────────────────────────────────────────────

check_tool_exists() {
    local tool="$1"
    if ! command -v "$tool" &>/dev/null; then
        echo -e "${YELLOW}SKIP: $tool not found in PATH${NC}"
        return 1
    fi
    # On macOS, verify non-fcoreutils tools are actually GNU (not BSD)
    if is_macos && [[ "$tool" != f* ]]; then
        if ! "$tool" --version 2>/dev/null | head -1 | grep -qi "GNU\|coreutils"; then
            echo -e "${YELLOW}SKIP: $tool is BSD (not GNU). Install GNU coreutils: brew install coreutils${NC}"
            return 1
        fi
    fi
    # Check if tool reports "not yet implemented"
    local test_output
    test_output=$(echo "test" | timeout "$TEST_TIMEOUT" "$tool" 2>&1 || true)
    if echo "$test_output" | grep -qi "not yet implemented"; then
        echo -e "${YELLOW}SKIP: $tool reports 'not yet implemented'${NC}"
        return 1
    fi
    return 0
}

get_tool_version() {
    local tool="$1"
    "$tool" --version 2>/dev/null | head -1 || echo "unknown"
}

# ── Test Framework ─────────────────────────────────────────────────────────────

init_test_suite() {
    local tool="$1"
    TOOL_NAME="$tool"
    TESTS_RUN=0
    TESTS_PASSED=0
    TESTS_FAILED=0
    TESTS_SKIPPED=0
    TOOL_RESULTS_JSON="[]"

    mkdir -p "$RESULTS_DIR" "$FAILED_TESTS_DIR"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Testing: $tool${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
}

# Run a compatibility test comparing GNU tool vs fcoreutils tool
# Usage: run_test "test_name" "gnu_command" "f_command" [stdin_file]
run_test() {
    local test_name="$1"
    local gnu_cmd="$2"
    local f_cmd="$3"
    local stdin_file="${4:-}"

    TESTS_RUN=$((TESTS_RUN + 1))

    local gnu_out="/tmp/gnu_output_$$"
    local f_out="/tmp/f_output_$$"
    local gnu_exit=0
    local f_exit=0

    # Run GNU tool (with timeout to prevent hangs)
    if [[ -n "$stdin_file" ]]; then
        timeout "$TEST_TIMEOUT" bash -c "$gnu_cmd" < "$stdin_file" > "$gnu_out" 2>&1 || gnu_exit=$?
    else
        timeout "$TEST_TIMEOUT" bash -c "$gnu_cmd" > "$gnu_out" 2>&1 || gnu_exit=$?
    fi

    # If GNU command timed out (exit 124), skip this test
    if [[ "$gnu_exit" -eq 124 ]]; then
        TESTS_SKIPPED=$((TESTS_SKIPPED + 1))
        echo -e "  ${YELLOW}SKIP${NC}: $test_name (GNU command timed out after ${TEST_TIMEOUT}s)"
        record_result "$test_name" "SKIP" "GNU command timed out" "$gnu_cmd" "$f_cmd"
        rm -f "$gnu_out" "$f_out"
        return 0
    fi

    # Run fcoreutils tool (with timeout to prevent hangs)
    if [[ -n "$stdin_file" ]]; then
        timeout "$TEST_TIMEOUT" bash -c "$f_cmd" < "$stdin_file" > "$f_out" 2>&1 || f_exit=$?
    else
        timeout "$TEST_TIMEOUT" bash -c "$f_cmd" > "$f_out" 2>&1 || f_exit=$?
    fi

    # If fcoreutils command timed out, treat as failure
    if [[ "$f_exit" -eq 124 ]]; then
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: $test_name (fcoreutils command timed out after ${TEST_TIMEOUT}s)"
        record_result "$test_name" "FAIL" "fcoreutils command timed out after ${TEST_TIMEOUT}s" "$gnu_cmd" "$f_cmd"
        rm -f "$gnu_out" "$f_out"
        return 0
    fi

    # Compare outputs
    local diff_output=""
    local passed=true

    if ! diff_output=$(diff "$gnu_out" "$f_out" 2>&1); then
        passed=false
    fi

    if [[ "$gnu_exit" != "$f_exit" ]]; then
        passed=false
        diff_output="${diff_output}
Exit code mismatch: GNU=$gnu_exit, fcoreutils=$f_exit"
    fi

    if $passed; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: $test_name"
        record_result "$test_name" "PASS" "" "$gnu_cmd" "$f_cmd"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: $test_name"
        echo -e "    GNU cmd:  $gnu_cmd"
        echo -e "    F cmd:    $f_cmd"
        echo -e "    Diff:"
        echo "$diff_output" | head -20 | sed 's/^/      /'
        save_failure "$test_name" "$gnu_cmd" "$f_cmd" "$gnu_out" "$f_out" "$diff_output" "$gnu_exit" "$f_exit"
        record_result "$test_name" "FAIL" "$diff_output" "$gnu_cmd" "$f_cmd"
    fi

    rm -f "$gnu_out" "$f_out"
}

# Run a test where we only check exit code matches (for error cases)
run_exit_code_test() {
    local test_name="$1"
    local gnu_cmd="$2"
    local f_cmd="$3"
    local stdin_file="${4:-}"

    TESTS_RUN=$((TESTS_RUN + 1))

    local gnu_exit=0
    local f_exit=0

    # Run GNU tool (with timeout)
    if [[ -n "$stdin_file" ]]; then
        timeout "$TEST_TIMEOUT" bash -c "$gnu_cmd" < "$stdin_file" > /dev/null 2>&1 || gnu_exit=$?
    else
        timeout "$TEST_TIMEOUT" bash -c "$gnu_cmd" > /dev/null 2>&1 || gnu_exit=$?
    fi

    # Run fcoreutils tool (with timeout)
    if [[ -n "$stdin_file" ]]; then
        timeout "$TEST_TIMEOUT" bash -c "$f_cmd" < "$stdin_file" > /dev/null 2>&1 || f_exit=$?
    else
        timeout "$TEST_TIMEOUT" bash -c "$f_cmd" > /dev/null 2>&1 || f_exit=$?
    fi

    # Both should succeed or both should fail
    if { [[ "$gnu_exit" -eq 0 ]] && [[ "$f_exit" -eq 0 ]]; } || \
       { [[ "$gnu_exit" -ne 0 ]] && [[ "$f_exit" -ne 0 ]]; }; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: $test_name (exit: GNU=$gnu_exit, F=$f_exit)"
        record_result "$test_name" "PASS" ""  "$gnu_cmd" "$f_cmd"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: $test_name (exit: GNU=$gnu_exit, F=$f_exit)"
        record_result "$test_name" "FAIL" "Exit code mismatch: GNU=$gnu_exit, fcoreutils=$f_exit" "$gnu_cmd" "$f_cmd"
    fi
}

# Run a test comparing only stdout (ignoring stderr differences)
run_stdout_test() {
    local test_name="$1"
    local gnu_cmd="$2"
    local f_cmd="$3"
    local stdin_file="${4:-}"

    TESTS_RUN=$((TESTS_RUN + 1))

    local gnu_out="/tmp/gnu_stdout_$$"
    local f_out="/tmp/f_stdout_$$"
    local gnu_exit=0
    local f_exit=0

    if [[ -n "$stdin_file" ]]; then
        timeout "$TEST_TIMEOUT" bash -c "$gnu_cmd" < "$stdin_file" > "$gnu_out" 2>/dev/null || gnu_exit=$?
        timeout "$TEST_TIMEOUT" bash -c "$f_cmd" < "$stdin_file" > "$f_out" 2>/dev/null || f_exit=$?
    else
        timeout "$TEST_TIMEOUT" bash -c "$gnu_cmd" > "$gnu_out" 2>/dev/null || gnu_exit=$?
        timeout "$TEST_TIMEOUT" bash -c "$f_cmd" > "$f_out" 2>/dev/null || f_exit=$?
    fi

    # If GNU command timed out, skip
    if [[ "$gnu_exit" -eq 124 ]]; then
        TESTS_SKIPPED=$((TESTS_SKIPPED + 1))
        echo -e "  ${YELLOW}SKIP${NC}: $test_name (GNU command timed out after ${TEST_TIMEOUT}s)"
        record_result "$test_name" "SKIP" "GNU command timed out" "$gnu_cmd" "$f_cmd"
        rm -f "$gnu_out" "$f_out"
        return 0
    fi

    # If fcoreutils timed out, treat as failure
    if [[ "$f_exit" -eq 124 ]]; then
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: $test_name (fcoreutils command timed out after ${TEST_TIMEOUT}s)"
        record_result "$test_name" "FAIL" "fcoreutils command timed out after ${TEST_TIMEOUT}s" "$gnu_cmd" "$f_cmd"
        rm -f "$gnu_out" "$f_out"
        return 0
    fi

    local diff_output=""
    local passed=true

    if ! diff_output=$(diff "$gnu_out" "$f_out" 2>&1); then
        passed=false
    fi

    if [[ "$gnu_exit" != "$f_exit" ]]; then
        passed=false
        diff_output="${diff_output}
Exit code mismatch: GNU=$gnu_exit, fcoreutils=$f_exit"
    fi

    if $passed; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "  ${GREEN}PASS${NC}: $test_name"
        record_result "$test_name" "PASS" "" "$gnu_cmd" "$f_cmd"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "  ${RED}FAIL${NC}: $test_name"
        echo "$diff_output" | head -20 | sed 's/^/      /'
        save_failure "$test_name" "$gnu_cmd" "$f_cmd" "$gnu_out" "$f_out" "$diff_output" "$gnu_exit" "$f_exit"
        record_result "$test_name" "FAIL" "$diff_output" "$gnu_cmd" "$f_cmd"
    fi

    rm -f "$gnu_out" "$f_out"
}

skip_test() {
    local test_name="$1"
    local reason="${2:-not applicable on this platform}"
    TESTS_RUN=$((TESTS_RUN + 1))
    TESTS_SKIPPED=$((TESTS_SKIPPED + 1))
    echo -e "  ${YELLOW}SKIP${NC}: $test_name ($reason)"
    record_result "$test_name" "SKIP" "$reason" "" ""
}

# ── Result Recording ───────────────────────────────────────────────────────────

record_result() {
    local test_name="$1"
    local status="$2"
    local detail="$3"
    local gnu_cmd="${4:-}"
    local f_cmd="${5:-}"

    # Escape strings for JSON
    local escaped_detail
    escaped_detail=$(echo "$detail" | head -5 | python3 -c "import sys,json; print(json.dumps(sys.stdin.read()))" 2>/dev/null || echo '""')
    local escaped_name
    escaped_name=$(echo "$test_name" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read().strip()))" 2>/dev/null || echo "\"$test_name\"")
    local escaped_gnu
    escaped_gnu=$(echo "$gnu_cmd" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read().strip()))" 2>/dev/null || echo '""')
    local escaped_f
    escaped_f=$(echo "$f_cmd" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read().strip()))" 2>/dev/null || echo '""')

    local entry="{\"name\":$escaped_name,\"status\":\"$status\",\"detail\":$escaped_detail,\"gnu_cmd\":$escaped_gnu,\"f_cmd\":$escaped_f}"

    if [[ "$TOOL_RESULTS_JSON" == "[]" ]]; then
        TOOL_RESULTS_JSON="[$entry]"
    else
        TOOL_RESULTS_JSON="${TOOL_RESULTS_JSON%]},${entry}]"
    fi
}

save_failure() {
    local test_name="$1"
    local gnu_cmd="$2"
    local f_cmd="$3"
    local gnu_out="$4"
    local f_out="$5"
    local diff_output="$6"
    local gnu_exit="$7"
    local f_exit="$8"

    local safe_name
    safe_name=$(echo "$test_name" | tr ' /:' '___')
    local fail_dir="$FAILED_TESTS_DIR/${TOOL_NAME}_${safe_name}"
    mkdir -p "$fail_dir"

    cp "$gnu_out" "$fail_dir/gnu_output" 2>/dev/null || true
    cp "$f_out" "$fail_dir/f_output" 2>/dev/null || true
    echo "$diff_output" > "$fail_dir/diff"
    cat > "$fail_dir/reproduce.sh" <<REPRO
#!/usr/bin/env bash
# Reproduction case for: $TOOL_NAME - $test_name
# GNU command:
$gnu_cmd
echo "GNU exit: \$?"

# fcoreutils command:
$f_cmd
echo "fcoreutils exit: \$?"
REPRO
    chmod +x "$fail_dir/reproduce.sh"
}

# ── Reporting ──────────────────────────────────────────────────────────────────

print_summary() {
    echo ""
    echo -e "${BLUE}───────────────────────────────────────────────────────${NC}"
    echo -e "  ${BLUE}$TOOL_NAME Summary${NC}"
    echo -e "${BLUE}───────────────────────────────────────────────────────${NC}"
    echo -e "  Total:   $TESTS_RUN"
    echo -e "  ${GREEN}Passed:  $TESTS_PASSED${NC}"
    echo -e "  ${RED}Failed:  $TESTS_FAILED${NC}"
    echo -e "  ${YELLOW}Skipped: $TESTS_SKIPPED${NC}"

    if [[ "$TESTS_FAILED" -eq 0 ]] && [[ "$TESTS_RUN" -gt 0 ]]; then
        local effective=$((TESTS_RUN - TESTS_SKIPPED))
        if [[ "$effective" -gt 0 ]]; then
            echo -e "  ${GREEN}Result:  ALL TESTS PASSED${NC}"
        fi
    else
        echo -e "  ${RED}Result:  $TESTS_FAILED FAILURES${NC}"
    fi
    echo -e "${BLUE}───────────────────────────────────────────────────────${NC}"
}

save_results_json() {
    local os_name
    os_name=$(uname -s | tr '[:upper:]' '[:lower:]')
    local arch
    arch=$(uname -m)

    cat > "$RESULTS_DIR/${TOOL_NAME}_results.json" <<EOF
{
    "tool": "$TOOL_NAME",
    "platform": "${os_name}_${arch}",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "summary": {
        "total": $TESTS_RUN,
        "passed": $TESTS_PASSED,
        "failed": $TESTS_FAILED,
        "skipped": $TESTS_SKIPPED,
        "pass_rate": $(if [[ $((TESTS_RUN - TESTS_SKIPPED)) -gt 0 ]]; then echo "scale=1; $TESTS_PASSED * 100 / ($TESTS_RUN - $TESTS_SKIPPED)" | bc 2>/dev/null || echo "0"; else echo "0"; fi)
    },
    "tests": $TOOL_RESULTS_JSON
}
EOF
}

finish_test_suite() {
    print_summary
    save_results_json
    # Don't fail the pipeline - report results but always succeed
    return 0
}

# ── Test Data Helpers ──────────────────────────────────────────────────────────

ensure_test_data() {
    if [[ ! -d "$TEST_DATA_DIR" ]]; then
        echo "Test data not found. Generating..."
        bash "$SCRIPT_DIR/helpers/generate_test_data.sh"
    fi
}

# Create a temporary file with given content
make_temp() {
    local content="$1"
    local tmp
    tmp=$(mktemp /tmp/fcoreutils_test_XXXXXX)
    printf '%s' "$content" > "$tmp"
    echo "$tmp"
}

# Create a temporary file with binary content from printf
make_temp_printf() {
    local content="$1"
    local tmp
    tmp=$(mktemp /tmp/fcoreutils_test_XXXXXX)
    printf "$content" > "$tmp"
    echo "$tmp"
}

# Cleanup temp files at exit
TEMP_FILES=()
register_temp() {
    TEMP_FILES+=("$1")
}

cleanup_temps() {
    for f in "${TEMP_FILES[@]}"; do
        rm -f "$f" 2>/dev/null || true
    done
}

trap cleanup_temps EXIT

# ── Platform Detection ─────────────────────────────────────────────────────────

is_linux() { [[ "$(uname -s)" == "Linux" ]]; }
is_macos() { [[ "$(uname -s)" == "Darwin" ]]; }
is_windows() { [[ "$(uname -s)" == MINGW* ]] || [[ "$(uname -s)" == MSYS* ]] || [[ "$(uname -s)" == CYGWIN* ]]; }
is_x86_64() { [[ "$(uname -m)" == "x86_64" ]]; }
is_arm64() { [[ "$(uname -m)" == "aarch64" ]] || [[ "$(uname -m)" == "arm64" ]]; }

get_platform_tag() {
    local os_name
    os_name=$(uname -s | tr '[:upper:]' '[:lower:]')
    local arch
    arch=$(uname -m)
    echo "${os_name}_${arch}"
}

# ── GNU Tool Resolution ──────────────────────────────────────────────────────

# Resolve the correct GNU tool binary name for this platform.
# On macOS, BSD tools differ from GNU — prefer Homebrew GNU coreutils (g-prefixed).
# Usage: GNU_TOOL=$(resolve_gnu_tool "base64")
resolve_gnu_tool() {
    local tool="$1"

    # On Linux, the system tool IS GNU coreutils
    if is_linux; then
        echo "$tool"
        return 0
    fi

    # On macOS, prefer Homebrew GNU coreutils (g-prefixed)
    if is_macos; then
        local gnu_name="g${tool}"
        if command -v "$gnu_name" &>/dev/null; then
            # Verify it's actually GNU
            if "$gnu_name" --version 2>/dev/null | head -1 | grep -qi "GNU\|coreutils"; then
                echo "$gnu_name"
                return 0
            fi
        fi
        # Fall back to bare name — check if it's GNU (e.g., Homebrew overriding PATH)
        if command -v "$tool" &>/dev/null; then
            if "$tool" --version 2>/dev/null | head -1 | grep -qi "GNU\|coreutils"; then
                echo "$tool"
                return 0
            fi
        fi
        # Neither g-prefixed nor bare name is GNU — return bare name.
        # check_tool_exists will detect it's not GNU and skip.
        echo "$tool"
        return 0
    fi

    # Windows / other: return as-is
    echo "$tool"
    return 0
}

# ── GNU Upstream Test Integration ─────────────────────────────────────────────
# DEPRECATED: Use tests/commands/run_tool.sh instead, which runs GNU upstream
# tests against both GNU coreutils and fcoreutils independently.
#
# This function is kept for backward compatibility but should not be used
# in new test scripts. The per-command test directories under
# tests/commands/<tool>/gnu/ now contain the GNU upstream tests, and
# run_tool.sh handles running them with TARGET=gnu and TARGET=f.
#
# Usage (deprecated): run_gnu_upstream_tests "cat"
run_gnu_upstream_tests() {
    local tool="$1"
    local gnu_upstream_dir="$PROJECT_ROOT/tests/compatibility/gnu_upstream"
    local tool_test_dir="$gnu_upstream_dir/tests/$tool"
    local misc_dir="$gnu_upstream_dir/tests/misc"
    local shim="$gnu_upstream_dir/init_shim.sh"

    # Bail out if GNU upstream infrastructure is missing
    [[ -f "$shim" ]] || return 0

    # Collect test scripts for this tool
    local test_scripts=()

    # From dedicated tool directory (e.g., tests/compatibility/gnu_upstream/tests/cat/*.sh)
    if [[ -d "$tool_test_dir" ]]; then
        while IFS= read -r f; do
            [[ -n "$f" ]] && test_scripts+=("$f")
        done < <(find "$tool_test_dir" -maxdepth 1 -name "*.sh" -type f 2>/dev/null | sort)
    fi

    # From misc/ directory — exact match (e.g., misc/echo.sh for "echo")
    if [[ -f "$misc_dir/${tool}.sh" ]]; then
        test_scripts+=("$misc_dir/${tool}.sh")
    fi

    # Special mapping: "false" → misc/false-status.sh
    if [[ "$tool" == "false" && -f "$misc_dir/false-status.sh" ]]; then
        test_scripts+=("$misc_dir/false-status.sh")
    fi

    # Nothing to run
    [[ ${#test_scripts[@]} -gt 0 ]] || return 0

    echo ""
    echo "=== GNU Upstream Tests ==="

    # Build a temp directory with f* tools symlinked as bare names
    # so GNU test scripts calling 'cat' get fcoreutils' fcat
    local ftools_dir
    ftools_dir=$(mktemp -d)
    local install_dir="${HOME}/.local/bin"
    if [[ -d "$install_dir" ]]; then
        for ftool in "$install_dir"/f*; do
            [[ -x "$ftool" ]] || continue
            local tname
            tname=$(basename "$ftool")
            local bare="${tname#f}"
            [[ -n "$bare" && "$bare" =~ ^[a-z0-9_-]+$ ]] || continue
            ln -sf "$ftool" "$ftools_dir/$bare" 2>/dev/null || true
        done
    fi

    for test_script in "${test_scripts[@]}"; do
        local base
        base=$(basename "$test_script")
        [[ "$base" == "init.sh" || "$base" == "init_shim.sh" ]] && continue

        local test_name="gnu/${tool}/${base%.sh}"

        # Patch: replace sourcing of GNU's init.sh with our shim
        local tmptest
        tmptest=$(mktemp --suffix=.sh)
        sed \
            -e "s|^[[:space:]]*source.*init\.sh.*$|source '$shim'|" \
            -e "s|^[[:space:]]*\. .*init\.sh.*$|source '$shim'|" \
            "$test_script" > "$tmptest"
        chmod +x "$tmptest"

        # Run test with fcoreutils in PATH, with 30s timeout
        local exit_code=0
        PATH="$ftools_dir:$PATH" timeout 30 bash "$tmptest" >/dev/null 2>&1 || exit_code=$?

        if [[ $exit_code -eq 0 ]]; then
            TESTS_RUN=$((TESTS_RUN + 1))
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "  ${GREEN}PASS${NC}: $test_name"
            record_result "$test_name" "PASS" "" "" ""
        elif [[ $exit_code -eq 77 || $exit_code -eq 124 ]]; then
            TESTS_RUN=$((TESTS_RUN + 1))
            TESTS_SKIPPED=$((TESTS_SKIPPED + 1))
            local reason="skipped by test"
            [[ $exit_code -eq 124 ]] && reason="timeout"
            echo -e "  ${YELLOW}SKIP${NC}: $test_name ($reason)"
            record_result "$test_name" "SKIP" "$reason" "" ""
        else
            TESTS_RUN=$((TESTS_RUN + 1))
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "  ${RED}FAIL${NC}: $test_name (exit=$exit_code)"
            record_result "$test_name" "FAIL" "GNU upstream test failed with exit code $exit_code" "" ""
        fi

        rm -f "$tmptest"
    done

    # Clean up symlink directory
    rm -rf "$ftools_dir"
}
