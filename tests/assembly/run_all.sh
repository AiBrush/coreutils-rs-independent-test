#!/usr/bin/env bash
# run_all.sh — Run all assembly tool GNU compatibility tests and aggregate results
#
# Runs each assembly tool's run_tests.sh against both the assembly binary and
# GNU coreutils, then produces a combined JSON report.
#
# Usage:
#   bash tests/assembly/run_all.sh [--repo-dir DIR] [--asm-dir DIR]
#
# Environment:
#   ASM_INSTALL_DIR  — directory containing assembly binaries (default: ~/.local/bin/asm)
#   FCOREUTILS_DIR   — fcoreutils source tree with assembly/ directory
#   RESULTS_DIR      — where to write JSON results (default: ./results)

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
RESULTS_DIR="${RESULTS_DIR:-$PROJECT_ROOT/results}"
ASM_INSTALL_DIR="${ASM_INSTALL_DIR:-$HOME/.local/bin/asm}"
FCOREUTILS_DIR="${FCOREUTILS_DIR:-}"

# Assembly tools to test (all 29 with compat tests; yes excluded — no compat test)
ASM_TOOLS=(
    arch base64 cat cut echo expand false fold head hostid logname
    md5sum nl od pwd rev seq sleep sort sync tac tail tr true tty
    unexpand uniq wc whoami
)

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

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --repo-dir)  FCOREUTILS_DIR="$2"; shift 2 ;;
        --asm-dir)   ASM_INSTALL_DIR="$2"; shift 2 ;;
        *)           echo "Unknown argument: $1"; exit 1 ;;
    esac
done

if [[ -z "$FCOREUTILS_DIR" ]]; then
    echo "ERROR: FCOREUTILS_DIR must be set or --repo-dir must be provided"
    echo "  This is the path to the fcoreutils source tree containing assembly/*"
    exit 1
fi

if [[ ! -d "$FCOREUTILS_DIR/assembly" ]]; then
    echo "ERROR: $FCOREUTILS_DIR/assembly/ not found"
    exit 1
fi

mkdir -p "$RESULTS_DIR"

# ── Per-tool test runner ─────────────────────────────────────────────────────

TOTAL_PASS=0
TOTAL_FAIL=0
TOTAL_SKIP=0
TOOL_RESULTS_JSON=""

run_tool_compat_test() {
    local tool="$1"
    local binary="f${tool}"
    local binary_path="$ASM_INSTALL_DIR/$binary"
    local test_script="$FCOREUTILS_DIR/assembly/$tool/tests/run_tests.sh"

    echo ""
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Assembly compat test: $tool ($binary)${NC}"
    echo -e "${BLUE}════════════════════════════════════════════${NC}"

    # Check binary exists
    if [[ ! -x "$binary_path" ]]; then
        echo -e "  ${YELLOW}SKIP: $binary not found at $binary_path${NC}"
        local entry="{\"tool\":\"$tool\",\"binary\":\"$binary\",\"status\":\"SKIP\",\"reason\":\"binary not found\",\"passed\":0,\"failed\":0}"
        if [[ -z "$TOOL_RESULTS_JSON" ]]; then
            TOOL_RESULTS_JSON="$entry"
        else
            TOOL_RESULTS_JSON="$TOOL_RESULTS_JSON,$entry"
        fi
        TOTAL_SKIP=$((TOTAL_SKIP + 1))
        return 0
    fi

    # Check test script exists
    if [[ ! -f "$test_script" ]]; then
        echo -e "  ${YELLOW}SKIP: No test script at $test_script${NC}"
        local entry="{\"tool\":\"$tool\",\"binary\":\"$binary\",\"status\":\"SKIP\",\"reason\":\"no test script\",\"passed\":0,\"failed\":0}"
        if [[ -z "$TOOL_RESULTS_JSON" ]]; then
            TOOL_RESULTS_JSON="$entry"
        else
            TOOL_RESULTS_JSON="$TOOL_RESULTS_JSON,$entry"
        fi
        TOTAL_SKIP=$((TOTAL_SKIP + 1))
        return 0
    fi

    # Run the tool's own test suite, passing the assembly binary path
    local test_output
    local test_exit=0
    test_output=$(timeout 300 bash "$test_script" "$binary_path" 2>&1) || test_exit=$?

    # Parse pass/fail from the output
    # The run_tests.sh scripts print "Results: N passed, M failed out of T tests"
    local passed=0
    local failed=0
    local total=0

    if echo "$test_output" | grep -q "Results:"; then
        passed=$(echo "$test_output" | grep "Results:" | sed -n 's/.*Results: \([0-9]*\) passed.*/\1/p')
        failed=$(echo "$test_output" | grep "Results:" | sed -n 's/.*, \([0-9]*\) failed.*/\1/p')
        total=$((passed + failed))
    fi

    # If parsing failed, fall back to exit code
    if [[ "$total" -eq 0 ]]; then
        if [[ "$test_exit" -eq 0 ]]; then
            passed=1
            total=1
        else
            failed=1
            total=1
        fi
    fi

    TOTAL_PASS=$((TOTAL_PASS + passed))
    TOTAL_FAIL=$((TOTAL_FAIL + failed))

    local status="tested"
    if [[ "$failed" -eq 0 ]]; then
        echo -e "  ${GREEN}PASS: $passed/$total tests passed${NC}"
    else
        echo -e "  ${RED}RESULT: $passed passed, $failed failed out of $total${NC}"
    fi

    # Show failures if any
    if [[ "$failed" -gt 0 ]]; then
        echo "$test_output" | grep "^FAIL:" | head -10 | while IFS= read -r line; do
            echo -e "    ${RED}$line${NC}"
        done
    fi

    local entry="{\"tool\":\"$tool\",\"binary\":\"$binary\",\"status\":\"$status\",\"passed\":$passed,\"failed\":$failed,\"total\":$total}"
    if [[ -z "$TOOL_RESULTS_JSON" ]]; then
        TOOL_RESULTS_JSON="$entry"
    else
        TOOL_RESULTS_JSON="$TOOL_RESULTS_JSON,$entry"
    fi
}

# ── Run all tests ─────────────────────────────────────────────────────────────

echo "=== Assembly GNU Compatibility Tests ==="
echo "  Assembly binaries: $ASM_INSTALL_DIR"
echo "  Source tree:       $FCOREUTILS_DIR"
echo "  Results dir:       $RESULTS_DIR"

for tool in "${ASM_TOOLS[@]}"; do
    run_tool_compat_test "$tool"
done

# ── Summary ───────────────────────────────────────────────────────────────────

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Assembly Compatibility Test Summary${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "  Tools tested: ${#ASM_TOOLS[@]}"
echo -e "  ${GREEN}Total passed:  $TOTAL_PASS${NC}"
echo -e "  ${RED}Total failed:  $TOTAL_FAIL${NC}"
echo -e "  ${YELLOW}Skipped:       $TOTAL_SKIP${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"

# ── Write JSON results ────────────────────────────────────────────────────────

cat > "$RESULTS_DIR/asm_compat_results.json" <<EOF
{
    "type": "assembly_compatibility",
    "platform": "$(uname -s)_$(uname -m)",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "summary": {
        "tools_tested": ${#ASM_TOOLS[@]},
        "total_passed": $TOTAL_PASS,
        "total_failed": $TOTAL_FAIL,
        "total_skipped": $TOTAL_SKIP
    },
    "tools": [$TOOL_RESULTS_JSON]
}
EOF

echo ""
echo "Results written to $RESULTS_DIR/asm_compat_results.json"
