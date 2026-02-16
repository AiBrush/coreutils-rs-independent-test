#!/usr/bin/env bash
# Install fcoreutils binaries from GitHub releases
set -euo pipefail

REPO="AiBrush/coreutils-rs"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
VERSION=""
API_URL="https://api.github.com/repos/${REPO}/releases"

usage() {
    echo "Usage: $0 [--version VERSION] [--install-dir DIR]"
    echo ""
    echo "  --version VERSION   Version tag to install (e.g., v0.0.31). Default: latest"
    echo "  --install-dir DIR   Installation directory. Default: \$HOME/.local/bin"
    echo ""
    exit 1
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --version)
            VERSION="$2"
            shift 2
            ;;
        --install-dir)
            INSTALL_DIR="$2"
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

# Detect platform and build target triple
detect_target() {
    local os arch
    os="$(uname -s)"
    arch="$(uname -m)"

    case "$os" in
        Linux)
            case "$arch" in
                x86_64)  echo "x86_64-unknown-linux-gnu" ;;
                aarch64) echo "aarch64-unknown-linux-gnu" ;;
                *)       echo "UNSUPPORTED"; return 1 ;;
            esac
            ;;
        Darwin)
            case "$arch" in
                x86_64)  echo "x86_64-apple-darwin" ;;
                arm64)   echo "aarch64-apple-darwin" ;;
                *)       echo "UNSUPPORTED"; return 1 ;;
            esac
            ;;
        MINGW*|MSYS*|CYGWIN*)
            case "$arch" in
                x86_64)  echo "x86_64-pc-windows-msvc" ;;
                *)       echo "UNSUPPORTED"; return 1 ;;
            esac
            ;;
        *)
            echo "UNSUPPORTED"; return 1
            ;;
    esac
}

# Auth header for GitHub API (avoids rate limits in CI)
auth_header() {
    if [[ -n "${GITHUB_TOKEN:-}" ]]; then
        echo "Authorization: token ${GITHUB_TOKEN}"
    else
        echo "X-No-Auth: true"
    fi
}

# Resolve the version to install
resolve_version() {
    if [[ -n "$VERSION" ]]; then
        echo "$VERSION"
        return
    fi

    echo "Fetching latest release..." >&2
    local latest
    latest=$(curl -sS -H "$(auth_header)" "${API_URL}/latest" | \
        python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])" 2>/dev/null)

    if [[ -z "$latest" ]]; then
        echo "ERROR: Could not determine latest release" >&2
        return 1
    fi
    echo "$latest"
}

# Download and extract binaries
install_version() {
    local version="$1"
    local target="$2"

    mkdir -p "$INSTALL_DIR"

    # Determine asset name and extension
    local ext="tar.gz"
    if [[ "$target" == *"windows"* ]]; then
        ext="zip"
    fi
    local asset_name="fcoreutils-${target}.${ext}"
    local download_url="https://github.com/${REPO}/releases/download/${version}/${asset_name}"

    echo "Downloading ${asset_name} for ${version}..."
    local tmp_dir
    tmp_dir=$(mktemp -d)
    local tmp_file="${tmp_dir}/${asset_name}"

    local http_code
    http_code=$(curl -sSL -w "%{http_code}" -o "$tmp_file" "$download_url")

    if [[ "$http_code" != "200" ]]; then
        echo "ERROR: Download failed with HTTP ${http_code} for ${download_url}"
        rm -rf "$tmp_dir"
        return 1
    fi

    # Check we got a real file (not a 404 HTML page)
    if [[ ! -s "$tmp_file" ]]; then
        echo "ERROR: Downloaded file is empty"
        rm -rf "$tmp_dir"
        return 1
    fi

    echo "Extracting to ${INSTALL_DIR}..."
    if [[ "$ext" == "zip" ]]; then
        # Extract to temp dir first, then move binaries to INSTALL_DIR
        # (zip may contain subdirectories like release/)
        local extract_dir="${tmp_dir}/extracted"
        mkdir -p "$extract_dir"
        unzip -o -q "$tmp_file" -d "$extract_dir"
        # Find and move all f* binaries to INSTALL_DIR
        find "$extract_dir" -type f -name "f*.exe" -exec cp {} "$INSTALL_DIR/" \;
        find "$extract_dir" -type f -name "f*" ! -name "*.exe" -exec cp {} "$INSTALL_DIR/" \;
    else
        tar xzf "$tmp_file" -C "$INSTALL_DIR"
    fi

    rm -rf "$tmp_dir"
    echo "Binaries installed to ${INSTALL_DIR}"
}

# Verify installation
verify_install() {
    local found=0
    for tool in fwc fsort fcut ftr funiq ftac fbase64 fsha256sum fmd5sum fb2sum fhead ftail fcat frev fexpand funexpand ffold fpaste fnl fcomm fjoin; do
        if [[ -x "${INSTALL_DIR}/${tool}" ]] || [[ -x "${INSTALL_DIR}/${tool}.exe" ]] || command -v "$tool" &>/dev/null; then
            found=$((found + 1))
        fi
    done

    if [[ "$found" -eq 0 ]]; then
        echo "ERROR: No fcoreutils binaries found after installation"
        echo "Contents of ${INSTALL_DIR}:"
        ls -la "${INSTALL_DIR}/" 2>/dev/null || echo "  (directory not found)"
        return 1
    fi

    # Try running one binary
    if command -v fwc &>/dev/null; then
        echo "Verification: fwc is available at $(which fwc)"
    elif [[ -x "${INSTALL_DIR}/fwc" ]]; then
        echo "Verification: fwc is available at ${INSTALL_DIR}/fwc"
    elif [[ -x "${INSTALL_DIR}/fwc.exe" ]]; then
        echo "Verification: fwc.exe is available at ${INSTALL_DIR}/fwc.exe"
    fi

    echo "Successfully installed ${found} fcoreutils binaries"
}

# Main
main() {
    local target
    target=$(detect_target)
    if [[ "$target" == "UNSUPPORTED" ]]; then
        echo "ERROR: Unsupported platform: $(uname -s) $(uname -m)"
        exit 1
    fi
    echo "Detected platform: ${target}"

    local version
    version=$(resolve_version)
    echo "Installing version: ${version}"

    install_version "$version" "$target"

    # Add to PATH for current session
    export PATH="${INSTALL_DIR}:${PATH}"

    verify_install

    echo ""
    echo "Add to your PATH if needed:"
    echo "  export PATH=\"${INSTALL_DIR}:\$PATH\""
}

main
