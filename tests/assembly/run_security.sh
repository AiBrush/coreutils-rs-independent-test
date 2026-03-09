#!/usr/bin/env bash
# run_security.sh — Run security_tests.py for each assembly tool and aggregate results
#
# Each tool's security test suite validates memory safety, buffer overflow
# resistance, signal handling, and edge cases for the assembly binary.
#
# Usage:
#   bash tests/assembly/run_security.sh [--repo-dir DIR] [--asm-dir DIR]
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

# Assembly tools to test
ASM_TOOLS=(cat seq nl expand unexpand fold uniq od sort false)

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
    exit 1
fi

if [[ ! -d "$FCOREUTILS_DIR/assembly" ]]; then
    echo "ERROR: $FCOREUTILS_DIR/assembly/ not found"
    exit 1
fi

mkdir -p "$RESULTS_DIR"

# ── Per-tool security test runner ────────────────────────────────────────────

TOTAL_PASS=0
TOTAL_FAIL=0
TOTAL_SKIP=0
TOTAL_TESTS=0
TOOL_RESULTS_JSON=""

run_tool_security_test() {
    local tool="$1"
    local binary="f${tool}"
    local binary_path="$ASM_INSTALL_DIR/$binary"
    local test_script="$FCOREUTILS_DIR/assembly/$tool/tests/security_tests.py"

    echo ""
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Assembly security test: $tool ($binary)${NC}"
    echo -e "${BLUE}════════════════════════════════════════════${NC}"

    # Check binary exists
    if [[ ! -x "$binary_path" ]]; then
        echo -e "  ${YELLOW}SKIP: $binary not found at $binary_path${NC}"
        local entry="{\"tool\":\"$tool\",\"binary\":\"$binary\",\"status\":\"SKIP\",\"reason\":\"binary not found\",\"passed\":0,\"failed\":0,\"skipped\":0,\"total\":0}"
        if [[ -z "$TOOL_RESULTS_JSON" ]]; then
            TOOL_RESULTS_JSON="$entry"
        else
            TOOL_RESULTS_JSON="$TOOL_RESULTS_JSON,$entry"
        fi
        return 0
    fi

    # Check test script exists
    if [[ ! -f "$test_script" ]]; then
        echo -e "  ${YELLOW}SKIP: No security test at $test_script${NC}"
        local entry="{\"tool\":\"$tool\",\"binary\":\"$binary\",\"status\":\"SKIP\",\"reason\":\"no security test\",\"passed\":0,\"failed\":0,\"skipped\":0,\"total\":0}"
        if [[ -z "$TOOL_RESULTS_JSON" ]]; then
            TOOL_RESULTS_JSON="$entry"
        else
            TOOL_RESULTS_JSON="$TOOL_RESULTS_JSON,$entry"
        fi
        return 0
    fi

    # The security_tests.py scripts have a BIN variable at the top that defaults
    # to looking for the binary relative to the test file. We override this via
    # environment or we change to the tool directory so the script finds it.
    local test_output
    local test_exit=0

    # Run security tests from the tool's directory so relative paths work.
    # Pass the binary path explicitly if the script supports it.
    pushd "$FCOREUTILS_DIR/assembly/$tool" >/dev/null
    # Create a symlink so the script finds the binary at its expected path
    local expected_bin_path="$FCOREUTILS_DIR/assembly/$tool/$binary"
    local created_symlink=false
    if [[ ! -f "$expected_bin_path" ]]; then
        ln -sf "$binary_path" "$expected_bin_path"
        created_symlink=true
    fi

    test_output=$(timeout 600 python3 tests/security_tests.py 2>&1) || test_exit=$?

    # Clean up symlink if we created it
    if $created_symlink; then
        rm -f "$expected_bin_path"
    fi
    popd >/dev/null

    # Parse results from the output
    # security_tests.py prints summary like:
    #   "TOTAL: 150  PASS: 148  FAIL: 1  SKIP: 1"
    # or: "N passed, M failed, K skipped out of T tests"
    local passed=0 failed=0 skipped=0 total=0

    # Try pattern: "TOTAL: N  PASS: N  FAIL: N  SKIP: N"
    if echo "$test_output" | grep -qE "TOTAL:\s+[0-9]"; then
        total=$(echo "$test_output" | grep -oP "TOTAL:\s+\K[0-9]+" | tail -1)
        passed=$(echo "$test_output" | grep -oP "PASS:\s+\K[0-9]+" | tail -1)
        failed=$(echo "$test_output" | grep -oP "FAIL:\s+\K[0-9]+" | tail -1)
        skipped=$(echo "$test_output" | grep -oP "SKIP:\s+\K[0-9]+" | tail -1)
    fi

    # Try alternative patterns
    if [[ "$total" -eq 0 ]]; then
        # Count [PASS], [FAIL], [SKIP] lines
        passed=$(echo "$test_output" | grep -c "^\[PASS\]" || true)
        failed=$(echo "$test_output" | grep -c "^\[FAIL\]" || true)
        skipped=$(echo "$test_output" | grep -c "^\[SKIP\]" || true)
        total=$((passed + failed + skipped))
    fi

    # Fallback
    if [[ "$total" -eq 0 ]]; then
        if [[ "$test_exit" -eq 0 ]]; then
            passed=1; total=1
        else
            failed=1; total=1
        fi
    fi

    TOTAL_PASS=$((TOTAL_PASS + passed))
    TOTAL_FAIL=$((TOTAL_FAIL + failed))
    TOTAL_SKIP=$((TOTAL_SKIP + skipped))
    TOTAL_TESTS=$((TOTAL_TESTS + total))

    local status="tested"
    if [[ "$failed" -eq 0 ]]; then
        echo -e "  ${GREEN}PASS: $passed/$total security tests passed ($skipped skipped)${NC}"
    else
        echo -e "  ${RED}RESULT: $passed passed, $failed FAILED, $skipped skipped out of $total${NC}"
        # Show failure details
        echo "$test_output" | grep "^\[FAIL\]" | head -10 | while IFS= read -r line; do
            echo -e "    ${RED}$line${NC}"
        done
    fi

    local entry="{\"tool\":\"$tool\",\"binary\":\"$binary\",\"status\":\"$status\",\"passed\":$passed,\"failed\":$failed,\"skipped\":$skipped,\"total\":$total}"
    if [[ -z "$TOOL_RESULTS_JSON" ]]; then
        TOOL_RESULTS_JSON="$entry"
    else
        TOOL_RESULTS_JSON="$TOOL_RESULTS_JSON,$entry"
    fi
}

# ── Run all tests ─────────────────────────────────────────────────────────────

echo "=== Assembly Security Tests ==="
echo "  Assembly binaries: $ASM_INSTALL_DIR"
echo "  Source tree:       $FCOREUTILS_DIR"
echo "  Results dir:       $RESULTS_DIR"

for tool in "${ASM_TOOLS[@]}"; do
    run_tool_security_test "$tool"
done

# ── Summary ───────────────────────────────────────────────────────────────────

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Assembly Security Test Summary${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "  Tools tested: ${#ASM_TOOLS[@]}"
echo -e "  Total tests:  $TOTAL_TESTS"
echo -e "  ${GREEN}Passed:        $TOTAL_PASS${NC}"
echo -e "  ${RED}Failed:        $TOTAL_FAIL${NC}"
echo -e "  ${YELLOW}Skipped:       $TOTAL_SKIP${NC}"

if [[ "$TOTAL_TESTS" -gt 0 ]]; then
    local_rate=$(python3 -c "print(f'{$TOTAL_PASS / $TOTAL_TESTS * 100:.1f}')" 2>/dev/null || echo "?")
    echo -e "  Pass rate:    ${local_rate}%"
fi
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"

# ── Write JSON results ────────────────────────────────────────────────────────

cat > "$RESULTS_DIR/asm_security_results.json" <<EOF
{
    "type": "assembly_security",
    "platform": "$(uname -s)_$(uname -m)",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "summary": {
        "tools_tested": ${#ASM_TOOLS[@]},
        "total_tests": $TOTAL_TESTS,
        "total_passed": $TOTAL_PASS,
        "total_failed": $TOTAL_FAIL,
        "total_skipped": $TOTAL_SKIP
    },
    "tools": [$TOOL_RESULTS_JSON]
}
EOF

echo ""
echo "Results written to $RESULTS_DIR/asm_security_results.json"

# Exit with failure if any security tests failed
if [[ "$TOTAL_FAIL" -gt 0 ]]; then
    exit 1
fi
exit 0
