#!/usr/bin/env bash
# Run all compatibility tests for all fcoreutils tools
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

# Auto-discover all test scripts alphabetically
TOOLS=()
for script in $(ls "$SCRIPT_DIR"/test_*.sh 2>/dev/null | sort); do
    tool=$(basename "$script" .sh)
    tool="${tool#test_}"
    TOOLS+=("$tool")
done

for tool in "${TOOLS[@]}"; do
    script="$SCRIPT_DIR/test_${tool}.sh"
    if [[ -f "$script" ]]; then
        echo ""
        echo "Running $tool tests..."
        # Never fail the overall run — individual tool failures are captured
        if bash "$script"; then
            TOOLS_TESTED=$((TOOLS_TESTED + 1))
        else
            TOOLS_TESTED=$((TOOLS_TESTED + 1))
        fi

        # Read results from JSON
        result_file="$RESULTS_DIR/${tool}_results.json"
        if [[ -f "$result_file" ]]; then
            status=$(python3 -c "import json; d=json.load(open('$result_file')); print(d.get('status',''))" 2>/dev/null | tr -d '\r' || echo "")
            if [[ "$status" == "NOT_IMPLEMENTED" ]]; then
                TOOLS_SKIPPED=$((TOOLS_SKIPPED + 1))
                TOOL_SUMMARIES="${TOOL_SUMMARIES}\n  $tool: NOT IMPLEMENTED (skipped)"
            else
                passed=$(python3 -c "import json; d=json.load(open('$result_file')); print(d['summary']['passed'])" 2>/dev/null | tr -d '\r' || echo "0")
                failed=$(python3 -c "import json; d=json.load(open('$result_file')); print(d['summary']['failed'])" 2>/dev/null | tr -d '\r' || echo "0")
                skipped=$(python3 -c "import json; d=json.load(open('$result_file')); print(d['summary']['skipped'])" 2>/dev/null | tr -d '\r' || echo "0")
                total=$(python3 -c "import json; d=json.load(open('$result_file')); print(d['summary']['total'])" 2>/dev/null | tr -d '\r' || echo "0")

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

# Write overall results JSON with per-tool details
python3 -c "
import json, os, glob

results_dir = '$RESULTS_DIR'
tool_details = {}

# Collect per-tool results from individual JSON files
for f in sorted(glob.glob(os.path.join(results_dir, '*_results.json'))):
    basename = os.path.basename(f)
    if basename == 'compatibility_results.json':
        continue
    tool_name = basename.replace('_results.json', '')
    try:
        data = json.load(open(f))
        status = data.get('status', '')
        if status == 'NOT_IMPLEMENTED':
            tool_details[tool_name] = {
                'status': 'NOT_IMPLEMENTED',
                'total': 0, 'passed': 0, 'failed': 0, 'skipped': 0,
                'failed_tests': []
            }
        else:
            s = data.get('summary', {})
            failed_tests = []
            for t in data.get('tests', []):
                if t.get('status') == 'FAIL':
                    failed_tests.append(t.get('name', '?'))
            tool_details[tool_name] = {
                'status': 'tested',
                'total': s.get('total', 0),
                'passed': s.get('passed', 0),
                'failed': s.get('failed', 0),
                'skipped': s.get('skipped', 0),
                'failed_tests': failed_tests
            }
    except Exception as e:
        tool_details[tool_name] = {
            'status': 'error',
            'error': str(e),
            'total': 0, 'passed': 0, 'failed': 0, 'skipped': 0,
            'failed_tests': []
        }

aggregate = {
    'type': 'compatibility',
    'platform': '$(uname -s)_$(uname -m)',
    'timestamp': '$(date -u +%Y-%m-%dT%H:%M:%SZ)',
    'summary': {
        'total_tests': $TOTAL_RUN,
        'passed': $TOTAL_PASSED,
        'failed': $TOTAL_FAILED,
        'skipped': $TOTAL_SKIPPED,
        'tools_tested': $TOOLS_TESTED,
        'tools_skipped': $TOOLS_SKIPPED
    },
    'tools': tool_details
}

with open(os.path.join(results_dir, 'compatibility_results.json'), 'w') as f:
    json.dump(aggregate, f, indent=2)
print('Compatibility results saved with per-tool details.')
" 2>/dev/null || {
    echo "Warning: Python aggregation failed, writing basic JSON"
    cat > "$RESULTS_DIR/compatibility_results.json" <<FALLBACK
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
    },
    "tools": {}
}
FALLBACK
}

# Exit with failure if any tests failed (so CI can report the status)
if [[ "$TOTAL_FAILED" -gt 0 ]]; then
    exit 1
fi
exit 0
