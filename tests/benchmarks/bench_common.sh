#!/usr/bin/env bash
# Common benchmark framework for fcoreutils
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
RESULTS_DIR="${RESULTS_DIR:-$PROJECT_ROOT/results}"
TEST_DATA_DIR="${TEST_DATA_DIR:-/tmp/fcoreutils-test-data}"

WARMUP=${BENCH_WARMUP:-3}
RUNS=${BENCH_RUNS:-10}
BENCH_RESULTS_JSON="[]"
TOOL_NAME=""

# Colors
if [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
    NC='\033[0m'
else
    RED='' GREEN='' YELLOW='' BLUE='' CYAN='' NC=''
fi

check_hyperfine() {
    if ! command -v hyperfine &>/dev/null; then
        echo "hyperfine not found. Installing..."
        if command -v cargo &>/dev/null; then
            cargo install hyperfine
        elif command -v brew &>/dev/null; then
            brew install hyperfine
        elif command -v apt-get &>/dev/null; then
            sudo apt-get install -y hyperfine 2>/dev/null || cargo install hyperfine
        else
            echo "ERROR: Cannot install hyperfine automatically"
            echo "Install it manually: cargo install hyperfine"
            return 1
        fi
    fi
}

init_benchmark() {
    local tool="$1"
    TOOL_NAME="$tool"
    BENCH_RESULTS_JSON="[]"
    mkdir -p "$RESULTS_DIR"

    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Benchmarking: $tool${NC}"
    echo -e "${BLUE}  Warmup: $WARMUP  Runs: $RUNS${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
}

# Run a single benchmark comparing GNU vs fcoreutils
# Usage: run_benchmark "name" "gnu_cmd" "f_cmd" "claimed_speedup"
run_benchmark() {
    local name="$1"
    local gnu_cmd="$2"
    local f_cmd="$3"
    local claimed_speedup="${4:-}"

    echo ""
    echo -e "${CYAN}--- $name ---${NC}"

    local json_file
    json_file=$(mktemp /tmp/bench_result_XXXXXX.json)

    # Run hyperfine
    if hyperfine \
        --warmup "$WARMUP" \
        --runs "$RUNS" \
        --export-json "$json_file" \
        -n "GNU $TOOL_NAME" "$gnu_cmd" \
        -n "f$TOOL_NAME" "$f_cmd" 2>&1; then

        # Parse results
        local gnu_mean f_mean speedup
        gnu_mean=$(python3 -c "
import json
d = json.load(open('$json_file'))
print(f\"{d['results'][0]['mean']:.6f}\")
" 2>/dev/null || echo "0")
        f_mean=$(python3 -c "
import json
d = json.load(open('$json_file'))
print(f\"{d['results'][1]['mean']:.6f}\")
" 2>/dev/null || echo "0")
        speedup=$(python3 -c "
gnu = $gnu_mean
f = $f_mean
if f > 0:
    print(f'{gnu/f:.1f}')
else:
    print('N/A')
" 2>/dev/null || echo "N/A")

        local verdict=""
        if [[ -n "$claimed_speedup" ]] && [[ "$speedup" != "N/A" ]]; then
            local claimed_num
            claimed_num=$(echo "$claimed_speedup" | sed 's/x$//')
            verdict=$(python3 -c "
s = $speedup
c = $claimed_num
if s >= c:
    print('MEETS/EXCEEDS')
elif s >= c * 0.5:
    print('CLOSE')
else:
    print('FALLS SHORT')
" 2>/dev/null || echo "UNKNOWN")
        fi

        echo -e "  GNU: ${gnu_mean}s  |  F: ${f_mean}s  |  ${GREEN}Speedup: ${speedup}x${NC}"
        if [[ -n "$claimed_speedup" ]]; then
            echo -e "  Claimed: ${claimed_speedup}  |  Verdict: $verdict"
        fi

        # Record result
        local entry="{\"name\":\"$name\",\"gnu_mean\":$gnu_mean,\"f_mean\":$f_mean,\"speedup\":$speedup,\"claimed\":\"$claimed_speedup\",\"verdict\":\"$verdict\"}"
        if [[ "$BENCH_RESULTS_JSON" == "[]" ]]; then
            BENCH_RESULTS_JSON="[$entry]"
        else
            BENCH_RESULTS_JSON="${BENCH_RESULTS_JSON%]},${entry}]"
        fi
    else
        echo -e "  ${RED}Benchmark failed${NC}"
        local entry="{\"name\":\"$name\",\"error\":\"benchmark failed\"}"
        if [[ "$BENCH_RESULTS_JSON" == "[]" ]]; then
            BENCH_RESULTS_JSON="[$entry]"
        else
            BENCH_RESULTS_JSON="${BENCH_RESULTS_JSON%]},${entry}]"
        fi
    fi

    rm -f "$json_file"
}

# Run benchmark with stdin piping
run_stdin_benchmark() {
    local name="$1"
    local input_file="$2"
    local gnu_cmd="$3"
    local f_cmd="$4"
    local claimed_speedup="${5:-}"

    run_benchmark "$name" \
        "cat '$input_file' | $gnu_cmd" \
        "cat '$input_file' | $f_cmd" \
        "$claimed_speedup"
}

save_benchmark_results() {
    local claimed_speedup="${1:-}"

    cat > "$RESULTS_DIR/${TOOL_NAME}_benchmark.json" <<EOF
{
    "tool": "$TOOL_NAME",
    "platform": "$(uname -s)_$(uname -m)",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "warmup": $WARMUP,
    "runs": $RUNS,
    "claimed_speedup": "$claimed_speedup",
    "benchmarks": $BENCH_RESULTS_JSON
}
EOF

    echo ""
    echo -e "${BLUE}Results saved to $RESULTS_DIR/${TOOL_NAME}_benchmark.json${NC}"
}
