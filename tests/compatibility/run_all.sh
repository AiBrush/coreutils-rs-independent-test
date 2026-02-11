#!/usr/bin/env bash
# Run all compatibility tests
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export RESULTS_DIR="${RESULTS_DIR:-$SCRIPT_DIR/../../results}"
export TEST_DATA_DIR="${TEST_DATA_DIR:-/tmp/fcoreutils-test-data}"

mkdir -p "$RESULTS_DIR"

echo "============================================================"
echo "  fcoreutils Compatibility Test Suite"
echo "  Platform: $(uname -s) $(uname -m)"
echo "  Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "============================================================"
echo ""

# Generate test data first
echo "Generating test data..."
bash "$SCRIPT_DIR/../helpers/generate_test_data.sh"
echo ""

TOTAL_PASSED=0
TOTAL_FAILED=0
TOTAL_SKIPPED=0
TOTAL_RUN=0
TOOLS_TESTED=0
TOOLS_SKIPPED=0
TOOL_SUMMARIES=""

TOOLS=(wc cut sha256sum md5sum b2sum base64 sort tr uniq tac)

for tool in "${TOOLS[@]}"; do
    script="$SCRIPT_DIR/test_${tool}.sh"
    if [[ -f "$script" ]]; then
        echo ""
        echo "Running $tool tests..."
        if bash "$script"; then
            TOOLS_TESTED=$((TOOLS_TESTED + 1))
        else
            TOOLS_TESTED=$((TOOLS_TESTED + 1))
        fi

        # Read results from JSON
        result_file="$RESULTS_DIR/${tool}_results.json"
        if [[ -f "$result_file" ]]; then
            status=$(python3 -c "import json; d=json.load(open('$result_file')); print(d.get('status',''))" 2>/dev/null || echo "")
            if [[ "$status" == "NOT_IMPLEMENTED" ]]; then
                TOOLS_SKIPPED=$((TOOLS_SKIPPED + 1))
                TOOL_SUMMARIES="${TOOL_SUMMARIES}\n  $tool: NOT IMPLEMENTED (skipped)"
            else
                passed=$(python3 -c "import json; d=json.load(open('$result_file')); print(d['summary']['passed'])" 2>/dev/null || echo "0")
                failed=$(python3 -c "import json; d=json.load(open('$result_file')); print(d['summary']['failed'])" 2>/dev/null || echo "0")
                skipped=$(python3 -c "import json; d=json.load(open('$result_file')); print(d['summary']['skipped'])" 2>/dev/null || echo "0")
                total=$(python3 -c "import json; d=json.load(open('$result_file')); print(d['summary']['total'])" 2>/dev/null || echo "0")

                TOTAL_PASSED=$((TOTAL_PASSED + passed))
                TOTAL_FAILED=$((TOTAL_FAILED + failed))
                TOTAL_SKIPPED=$((TOTAL_SKIPPED + skipped))
                TOTAL_RUN=$((TOTAL_RUN + total))

                if [[ "$failed" -eq 0 ]]; then
                    TOOL_SUMMARIES="${TOOL_SUMMARIES}\n  $tool: ${passed}/${total} PASSED"
                else
                    TOOL_SUMMARIES="${TOOL_SUMMARIES}\n  $tool: ${passed}/${total} passed, ${failed} FAILED"
                fi
            fi
        fi
    else
        echo "WARNING: No test script for $tool"
    fi
done

echo ""
echo "============================================================"
echo "  OVERALL COMPATIBILITY RESULTS"
echo "============================================================"
echo -e "$TOOL_SUMMARIES"
echo ""
echo "  Total tests:   $TOTAL_RUN"
echo "  Passed:        $TOTAL_PASSED"
echo "  Failed:        $TOTAL_FAILED"
echo "  Skipped:       $TOTAL_SKIPPED"
echo "  Tools tested:  $TOOLS_TESTED"
echo "  Tools skipped: $TOOLS_SKIPPED"
echo "============================================================"

# Write overall results JSON
cat > "$RESULTS_DIR/compatibility_results.json" <<EOF
{
    "type": "compatibility",
    "platform": "$(uname -s)_$(uname -m)",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "summary": {
        "total_tests": $TOTAL_RUN,
        "passed": $TOTAL_PASSED,
        "failed": $TOTAL_FAILED,
        "skipped": $TOTAL_SKIPPED,
        "tools_tested": $TOOLS_TESTED,
        "tools_skipped": $TOOLS_SKIPPED
    }
}
EOF

# Exit with failure if any tests failed
if [[ "$TOTAL_FAILED" -gt 0 ]]; then
    exit 1
fi
exit 0
