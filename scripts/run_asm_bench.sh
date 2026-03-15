#!/usr/bin/env bash
# run_asm_bench.sh — 3-way benchmark runner for GNU / Rust / Assembly coreutils
#
# Expected environment variables:
#   TOOL      — tool name (e.g. "wc", "sort", "cat")
#   GNU_BIN   — GNU binary name (same as TOOL)
#   RUST_BIN  — path to Rust fcoreutils binary
#   ASM_BIN   — path to assembly binary
#   DATA_DIR  — path to test data directory
#
# Outputs BENCH_RESULTS (JSON array) and writes results/asm_bench_${TOOL}.json

set -euo pipefail

: "${TOOL:?TOOL must be set}"
: "${GNU_BIN:=$TOOL}"
: "${RUST_BIN:=$HOME/.local/bin/f${TOOL}}"
: "${ASM_BIN:=$HOME/.local/bin/asm/f${TOOL}}"
: "${DATA_DIR:=/tmp/fcoreutils-test-data}"

mkdir -p results

# Check binaries
echo "GNU:  $(which "$GNU_BIN" 2>/dev/null || echo 'not found')"
echo "Rust: $RUST_BIN ($(test -x "$RUST_BIN" && echo 'OK' || echo 'not found'))"
echo "ASM:  $ASM_BIN ($(test -x "$ASM_BIN" && echo 'OK' || echo 'not found'))"

if [[ ! -x "$ASM_BIN" ]]; then
  echo "Assembly binary not found, skipping benchmark"
  echo "{\"tool\":\"$TOOL\",\"status\":\"SKIP\",\"reason\":\"asm binary not found\"}" \
    > "results/asm_bench_${TOOL}.json"
  exit 0
fi

BENCH_RESULTS="[]"
add_result() {
  local entry="$1"
  if [[ "$BENCH_RESULTS" == "[]" ]]; then
    BENCH_RESULTS="[$entry]"
  else
    BENCH_RESULTS="${BENCH_RESULTS%]},${entry}]"
  fi
}

run_bench() {
  local name="$1"
  local gnu_cmd="$2"
  local rust_cmd="$3"
  local asm_cmd="$4"

  echo ""
  echo "--- $name ---"

  local json_file
  json_file=$(mktemp /tmp/asm_bench_XXXXXX.json)

  local hf_args=(--warmup 3 --runs 10 --export-json "$json_file")

  # Add available commands
  if command -v "$GNU_BIN" &>/dev/null; then
    hf_args+=(-n "GNU $TOOL" "$gnu_cmd")
  fi
  if [[ -x "$RUST_BIN" ]]; then
    hf_args+=(-n "Rust f$TOOL" "$rust_cmd")
  fi
  if [[ -x "$ASM_BIN" ]]; then
    hf_args+=(-n "ASM f$TOOL" "$asm_cmd")
  fi

  if hyperfine "${hf_args[@]}" 2>&1; then
    local result
    result=$(python3 -c "
import json
d = json.load(open('$json_file'))
entry = {'name': '$name', 'status': 'benchmarked'}
for r in d.get('results', []):
    cmd = r.get('command', '')
    mean = round(r.get('mean', 0), 6)
    if 'GNU' in cmd: entry['gnu_mean'] = mean
    elif 'Rust' in cmd: entry['rust_mean'] = mean
    elif 'ASM' in cmd: entry['asm_mean'] = mean
gnu = entry.get('gnu_mean')
rust = entry.get('rust_mean')
asm = entry.get('asm_mean')
if gnu and rust and rust > 0: entry['rust_vs_gnu'] = round(gnu/rust, 1)
if gnu and asm and asm > 0: entry['asm_vs_gnu'] = round(gnu/asm, 1)
if rust and asm and asm > 0: entry['asm_vs_rust'] = round(rust/asm, 1)
print(json.dumps(entry))
" 2>/dev/null || echo "")

    if [[ -n "$result" ]]; then
      add_result "$result"
    fi
  fi

  rm -f "$json_file"
}

# ─────────────────────────────────────────────────────────────────────────────
# Tool-specific benchmarks
# ─────────────────────────────────────────────────────────────────────────────
case "$TOOL" in
  arch)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  b2sum)
    run_bench "hash 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt'"
    ;;
  base32)
    run_bench "encode 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  base64)
    run_bench "encode 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  basename)
    run_bench "invoke" \
      "$GNU_BIN /usr/local/bin/test.txt .txt" \
      "$RUST_BIN /usr/local/bin/test.txt .txt" \
      "$ASM_BIN /usr/local/bin/test.txt .txt"
    ;;
  basenc)
    run_bench "encode 1MB --base64" \
      "$GNU_BIN --base64 '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN --base64 '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN --base64 '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  cat)
    run_bench "passthrough 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "passthrough 10MB" \
        "$GNU_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN '$DATA_DIR/text_10m.txt' > /dev/null"
      run_bench "-n 10MB" \
        "$GNU_BIN -n '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN -n '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN -n '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  chcon)
    run_bench "invoke" \
      "$GNU_BIN --help > /dev/null 2>&1 || true" \
      "$RUST_BIN --help > /dev/null 2>&1 || true" \
      "$ASM_BIN --help > /dev/null 2>&1 || true"
    ;;
  chgrp)
    CHGRP_FILE=$(mktemp /tmp/asm_bench_chgrp_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN $(id -un) '$CHGRP_FILE' 2>/dev/null || true" \
      "$RUST_BIN $(id -un) '$CHGRP_FILE' 2>/dev/null || true" \
      "$ASM_BIN $(id -un) '$CHGRP_FILE' 2>/dev/null || true"
    rm -f "$CHGRP_FILE"
    ;;
  chmod)
    CHMOD_FILE=$(mktemp /tmp/asm_bench_chmod_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN 644 '$CHMOD_FILE'" \
      "$RUST_BIN 644 '$CHMOD_FILE'" \
      "$ASM_BIN 644 '$CHMOD_FILE'"
    rm -f "$CHMOD_FILE"
    ;;
  chown)
    CHOWN_FILE=$(mktemp /tmp/asm_bench_chown_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN $(id -un) '$CHOWN_FILE' 2>/dev/null || true" \
      "$RUST_BIN $(id -un) '$CHOWN_FILE' 2>/dev/null || true" \
      "$ASM_BIN $(id -un) '$CHOWN_FILE' 2>/dev/null || true"
    rm -f "$CHOWN_FILE"
    ;;
  chroot)
    run_bench "invoke" \
      "$GNU_BIN --help > /dev/null 2>&1 || true" \
      "$RUST_BIN --help > /dev/null 2>&1 || true" \
      "$ASM_BIN --help > /dev/null 2>&1 || true"
    ;;
  cksum)
    run_bench "hash 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt'"
    ;;
  comm)
    sort "$DATA_DIR/text_1m.txt" > /tmp/asm_bench_comm_sorted.txt
    run_bench "compare sorted 1MB" \
      "$GNU_BIN /tmp/asm_bench_comm_sorted.txt /tmp/asm_bench_comm_sorted.txt > /dev/null" \
      "$RUST_BIN /tmp/asm_bench_comm_sorted.txt /tmp/asm_bench_comm_sorted.txt > /dev/null" \
      "$ASM_BIN /tmp/asm_bench_comm_sorted.txt /tmp/asm_bench_comm_sorted.txt > /dev/null"
    rm -f /tmp/asm_bench_comm_sorted.txt
    ;;
  cp)
    CP_DEST=$(mktemp /tmp/asm_bench_cp_XXXXXX)
    run_bench "copy 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' '$CP_DEST'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' '$CP_DEST'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' '$CP_DEST'"
    rm -f "$CP_DEST"
    ;;
  csplit)
    CSPLIT_DIR=$(mktemp -d /tmp/asm_bench_csplit_XXXXXX)
    pushd "$CSPLIT_DIR" >/dev/null
    run_bench "split by pattern 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' '/^[[:space:]]*$/' '{*}' > /dev/null 2>&1; rm -f xx*" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' '/^[[:space:]]*$/' '{*}' > /dev/null 2>&1; rm -f xx*" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' '/^[[:space:]]*$/' '{*}' > /dev/null 2>&1; rm -f xx*"
    popd >/dev/null
    rm -rf "$CSPLIT_DIR"
    ;;
  cut)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "10MB -c1-20" \
        "$GNU_BIN -c1-20 '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN -c1-20 '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN -c1-20 '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  date)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  dd)
    run_bench "copy 1MB" \
      "$GNU_BIN if='$DATA_DIR/text_1m.txt' of=/dev/null bs=64k 2>/dev/null" \
      "$RUST_BIN if='$DATA_DIR/text_1m.txt' of=/dev/null bs=64k 2>/dev/null" \
      "$ASM_BIN if='$DATA_DIR/text_1m.txt' of=/dev/null bs=64k 2>/dev/null"
    ;;
  df)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  dir)
    run_bench "list data dir" \
      "$GNU_BIN '$DATA_DIR' > /dev/null" \
      "$RUST_BIN '$DATA_DIR' > /dev/null" \
      "$ASM_BIN '$DATA_DIR' > /dev/null"
    ;;
  dircolors)
    run_bench "invoke" \
      "$GNU_BIN -b > /dev/null" \
      "$RUST_BIN -b > /dev/null" \
      "$ASM_BIN -b > /dev/null"
    ;;
  dirname)
    run_bench "invoke" \
      "$GNU_BIN /usr/local/bin/test.txt" \
      "$RUST_BIN /usr/local/bin/test.txt" \
      "$ASM_BIN /usr/local/bin/test.txt"
    ;;
  du)
    run_bench "summarize test data" \
      "$GNU_BIN -s '$DATA_DIR' > /dev/null" \
      "$RUST_BIN -s '$DATA_DIR' > /dev/null" \
      "$ASM_BIN -s '$DATA_DIR' > /dev/null"
    ;;
  echo)
    run_bench "short string" \
      "$GNU_BIN 'hello world' > /dev/null" \
      "$RUST_BIN 'hello world' > /dev/null" \
      "$ASM_BIN 'hello world' > /dev/null"
    ;;
  env)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  expand)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "10MB text" \
        "$GNU_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  expr)
    run_bench "arithmetic" \
      "$GNU_BIN 12345 + 67890" \
      "$RUST_BIN 12345 + 67890" \
      "$ASM_BIN 12345 + 67890"
    ;;
  factor)
    seq 1 100000 > /tmp/asm_bench_factor_input.txt
    run_bench "factor 100K numbers" \
      "$GNU_BIN < /tmp/asm_bench_factor_input.txt > /dev/null" \
      "$RUST_BIN < /tmp/asm_bench_factor_input.txt > /dev/null" \
      "$ASM_BIN < /tmp/asm_bench_factor_input.txt > /dev/null"
    rm -f /tmp/asm_bench_factor_input.txt
    ;;
  "false")
    run_bench "invoke" \
      "$GNU_BIN || true" \
      "$RUST_BIN || true" \
      "$ASM_BIN || true"
    ;;
  fmt)
    run_bench "format 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  fold)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "10MB default width" \
        "$GNU_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN '$DATA_DIR/text_10m.txt' > /dev/null"
      run_bench "10MB -w 40" \
        "$GNU_BIN -w 40 '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN -w 40 '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN -w 40 '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  groups)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  head)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "first 1000 lines 10MB" \
        "$GNU_BIN -n 1000 '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN -n 1000 '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN -n 1000 '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  hostid)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  id)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  install)
    INST_BASE=$(mktemp -d /tmp/asm_bench_install_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' '$INST_BASE/gnu_f'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' '$INST_BASE/rust_f'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' '$INST_BASE/asm_f'"
    rm -rf "$INST_BASE"
    ;;
  join)
    sort "$DATA_DIR/text_1m.txt" > /tmp/asm_bench_join_a.txt
    cp /tmp/asm_bench_join_a.txt /tmp/asm_bench_join_b.txt
    run_bench "join sorted 1MB" \
      "$GNU_BIN /tmp/asm_bench_join_a.txt /tmp/asm_bench_join_b.txt > /dev/null" \
      "$RUST_BIN /tmp/asm_bench_join_a.txt /tmp/asm_bench_join_b.txt > /dev/null" \
      "$ASM_BIN /tmp/asm_bench_join_a.txt /tmp/asm_bench_join_b.txt > /dev/null"
    rm -f /tmp/asm_bench_join_a.txt /tmp/asm_bench_join_b.txt
    ;;
  kill)
    run_bench "invoke" \
      "$GNU_BIN -l > /dev/null" \
      "$RUST_BIN -l > /dev/null" \
      "$ASM_BIN -l > /dev/null"
    ;;
  link)
    LINK_SRC=$(mktemp /tmp/asm_bench_link_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN '$LINK_SRC' '${LINK_SRC}_gnu'; rm -f '${LINK_SRC}_gnu'" \
      "$RUST_BIN '$LINK_SRC' '${LINK_SRC}_rust'; rm -f '${LINK_SRC}_rust'" \
      "$ASM_BIN '$LINK_SRC' '${LINK_SRC}_asm'; rm -f '${LINK_SRC}_asm'"
    rm -f "$LINK_SRC"
    ;;
  ln)
    LN_SRC=$(mktemp /tmp/asm_bench_ln_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN -sf '$LN_SRC' '${LN_SRC}_gnu'" \
      "$RUST_BIN -sf '$LN_SRC' '${LN_SRC}_rust'" \
      "$ASM_BIN -sf '$LN_SRC' '${LN_SRC}_asm'"
    rm -f "$LN_SRC" "${LN_SRC}_gnu" "${LN_SRC}_rust" "${LN_SRC}_asm"
    ;;
  logname)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  ls)
    run_bench "list data dir" \
      "$GNU_BIN -la '$DATA_DIR' > /dev/null" \
      "$RUST_BIN -la '$DATA_DIR' > /dev/null" \
      "$ASM_BIN -la '$DATA_DIR' > /dev/null"
    ;;
  md5sum)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "10MB file" \
        "$GNU_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  mkdir)
    MKDIR_BASE=$(mktemp -d /tmp/asm_bench_mkdir_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN '$MKDIR_BASE/gnu_d' && rmdir '$MKDIR_BASE/gnu_d'" \
      "$RUST_BIN '$MKDIR_BASE/rust_d' && rmdir '$MKDIR_BASE/rust_d'" \
      "$ASM_BIN '$MKDIR_BASE/asm_d' && rmdir '$MKDIR_BASE/asm_d'"
    rm -rf "$MKDIR_BASE"
    ;;
  mkfifo)
    MKFIFO_BASE=$(mktemp -d /tmp/asm_bench_mkfifo_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN '$MKFIFO_BASE/gnu_f' && rm -f '$MKFIFO_BASE/gnu_f'" \
      "$RUST_BIN '$MKFIFO_BASE/rust_f' && rm -f '$MKFIFO_BASE/rust_f'" \
      "$ASM_BIN '$MKFIFO_BASE/asm_f' && rm -f '$MKFIFO_BASE/asm_f'"
    rm -rf "$MKFIFO_BASE"
    ;;
  mknod)
    MKNOD_BASE=$(mktemp -d /tmp/asm_bench_mknod_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN '$MKNOD_BASE/gnu_p' p && rm -f '$MKNOD_BASE/gnu_p'" \
      "$RUST_BIN '$MKNOD_BASE/rust_p' p && rm -f '$MKNOD_BASE/rust_p'" \
      "$ASM_BIN '$MKNOD_BASE/asm_p' p && rm -f '$MKNOD_BASE/asm_p'"
    rm -rf "$MKNOD_BASE"
    ;;
  mktemp)
    run_bench "invoke" \
      "f=$($GNU_BIN) && rm -f \$f" \
      "f=$($RUST_BIN) && rm -f \$f" \
      "f=$($ASM_BIN) && rm -f \$f"
    ;;
  mv)
    MV_BASE=$(mktemp -d /tmp/asm_bench_mv_XXXXXX)
    run_bench "invoke" \
      "touch '$MV_BASE/s'; $GNU_BIN '$MV_BASE/s' '$MV_BASE/d'" \
      "touch '$MV_BASE/s'; $RUST_BIN '$MV_BASE/s' '$MV_BASE/d'" \
      "touch '$MV_BASE/s'; $ASM_BIN '$MV_BASE/s' '$MV_BASE/d'"
    rm -rf "$MV_BASE"
    ;;
  nice)
    run_bench "invoke" \
      "$GNU_BIN true" \
      "$RUST_BIN true" \
      "$ASM_BIN true"
    ;;
  nl)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "10MB text" \
        "$GNU_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  nohup)
    run_bench "invoke" \
      "$GNU_BIN true > /dev/null 2>&1" \
      "$RUST_BIN true > /dev/null 2>&1" \
      "$ASM_BIN true > /dev/null 2>&1"
    ;;
  nproc)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  numfmt)
    seq 1 100000 > /tmp/asm_bench_numfmt_input.txt
    run_bench "format 100K numbers" \
      "$GNU_BIN --to=iec < /tmp/asm_bench_numfmt_input.txt > /dev/null" \
      "$RUST_BIN --to=iec < /tmp/asm_bench_numfmt_input.txt > /dev/null" \
      "$ASM_BIN --to=iec < /tmp/asm_bench_numfmt_input.txt > /dev/null"
    rm -f /tmp/asm_bench_numfmt_input.txt
    ;;
  od)
    run_bench "1MB text" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  paste)
    run_bench "merge two 1MB files" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  pathchk)
    run_bench "invoke" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt'"
    ;;
  pinky)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null 2>&1 || true" \
      "$RUST_BIN > /dev/null 2>&1 || true" \
      "$ASM_BIN > /dev/null 2>&1 || true"
    ;;
  pr)
    run_bench "format 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  printenv)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  printf)
    run_bench "format string" \
      "$GNU_BIN '%s %d %x\n' hello 42 255" \
      "$RUST_BIN '%s %d %x\n' hello 42 255" \
      "$ASM_BIN '%s %d %x\n' hello 42 255"
    ;;
  ptx)
    run_bench "index 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  pwd)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  readlink)
    ln -sf "$DATA_DIR/text_1m.txt" /tmp/asm_bench_readlink_sym
    run_bench "invoke" \
      "$GNU_BIN /tmp/asm_bench_readlink_sym" \
      "$RUST_BIN /tmp/asm_bench_readlink_sym" \
      "$ASM_BIN /tmp/asm_bench_readlink_sym"
    rm -f /tmp/asm_bench_readlink_sym
    ;;
  realpath)
    run_bench "invoke" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt'"
    ;;
  rev)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "10MB text" \
        "$GNU_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  rm)
    RM_BASE=$(mktemp -d /tmp/asm_bench_rm_XXXXXX)
    run_bench "invoke" \
      "touch '$RM_BASE/f'; $GNU_BIN '$RM_BASE/f'" \
      "touch '$RM_BASE/f'; $RUST_BIN '$RM_BASE/f'" \
      "touch '$RM_BASE/f'; $ASM_BIN '$RM_BASE/f'"
    rm -rf "$RM_BASE"
    ;;
  rmdir)
    RMDIR_BASE=$(mktemp -d /tmp/asm_bench_rmdir_XXXXXX)
    run_bench "invoke" \
      "mkdir -p '$RMDIR_BASE/d'; $GNU_BIN '$RMDIR_BASE/d'" \
      "mkdir -p '$RMDIR_BASE/d'; $RUST_BIN '$RMDIR_BASE/d'" \
      "mkdir -p '$RMDIR_BASE/d'; $ASM_BIN '$RMDIR_BASE/d'"
    rm -rf "$RMDIR_BASE"
    ;;
  runcon)
    run_bench "invoke" \
      "$GNU_BIN --help > /dev/null 2>&1 || true" \
      "$RUST_BIN --help > /dev/null 2>&1 || true" \
      "$ASM_BIN --help > /dev/null 2>&1 || true"
    ;;
  seq)
    run_bench "1 to 1M" \
      "$GNU_BIN 1000000 > /dev/null" \
      "$RUST_BIN 1000000 > /dev/null" \
      "$ASM_BIN 1000000 > /dev/null"
    run_bench "1 to 10M" \
      "$GNU_BIN 10000000 > /dev/null" \
      "$RUST_BIN 10000000 > /dev/null" \
      "$ASM_BIN 10000000 > /dev/null"
    ;;
  sha1sum)
    run_bench "hash 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt'"
    ;;
  sha224sum)
    run_bench "hash 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt'"
    ;;
  sha256sum)
    run_bench "hash 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt'"
    ;;
  sha384sum)
    run_bench "hash 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt'"
    ;;
  sha512sum)
    run_bench "hash 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt'"
    ;;
  shred)
    SHRED_FILE=$(mktemp /tmp/asm_bench_shred_XXXXXX)
    cp "$DATA_DIR/text_1m.txt" "$SHRED_FILE"
    run_bench "shred 1MB" \
      "cp '$DATA_DIR/text_1m.txt' '$SHRED_FILE' && $GNU_BIN -n 1 '$SHRED_FILE'" \
      "cp '$DATA_DIR/text_1m.txt' '$SHRED_FILE' && $RUST_BIN -n 1 '$SHRED_FILE'" \
      "cp '$DATA_DIR/text_1m.txt' '$SHRED_FILE' && $ASM_BIN -n 1 '$SHRED_FILE'"
    rm -f "$SHRED_FILE"
    ;;
  shuf)
    run_bench "shuffle 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  sleep)
    run_bench "invoke" \
      "$GNU_BIN 0" \
      "$RUST_BIN 0" \
      "$ASM_BIN 0"
    ;;
  sort)
    run_bench "1MB text" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  split)
    SPLIT_DIR=$(mktemp -d /tmp/asm_bench_split_XXXXXX)
    run_bench "split 1MB" \
      "$GNU_BIN -l 1000 '$DATA_DIR/text_1m.txt' -d '$SPLIT_DIR/gnu_'; rm -f $SPLIT_DIR/gnu_*" \
      "$RUST_BIN -l 1000 '$DATA_DIR/text_1m.txt' -d '$SPLIT_DIR/rust_'; rm -f $SPLIT_DIR/rust_*" \
      "$ASM_BIN -l 1000 '$DATA_DIR/text_1m.txt' -d '$SPLIT_DIR/asm_'; rm -f $SPLIT_DIR/asm_*"
    rm -rf "$SPLIT_DIR"
    ;;
  stat)
    run_bench "stat file" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  stdbuf)
    run_bench "invoke" \
      "$GNU_BIN --help > /dev/null 2>&1 || true" \
      "$RUST_BIN --help > /dev/null 2>&1 || true" \
      "$ASM_BIN --help > /dev/null 2>&1 || true"
    ;;
  stty)
    run_bench "invoke" \
      "$GNU_BIN --help > /dev/null 2>&1 || true" \
      "$RUST_BIN --help > /dev/null 2>&1 || true" \
      "$ASM_BIN --help > /dev/null 2>&1 || true"
    ;;
  sum)
    run_bench "hash 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt'" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt'" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt'"
    ;;
  sync)
    run_bench "invoke" \
      "$GNU_BIN" \
      "$RUST_BIN" \
      "$ASM_BIN"
    ;;
  tac)
    run_bench "reverse 1MB" \
      "$GNU_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  tail)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "last 1000 lines 10MB" \
        "$GNU_BIN -n 1000 '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN -n 1000 '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN -n 1000 '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  tee)
    run_bench "tee 1MB" \
      "$GNU_BIN /dev/null < '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$RUST_BIN /dev/null < '$DATA_DIR/text_1m.txt' > /dev/null" \
      "$ASM_BIN /dev/null < '$DATA_DIR/text_1m.txt' > /dev/null"
    ;;
  "test")
    run_bench "invoke" \
      "$GNU_BIN 1 -eq 1" \
      "$RUST_BIN 1 -eq 1" \
      "$ASM_BIN 1 -eq 1"
    ;;
  timeout)
    run_bench "invoke" \
      "$GNU_BIN 1 true" \
      "$RUST_BIN 1 true" \
      "$ASM_BIN 1 true"
    ;;
  touch)
    TOUCH_BASE=$(mktemp -d /tmp/asm_bench_touch_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN '$TOUCH_BASE/gnu_f'" \
      "$RUST_BIN '$TOUCH_BASE/rust_f'" \
      "$ASM_BIN '$TOUCH_BASE/asm_f'"
    rm -rf "$TOUCH_BASE"
    ;;
  tr)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "10MB lowercase" \
        "$GNU_BIN a-z A-Z < '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN a-z A-Z < '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN a-z A-Z < '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  "true")
    run_bench "invoke" \
      "$GNU_BIN" \
      "$RUST_BIN" \
      "$ASM_BIN"
    ;;
  truncate)
    TRUNC_FILE=$(mktemp /tmp/asm_bench_truncate_XXXXXX)
    run_bench "invoke" \
      "$GNU_BIN -s 0 '$TRUNC_FILE'" \
      "$RUST_BIN -s 0 '$TRUNC_FILE'" \
      "$ASM_BIN -s 0 '$TRUNC_FILE'"
    rm -f "$TRUNC_FILE"
    ;;
  tsort)
    # Generate pairs: "1 2\n2 3\n3 4\n..." for topological sort
    python3 -c "
for i in range(1, 100001):
    print(f'{i} {i+1}')
" > /tmp/asm_bench_tsort_input.txt
    run_bench "100K pairs" \
      "$GNU_BIN /tmp/asm_bench_tsort_input.txt > /dev/null" \
      "$RUST_BIN /tmp/asm_bench_tsort_input.txt > /dev/null" \
      "$ASM_BIN /tmp/asm_bench_tsort_input.txt > /dev/null"
    rm -f /tmp/asm_bench_tsort_input.txt
    ;;
  tty)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  uname)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  unexpand)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "10MB text" \
        "$GNU_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  uniq)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      sort "$DATA_DIR/text_10m.txt" > /tmp/asm_bench_sorted.txt
      run_bench "10MB sorted" \
        "$GNU_BIN /tmp/asm_bench_sorted.txt > /dev/null" \
        "$RUST_BIN /tmp/asm_bench_sorted.txt > /dev/null" \
        "$ASM_BIN /tmp/asm_bench_sorted.txt > /dev/null"
      rm -f /tmp/asm_bench_sorted.txt
    fi
    ;;
  unlink)
    UNLINK_BASE=$(mktemp -d /tmp/asm_bench_unlink_XXXXXX)
    run_bench "invoke" \
      "touch '$UNLINK_BASE/f'; $GNU_BIN '$UNLINK_BASE/f'" \
      "touch '$UNLINK_BASE/f'; $RUST_BIN '$UNLINK_BASE/f'" \
      "touch '$UNLINK_BASE/f'; $ASM_BIN '$UNLINK_BASE/f'"
    rm -rf "$UNLINK_BASE"
    ;;
  uptime)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  users)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null 2>&1 || true" \
      "$RUST_BIN > /dev/null 2>&1 || true" \
      "$ASM_BIN > /dev/null 2>&1 || true"
    ;;
  vdir)
    run_bench "list data dir" \
      "$GNU_BIN '$DATA_DIR' > /dev/null" \
      "$RUST_BIN '$DATA_DIR' > /dev/null" \
      "$ASM_BIN '$DATA_DIR' > /dev/null"
    ;;
  wc)
    if [[ -f "$DATA_DIR/text_10m.txt" ]]; then
      run_bench "10MB text" \
        "$GNU_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN '$DATA_DIR/text_10m.txt' > /dev/null"
      run_bench "10MB -l only" \
        "$GNU_BIN -l '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$RUST_BIN -l '$DATA_DIR/text_10m.txt' > /dev/null" \
        "$ASM_BIN -l '$DATA_DIR/text_10m.txt' > /dev/null"
    fi
    ;;
  who)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null 2>&1 || true" \
      "$RUST_BIN > /dev/null 2>&1 || true" \
      "$ASM_BIN > /dev/null 2>&1 || true"
    ;;
  whoami)
    run_bench "invoke" \
      "$GNU_BIN > /dev/null" \
      "$RUST_BIN > /dev/null" \
      "$ASM_BIN > /dev/null"
    ;;
  yes)
    run_bench "1M lines" \
      "$GNU_BIN | head -n 1000000 > /dev/null" \
      "$RUST_BIN | head -n 1000000 > /dev/null" \
      "$ASM_BIN | head -n 1000000 > /dev/null"
    ;;
esac

# ─────────────────────────────────────────────────────────────────────────────
# Measure sizes and write final JSON
# ─────────────────────────────────────────────────────────────────────────────
gnu_size=0; rust_size=0; asm_size=0
gnu_path=$(which "$GNU_BIN" 2>/dev/null || echo "")
[[ -n "$gnu_path" ]] && gnu_size=$(stat -c%s "$gnu_path" 2>/dev/null || echo 0)
[[ -f "$RUST_BIN" ]] && rust_size=$(stat -c%s "$RUST_BIN" 2>/dev/null || echo 0)
[[ -f "$ASM_BIN" ]] && asm_size=$(stat -c%s "$ASM_BIN" 2>/dev/null || echo 0)

cat > "results/asm_bench_${TOOL}.json" <<EOJSON
{
    "tool": "$TOOL",
    "platform": "$(uname -s)_$(uname -m)",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "warmup": 3,
    "runs": 10,
    "benchmarks": $BENCH_RESULTS,
    "sizes": {
        "gnu_bytes": $gnu_size,
        "rust_bytes": $rust_size,
        "asm_bytes": $asm_size
    }
}
EOJSON

echo ""
echo "=== Benchmark results written to results/asm_bench_${TOOL}.json ==="
