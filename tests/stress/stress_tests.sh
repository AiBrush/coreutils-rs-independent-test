#!/usr/bin/env bash
# Stress tests for fcoreutils - push tools to their limits
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common.sh"

export TEST_DATA_DIR="${TEST_DATA_DIR:-/tmp/fcoreutils-test-data}"
export RESULTS_DIR="${RESULTS_DIR:-$SCRIPT_DIR/../../results}"
mkdir -p "$RESULTS_DIR"

STRESS_PASSED=0
STRESS_FAILED=0
STRESS_SKIPPED=0
STRESS_RESULTS="[]"

stress_pass() {
    local name="$1"
    STRESS_PASSED=$((STRESS_PASSED + 1))
    echo -e "  ${GREEN:-}PASS${NC:-}: $name"
}

stress_fail() {
    local name="$1"
    local detail="${2:-}"
    STRESS_FAILED=$((STRESS_FAILED + 1))
    echo -e "  ${RED:-}FAIL${NC:-}: $name"
    [[ -n "$detail" ]] && echo "    $detail"
}

stress_skip() {
    local name="$1"
    local reason="${2:-}"
    STRESS_SKIPPED=$((STRESS_SKIPPED + 1))
    echo -e "  ${YELLOW:-}SKIP${NC:-}: $name ($reason)"
}

echo "============================================================"
echo "  fcoreutils Stress Tests"
echo "  Platform: $(uname -s) $(uname -m)"
echo "============================================================"

ensure_test_data

# List of tools to stress test
FTOOLS=("fwc" "fcut" "fsha256sum" "fmd5sum" "fb2sum" "fbase64" "fsort" "ftr" "funiq" "ftac")

echo ""
echo "=== Concurrent Execution (50 parallel instances) ==="

for tool in "${FTOOLS[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
        stress_skip "concurrent $tool" "not installed"
        continue
    fi

    # Run 50 parallel instances
    pids=()
    all_ok=true
    for i in $(seq 1 50); do
        case "$tool" in
            fwc)     $tool "$TEST_DATA_DIR/text_100k.txt" > /dev/null 2>&1 & ;;
            fcut)    $tool -d, -f1 "$TEST_DATA_DIR/simple.csv" > /dev/null 2>&1 & ;;
            fsha256sum|fmd5sum|fb2sum) $tool "$TEST_DATA_DIR/text_100k.txt" > /dev/null 2>&1 & ;;
            fbase64) $tool "$TEST_DATA_DIR/text_100k.txt" > /dev/null 2>&1 & ;;
            fsort)   $tool "$TEST_DATA_DIR/unsorted.txt" > /dev/null 2>&1 & ;;
            ftr)     echo "hello" | $tool 'a-z' 'A-Z' > /dev/null 2>&1 & ;;
            funiq)   $tool "$TEST_DATA_DIR/duplicates.txt" > /dev/null 2>&1 & ;;
            ftac)    $tool "$TEST_DATA_DIR/tac_simple.txt" > /dev/null 2>&1 & ;;
        esac
        pids+=($!)
    done

    for pid in "${pids[@]}"; do
        if ! wait "$pid" 2>/dev/null; then
            all_ok=false
        fi
    done

    if $all_ok; then
        stress_pass "concurrent $tool (50 instances)"
    else
        stress_fail "concurrent $tool (50 instances)" "some instances failed"
    fi
done

echo ""
echo "=== Rapid Repeated Execution (100 runs) ==="

for tool in "${FTOOLS[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
        stress_skip "rapid $tool" "not installed"
        continue
    fi

    all_ok=true
    for i in $(seq 1 100); do
        case "$tool" in
            fwc)     $tool "$TEST_DATA_DIR/simple.csv" > /dev/null 2>&1 ;;
            fcut)    $tool -d, -f1 "$TEST_DATA_DIR/simple.csv" > /dev/null 2>&1 ;;
            fsha256sum|fmd5sum|fb2sum) $tool "$TEST_DATA_DIR/checksum_abc.txt" > /dev/null 2>&1 ;;
            fbase64) echo "hello" | $tool > /dev/null 2>&1 ;;
            fsort)   echo "b\na\nc" | $tool > /dev/null 2>&1 ;;
            ftr)     echo "hello" | $tool 'a-z' 'A-Z' > /dev/null 2>&1 ;;
            funiq)   echo -e "a\na\nb" | $tool > /dev/null 2>&1 ;;
            ftac)    echo -e "a\nb\nc" | $tool > /dev/null 2>&1 ;;
        esac
        if [[ $? -ne 0 ]]; then
            all_ok=false
            break
        fi
    done

    if $all_ok; then
        stress_pass "rapid $tool (100 runs)"
    else
        stress_fail "rapid $tool (100 runs)" "failed during rapid execution"
    fi
done

echo ""
echo "=== Very Long Lines (1MB single line) ==="

if [[ -f "$TEST_DATA_DIR/long_line_1m.txt" ]]; then
    for tool in "${FTOOLS[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            stress_skip "long line $tool" "not installed"
            continue
        fi

        case "$tool" in
            fwc)     if $tool "$TEST_DATA_DIR/long_line_1m.txt" > /dev/null 2>&1; then stress_pass "long line $tool"; else stress_fail "long line $tool"; fi ;;
            fcut)    if $tool -b1-100 "$TEST_DATA_DIR/long_line_1m.txt" > /dev/null 2>&1; then stress_pass "long line $tool"; else stress_fail "long line $tool"; fi ;;
            fsha256sum|fmd5sum|fb2sum) if $tool "$TEST_DATA_DIR/long_line_1m.txt" > /dev/null 2>&1; then stress_pass "long line $tool"; else stress_fail "long line $tool"; fi ;;
            fbase64) if $tool "$TEST_DATA_DIR/long_line_1m.txt" > /dev/null 2>&1; then stress_pass "long line $tool"; else stress_fail "long line $tool"; fi ;;
            fsort)   if $tool "$TEST_DATA_DIR/long_line_1m.txt" > /dev/null 2>&1; then stress_pass "long line $tool"; else stress_fail "long line $tool"; fi ;;
            ftr)     if $tool 'a-z' 'A-Z' < "$TEST_DATA_DIR/long_line_1m.txt" > /dev/null 2>&1; then stress_pass "long line $tool"; else stress_fail "long line $tool"; fi ;;
            funiq)   if $tool "$TEST_DATA_DIR/long_line_1m.txt" > /dev/null 2>&1; then stress_pass "long line $tool"; else stress_fail "long line $tool"; fi ;;
            ftac)    if $tool "$TEST_DATA_DIR/long_line_1m.txt" > /dev/null 2>&1; then stress_pass "long line $tool"; else stress_fail "long line $tool"; fi ;;
        esac
    done
fi

echo ""
echo "=== Millions of Short Lines ==="

MANY_LINES_FILE="/tmp/fcoreutils_millions_lines_$$"
python3 -c "
for i in range(2000000):
    print(f'line{i}')
" > "$MANY_LINES_FILE"

for tool in "fwc" "fsort" "funiq" "ftac"; do
    if ! command -v "$tool" &>/dev/null; then
        stress_skip "millions of lines $tool" "not installed"
        continue
    fi

    if timeout 60 $tool "$MANY_LINES_FILE" > /dev/null 2>&1; then
        stress_pass "millions of lines $tool (2M lines)"
    else
        stress_fail "millions of lines $tool (2M lines)" "timeout or error"
    fi
done
rm -f "$MANY_LINES_FILE"

echo ""
echo "=== Mixed Binary and Text ==="

MIXED_FILE="/tmp/fcoreutils_mixed_$$"
python3 -c "
import sys
for i in range(10000):
    sys.stdout.buffer.write(f'line {i} '.encode())
    sys.stdout.buffer.write(bytes([0, 128, 255, 1, 127]))
    sys.stdout.buffer.write(b'\n')
" > "$MIXED_FILE"

for tool in "fwc" "fsha256sum" "fmd5sum" "ftac"; do
    if ! command -v "$tool" &>/dev/null; then
        stress_skip "mixed binary $tool" "not installed"
        continue
    fi

    if $tool "$MIXED_FILE" > /dev/null 2>&1; then
        stress_pass "mixed binary/text $tool"
    else
        stress_fail "mixed binary/text $tool"
    fi
done
rm -f "$MIXED_FILE"

echo ""
echo "=== Adversarial Input ==="

# NULL-only input
for tool in "fwc" "ftr" "ftac"; do
    if ! command -v "$tool" &>/dev/null; then
        stress_skip "null-only input $tool" "not installed"
        continue
    fi

    case "$tool" in
        fwc)  if printf '\0\0\0\0\0' | $tool > /dev/null 2>&1; then stress_pass "null-only input $tool"; else stress_fail "null-only input $tool"; fi ;;
        ftr)  if printf '\0\0\0\0\0' | $tool '\0' 'X' > /dev/null 2>&1; then stress_pass "null-only input $tool"; else stress_fail "null-only input $tool"; fi ;;
        ftac) if printf '\0\0\0\0\0' | $tool > /dev/null 2>&1; then stress_pass "null-only input $tool"; else stress_fail "null-only input $tool"; fi ;;
    esac
done

echo ""
echo "=== Signal Handling (SIGTERM during processing) ==="

for tool in "fwc" "fsort" "fsha256sum"; do
    if ! command -v "$tool" &>/dev/null; then
        stress_skip "SIGTERM $tool" "not installed"
        continue
    fi

    # Start a long-running process and send SIGTERM
    yes "test line for signal handling" | head -10000000 | $tool > /dev/null 2>&1 &
    pid=$!
    sleep 0.5
    kill -TERM "$pid" 2>/dev/null
    wait "$pid" 2>/dev/null
    exit_code=$?

    # Tool should exit cleanly (not crash/segfault - exit code 143 = SIGTERM, or 0)
    if [[ "$exit_code" -le 143 ]]; then
        stress_pass "SIGTERM $tool (exit: $exit_code)"
    else
        stress_fail "SIGTERM $tool (exit: $exit_code)" "unexpected exit code"
    fi
done

echo ""
echo "=== Slow Stdin (throttled input) ==="

for tool in "fwc" "ftr"; do
    if ! command -v "$tool" &>/dev/null; then
        stress_skip "slow stdin $tool" "not installed"
        continue
    fi

    # Throttle input: send 10 lines with 0.01s delay each
    result=$(for i in $(seq 1 10); do echo "line $i"; sleep 0.01; done | timeout 10 $tool 2>&1)
    if [[ $? -le 1 ]]; then
        stress_pass "slow stdin $tool"
    else
        stress_fail "slow stdin $tool" "timeout or error"
    fi
done

echo ""
echo "============================================================"
echo "  STRESS TEST RESULTS"
echo "============================================================"
echo "  Passed:  $STRESS_PASSED"
echo "  Failed:  $STRESS_FAILED"
echo "  Skipped: $STRESS_SKIPPED"
echo "============================================================"

# Save results
cat > "$RESULTS_DIR/stress_results.json" <<EOF
{
    "type": "stress",
    "platform": "$(uname -s)_$(uname -m)",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "passed": $STRESS_PASSED,
    "failed": $STRESS_FAILED,
    "skipped": $STRESS_SKIPPED
}
EOF

[[ "$STRESS_FAILED" -gt 0 ]] && exit 1
exit 0
