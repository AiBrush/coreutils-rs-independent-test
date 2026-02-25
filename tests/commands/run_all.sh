#!/usr/bin/env bash
# run_all.sh — Run all per-command tests and aggregate results
#
# Discovers all tool directories under tests/commands/, runs run_tool.sh
# for each, then aggregates results into compatibility_results.json
# (backward-compatible with existing report pipeline).

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
export RESULTS_DIR="${RESULTS_DIR:-$PROJECT_ROOT/results}"
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
bash "$PROJECT_ROOT/tests/helpers/generate_test_data.sh"
echo ""

TOTAL_PASSED=0
TOTAL_FAILED=0
TOTAL_SKIPPED=0
TOTAL_RUN=0
TOOLS_TESTED=0
TOOLS_SKIPPED=0
TOOL_SUMMARIES=""

# Discover tool directories (skip _shared and support)
TOOLS=()
for dir in "$SCRIPT_DIR"/*/; do
    tool=$(basename "$dir")
    # Skip non-tool directories
    [[ "$tool" == "_shared" || "$tool" == "support" ]] && continue
    # Must have at least test_compat.sh or gnu/ directory
    if [[ -f "$dir/test_compat.sh" ]] || [[ -d "$dir/gnu" ]]; then
        TOOLS+=("$tool")
    fi
done

# Sort tools
IFS=$'\n' TOOLS=($(sort <<<"${TOOLS[*]}")); unset IFS

for tool in "${TOOLS[@]}"; do
    echo ""
    echo "Running $tool tests..."

    # Run per-tool test suite (never fail the overall run)
    if bash "$SCRIPT_DIR/run_tool.sh" "$tool"; then
        TOOLS_TESTED=$((TOOLS_TESTED + 1))
    else
        TOOLS_TESTED=$((TOOLS_TESTED + 1))
    fi

    # Read results from JSON
    result_file="$RESULTS_DIR/${tool}_results.json"
    if [[ ! -f "$result_file" ]]; then
        TOOLS_SKIPPED=$((TOOLS_SKIPPED + 1))
        TOOL_SUMMARIES="${TOOL_SUMMARIES}\n  $tool: NO RESULTS (skipped)"
    else
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
done

# --- Run _shared tests ---
SHARED_DIR="$SCRIPT_DIR/_shared/gnu"
if [[ -d "$SHARED_DIR" ]]; then
    SHARED_TESTS=()
    while IFS= read -r f; do
        [[ -n "$f" ]] && SHARED_TESTS+=("$f")
    done < <(find "$SHARED_DIR" -maxdepth 1 \( -name "*.sh" -o -name "*.pl" \) -type f 2>/dev/null | sort)

    if [[ ${#SHARED_TESTS[@]} -gt 0 ]]; then
        echo ""
        echo "Running ${#SHARED_TESTS[@]} shared/generic GNU upstream tests..."
        # Shared tests are informational — not counted in per-tool totals
    fi
fi

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

# Write overall results JSON with per-tool details (backward-compatible)
python3 -c "
import json, os, glob

results_dir = '$RESULTS_DIR'
tool_details = {}

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
                if t.get('status') == 'FAIL' or t.get('f_status') == 'FAIL':
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

# Exit with failure if any tests failed
if [[ "$TOTAL_FAILED" -gt 0 ]]; then
    exit 1
fi
exit 0
