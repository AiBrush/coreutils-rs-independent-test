#!/usr/bin/env bash
# Clone and build uutils/coreutils from source
# Exports UUTILS_DIR pointing to the directory containing built binaries
set -euo pipefail

UUTILS_REPO="https://github.com/uutils/coreutils.git"
BUILD_DIR="${UUTILS_BUILD_DIR:-/tmp/uutils-build}"

usage() {
    echo "Usage: $0 [--build-dir DIR]"
    echo ""
    echo "  --build-dir DIR   Directory to clone/build uutils in. Default: /tmp/uutils-build"
    echo ""
    exit 1
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --build-dir)
            BUILD_DIR="$2"
            shift 2
            ;;
        --help|-h)
            usage
            ;;
        *)
            echo "Unknown argument: $1"
            usage
            ;;
    esac
done

# Check dependencies
check_deps() {
    local missing=()
    if ! command -v git &>/dev/null; then
        missing+=("git")
    fi
    if ! command -v cargo &>/dev/null; then
        missing+=("cargo")
    fi
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo "ERROR: Missing required dependencies: ${missing[*]}"
        echo "Install them and retry."
        return 1
    fi
}

# Clone or update the uutils repo
clone_or_update() {
    if [[ -d "$BUILD_DIR/.git" ]]; then
        echo "Updating existing uutils clone in $BUILD_DIR..."
        git -C "$BUILD_DIR" pull --ff-only 2>/dev/null || {
            echo "WARNING: git pull failed, using existing checkout"
        }
    elif [[ -d "$BUILD_DIR" ]]; then
        # Directory exists but no .git (e.g. from CI cache restoring target/).
        # Preserve cached target/, clone fresh, then restore target/.
        echo "Directory $BUILD_DIR exists without .git (cache artifact). Cloning source..."
        if [[ -d "$BUILD_DIR/target" ]]; then
            mv "$BUILD_DIR/target" /tmp/uutils-target-cache
        fi
        rm -rf "$BUILD_DIR"
        git clone --depth 1 "$UUTILS_REPO" "$BUILD_DIR"
        if [[ -d /tmp/uutils-target-cache ]]; then
            mv /tmp/uutils-target-cache "$BUILD_DIR/target"
        fi
    else
        echo "Cloning uutils/coreutils into $BUILD_DIR..."
        mkdir -p "$(dirname "$BUILD_DIR")"
        git clone --depth 1 "$UUTILS_REPO" "$BUILD_DIR"
    fi
}

# Build only the 10 tools we benchmark
build_tools() {
    echo "Building uutils tools (release mode)..."
    cd "$BUILD_DIR"

    cargo build --release \
        -p uu_wc -p uu_sort -p uu_uniq -p uu_cut -p uu_tr \
        -p uu_base64 -p uu_tac -p uu_md5sum -p uu_b2sum -p uu_sha256sum

    echo "Build complete."
}

# Record uutils version info
get_version() {
    cd "$BUILD_DIR"
    local tag
    tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "")
    local hash
    hash=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")

    if [[ -n "$tag" ]]; then
        echo "${tag} (${hash})"
    else
        echo "main (${hash})"
    fi
}

# Verify built binaries exist
verify_build() {
    local release_dir="$BUILD_DIR/target/release"
    local found=0
    local tools=(wc sort uniq cut tr base64 tac md5sum b2sum sha256sum)

    for tool in "${tools[@]}"; do
        if [[ -x "$release_dir/$tool" ]]; then
            found=$((found + 1))
        else
            echo "WARNING: $release_dir/$tool not found"
        fi
    done

    if [[ "$found" -eq 0 ]]; then
        echo "ERROR: No uutils binaries found after build"
        return 1
    fi

    echo "Successfully built $found/10 uutils binaries"
}

# Main
main() {
    check_deps || exit 1

    clone_or_update
    build_tools

    local uutils_dir="$BUILD_DIR/target/release"
    local version
    version=$(get_version)

    verify_build

    export UUTILS_DIR="$uutils_dir"
    export UUTILS_VERSION="$version"

    echo ""
    echo "uutils/coreutils version: $version"
    echo "UUTILS_DIR=$uutils_dir"
    echo ""
    echo "To use in your shell:"
    echo "  export UUTILS_DIR=\"$uutils_dir\""
}

main
