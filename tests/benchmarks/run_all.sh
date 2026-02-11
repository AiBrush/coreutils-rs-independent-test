#!/usr/bin/env bash
# Run all performance benchmarks
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export RESULTS_DIR="${RESULTS_DIR:-$SCRIPT_DIR/../../results}"
export TEST_DATA_DIR="${TEST_DATA_DIR:-/tmp/fcoreutils-test-data}"
export GENERATE_LARGE="${GENERATE_LARGE:-true}"

mkdir -p "$RESULTS_DIR"

echo "============================================================"
echo "  fcoreutils Performance Benchmark Suite"
echo "  Platform: $(uname -s) $(uname -m)"
echo "  Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "============================================================"
echo ""

# Generate test data (including large files)
echo "Generating test data (including large files for benchmarks)..."
bash "$SCRIPT_DIR/../helpers/generate_test_data.sh"
echo ""

TOOLS=(wc cut sha256sum md5sum b2sum base64 sort tr uniq tac)
BENCH_SUMMARIES=""

for tool in "${TOOLS[@]}"; do
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
echo "  BENCHMARK SUMMARY"
echo "============================================================"
echo -e "$BENCH_SUMMARIES"
echo ""

# Aggregate all benchmark results
python3 -c "
import json, glob, os

results = {}
for f in glob.glob('$RESULTS_DIR/*_benchmark.json'):
    try:
        data = json.load(open(f))
        tool = data.get('tool', os.path.basename(f).replace('_benchmark.json', ''))
        results[tool] = data
    except:
        pass

aggregate = {
    'type': 'benchmark',
    'platform': '$(uname -s)_$(uname -m)',
    'timestamp': '$(date -u +%Y-%m-%dT%H:%M:%SZ)',
    'tools': results
}

with open('$RESULTS_DIR/benchmark_results.json', 'w') as f:
    json.dump(aggregate, f, indent=2)
print('Aggregate benchmark results saved.')
" 2>/dev/null || echo "Warning: Could not aggregate benchmark results"

echo "Results saved to $RESULTS_DIR/"
echo "============================================================"
