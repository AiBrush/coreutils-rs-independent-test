#!/usr/bin/env bash
# Install fcoreutils assembly tools from source
#
# Clones the fcoreutils repo, builds each x86-64 assembly tool with nasm+ld,
# and copies the resulting static ELF binaries to INSTALL_DIR.
#
# Usage:
#   bash scripts/install_assembly.sh [--version TAG] [--install-dir DIR] [--repo-dir DIR]
#
# Requirements: nasm, ld (binutils), make, git  (Linux x86-64 only)

set -euo pipefail

REPO_URL="https://github.com/AiBrush/fcoreutils.git"
INSTALL_DIR="${ASM_INSTALL_DIR:-$HOME/.local/bin/asm}"
REPO_DIR=""
VERSION=""
CLEANUP_REPO=false

# Assembly tools to build (tool_name:binary_name)
ASM_TOOLS=(
    arch:farch
    base64:fbase64
    cat:fcat
    cut:fcut
    echo:fecho
    expand:fexpand
    false:ffalse
    fold:ffold
    head:fhead
    hostid:fhostid
    logname:flogname
    md5sum:fmd5sum
    nl:fnl
    od:fod
    pwd:fpwd
    rev:frev
    seq:fseq
    sleep:fsleep
    sort:fsort
    sync:fsync
    tac:ftac
    tail:ftail
    tr:ftr
    true:ftrue
    tty:ftty
    unexpand:funexpand
    uniq:funiq
    wc:fwc
    whoami:fwhoami
    yes:fyes
)

usage() {
    echo "Usage: $0 [--version TAG] [--install-dir DIR] [--repo-dir DIR]"
    echo ""
    echo "  --version TAG      Git tag or branch to check out (default: main)"
    echo "  --install-dir DIR  Where to install binaries (default: ~/.local/bin/asm)"
    echo "  --repo-dir DIR     Use existing clone instead of cloning fresh"
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
        --repo-dir)
            REPO_DIR="$2"
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

# ── Platform check ────────────────────────────────────────────────────────────
check_platform() {
    local os arch
    os="$(uname -s)"
    arch="$(uname -m)"

    if [[ "$os" != "Linux" ]]; then
        echo "ERROR: Assembly tools are Linux-only (detected: $os)"
        exit 1
    fi

    if [[ "$arch" != "x86_64" ]]; then
        echo "ERROR: Assembly tools are x86-64 only (detected: $arch)"
        exit 1
    fi
}

# ── Install nasm if missing ──────────────────────────────────────────────────
install_nasm() {
    if command -v nasm &>/dev/null; then
        echo "nasm already installed: $(nasm --version 2>&1 | head -1)"
        return 0
    fi

    echo "Installing nasm..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get update -qq
        sudo apt-get install -y nasm
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y nasm
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm nasm
    else
        echo "ERROR: Cannot install nasm automatically. Please install it manually."
        exit 1
    fi

    echo "nasm installed: $(nasm --version 2>&1 | head -1)"
}

# ── Install binutils (ld) if missing ────────────────────────────────────────
install_binutils() {
    if command -v ld &>/dev/null; then
        return 0
    fi

    echo "Installing binutils (ld)..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get install -y binutils
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y binutils
    fi
}

# ── Clone or use existing repo ───────────────────────────────────────────────
prepare_repo() {
    if [[ -n "$REPO_DIR" ]]; then
        if [[ ! -d "$REPO_DIR/assembly" ]]; then
            echo "ERROR: $REPO_DIR does not look like fcoreutils (no assembly/ dir)"
            exit 1
        fi
        echo "Using existing repo: $REPO_DIR"
        if [[ -n "$VERSION" ]]; then
            echo "Checking out $VERSION..."
            git -C "$REPO_DIR" fetch --tags 2>/dev/null || true
            git -C "$REPO_DIR" checkout "$VERSION" 2>/dev/null || \
                git -C "$REPO_DIR" checkout "origin/$VERSION" 2>/dev/null || {
                    echo "WARNING: Could not checkout $VERSION, using current HEAD"
                }
        fi
        return 0
    fi

    REPO_DIR=$(mktemp -d /tmp/fcoreutils-asm-build.XXXXXX)
    CLEANUP_REPO=true

    echo "Cloning fcoreutils..."
    local clone_args=(--depth 1)
    if [[ -n "$VERSION" ]]; then
        # Try shallow clone of specific tag/branch
        if git clone --depth 1 --branch "$VERSION" "$REPO_URL" "$REPO_DIR" 2>/dev/null; then
            echo "Cloned $VERSION"
            return 0
        fi
        # Fall back to full clone + checkout
        clone_args=()
    fi

    git clone "${clone_args[@]}" "$REPO_URL" "$REPO_DIR"

    if [[ -n "$VERSION" ]]; then
        git -C "$REPO_DIR" checkout "$VERSION"
    fi
}

# ── Build assembly tools ─────────────────────────────────────────────────────
build_tools() {
    local built=0
    local failed=0
    local failed_tools=()

    mkdir -p "$INSTALL_DIR"

    echo ""
    echo "Building assembly tools..."
    echo "  Source: $REPO_DIR/assembly/"
    echo "  Install: $INSTALL_DIR"
    echo ""

    for entry in "${ASM_TOOLS[@]}"; do
        local tool="${entry%%:*}"
        local binary="${entry##*:}"
        local tool_dir="$REPO_DIR/assembly/$tool"

        if [[ ! -d "$tool_dir" ]]; then
            echo "  SKIP: $tool (directory not found)"
            continue
        fi

        # Tools without Makefiles: build from unified .asm source using nasm -f bin
        if [[ ! -f "$tool_dir/Makefile" ]]; then
            local unified_src=""
            # Look for unified source file
            if [[ -d "$tool_dir/unified" ]]; then
                unified_src=$(ls "$tool_dir/unified/"*_unified.asm 2>/dev/null | head -1)
            fi
            # Some tools have source directly in their directory (e.g. yes)
            if [[ -z "$unified_src" ]] && [[ -f "$tool_dir/${binary}.asm" ]]; then
                unified_src="$tool_dir/${binary}.asm"
            fi

            if [[ -n "$unified_src" ]]; then
                echo -n "  Building $binary (nasm -f bin)... "
                if nasm -f bin "$unified_src" -o "$INSTALL_DIR/$binary" 2>/dev/null && \
                   chmod +x "$INSTALL_DIR/$binary"; then
                    local size
                    size=$(stat -c%s "$INSTALL_DIR/$binary" 2>/dev/null || echo "?")
                    echo "OK ($size bytes)"
                    built=$((built + 1))
                else
                    echo "FAIL (nasm error)"
                    failed=$((failed + 1))
                    failed_tools+=("$tool")
                fi
            elif [[ -f "$tool_dir/tools/${binary}.asm" ]] && [[ -d "$tool_dir/lib" ]]; then
                # Multi-file build: nasm -f elf64 + ld (e.g. wc)
                echo -n "  Building $binary (nasm elf64 + ld)... "
                local build_dir="$tool_dir/build"
                mkdir -p "$build_dir/tools" "$build_dir/lib"
                local obj_files=""
                local build_ok=true

                # Build main tool object
                if ! nasm -f elf64 -I "$tool_dir/include/" "$tool_dir/tools/${binary}.asm" \
                     -o "$build_dir/tools/${binary}.o" 2>/dev/null; then
                    build_ok=false
                fi
                obj_files="$build_dir/tools/${binary}.o"

                # Build library objects
                if $build_ok; then
                    for lib_src in "$tool_dir/lib/"*.asm; do
                        local lib_name
                        lib_name=$(basename "$lib_src" .asm)
                        if ! nasm -f elf64 -I "$tool_dir/include/" "$lib_src" \
                             -o "$build_dir/lib/${lib_name}.o" 2>/dev/null; then
                            build_ok=false
                            break
                        fi
                        obj_files="$obj_files $build_dir/lib/${lib_name}.o"
                    done
                fi

                # Link
                if $build_ok && ld --gc-sections -n $obj_files -o "$INSTALL_DIR/$binary" 2>/dev/null; then
                    chmod +x "$INSTALL_DIR/$binary"
                    local size
                    size=$(stat -c%s "$INSTALL_DIR/$binary" 2>/dev/null || echo "?")
                    echo "OK ($size bytes)"
                    built=$((built + 1))
                else
                    echo "FAIL (build error)"
                    failed=$((failed + 1))
                    failed_tools+=("$tool")
                fi
                rm -rf "$build_dir"
            elif [[ -f "$tool_dir/$binary" ]]; then
                # Fallback: copy pre-built binary if present
                echo -n "  Copying pre-built $binary... "
                cp "$tool_dir/$binary" "$INSTALL_DIR/$binary"
                chmod +x "$INSTALL_DIR/$binary"
                local size
                size=$(stat -c%s "$INSTALL_DIR/$binary" 2>/dev/null || echo "?")
                echo "OK ($size bytes)"
                built=$((built + 1))
            else
                echo "  SKIP: $tool (no Makefile, no unified source, no pre-built binary)"
            fi
            continue
        fi

        echo -n "  Building $binary... "

        # Clean any previous build artifacts
        make -C "$tool_dir" clean >/dev/null 2>&1 || true

        # Build (dev target produces the binary)
        if make -C "$tool_dir" dev 2>/dev/null; then
            # The binary is produced in the tool directory as $binary
            if [[ -f "$tool_dir/$binary" ]]; then
                cp "$tool_dir/$binary" "$INSTALL_DIR/$binary"
                chmod +x "$INSTALL_DIR/$binary"
                local size
                size=$(stat -c%s "$INSTALL_DIR/$binary" 2>/dev/null || stat -f%z "$INSTALL_DIR/$binary" 2>/dev/null || echo "?")
                echo "OK ($size bytes)"
                built=$((built + 1))
            else
                echo "FAIL (binary not produced)"
                failed=$((failed + 1))
                failed_tools+=("$tool")
            fi
        else
            echo "FAIL (make error)"
            failed=$((failed + 1))
            failed_tools+=("$tool")
        fi
    done

    echo ""
    echo "Build complete: $built succeeded, $failed failed"

    if [[ ${#failed_tools[@]} -gt 0 ]]; then
        echo "Failed tools: ${failed_tools[*]}"
    fi

    if [[ $built -eq 0 ]]; then
        echo "ERROR: No assembly tools were built successfully"
        exit 1
    fi
}

# ── Verify installation ──────────────────────────────────────────────────────
verify_install() {
    local found=0
    local total=0

    echo ""
    echo "Verifying assembly binaries:"

    for entry in "${ASM_TOOLS[@]}"; do
        local binary="${entry##*:}"
        total=$((total + 1))

        if [[ -x "$INSTALL_DIR/$binary" ]]; then
            # Quick sanity check: the binary should be a static ELF
            local filetype
            filetype=$(file "$INSTALL_DIR/$binary" 2>/dev/null | head -1)
            if echo "$filetype" | grep -q "ELF"; then
                echo "  OK: $binary (ELF binary)"
                found=$((found + 1))
            else
                echo "  WARN: $binary (not ELF: $filetype)"
                found=$((found + 1))
            fi
        else
            echo "  MISSING: $binary"
        fi
    done

    echo ""
    echo "Verified $found/$total assembly binaries in $INSTALL_DIR"
}

# ── Measure binary sizes ─────────────────────────────────────────────────────
measure_sizes() {
    echo ""
    echo "Assembly binary sizes:"
    echo "  ────────────────────────────────────────"

    for entry in "${ASM_TOOLS[@]}"; do
        local tool="${entry%%:*}"
        local binary="${entry##*:}"

        if [[ -f "$INSTALL_DIR/$binary" ]]; then
            local asm_size
            asm_size=$(stat -c%s "$INSTALL_DIR/$binary" 2>/dev/null || echo "?")

            local gnu_path gnu_size=""
            gnu_path=$(which "$tool" 2>/dev/null || echo "")
            if [[ -n "$gnu_path" ]]; then
                gnu_size=$(stat -c%s "$gnu_path" 2>/dev/null || echo "?")
            fi

            printf "  %-12s %8s bytes" "$binary" "$asm_size"
            if [[ -n "$gnu_size" ]]; then
                printf "  (GNU %s: %s bytes)" "$tool" "$gnu_size"
            fi
            echo ""
        fi
    done
}

# ── Cleanup ───────────────────────────────────────────────────────────────────
cleanup() {
    if $CLEANUP_REPO && [[ -n "$REPO_DIR" ]] && [[ -d "$REPO_DIR" ]]; then
        echo ""
        echo "Cleaning up temporary clone..."
        rm -rf "$REPO_DIR"
    fi
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
    echo "=== fcoreutils Assembly Tool Installer ==="
    echo ""

    check_platform
    install_nasm
    install_binutils
    prepare_repo
    build_tools
    verify_install
    measure_sizes
    cleanup

    echo ""
    echo "Assembly tools installed to: $INSTALL_DIR"
    echo "Add to PATH: export PATH=\"$INSTALL_DIR:\$PATH\""
}

trap cleanup EXIT
main
