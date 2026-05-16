#!/bin/bash

info()    { echo -e "  \033[0;36m→\033[0m $1"; }
success() { echo -e "  \033[0;32m✔\033[0m \033[0;32m$1\033[0m"; }
warn()    { echo -e "  \033[1;33m⚠\033[0m \033[1;33m$1\033[0m"; }
error()   { echo -e "  \033[0;31m✘\033[0m \033[0;31m$1\033[0m"; }
header()  { echo -e "\n\033[1m\033[0;36m$1\033[0m\n"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

setup_yt_download() {
    header "Setting up yt-download"

    # Check python3 exists
    if ! command -v python3 &>/dev/null; then
        error "python3 not found. Install it first."
        return 1
    fi

    # Create venv
    info "Creating venv at ~/.venv/yt-download..."
    python3 -m venv ~/.venv/yt-download
    success "Venv created"

    # Install yt-dlp
    info "Installing yt-dlp..."
    ~/.venv/yt-download/bin/pip install --quiet yt-dlp
    success "yt-dlp installed"

    # Create history dir (not backed up, lives outside dotfiles)
    mkdir -p ~/.local/share/yt-download
    success "History dir created at ~/.local/share/yt-download"

    # Install script with correct shebang for this machine
    info "Installing script..."
    mkdir -p ~/.local/bin
    VENV_PYTHON="$HOME/.venv/yt-download/bin/python"
    sed "s|#!/usr/bin/env python3|#!${VENV_PYTHON}|" \
        "$DOTFILES_DIR/scripts/yt-download.py" \
        > ~/.local/bin/yt-download
    chmod +x ~/.local/bin/yt-download
    success "Script installed at ~/.local/bin/yt-download"

    # Warn if ~/.local/bin is not in PATH
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        warn "~/.local/bin is not in your PATH"
        warn "Add this to your .bashrc or .zshrc:"
        echo ""
        echo '      export PATH="$HOME/.local/bin:$PATH"'
        echo ""
    fi
}

main() {
    echo ""
    echo -e "\033[1m\033[0;36m╔══════════════════════════════════════╗\033[0m"
    echo -e "\033[1m\033[0;36m║       Dotfiles Install Script        ║\033[0m"
    echo -e "\033[1m\033[0;36m╚══════════════════════════════════════╝\033[0m"

    setup_yt_download

    echo ""
    success "All done! Run: yt-download"
    echo ""
}

main
