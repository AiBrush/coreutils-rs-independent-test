#!/usr/bin/env bash
# Run all performance benchmarks for NEW tools (v0.5.9+ additions)
# These benchmarks are separate from the main suite and DO NOT block CI/CD.
# Results are saved but NOT included in speedup-history.png or README tables.
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export RESULTS_DIR="${RESULTS_DIR:-$SCRIPT_DIR/../../results}"
export TEST_DATA_DIR="${TEST_DATA_DIR:-/tmp/fcoreutils-test-data}"
export GENERATE_LARGE="${GENERATE_LARGE:-true}"

mkdir -p "$RESULTS_DIR"

echo "============================================================"
echo "  fcoreutils NEW Tools Performance Benchmark Suite"
echo "  Platform: $(uname -s) $(uname -m)"
echo "  Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "  NOTE: These results do NOT affect the main benchmark metrics"
echo "============================================================"
echo ""

# Generate test data (including large files for benchmarks)
echo "Generating test data (including large files for benchmarks)..."
bash "$SCRIPT_DIR/../helpers/generate_test_data.sh"
echo ""

# Build uutils/coreutils if UUTILS_DIR is not already set
if [[ -z "${UUTILS_DIR:-}" ]]; then
    echo "Building uutils/coreutils from source..."
    INSTALL_UUTILS_SCRIPT="$SCRIPT_DIR/../../scripts/install_uutils.sh"
    if [[ -f "$INSTALL_UUTILS_SCRIPT" ]]; then
        UUTILS_OUTPUT=$(bash "$INSTALL_UUTILS_SCRIPT" 2>&1) && {
            UUTILS_DIR_LINE=$(echo "$UUTILS_OUTPUT" | grep "^UUTILS_DIR=" | tail -1)
            if [[ -n "$UUTILS_DIR_LINE" ]]; then
                export UUTILS_DIR="${UUTILS_DIR_LINE#UUTILS_DIR=}"
                echo "uutils binaries at: $UUTILS_DIR"
            fi
        } || {
            echo "WARNING: Failed to build uutils/coreutils. Continuing without uutils."
            echo "$UUTILS_OUTPUT" | tail -5
        }
    else
        echo "WARNING: install_uutils.sh not found. Continuing without uutils."
    fi
    echo ""
fi

# The 11 new tools
NEW_TOOLS=(head tail cat rev expand unexpand fold paste nl comm join)
BENCH_SUMMARIES=""

for tool in "${NEW_TOOLS[@]}"; do
    script="$SCRIPT_DIR/bench_${tool}.sh"
    if [[ -f "$script" ]]; then
        echo ""
        echo "Running $tool benchmarks..."
        bash "$script" || true
        BENCH_SUMMARIES="${BENCH_SUMMARIES}\n  $tool: done"
    else
        echo "WARNING: No benchmark script for $tool"
        BENCH_SUMMARIES="${BENCH_SUMMARIES}\n  $tool: NO SCRIPT"
    fi
done

echo ""
echo "============================================================"
echo "  NEW TOOLS BENCHMARK SUMMARY"
echo "============================================================"
echo -e "$BENCH_SUMMARIES"
echo ""

# Aggregate all new tool benchmark results
python3 -c "
import json, glob, os

new_tools = ['head', 'tail', 'cat', 'rev', 'expand', 'unexpand', 'fold', 'paste', 'nl', 'comm', 'join']
results = {}
tools_benchmarked = 0
tools_skipped = 0
tool_summaries = {}

for tool in new_tools:
    f_path = '$RESULTS_DIR/{}_benchmark.json'.format(tool)
    if os.path.exists(f_path):
        try:
            data = json.load(open(f_path))
            results[tool] = data
            if data.get('status') == 'NOT_IMPLEMENTED':
                tools_skipped += 1
                tool_summaries[tool] = {'status': 'skipped'}
            else:
                benchmarks = data.get('benchmarks', [])
                valid = [b for b in benchmarks if not b.get('error')]
                if not valid:
                    tools_skipped += 1
                    tool_summaries[tool] = {'status': 'no_results'}
                else:
                    tools_benchmarked += 1
                    # Compute average speedup vs GNU
                    gnu_speedups = [b['speedup'] for b in valid if b.get('speedup') is not None and isinstance(b.get('speedup'), (int, float))]
                    avg_gnu_speedup = sum(gnu_speedups) / len(gnu_speedups) if gnu_speedups else None
                    # Compute average speedup vs uutils
                    uutils_speedups = [b['f_vs_uutils'] for b in valid if b.get('f_vs_uutils') is not None and isinstance(b.get('f_vs_uutils'), (int, float))]
                    avg_uutils_speedup = sum(uutils_speedups) / len(uutils_speedups) if uutils_speedups else None
                    # Collect individual benchmark details
                    bench_details = []
                    for b in valid:
                        detail = {'name': b.get('name', '?')}
                        if b.get('gnu_mean') is not None:
                            detail['gnu_mean_s'] = round(b['gnu_mean'], 6)
                        if b.get('f_mean') is not None:
                            detail['f_mean_s'] = round(b['f_mean'], 6)
                        if b.get('uutils_mean') is not None:
                            detail['uutils_mean_s'] = round(b['uutils_mean'], 6)
                        if b.get('speedup') is not None:
                            detail['vs_gnu'] = b['speedup']
                        if b.get('f_vs_uutils') is not None:
                            detail['vs_uutils'] = b['f_vs_uutils']
                        bench_details.append(detail)
                    tool_summaries[tool] = {
                        'status': 'benchmarked',
                        'num_benchmarks': len(valid),
                        'avg_speedup_vs_gnu': round(avg_gnu_speedup, 2) if avg_gnu_speedup else None,
                        'avg_speedup_vs_uutils': round(avg_uutils_speedup, 2) if avg_uutils_speedup else None,
                        'benchmarks': bench_details,
                    }
        except Exception as e:
            tools_skipped += 1
            tool_summaries[tool] = {'status': 'error', 'message': str(e)}
    else:
        tools_skipped += 1
        tool_summaries[tool] = {'status': 'no_file'}

aggregate = {
    'type': 'new_tools_benchmark',
    'platform': '$(uname -s)_$(uname -m)',
    'timestamp': '$(date -u +%Y-%m-%dT%H:%M:%SZ)',
    'note': 'These results are for new tools and are NOT included in the main performance metrics',
    'summary': {
        'tools_benchmarked': tools_benchmarked,
        'tools_skipped': tools_skipped,
        'tool_summaries': tool_summaries,
    },
    'tools': results
}

with open('$RESULTS_DIR/new_tools_benchmark_results.json', 'w') as f:
    json.dump(aggregate, f, indent=2)
print('Aggregate new tools benchmark results saved.')
" 2>/dev/null || echo "Warning: Could not aggregate new tools benchmark results"

echo "Results saved to $RESULTS_DIR/"
echo "============================================================"

# IMPORTANT: Always exit 0 — new tool failures must NOT block CI/CD
exit 0
