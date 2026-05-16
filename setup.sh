#!/bin/bash

info()    { echo -e "  \033[0;36m→\033[0m $1"; }
success() { echo -e "  \033[0;32m✔\033[0m \033[0;32m$1\033[0m"; }
warn()    { echo -e "  \033[1;33m⚠\033[0m \033[1;33m$1\033[0m"; }
error()   { echo -e "  \033[0;31m✘\033[0m \033[0;31m$1\033[0m"; }
header()  { echo -e "\n\033[1m\033[0;36m$1\033[0m\n"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Symlink helper ─────────────────────────────────────────────────────────────
# Usage: symlink <source relative to dotfiles> <destination>

symlink() {
    local src="$DOTFILES_DIR/$1"
    local dst="$2"

    if [ ! -e "$src" ]; then
        warn "Source not found, skipping: $src"
        return
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mv "$dst" "${dst}.bak"
        warn "Backed up existing: $dst → ${dst}.bak"
    fi

    ln -s "$src" "$dst"
    success "$dst"
}

# ── Dotfiles ──────────────────────────────────────────────────────────────────

setup_dotfiles() {
    header "Symlinking dotfiles"

    symlink ".bashrc"                    "$HOME/.bashrc"
    symlink ".profile"                   "$HOME/.profile"
    symlink ".config/starship.toml"      "$HOME/.config/starship.toml"
    symlink ".config/alacritty"          "$HOME/.config/alacritty"
    symlink ".config/cmus"               "$HOME/.config/cmus"
    symlink ".config/neofetch"           "$HOME/.config/neofetch"
    symlink ".config/nvim"               "$HOME/.config/nvim"
    symlink ".config/rofi"               "$HOME/.config/rofi"
    symlink "bin"                        "$HOME/bin"
}

# ── yt-download ───────────────────────────────────────────────────────────────

setup_yt_download() {
    header "Setting up yt-download"

    if ! command -v python3 &>/dev/null; then
        error "python3 not found. Install it first."
        return 1
    fi

    info "Creating venv at ~/.venv/yt-download..."
    python3 -m venv ~/.venv/yt-download
    success "Venv created"

    info "Installing yt-dlp..."
    ~/.venv/yt-download/bin/pip install --quiet yt-dlp
    success "yt-dlp installed"

    mkdir -p ~/.local/share/yt-download
    success "History dir created at ~/.local/share/yt-download"

    info "Installing script..."
    mkdir -p ~/.local/bin
    VENV_PYTHON="$HOME/.venv/yt-download/bin/python"
    sed "s|#!/usr/bin/env python3|#!${VENV_PYTHON}|" \
        "$DOTFILES_DIR/scripts/yt-download.py" \
        > ~/.local/bin/yt-download
    chmod +x ~/.local/bin/yt-download
    success "Script installed at ~/.local/bin/yt-download"

    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        warn "~/.local/bin is not in your PATH — add it to your .bashrc"
    fi
}

# ── Main ──────────────────────────────────────────────────────────────────────

main() {
    echo ""
    echo -e "\033[1m\033[0;36m╔══════════════════════════════════════╗\033[0m"
    echo -e "\033[1m\033[0;36m║        Dotfiles Setup Script         ║\033[0m"
    echo -e "\033[1m\033[0;36m╚══════════════════════════════════════╝\033[0m"

    setup_dotfiles
    setup_yt_download

    echo ""
    success "All done! Restart your shell or run: source ~/.bashrc"
    echo ""
}

main
