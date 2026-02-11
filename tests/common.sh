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
    if command -v "$tool" &>/dev/null; then
        return 0
    else
        echo -e "${YELLOW}SKIP: $tool not found in PATH${NC}"
        return 1
    fi
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

    # Run GNU tool
    if [[ -n "$stdin_file" ]]; then
        eval "$gnu_cmd" < "$stdin_file" > "$gnu_out" 2>&1 || gnu_exit=$?
    else
        eval "$gnu_cmd" > "$gnu_out" 2>&1 || gnu_exit=$?
    fi

    # Run fcoreutils tool
    if [[ -n "$stdin_file" ]]; then
        eval "$f_cmd" < "$stdin_file" > "$f_out" 2>&1 || f_exit=$?
    else
        eval "$f_cmd" > "$f_out" 2>&1 || f_exit=$?
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

    # Run GNU tool
    if [[ -n "$stdin_file" ]]; then
        eval "$gnu_cmd" < "$stdin_file" > /dev/null 2>&1 || gnu_exit=$?
    else
        eval "$gnu_cmd" > /dev/null 2>&1 || gnu_exit=$?
    fi

    # Run fcoreutils tool
    if [[ -n "$stdin_file" ]]; then
        eval "$f_cmd" < "$stdin_file" > /dev/null 2>&1 || f_exit=$?
    else
        eval "$f_cmd" > /dev/null 2>&1 || f_exit=$?
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
        eval "$gnu_cmd" < "$stdin_file" > "$gnu_out" 2>/dev/null || gnu_exit=$?
        eval "$f_cmd" < "$stdin_file" > "$f_out" 2>/dev/null || f_exit=$?
    else
        eval "$gnu_cmd" > "$gnu_out" 2>/dev/null || gnu_exit=$?
        eval "$f_cmd" > "$f_out" 2>/dev/null || f_exit=$?
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
        "pass_rate": $(echo "scale=1; $TESTS_PASSED * 100 / ($TESTS_RUN - $TESTS_SKIPPED + 1)" | bc 2>/dev/null || echo "0")
    },
    "tests": $TOOL_RESULTS_JSON
}
EOF
}

finish_test_suite() {
    print_summary
    save_results_json
    if [[ "$TESTS_FAILED" -gt 0 ]]; then
        return 1
    fi
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
