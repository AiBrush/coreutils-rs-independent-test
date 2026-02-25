#!/usr/bin/env bash
# init_shim.sh — Drop-in replacement for GNU's tests/init.sh
# Adapts GNU coreutils tests to run against fcoreutils (f* binaries)
#
# Exit codes used by GNU tests:
#   0  = pass
#   1  = fail
#   77 = skip (SKIP_)
#   99 = hard error

# Prevent re-sourcing
[[ -n "${_INIT_SHIM_LOADED:-}" ]] && return 0
_INIT_SHIM_LOADED=1

# --- Core state ---
ME=$(basename "$0" .sh)
srcdir="${srcdir:-.}"
fail=0

# --- Path manipulation ---
path_prepend_() {
    local dir="$1"
    PATH="${dir}:${PATH}"
    export PATH
}

# --- Skipping ---
skip_() {
    local reason="${1:-no reason given}"
    echo "SKIP: $ME: $reason" >&2
    exit 77
}

# Alias used in many tests
SKIP_() { skip_ "$@"; }

# --- Failure ---
fail_() {
    local reason="${1:-test failed}"
    echo "FAIL: $ME: $reason" >&2
    fail=1
}

# --- Comparison ---
compare() {
    diff -u "$1" "$2" >&2
    return $?
}

compare_() {
    compare "$@"
}

# --- Root / privilege checks ---
require_root_() {
    if [[ "$(id -u)" -ne 0 ]]; then
        skip_ "requires root"
    fi
}

# --- SELinux / special env checks ---
require_selinux_() {
    skip_ "SELinux not tested in this environment"
}

# --- Tool availability ---
require_built_() {
    local tool="$1"
    local f_tool="f${tool}"
    if ! command -v "$f_tool" &>/dev/null; then
        skip_ "$f_tool not found in PATH"
    fi
}

# Fallback for tests that call require_ with GNU tool names
require_() {
    local tool="$1"
    if ! command -v "$tool" &>/dev/null && ! command -v "f${tool}" &>/dev/null; then
        skip_ "required tool $tool not available"
    fi
}

# --- Exit helper ---
Exit() {
    local code="${1:-0}"
    [[ $fail -ne 0 ]] && exit 1
    exit "$code"
}

# --- Temp dir management ---
cleanup_() {
    [[ -n "${tmpdir:-}" ]] && rm -rf "$tmpdir"
}

setup_() {
    tmpdir=$(mktemp -d)
    trap cleanup_ EXIT
    cd "$tmpdir" || exit 1
}

# --- Assertion helpers ---
returns_() {
    local expected="$1"
    shift
    "$@"
    local actual=$?
    if [[ "$actual" -ne "$expected" ]]; then
        fail_ "expected exit $expected, got $actual from: $*"
    fi
}

# --- Common output helpers ---
print_ver_() {
    echo "init_shim.sh: running $ME"
}

# --- Framework failure ---
framework_failure_() {
    echo "FRAMEWORK FAILURE: $ME: ${1:-setup failed}" >&2
    exit 99
}

# --- Silence noisy GNU infrastructure functions ---
# These are used in some tests but we don't need them
check_coreutils_or_skip_() { :; }
emit_superuser_warning() { :; }
check_prog() {
    command -v "$1" &>/dev/null || skip_ "$1 not available"
}

# --- Auto-create temp working directory ---
# Many GNU tests expect to run in a clean temp directory
# Set up automatically so tests don't need to call setup_ explicitly
tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT
cd "$tmpdir" || exit 99

# --- Announce startup ---
echo "Running: $ME (via init_shim.sh)"
