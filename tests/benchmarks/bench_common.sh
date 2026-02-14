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

# Run a single benchmark comparing GNU vs fcoreutils (and optionally uutils)
# Usage: run_benchmark "name" "gnu_cmd" "f_cmd" ["uutils_cmd"]
run_benchmark() {
    local name="$1"
    local gnu_cmd="$2"
    local f_cmd="$3"
    local uutils_cmd="${4:-}"

    # Skip uutils if UUTILS_DIR is not set or empty
    if [[ -z "${UUTILS_DIR:-}" ]]; then
        uutils_cmd=""
    fi

    echo ""
    echo -e "${CYAN}--- $name ---${NC}"

    local json_file
    json_file=$(mktemp /tmp/bench_result_XXXXXX.json)

    # Extract the GNU tool name (use override for stdin benchmarks, or first word)
    local gnu_binary
    if [[ -n "${GNU_BINARY_OVERRIDE:-}" ]]; then
        gnu_binary="$GNU_BINARY_OVERRIDE"
        unset GNU_BINARY_OVERRIDE
    else
        gnu_binary=$(echo "$gnu_cmd" | awk '{print $1}')
        # 'eval' is a shell builtin — the actual tool is the second word
        if [[ "$gnu_binary" == "eval" ]]; then
            gnu_binary=$(echo "$gnu_cmd" | awk '{print $2}')
        fi
    fi

    # Check if GNU tool is available
    if ! command -v "$gnu_binary" &>/dev/null; then
        echo -e "  ${YELLOW}GNU $TOOL_NAME not available on this platform${NC}"

        # Run fcoreutils only
        if hyperfine \
            --warmup "$WARMUP" \
            --runs "$RUNS" \
            --export-json "$json_file" \
            -n "f$TOOL_NAME" "$f_cmd" 2>&1; then

            local f_mean
            f_mean=$(python3 -c "
import json
d = json.load(open('$json_file'))
print(f\"{d['results'][0]['mean']:.6f}\")
" 2>/dev/null || echo "0")

            echo -e "  GNU: N/A (not installed)  |  F: ${f_mean}s"

            local entry="{\"name\":\"$name\",\"gnu_mean\":null,\"f_mean\":$f_mean,\"speedup\":null,\"gnu_missing\":true}"
            if [[ "$BENCH_RESULTS_JSON" == "[]" ]]; then
                BENCH_RESULTS_JSON="[$entry]"
            else
                BENCH_RESULTS_JSON="${BENCH_RESULTS_JSON%]},${entry}]"
            fi
        else
            echo -e "  ${RED}Benchmark failed${NC}"
            local entry="{\"name\":\"$name\",\"gnu_mean\":null,\"f_mean\":null,\"gnu_missing\":true,\"error\":\"benchmark failed\"}"
            if [[ "$BENCH_RESULTS_JSON" == "[]" ]]; then
                BENCH_RESULTS_JSON="[$entry]"
            else
                BENCH_RESULTS_JSON="${BENCH_RESULTS_JSON%]},${entry}]"
            fi
        fi

        rm -f "$json_file"
        return
    fi

    # Determine if we're running 2-way or 3-way comparison
    local has_uutils=false
    if [[ -n "$uutils_cmd" ]]; then
        # Check that the uutils binary actually exists
        local uutils_binary
        uutils_binary=$(echo "$uutils_cmd" | awk '{print $1}')
        if [[ "$uutils_binary" == "eval" ]]; then
            uutils_binary=$(echo "$uutils_cmd" | awk '{print $2}')
        fi
        if [[ "$uutils_binary" == cat ]]; then
            # stdin benchmark — uutils binary is after the pipe
            has_uutils=true
        elif [[ -x "$uutils_binary" ]]; then
            has_uutils=true
        else
            echo -e "  ${YELLOW}uutils binary not found: $uutils_binary${NC}"
        fi
    fi

    if $has_uutils; then
        # 3-way comparison: GNU vs fcoreutils vs uutils
        if hyperfine \
            --warmup "$WARMUP" \
            --runs "$RUNS" \
            --export-json "$json_file" \
            -n "GNU $TOOL_NAME" "$gnu_cmd" \
            -n "f$TOOL_NAME" "$f_cmd" \
            -n "uutils $TOOL_NAME" "$uutils_cmd" 2>&1; then

            local gnu_mean f_mean uutils_mean speedup f_vs_uutils uutils_vs_gnu
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
            uutils_mean=$(python3 -c "
import json
d = json.load(open('$json_file'))
print(f\"{d['results'][2]['mean']:.6f}\")
" 2>/dev/null || echo "0")
            speedup=$(python3 -c "
gnu=$gnu_mean; f=$f_mean
print(f'{gnu/f:.1f}' if f > 0 else 'N/A')
" 2>/dev/null || echo "N/A")
            f_vs_uutils=$(python3 -c "
u=$uutils_mean; f=$f_mean
print(f'{u/f:.1f}' if f > 0 else 'N/A')
" 2>/dev/null || echo "N/A")
            uutils_vs_gnu=$(python3 -c "
gnu=$gnu_mean; u=$uutils_mean
print(f'{gnu/u:.1f}' if u > 0 else 'N/A')
" 2>/dev/null || echo "N/A")

            echo -e "  GNU: ${gnu_mean}s  |  F: ${f_mean}s  |  uutils: ${uutils_mean}s  |  ${GREEN}f vs GNU: ${speedup}x  |  f vs uutils: ${f_vs_uutils}x${NC}"

            local entry="{\"name\":\"$name\",\"gnu_mean\":$gnu_mean,\"f_mean\":$f_mean,\"uutils_mean\":$uutils_mean,\"speedup\":$speedup,\"f_vs_uutils\":$f_vs_uutils,\"uutils_vs_gnu\":$uutils_vs_gnu}"
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
    else
        # 2-way comparison: GNU vs fcoreutils (original behavior)
        if hyperfine \
            --warmup "$WARMUP" \
            --runs "$RUNS" \
            --export-json "$json_file" \
            -n "GNU $TOOL_NAME" "$gnu_cmd" \
            -n "f$TOOL_NAME" "$f_cmd" 2>&1; then

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

            echo -e "  GNU: ${gnu_mean}s  |  F: ${f_mean}s  |  ${GREEN}Speedup: ${speedup}x${NC}"

            local entry="{\"name\":\"$name\",\"gnu_mean\":$gnu_mean,\"f_mean\":$f_mean,\"speedup\":$speedup}"
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
    fi

    rm -f "$json_file"
}

# Run benchmark with stdin piping
# Note: gnu_cmd/f_cmd/uutils_cmd here are the tool commands (e.g. "tr 'a-z' 'A-Z'"),
# not wrapped with cat yet. We pass the raw gnu_cmd so run_benchmark can
# detect the GNU tool binary correctly.
# Usage: run_stdin_benchmark "name" "input_file" "gnu_cmd" "f_cmd" ["uutils_cmd"]
run_stdin_benchmark() {
    local name="$1"
    local input_file="$2"
    local gnu_cmd="$3"
    local f_cmd="$4"
    local uutils_cmd="${5:-}"

    # Extract GNU binary for detection before wrapping with cat pipe
    local gnu_binary
    gnu_binary=$(echo "$gnu_cmd" | awk '{print $1}')

    local uutils_piped=""
    if [[ -n "$uutils_cmd" ]]; then
        uutils_piped="cat '$input_file' | $uutils_cmd"
    fi

    # Set env var so run_benchmark can detect the right binary
    GNU_BINARY_OVERRIDE="$gnu_binary" run_benchmark "$name" \
        "cat '$input_file' | $gnu_cmd" \
        "cat '$input_file' | $f_cmd" \
        "$uutils_piped"
}

save_benchmark_results() {
    cat > "$RESULTS_DIR/${TOOL_NAME}_benchmark.json" <<EOF
{
    "tool": "$TOOL_NAME",
    "platform": "$(uname -s)_$(uname -m)",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "warmup": $WARMUP,
    "runs": $RUNS,
    "benchmarks": $BENCH_RESULTS_JSON
}
EOF

    echo ""
    echo -e "${BLUE}Results saved to $RESULTS_DIR/${TOOL_NAME}_benchmark.json${NC}"
}
