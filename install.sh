#!/usr/bin/env bash
#
# clipssh installer
#

set -e

INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
REPO_URL="https://raw.githubusercontent.com/samuellawrentz/clipssh/main/clipssh"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}==>${NC} $1"; }
warn() { echo -e "${YELLOW}Warning:${NC} $1"; }
error() { echo -e "${RED}Error:${NC} $1" >&2; exit 1; }

# Check OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux"* ]]; then
    OS="linux"
else
    error "Unsupported OS: $OSTYPE"
fi

info "Installing clipssh..."

# Check dependencies
if [[ "$OS" == "macos" ]]; then
    if ! command -v pngpaste &> /dev/null; then
        if command -v brew &> /dev/null; then
            info "Installing pngpaste via Homebrew..."
            brew install pngpaste
        else
            error "pngpaste not found. Install with: brew install pngpaste"
        fi
    fi
elif [[ "$OS" == "linux" ]]; then
    if ! command -v xclip &> /dev/null && ! command -v wl-paste &> /dev/null; then
        warn "No clipboard tool found. Install xclip or wl-clipboard"
    fi
fi

# Create install directory
mkdir -p "$INSTALL_DIR"

# Download or copy script
if [[ -f "clipssh" ]]; then
    info "Installing from local file..."
    cp clipssh "$INSTALL_DIR/clipssh"
else
    info "Downloading clipssh..."
    curl -fsSL "$REPO_URL" -o "$INSTALL_DIR/clipssh"
fi

chmod +x "$INSTALL_DIR/clipssh"

# Check if in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    warn "$INSTALL_DIR is not in your PATH"
    echo ""
    echo "Add this to your shell config (~/.zshrc or ~/.bashrc):"
    echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
    echo ""
fi

info "Installed to $INSTALL_DIR/clipssh"
echo ""
echo "Usage:"
echo "  clipssh user@host    # upload screenshot to remote"
echo ""
echo "Set default host:"
echo "  export CLIPSSH_HOST=user@host"
