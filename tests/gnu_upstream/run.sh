#!/usr/bin/env bash
# run.sh — Run GNU upstream coreutils tests against fcoreutils binaries
# Exit codes: 0=pass, 1=fail, 77=skip
#
# Produces JSON results at $RESULTS_DIR/gnu_upstream_results.json

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TESTS_DIR="$SCRIPT_DIR/tests"
SHIM="$SCRIPT_DIR/init_shim.sh"
export RESULTS_DIR="${RESULTS_DIR:-$SCRIPT_DIR/../../results}"

mkdir -p "$RESULTS_DIR"

# --- Verify setup ---
if [[ ! -d "$TESTS_DIR" ]]; then
    echo "ERROR: GNU upstream tests not found at $TESTS_DIR"
    echo "Run: bash tests/gnu_upstream/run.sh after downloading GNU tests"
    exit 1
fi

if [[ ! -f "$SHIM" ]]; then
    echo "ERROR: init_shim.sh not found at $SHIM"
    exit 1
fi

# --- Build a temp dir with f* tools symlinked as their bare names ---
# This lets GNU tests call 'wc' and get fwc
FTOOLS_DIR=$(mktemp -d)
trap "rm -rf $FTOOLS_DIR" EXIT

INSTALL_DIR="${HOME}/.local/bin"
for ftool in "$INSTALL_DIR"/f*; do
    [[ -x "$ftool" ]] || continue
    tool_name=$(basename "$ftool")
    bare_name="${tool_name#f}"
    # Only create symlink if bare_name is non-empty and looks like a coreutil (no uppercase, no extension)
    [[ -n "$bare_name" && "$bare_name" =~ ^[a-z0-9_-]+$ ]] || continue
    ln -sf "$ftool" "$FTOOLS_DIR/$bare_name" 2>/dev/null || true
done

# Prepend ftools dir so GNU tests get f* binaries when calling bare names
export PATH="$FTOOLS_DIR:$PATH"

# --- Run tests ---
PASS=0
FAIL=0
SKIP=0
RESULTS=()

echo "============================================================"
echo "  GNU Upstream Tests (against fcoreutils)"
echo "  Tests dir: $TESTS_DIR"
echo "  Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "============================================================"

# Find all test scripts
mapfile -t TEST_SCRIPTS < <(find "$TESTS_DIR" -name "*.sh" | sort)

for test_script in "${TEST_SCRIPTS[@]}"; do
    # Skip init.sh itself and helper scripts
    base=$(basename "$test_script")
    [[ "$base" == "init.sh" ]] && continue
    [[ "$base" == "init_shim.sh" ]] && continue

    # Get tool name from directory
    tool_dir=$(basename "$(dirname "$test_script")")
    test_name="${tool_dir}/${base}"

    # Patch: replace 'source .../init.sh' or '. .../init.sh' with our shim
    tmptest=$(mktemp --suffix=.sh)
    # Replace any sourcing of init.sh with our shim
    sed \
        -e "s|source.*init\.sh|source '$SHIM'|g" \
        -e "s|\. .*init\.sh|source '$SHIM'|g" \
        "$test_script" > "$tmptest"
    chmod +x "$tmptest"

    # Run with timeout
    set +e
    timeout 30 bash "$tmptest" 2>/tmp/gnu_test_stderr
    exit_code=$?
    set -e

    if [[ $exit_code -eq 0 ]]; then
        status="pass"
        PASS=$((PASS + 1))
        echo "  PASS: $test_name"
    elif [[ $exit_code -eq 77 ]]; then
        status="skip"
        SKIP=$((SKIP + 1))
        echo "  SKIP: $test_name"
    elif [[ $exit_code -eq 124 ]]; then
        status="skip"
        SKIP=$((SKIP + 1))
        echo "  SKIP (timeout): $test_name"
    else
        status="fail"
        FAIL=$((FAIL + 1))
        stderr_preview=$(head -5 /tmp/gnu_test_stderr 2>/dev/null | tr '\n' ' ' | cut -c1-200)
        echo "  FAIL: $test_name (exit=$exit_code) $stderr_preview"
    fi

    rm -f "$tmptest"

    RESULTS+=("{\"test\":\"$test_name\",\"status\":\"$status\",\"exit_code\":$exit_code}")
done

TOTAL=$((PASS + FAIL + SKIP))

echo ""
echo "============================================================"
echo "  GNU Upstream Results: $PASS pass, $FAIL fail, $SKIP skip"
echo "============================================================"

# Write JSON
RESULTS_JSON=$(IFS=','; echo "${RESULTS[*]:-}")
cat > "$RESULTS_DIR/gnu_upstream_results.json" <<EOF
{
  "type": "gnu_upstream",
  "platform": "$(uname -s)_$(uname -m)",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "summary": {
    "total": $TOTAL,
    "pass": $PASS,
    "fail": $FAIL,
    "skip": $SKIP
  },
  "tests": [$RESULTS_JSON]
}
EOF

echo "Results saved to $RESULTS_DIR/gnu_upstream_results.json"

if [[ $FAIL -gt 0 ]]; then
    exit 1
fi
exit 0
