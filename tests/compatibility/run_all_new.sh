#!/usr/bin/env bash
# Run all compatibility tests for NEW tools (v0.5.9+ additions)
# These tests are separate from the main test suite and DO NOT block CI/CD.
# Results are saved but NOT included in speedup-history.png or README tables.
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export RESULTS_DIR="${RESULTS_DIR:-$SCRIPT_DIR/../../results}"
export TEST_DATA_DIR="${TEST_DATA_DIR:-/tmp/fcoreutils-test-data}"

mkdir -p "$RESULTS_DIR"

echo "============================================================"
echo "  fcoreutils NEW Tools Compatibility Test Suite"
echo "  Platform: $(uname -s) $(uname -m)"
echo "  Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "  NOTE: These results do NOT affect the main test metrics"
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

# All new tools (original 11 + 40 additional tools from v0.5.10+)
NEW_TOOLS=(
    # Original 11 new tools (v0.5.9)
    head tail cat rev expand unexpand fold paste nl comm join
    # Encoding/Decoding
    basenc base32
    # File Operations
    ln touch truncate mkdir rmdir mknod mkfifo mktemp
    # Text/Data Processing
    seq shuf tsort tee sum cksum sha1sum sha224sum sha384sum sha512sum
    # System Information
    id groups whoami logname uname uptime arch hostid tty nproc pwd
    # Process/Environment
    env timeout nice nohup sleep sync
    # Utility Commands
    true false link unlink basename dirname pathchk realpath readlink dircolors
    # PR #241 additions
    echo users printf test expr factor split numfmt fmt csplit od ptx
    stat who pinky date df du stty chmod chown chgrp shred dd
    rm cp mv install pr ls stdbuf
)

for tool in "${NEW_TOOLS[@]}"; do
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
echo "  NEW TOOLS COMPATIBILITY RESULTS"
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

# Write overall results JSON for new tools (with per-tool detail)
python3 -c "
import json, os, glob

results_dir = '$RESULTS_DIR'
tool_details = {}

# Collect per-tool results from individual JSON files
for f in sorted(glob.glob(os.path.join(results_dir, '*_results.json'))):
    basename = os.path.basename(f)
    # Skip the aggregate file itself
    if basename == 'new_tools_compatibility_results.json':
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
    'type': 'new_tools_compatibility',
    'platform': '$(uname -s)_$(uname -m)',
    'timestamp': '$(date -u +%Y-%m-%dT%H:%M:%SZ)',
    'note': 'These results are for new tools and are NOT included in the main performance/compatibility metrics',
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

with open(os.path.join(results_dir, 'new_tools_compatibility_results.json'), 'w') as f:
    json.dump(aggregate, f, indent=2)
print('Aggregate results with per-tool details saved.')
" 2>/dev/null || {
    echo "Warning: Python aggregation failed, writing basic JSON"
    cat > "$RESULTS_DIR/new_tools_compatibility_results.json" <<FALLBACK
{
    "type": "new_tools_compatibility",
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

echo ""
echo "Results saved to $RESULTS_DIR/new_tools_compatibility_results.json"

# IMPORTANT: Always exit 0 — new tool failures must NOT block CI/CD
exit 0
