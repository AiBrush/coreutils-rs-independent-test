#!/usr/bin/env bash
# bench_all.sh — Benchmark assembly tools against GNU coreutils AND Rust fcoreutils
#
# 3-way comparison: GNU vs Rust (fcoreutils) vs Assembly (asm)
# Uses hyperfine for accurate benchmarking with warmup and multiple runs.
#
# Usage:
#   bash tests/assembly/bench_all.sh [--asm-dir DIR] [--rust-dir DIR]
#
# Environment:
#   ASM_INSTALL_DIR   — assembly binaries directory (default: ~/.local/bin/asm)
#   RUST_INSTALL_DIR  — Rust fcoreutils binaries directory (default: ~/.local/bin)
#   RESULTS_DIR       — where to write JSON results (default: ./results)
#   TEST_DATA_DIR     — test data directory (default: /tmp/fcoreutils-test-data)

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
RESULTS_DIR="${RESULTS_DIR:-$PROJECT_ROOT/results}"
ASM_INSTALL_DIR="${ASM_INSTALL_DIR:-$HOME/.local/bin/asm}"
RUST_INSTALL_DIR="${RUST_INSTALL_DIR:-$HOME/.local/bin}"
TEST_DATA_DIR="${TEST_DATA_DIR:-/tmp/fcoreutils-test-data}"

WARMUP=${BENCH_WARMUP:-3}
RUNS=${BENCH_RUNS:-10}

# Assembly tools available for benchmarking
# Format: tool_name:binary_name
# Data-processing tools that benefit from benchmarking:
ASM_TOOLS=(
    base32:fbase32
    base64:fbase64
    basenc:fbasenc
    cat:fcat
    comm:fcomm
    cut:fcut
    echo:fecho
    expand:fexpand
    factor:ffactor
    fold:ffold
    head:fhead
    join:fjoin
    md5sum:fmd5sum
    nl:fnl
    od:fod
    paste:fpaste
    pr:fpr
    rev:frev
    seq:fseq
    shred:fshred
    shuf:fshuf
    sort:fsort
    tac:ftac
    tail:ftail
    tr:ftr
    tsort:ftsort
    unexpand:funexpand
    uniq:funiq
    wc:fwc
    yes:fyes
)
# Note: trivial tools excluded from benchmarks:
# true, false, arch, hostid, logname, tty, whoami, pwd, sync, sleep

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

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --asm-dir)   ASM_INSTALL_DIR="$2"; shift 2 ;;
        --rust-dir)  RUST_INSTALL_DIR="$2"; shift 2 ;;
        *)           echo "Unknown argument: $1"; exit 1 ;;
    esac
done

# ── Prerequisite checks ──────────────────────────────────────────────────────

check_hyperfine() {
    if ! command -v hyperfine &>/dev/null; then
        echo "hyperfine not found. Installing..."
        if command -v apt-get &>/dev/null; then
            sudo apt-get install -y hyperfine 2>/dev/null || true
        fi
        if ! command -v hyperfine &>/dev/null; then
            echo "ERROR: hyperfine is required for benchmarking"
            exit 1
        fi
    fi
}

ensure_test_data() {
    if [[ ! -d "$TEST_DATA_DIR" ]]; then
        echo "Test data not found at $TEST_DATA_DIR"
        local gen_script="$PROJECT_ROOT/tests/helpers/generate_test_data.sh"
        if [[ -f "$gen_script" ]]; then
            echo "Generating test data..."
            bash "$gen_script"
        else
            echo "WARNING: No test data generator found, creating minimal data..."
            mkdir -p "$TEST_DATA_DIR"
            dd if=/dev/urandom of="$TEST_DATA_DIR/text_1m.txt" bs=1M count=1 2>/dev/null
            dd if=/dev/urandom of="$TEST_DATA_DIR/text_10m.txt" bs=1M count=10 2>/dev/null
            # Create text-like data
            python3 -c "
import random, string
with open('$TEST_DATA_DIR/text_1m.txt', 'w') as f:
    for _ in range(20000):
        f.write(''.join(random.choices(string.ascii_letters + ' ', k=50)) + '\n')
" 2>/dev/null || true
        fi
    fi
}

mkdir -p "$RESULTS_DIR"

# ── Benchmark result tracking ─────────────────────────────────────────────────

ALL_BENCH_JSON=""

add_bench_result() {
    local json="$1"
    if [[ -z "$ALL_BENCH_JSON" ]]; then
        ALL_BENCH_JSON="$json"
    else
        ALL_BENCH_JSON="$ALL_BENCH_JSON,$json"
    fi
}

# ── 3-way benchmark runner ───────────────────────────────────────────────────
# Runs hyperfine comparing GNU, Rust fcoreutils, and Assembly for a given scenario
#
# Usage: run_3way_benchmark "tool" "scenario_name" "gnu_cmd" "rust_cmd" "asm_cmd"

run_3way_benchmark() {
    local tool="$1"
    local name="$2"
    local gnu_cmd="$3"
    local rust_cmd="$4"
    local asm_cmd="$5"

    echo -e "  ${CYAN}--- $name ---${NC}"

    local json_file
    json_file=$(mktemp /tmp/asm_bench_XXXXXX.json)

    # Determine which commands are available
    local cmds=()
    local labels=()

    # Check GNU tool
    local gnu_binary
    gnu_binary=$(echo "$gnu_cmd" | awk '{print $1}')
    if [[ "$gnu_binary" == "eval" ]]; then
        gnu_binary=$(echo "$gnu_cmd" | awk '{print $2}')
    fi
    if command -v "$gnu_binary" &>/dev/null; then
        cmds+=("$gnu_cmd")
        labels+=("GNU $tool")
    fi

    # Check Rust binary
    local rust_binary
    rust_binary=$(echo "$rust_cmd" | awk '{print $1}')
    if [[ -x "$rust_binary" ]] || command -v "$rust_binary" &>/dev/null; then
        cmds+=("$rust_cmd")
        labels+=("Rust f$tool")
    fi

    # Check Assembly binary
    local asm_binary
    asm_binary=$(echo "$asm_cmd" | awk '{print $1}')
    if [[ -x "$asm_binary" ]]; then
        cmds+=("$asm_cmd")
        labels+=("ASM f$tool")
    fi

    if [[ ${#cmds[@]} -lt 2 ]]; then
        echo -e "    ${YELLOW}SKIP: Need at least 2 of 3 binaries for comparison${NC}"
        local entry="{\"tool\":\"$tool\",\"name\":\"$name\",\"status\":\"SKIP\",\"reason\":\"insufficient binaries\"}"
        add_bench_result "$entry"
        rm -f "$json_file"
        return
    fi

    # Build hyperfine command
    local hf_args=(--warmup "$WARMUP" --runs "$RUNS" --export-json "$json_file")
    for i in "${!cmds[@]}"; do
        hf_args+=(-n "${labels[$i]}" "${cmds[$i]}")
    done

    if hyperfine "${hf_args[@]}" 2>&1; then
        # Parse results
        local result_json
        result_json=$(python3 -c "
import json, sys

d = json.load(open('$json_file'))
results = d.get('results', [])

entry = {
    'tool': '$tool',
    'name': '$name',
    'status': 'benchmarked',
}

for r in results:
    label = r.get('command', '')
    mean = r.get('mean', 0)
    stddev = r.get('stddev', 0)

    if 'GNU' in label:
        entry['gnu_mean'] = round(mean, 6)
        entry['gnu_stddev'] = round(stddev, 6)
    elif 'Rust' in label:
        entry['rust_mean'] = round(mean, 6)
        entry['rust_stddev'] = round(stddev, 6)
    elif 'ASM' in label:
        entry['asm_mean'] = round(mean, 6)
        entry['asm_stddev'] = round(stddev, 6)

# Compute speedups
gnu_mean = entry.get('gnu_mean')
rust_mean = entry.get('rust_mean')
asm_mean = entry.get('asm_mean')

if gnu_mean and rust_mean and rust_mean > 0:
    entry['rust_vs_gnu'] = round(gnu_mean / rust_mean, 1)
if gnu_mean and asm_mean and asm_mean > 0:
    entry['asm_vs_gnu'] = round(gnu_mean / asm_mean, 1)
if rust_mean and asm_mean and asm_mean > 0:
    entry['asm_vs_rust'] = round(rust_mean / asm_mean, 1)

print(json.dumps(entry))
" 2>/dev/null)

        if [[ -n "$result_json" ]]; then
            add_bench_result "$result_json"

            # Print summary
            local asm_vs_gnu rust_vs_gnu asm_vs_rust
            asm_vs_gnu=$(echo "$result_json" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('asm_vs_gnu','N/A'))" 2>/dev/null || echo "N/A")
            rust_vs_gnu=$(echo "$result_json" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('rust_vs_gnu','N/A'))" 2>/dev/null || echo "N/A")
            asm_vs_rust=$(echo "$result_json" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('asm_vs_rust','N/A'))" 2>/dev/null || echo "N/A")

            echo -e "    ${GREEN}ASM vs GNU: ${asm_vs_gnu}x  |  Rust vs GNU: ${rust_vs_gnu}x  |  ASM vs Rust: ${asm_vs_rust}x${NC}"
        else
            local entry="{\"tool\":\"$tool\",\"name\":\"$name\",\"status\":\"error\",\"error\":\"parse failed\"}"
            add_bench_result "$entry"
        fi
    else
        echo -e "    ${RED}Benchmark failed${NC}"
        local entry="{\"tool\":\"$tool\",\"name\":\"$name\",\"status\":\"error\",\"error\":\"hyperfine failed\"}"
        add_bench_result "$entry"
    fi

    rm -f "$json_file"
}

# ── Per-tool benchmark definitions ───────────────────────────────────────────

bench_cat() {
    local gnu="cat"
    local rust="$RUST_INSTALL_DIR/fcat"
    local asm="$ASM_INSTALL_DIR/fcat"

    run_3way_benchmark "cat" "passthrough 1MB" \
        "$gnu '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
        "$rust '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
        "$asm '$TEST_DATA_DIR/text_1m.txt' > /dev/null"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "cat" "passthrough 10MB" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"

        run_3way_benchmark "cat" "-n 10MB" \
            "$gnu -n '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust -n '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm -n '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_seq() {
    local gnu="seq"
    local rust="$RUST_INSTALL_DIR/fseq"
    local asm="$ASM_INSTALL_DIR/fseq"

    run_3way_benchmark "seq" "1 to 1M" \
        "$gnu 1000000 > /dev/null" \
        "$rust 1000000 > /dev/null" \
        "$asm 1000000 > /dev/null"

    run_3way_benchmark "seq" "1 to 10M" \
        "$gnu 10000000 > /dev/null" \
        "$rust 10000000 > /dev/null" \
        "$asm 10000000 > /dev/null"
}

bench_nl() {
    local gnu="nl"
    local rust="$RUST_INSTALL_DIR/fnl"
    local asm="$ASM_INSTALL_DIR/fnl"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "nl" "10MB text" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi

    if [[ -f "$TEST_DATA_DIR/text_1m.txt" ]]; then
        run_3way_benchmark "nl" "1MB text" \
            "$gnu '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_1m.txt' > /dev/null"
    fi
}

bench_expand() {
    local gnu="expand"
    local rust="$RUST_INSTALL_DIR/fexpand"
    local asm="$ASM_INSTALL_DIR/fexpand"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "expand" "10MB text" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_unexpand() {
    local gnu="unexpand"
    local rust="$RUST_INSTALL_DIR/funexpand"
    local asm="$ASM_INSTALL_DIR/funexpand"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "unexpand" "10MB text" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_fold() {
    local gnu="fold"
    local rust="$RUST_INSTALL_DIR/ffold"
    local asm="$ASM_INSTALL_DIR/ffold"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "fold" "10MB text (default width)" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"

        run_3way_benchmark "fold" "10MB text -w 40" \
            "$gnu -w 40 '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust -w 40 '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm -w 40 '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_uniq() {
    local gnu="uniq"
    local rust="$RUST_INSTALL_DIR/funiq"
    local asm="$ASM_INSTALL_DIR/funiq"

    # Create sorted data for uniq (it requires sorted input)
    local sorted_file="/tmp/asm_bench_sorted.txt"
    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        sort "$TEST_DATA_DIR/text_10m.txt" > "$sorted_file" 2>/dev/null

        run_3way_benchmark "uniq" "10MB sorted text" \
            "$gnu '$sorted_file' > /dev/null" \
            "$rust '$sorted_file' > /dev/null" \
            "$asm '$sorted_file' > /dev/null"

        run_3way_benchmark "uniq" "10MB sorted -c" \
            "$gnu -c '$sorted_file' > /dev/null" \
            "$rust -c '$sorted_file' > /dev/null" \
            "$asm -c '$sorted_file' > /dev/null"

        rm -f "$sorted_file"
    fi
}

bench_od() {
    local gnu="od"
    local rust="$RUST_INSTALL_DIR/fod"
    local asm="$ASM_INSTALL_DIR/fod"

    if [[ -f "$TEST_DATA_DIR/text_1m.txt" ]]; then
        run_3way_benchmark "od" "1MB text" \
            "$gnu '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_1m.txt' > /dev/null"
    fi

    # Create binary data for od
    local bin_file="/tmp/asm_bench_binary.bin"
    dd if=/dev/urandom of="$bin_file" bs=1M count=1 2>/dev/null
    run_3way_benchmark "od" "1MB binary" \
        "$gnu '$bin_file' > /dev/null" \
        "$rust '$bin_file' > /dev/null" \
        "$asm '$bin_file' > /dev/null"
    rm -f "$bin_file"
}

bench_sort() {
    local gnu="sort"
    local rust="$RUST_INSTALL_DIR/fsort"
    local asm="$ASM_INSTALL_DIR/fsort"

    if [[ -f "$TEST_DATA_DIR/text_1m.txt" ]]; then
        run_3way_benchmark "sort" "1MB text" \
            "$gnu '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_1m.txt' > /dev/null"
    fi

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "sort" "10MB text" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_head() {
    local gnu="head"
    local rust="$RUST_INSTALL_DIR/fhead"
    local asm="$ASM_INSTALL_DIR/fhead"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "head" "first 1000 lines 10MB" \
            "$gnu -n 1000 '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust -n 1000 '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm -n 1000 '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_tail() {
    local gnu="tail"
    local rust="$RUST_INSTALL_DIR/ftail"
    local asm="$ASM_INSTALL_DIR/ftail"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "tail" "last 1000 lines 10MB" \
            "$gnu -n 1000 '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust -n 1000 '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm -n 1000 '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_tac() {
    local gnu="tac"
    local rust="$RUST_INSTALL_DIR/ftac"
    local asm="$ASM_INSTALL_DIR/ftac"

    if [[ -f "$TEST_DATA_DIR/text_1m.txt" ]]; then
        run_3way_benchmark "tac" "reverse 1MB" \
            "$gnu '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_1m.txt' > /dev/null"
    fi
}

bench_rev() {
    local gnu="rev"
    local rust="$RUST_INSTALL_DIR/frev"
    local asm="$ASM_INSTALL_DIR/frev"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "rev" "10MB text" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_wc() {
    local gnu="wc"
    local rust="$RUST_INSTALL_DIR/fwc"
    local asm="$ASM_INSTALL_DIR/fwc"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "wc" "10MB text" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"

        run_3way_benchmark "wc" "10MB -l only" \
            "$gnu -l '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust -l '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm -l '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_cut() {
    local gnu="cut"
    local rust="$RUST_INSTALL_DIR/fcut"
    local asm="$ASM_INSTALL_DIR/fcut"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "cut" "10MB -c1-20" \
            "$gnu -c1-20 '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust -c1-20 '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm -c1-20 '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_tr() {
    local gnu="tr"
    local rust="$RUST_INSTALL_DIR/ftr"
    local asm="$ASM_INSTALL_DIR/ftr"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "tr" "10MB lowercase" \
            "$gnu a-z A-Z < '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust a-z A-Z < '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm a-z A-Z < '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_base64() {
    local gnu="base64"
    local rust="$RUST_INSTALL_DIR/fbase64"
    local asm="$ASM_INSTALL_DIR/fbase64"

    if [[ -f "$TEST_DATA_DIR/text_1m.txt" ]]; then
        run_3way_benchmark "base64" "encode 1MB" \
            "$gnu '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_1m.txt' > /dev/null"
    fi
}

bench_md5sum() {
    local gnu="md5sum"
    local rust="$RUST_INSTALL_DIR/fmd5sum"
    local asm="$ASM_INSTALL_DIR/fmd5sum"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "md5sum" "10MB file" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_echo() {
    local gnu="echo"
    local rust="$RUST_INSTALL_DIR/fecho"
    local asm="$ASM_INSTALL_DIR/fecho"

    # echo is fast — benchmark with many invocations
    run_3way_benchmark "echo" "short string" \
        "$gnu 'hello world' > /dev/null" \
        "$rust 'hello world' > /dev/null" \
        "$asm 'hello world' > /dev/null"
}

bench_yes() {
    local gnu="yes"
    local rust="$RUST_INSTALL_DIR/fyes"
    local asm="$ASM_INSTALL_DIR/fyes"

    run_3way_benchmark "yes" "1M lines" \
        "$gnu | head -n 1000000 > /dev/null" \
        "$rust | head -n 1000000 > /dev/null" \
        "$asm | head -n 1000000 > /dev/null"
}

bench_base32() {
    local gnu="base32"
    local rust="$RUST_INSTALL_DIR/fbase32"
    local asm="$ASM_INSTALL_DIR/fbase32"

    if [[ -f "$TEST_DATA_DIR/text_1m.txt" ]]; then
        run_3way_benchmark "base32" "encode 1MB" \
            "$gnu '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_1m.txt' > /dev/null"
    fi
}

bench_basenc() {
    local gnu="basenc"
    local rust="$RUST_INSTALL_DIR/fbasenc"
    local asm="$ASM_INSTALL_DIR/fbasenc"

    if [[ -f "$TEST_DATA_DIR/text_1m.txt" ]]; then
        run_3way_benchmark "basenc" "base64 encode 1MB" \
            "$gnu --base64 '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$rust --base64 '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$asm --base64 '$TEST_DATA_DIR/text_1m.txt' > /dev/null"

        run_3way_benchmark "basenc" "base32 encode 1MB" \
            "$gnu --base32 '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$rust --base32 '$TEST_DATA_DIR/text_1m.txt' > /dev/null" \
            "$asm --base32 '$TEST_DATA_DIR/text_1m.txt' > /dev/null"
    fi
}

bench_comm() {
    local gnu="comm"
    local rust="$RUST_INSTALL_DIR/fcomm"
    local asm="$ASM_INSTALL_DIR/fcomm"

    if [[ -f "$TEST_DATA_DIR/comm_bench_file1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/comm_bench_file2_10m.txt" ]]; then
        run_3way_benchmark "comm" "10MB sorted files" \
            "$gnu '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' > /dev/null"

        run_3way_benchmark "comm" "10MB -12 (common only)" \
            "$gnu -12 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' > /dev/null" \
            "$rust -12 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' > /dev/null" \
            "$asm -12 '$TEST_DATA_DIR/comm_bench_file1_10m.txt' '$TEST_DATA_DIR/comm_bench_file2_10m.txt' > /dev/null"
    fi
}

bench_factor() {
    local gnu="factor"
    local rust="$RUST_INSTALL_DIR/ffactor"
    local asm="$ASM_INSTALL_DIR/ffactor"

    run_3way_benchmark "factor" "range 1-100000" \
        "seq 1 100000 | $gnu > /dev/null" \
        "seq 1 100000 | $rust > /dev/null" \
        "seq 1 100000 | $asm > /dev/null"

    run_3way_benchmark "factor" "large primes" \
        "$gnu 999999999999999989 1000000000000000003 999999999999999877 > /dev/null" \
        "$rust 999999999999999989 1000000000000000003 999999999999999877 > /dev/null" \
        "$asm 999999999999999989 1000000000000000003 999999999999999877 > /dev/null"
}

bench_join() {
    local gnu="join"
    local rust="$RUST_INSTALL_DIR/fjoin"
    local asm="$ASM_INSTALL_DIR/fjoin"

    if [[ -f "$TEST_DATA_DIR/join_bench_file1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/join_bench_file2_10m.txt" ]]; then
        run_3way_benchmark "join" "10MB keyed files" \
            "$gnu '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/join_bench_file1_10m.txt' '$TEST_DATA_DIR/join_bench_file2_10m.txt' > /dev/null"
    fi
}

bench_paste() {
    local gnu="paste"
    local rust="$RUST_INSTALL_DIR/fpaste"
    local asm="$ASM_INSTALL_DIR/fpaste"

    if [[ -f "$TEST_DATA_DIR/paste_bench_col1_10m.txt" ]] && [[ -f "$TEST_DATA_DIR/paste_bench_col2_10m.txt" ]]; then
        run_3way_benchmark "paste" "two 10MB columns" \
            "$gnu '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/paste_bench_col1_10m.txt' '$TEST_DATA_DIR/paste_bench_col2_10m.txt' > /dev/null"

        run_3way_benchmark "paste" "-s serial 10MB" \
            "$gnu -s '$TEST_DATA_DIR/paste_bench_col1_10m.txt' > /dev/null" \
            "$rust -s '$TEST_DATA_DIR/paste_bench_col1_10m.txt' > /dev/null" \
            "$asm -s '$TEST_DATA_DIR/paste_bench_col1_10m.txt' > /dev/null"
    fi
}

bench_pr() {
    local gnu="pr"
    local rust="$RUST_INSTALL_DIR/fpr"
    local asm="$ASM_INSTALL_DIR/fpr"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "pr" "10MB default format" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"

        run_3way_benchmark "pr" "10MB 2 columns" \
            "$gnu -2 '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust -2 '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm -2 '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi
}

bench_shred() {
    local gnu="shred"
    local rust="$RUST_INSTALL_DIR/fshred"
    local asm="$ASM_INSTALL_DIR/fshred"

    # Create a temporary file for shredding (shred is destructive)
    local shred_tmp="/tmp/asm_bench_shred_$$.tmp"

    # 10MB single pass
    dd if=/dev/zero of="$shred_tmp" bs=1M count=10 2>/dev/null
    run_3way_benchmark "shred" "10MB -n1 single pass" \
        "cp '$shred_tmp' '${shred_tmp}.gnu' && $gnu -n 1 '${shred_tmp}.gnu'" \
        "cp '$shred_tmp' '${shred_tmp}.rust' && $rust -n 1 '${shred_tmp}.rust'" \
        "cp '$shred_tmp' '${shred_tmp}.asm' && $asm -n 1 '${shred_tmp}.asm'"

    rm -f "$shred_tmp" "${shred_tmp}.gnu" "${shred_tmp}.rust" "${shred_tmp}.asm"
}

bench_shuf() {
    local gnu="shuf"
    local rust="$RUST_INSTALL_DIR/fshuf"
    local asm="$ASM_INSTALL_DIR/fshuf"

    if [[ -f "$TEST_DATA_DIR/text_10m.txt" ]]; then
        run_3way_benchmark "shuf" "shuffle 10MB" \
            "$gnu '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$rust '$TEST_DATA_DIR/text_10m.txt' > /dev/null" \
            "$asm '$TEST_DATA_DIR/text_10m.txt' > /dev/null"
    fi

    run_3way_benchmark "shuf" "-i range 1-1000000" \
        "$gnu -i 1-1000000 > /dev/null" \
        "$rust -i 1-1000000 > /dev/null" \
        "$asm -i 1-1000000 > /dev/null"
}

bench_tsort() {
    local gnu="tsort"
    local rust="$RUST_INSTALL_DIR/ftsort"
    local asm="$ASM_INSTALL_DIR/ftsort"

    # Generate a large DAG for benchmarking
    local tsort_input="/tmp/asm_bench_tsort_$$.txt"
    python3 -c "
for i in range(100000):
    print(f'node{i} node{i+1}')
" > "$tsort_input" 2>/dev/null

    if [[ -f "$tsort_input" ]]; then
        run_3way_benchmark "tsort" "100K-edge chain" \
            "$gnu '$tsort_input' > /dev/null" \
            "$rust '$tsort_input' > /dev/null" \
            "$asm '$tsort_input' > /dev/null"
        rm -f "$tsort_input"
    fi
}

# ── Main ──────────────────────────────────────────────────────────────────────

main() {
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Assembly 3-Way Benchmarks: GNU vs Rust vs Assembly${NC}"
    echo -e "${BLUE}  Warmup: $WARMUP  Runs: $RUNS${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo ""
    echo "  ASM binaries:  $ASM_INSTALL_DIR"
    echo "  Rust binaries: $RUST_INSTALL_DIR"
    echo "  Test data:     $TEST_DATA_DIR"
    echo ""

    check_hyperfine
    ensure_test_data

    for entry in "${ASM_TOOLS[@]}"; do
        local tool="${entry%%:*}"
        local binary="${entry##*:}"

        echo ""
        echo -e "${BLUE}════════════════════════════════════════════${NC}"
        echo -e "${BLUE}  Benchmarking: $tool${NC}"
        echo -e "${BLUE}════════════════════════════════════════════${NC}"

        # Check if the asm binary exists
        if [[ ! -x "$ASM_INSTALL_DIR/$binary" ]]; then
            echo -e "  ${YELLOW}SKIP: $binary not found in $ASM_INSTALL_DIR${NC}"
            add_bench_result "{\"tool\":\"$tool\",\"status\":\"SKIP\",\"reason\":\"asm binary not found\"}"
            continue
        fi

        # Call the tool-specific benchmark function
        if declare -f "bench_$tool" &>/dev/null; then
            "bench_$tool"
        else
            echo -e "  ${YELLOW}No benchmark defined for $tool${NC}"
            add_bench_result "{\"tool\":\"$tool\",\"status\":\"SKIP\",\"reason\":\"no benchmark defined\"}"
        fi
    done

    # ── Measure binary sizes ─────────────────────────────────────────────────

    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Binary Size Comparison${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"

    local sizes_json=""
    printf "  %-10s %10s %10s %10s\n" "Tool" "GNU" "Rust" "ASM"
    printf "  %-10s %10s %10s %10s\n" "────" "───" "────" "───"

    for entry_item in "${ASM_TOOLS[@]}"; do
        local tool="${entry_item%%:*}"
        local binary="${entry_item##*:}"

        local gnu_size=0 rust_size=0 asm_size=0
        local gnu_path
        gnu_path=$(which "$tool" 2>/dev/null || echo "")

        [[ -n "$gnu_path" ]] && gnu_size=$(stat -c%s "$gnu_path" 2>/dev/null || echo 0)
        [[ -f "$RUST_INSTALL_DIR/$binary" ]] && rust_size=$(stat -c%s "$RUST_INSTALL_DIR/$binary" 2>/dev/null || echo 0)
        [[ -f "$ASM_INSTALL_DIR/$binary" ]] && asm_size=$(stat -c%s "$ASM_INSTALL_DIR/$binary" 2>/dev/null || echo 0)

        printf "  %-10s %10s %10s %10s\n" "$tool" "${gnu_size}B" "${rust_size}B" "${asm_size}B"

        local size_entry="{\"tool\":\"$tool\",\"gnu_bytes\":$gnu_size,\"rust_bytes\":$rust_size,\"asm_bytes\":$asm_size}"
        if [[ -z "$sizes_json" ]]; then
            sizes_json="$size_entry"
        else
            sizes_json="$sizes_json,$size_entry"
        fi
    done

    # ── Write JSON results ───────────────────────────────────────────────────

    cat > "$RESULTS_DIR/asm_benchmark_results.json" <<EOF
{
    "type": "assembly_benchmark",
    "platform": "$(uname -s)_$(uname -m)",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "warmup": $WARMUP,
    "runs": $RUNS,
    "benchmarks": [$ALL_BENCH_JSON],
    "sizes": [$sizes_json]
}
EOF

    echo ""
    echo "Results written to $RESULTS_DIR/asm_benchmark_results.json"
}

main
