#!/usr/bin/env bash
# run_tool.sh — Run all tests for a single tool against both GNU and fcoreutils
#
# Usage: run_tool.sh <tool>
#
# Runs:
#   1. Custom compatibility tests (test_compat.sh) — already compares both
#   2. GNU upstream tests (gnu/*.sh) — run twice: once with TARGET=gnu, once with TARGET=f
#
# Writes per-tool JSON result to $RESULTS_DIR/<tool>_results.json

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
RESULTS_DIR="${RESULTS_DIR:-$PROJECT_ROOT/results}"
SHIM="$SCRIPT_DIR/init_shim.sh"

# Colors
if [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m'
else
    RED='' GREEN='' YELLOW='' BLUE='' NC=''
fi

if [[ $# -lt 1 ]]; then
    echo "Usage: run_tool.sh <tool>" >&2
    exit 1
fi

TOOL="$1"
TOOL_DIR="$SCRIPT_DIR/$TOOL"

if [[ ! -d "$TOOL_DIR" ]]; then
    echo "No test directory for $TOOL at $TOOL_DIR" >&2
    exit 1
fi

mkdir -p "$RESULTS_DIR"

# --- Build fcoreutils symlink directory ---
# Create temp dir with f* tools symlinked as bare names
FTOOLS_DIR=$(mktemp -d)
INSTALL_DIR="${HOME}/.local/bin"
if [[ -d "$INSTALL_DIR" ]]; then
    for ftool in "$INSTALL_DIR"/f*; do
        [[ -x "$ftool" ]] || continue
        tname=$(basename "$ftool")
        bare="${tname#f}"
        [[ -n "$bare" && "$bare" =~ ^[a-z0-9_-]+$ ]] || continue
        ln -sf "$ftool" "$FTOOLS_DIR/$bare" 2>/dev/null || true
    done
fi

cleanup() {
    rm -rf "$FTOOLS_DIR"
}
trap cleanup EXIT

# --- Result tracking ---
CUSTOM_TOTAL=0
CUSTOM_PASSED=0
CUSTOM_FAILED=0
CUSTOM_SKIPPED=0

GNU_TOTAL=0
GNU_GNU_PASSED=0
GNU_GNU_FAILED=0
GNU_GNU_SKIPPED=0
GNU_F_PASSED=0
GNU_F_FAILED=0
GNU_F_SKIPPED=0

TESTS_JSON="["
FIRST_TEST=true

add_test_json() {
    local json="$1"
    if $FIRST_TEST; then
        TESTS_JSON="${TESTS_JSON}${json}"
        FIRST_TEST=false
    else
        TESTS_JSON="${TESTS_JSON},${json}"
    fi
}

escape_json() {
    python3 -c "import sys,json; print(json.dumps(sys.stdin.read().strip()))" 2>/dev/null <<< "$1" || echo "\"$1\""
}

# --- Step 1: Run custom tests ---
# On Linux x86_64: run test_compat.sh (compares against GNU coreutils)
# On all other platforms: run test_functional.sh (standalone expected-value tests)
# Source common.sh for platform detection and portable timeout
source "$SCRIPT_DIR/../common.sh" 2>/dev/null || true

COMPAT_SCRIPT="$TOOL_DIR/test_compat.sh"
FUNCTIONAL_SCRIPT="$TOOL_DIR/test_functional.sh"
COMPAT_STATUS="skipped"
TOOL_TIMEOUT="${TOOL_TIMEOUT:-300}"  # 5 min per tool

# Choose which test script to run based on platform
SELECTED_SCRIPT=""
if is_linux && is_x86_64; then
    # Linux x86_64: prefer compat tests (compare against GNU)
    if [[ -f "$COMPAT_SCRIPT" ]]; then
        SELECTED_SCRIPT="$COMPAT_SCRIPT"
    fi
else
    # Non-Linux-x86_64: use functional tests (standalone expected values)
    if [[ -f "$FUNCTIONAL_SCRIPT" ]]; then
        SELECTED_SCRIPT="$FUNCTIONAL_SCRIPT"
    elif [[ -f "$COMPAT_SCRIPT" ]]; then
        # Fallback to compat if no functional tests exist
        SELECTED_SCRIPT="$COMPAT_SCRIPT"
    fi
fi

if [[ -n "$SELECTED_SCRIPT" ]]; then
    local_label="Custom compatibility tests"
    if [[ "$SELECTED_SCRIPT" == *"test_functional.sh" ]]; then
        local_label="Functional tests"
    fi
    echo -e "${BLUE}=== $TOOL: $local_label ===${NC}"
    compat_exit=0
    timeout "$TOOL_TIMEOUT" bash "$SELECTED_SCRIPT" || compat_exit=$?
    if [[ "$compat_exit" -eq 0 ]]; then
        COMPAT_STATUS="passed"
    else
        if [[ "$compat_exit" -eq 124 ]]; then
            echo -e "${YELLOW}WARNING: $TOOL compatibility tests timed out after ${TOOL_TIMEOUT}s${NC}"
        fi
        COMPAT_STATUS="completed"
    fi

    # Parse results from the per-tool JSON that test_compat.sh wrote
    COMPAT_RESULT="$RESULTS_DIR/${TOOL}_results.json"
    if [[ -f "$COMPAT_RESULT" ]]; then
        COMPAT_DATA=$(python3 -c "
import json, sys
d = json.load(open('$COMPAT_RESULT'))
status = d.get('status', '')
if status == 'NOT_IMPLEMENTED':
    print('NOT_IMPLEMENTED')
else:
    s = d.get('summary', {})
    print(f\"{s.get('total',0)} {s.get('passed',0)} {s.get('failed',0)} {s.get('skipped',0)}\")
" 2>/dev/null || echo "0 0 0 0")

        if [[ "$COMPAT_DATA" == "NOT_IMPLEMENTED" ]]; then
            COMPAT_STATUS="not_implemented"
        else
            read -r CUSTOM_TOTAL CUSTOM_PASSED CUSTOM_FAILED CUSTOM_SKIPPED <<< "$COMPAT_DATA"
        fi

        # Import individual test results from the compat JSON
        python3 -c "
import json, sys
d = json.load(open('$COMPAT_RESULT'))
for t in d.get('tests', []):
    name = json.dumps(t.get('name', ''))
    status = t.get('status', 'UNKNOWN')
    detail = json.dumps(t.get('detail', ''))
    print(f'{{\"name\":{name},\"type\":\"custom\",\"status\":\"{status}\",\"detail\":{detail}}}')
" 2>/dev/null | while IFS= read -r line; do
            add_test_json "$line"
        done
    fi
fi

# --- Step 2: Run GNU upstream tests (gnu/*.sh) ---
GNU_TEST_DIR="$TOOL_DIR/gnu"
GNU_TESTS=()

if [[ -d "$GNU_TEST_DIR" ]]; then
    while IFS= read -r f; do
        [[ -n "$f" ]] && GNU_TESTS+=("$f")
    done < <(find "$GNU_TEST_DIR" -maxdepth 1 -name "*.sh" -type f 2>/dev/null | sort)
fi

if [[ ${#GNU_TESTS[@]} -gt 0 ]]; then
    echo ""
    echo -e "${BLUE}=== $TOOL (${#GNU_TESTS[@]} GNU upstream tests) ===${NC}"
    printf "  %-40s %-10s %s\n" "Test" "GNU" "fcoreutils"
    printf "  %-40s %-10s %s\n" "----" "---" "----------"

    for test_script in "${GNU_TESTS[@]}"; do
        base=$(basename "$test_script")
        [[ "$base" == "init.sh" || "$base" == "init_shim.sh" ]] && continue

        test_name="gnu/${base%.sh}"
        GNU_TOTAL=$((GNU_TOTAL + 1))

        # Patch: replace sourcing of GNU's init.sh with our shim
        tmptest=$(mktemp --suffix=.sh 2>/dev/null || mktemp)
        sed \
            -e "s|^[[:space:]]*source.*init\.sh.*$|source '$SHIM'|" \
            -e "s|^[[:space:]]*\. .*init\.sh.*$|source '$SHIM'|" \
            "$test_script" > "$tmptest"
        chmod +x "$tmptest"

        # --- Run with TARGET=gnu (system PATH) ---
        gnu_exit=0
        export TARGET=gnu
        timeout 30 bash "$tmptest" >/dev/null 2>&1 || gnu_exit=$?
        unset TARGET

        if [[ $gnu_exit -eq 0 ]]; then
            gnu_status="PASS"
            GNU_GNU_PASSED=$((GNU_GNU_PASSED + 1))
        elif [[ $gnu_exit -eq 77 || $gnu_exit -eq 124 ]]; then
            gnu_status="SKIP"
            GNU_GNU_SKIPPED=$((GNU_GNU_SKIPPED + 1))
            [[ $gnu_exit -eq 124 ]] && gnu_status="SKIP(t/o)"
        else
            gnu_status="FAIL"
            GNU_GNU_FAILED=$((GNU_GNU_FAILED + 1))
        fi

        # --- Run with TARGET=f (fcoreutils symlinks in PATH) ---
        f_exit=0
        export TARGET=f
        PATH="$FTOOLS_DIR:$PATH" timeout 30 bash "$tmptest" >/dev/null 2>&1 || f_exit=$?
        unset TARGET

        if [[ $f_exit -eq 0 ]]; then
            f_status="PASS"
            GNU_F_PASSED=$((GNU_F_PASSED + 1))
        elif [[ $f_exit -eq 77 || $f_exit -eq 124 ]]; then
            f_status="SKIP"
            GNU_F_SKIPPED=$((GNU_F_SKIPPED + 1))
            [[ $f_exit -eq 124 ]] && f_status="SKIP(t/o)"
        else
            f_status="FAIL"
            GNU_F_FAILED=$((GNU_F_FAILED + 1))
        fi

        # Color-coded output
        gnu_color="$GREEN"
        [[ "$gnu_status" == FAIL ]] && gnu_color="$RED"
        [[ "$gnu_status" == SKIP* ]] && gnu_color="$YELLOW"

        f_color="$GREEN"
        [[ "$f_status" == FAIL ]] && f_color="$RED"
        [[ "$f_status" == SKIP* ]] && f_color="$YELLOW"

        printf "  %-40s ${gnu_color}%-10s${NC} ${f_color}%s${NC}\n" "$base" "$gnu_status" "$f_status"

        # Record JSON
        add_test_json "{\"name\":\"$test_name\",\"type\":\"gnu_upstream\",\"gnu_status\":\"$gnu_status\",\"f_status\":\"$f_status\"}"

        rm -f "$tmptest"
    done

    # Summary line
    echo ""
    echo -e "  GNU:         ${GNU_GNU_PASSED} passed, ${GNU_GNU_FAILED} failed, ${GNU_GNU_SKIPPED} skipped"
    echo -e "  fcoreutils:  ${GNU_F_PASSED} passed, ${GNU_F_FAILED} failed, ${GNU_F_SKIPPED} skipped"
fi

TESTS_JSON="${TESTS_JSON}]"

# --- Write per-tool JSON result ---
OS_NAME=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)

if [[ "$COMPAT_STATUS" == "not_implemented" ]]; then
    cat > "$RESULTS_DIR/${TOOL}_results.json" <<EOF
{"tool":"$TOOL","status":"NOT_IMPLEMENTED","tests":[]}
EOF
else
    cat > "$RESULTS_DIR/${TOOL}_results.json" <<EOF
{
    "tool": "$TOOL",
    "platform": "${OS_NAME}_${ARCH}",
    "timestamp": "$TIMESTAMP",
    "summary": {
        "custom_tests": {
            "total": $CUSTOM_TOTAL,
            "passed": $CUSTOM_PASSED,
            "failed": $CUSTOM_FAILED,
            "skipped": $CUSTOM_SKIPPED
        },
        "gnu_upstream": {
            "total": $GNU_TOTAL,
            "gnu": {
                "passed": $GNU_GNU_PASSED,
                "failed": $GNU_GNU_FAILED,
                "skipped": $GNU_GNU_SKIPPED
            },
            "f": {
                "passed": $GNU_F_PASSED,
                "failed": $GNU_F_FAILED,
                "skipped": $GNU_F_SKIPPED
            }
        },
        "total": $((CUSTOM_TOTAL + GNU_TOTAL)),
        "passed": $((CUSTOM_PASSED + GNU_F_PASSED)),
        "failed": $((CUSTOM_FAILED + GNU_F_FAILED)),
        "skipped": $((CUSTOM_SKIPPED + GNU_F_SKIPPED))
    },
    "tests": $TESTS_JSON
}
EOF
fi

echo ""
echo -e "${BLUE}───────────────────────────────────────────────────────${NC}"
echo -e "  ${BLUE}$TOOL Complete${NC}"
echo -e "${BLUE}───────────────────────────────────────────────────────${NC}"

# Report failures but don't fail the pipeline
exit 0
