#!/usr/bin/env bash
# Run all performance benchmarks for all fcoreutils tools
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

# Generate test data (including large files for benchmarks)
echo "Generating test data (including large files for benchmarks)..."
bash "$SCRIPT_DIR/../helpers/generate_test_data.sh"
echo ""

# Build uutils/coreutils if UUTILS_DIR is not already set
if [[ -z "${UUTILS_DIR:-}" ]]; then
    echo "Building uutils/coreutils from source..."
    INSTALL_UUTILS_SCRIPT="$SCRIPT_DIR/../../scripts/install_uutils.sh"
    if [[ -f "$INSTALL_UUTILS_SCRIPT" ]]; then
        # Source to capture UUTILS_DIR export; run in subshell to capture output
        UUTILS_OUTPUT=$(bash "$INSTALL_UUTILS_SCRIPT" 2>&1) && {
            # Extract UUTILS_DIR from the output
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

# All tools — run bench scripts for any that exist
TOOLS=(
    # Original core tools
    wc cut sha256sum md5sum b2sum base64 sort tr uniq tac
    # Text processing
    head tail cat rev expand unexpand fold paste nl comm join
    # Encoding/Decoding
    basenc base32
    # File operations
    ln touch truncate mkdir rmdir mknod mkfifo mktemp
    # Text/Data processing
    seq shuf tsort tee sum cksum sha1sum sha224sum sha384sum sha512sum
    # System information
    id groups whoami logname uname uptime arch hostid tty nproc pwd
    # Process/Environment
    env timeout nice nohup sleep sync
    # Utility commands
    true false link unlink basename dirname pathchk realpath readlink dircolors
    # I/O & Text
    echo factor expr test
    # File ops
    cp mv rm dd split csplit install shred chmod chown chgrp
    # Assembly-optimized
    yes
)
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
