#!/bin/bash

# Run this from inside ~/projects/dotfiles

info()    { echo -e "  \033[0;36m→\033[0m $1"; }
success() { echo -e "  \033[0;32m✔\033[0m \033[0;32m$1\033[0m"; }
warn()    { echo -e "  \033[1;33m⚠\033[0m \033[1;33m$1\033[0m"; }
error()   { echo -e "  \033[0;31m✘\033[0m \033[0;31m$1\033[0m"; }
header()  { echo -e "\n\033[1m\033[0;36m$1\033[0m\n"; }

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Cleanup: delete all .bak files in the repo ────────────────────────────────

cleanup_bak() {
    header "Removing .bak files from repo"
    while IFS= read -r -d '' f; do
        rm -f "$f"
        success "Deleted $f"
    done < <(find "$DOTFILES" -name "*.bak" -not -path "$DOTFILES/.git/*" -print0)
}

# ── Move file into repo, then symlink back ────────────────────────────────────
# Usage: adopt <source in $HOME> <destination relative to repo root>

adopt() {
    local src="$HOME/$1"
    local rel="$2"
    local dst="$DOTFILES/$rel"
    local dst_dir
    dst_dir="$(dirname "$dst")"

    # Source must exist
    if [ ! -e "$src" ]; then
        warn "Not found, skipping: $src"
        return
    fi

    # If it's already a symlink pointing to the right place, skip
    if [ -L "$src" ] && [ "$(readlink -f "$src")" = "$dst" ]; then
        warn "Already symlinked correctly: $src"
        return
    fi

    mkdir -p "$dst_dir"

    # If something already exists in repo at dst, back it up
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mv "$dst" "${dst}.bak"
        warn "Backed up existing repo file: ${dst}.bak"
    fi

    # Move from home into repo
    mv "$src" "$dst"
    info "Moved $src → $dst"

    # Symlink back
    ln -s "$dst" "$src"
    success "Symlinked $src → $dst"
}

# ── Symlink only (for files already in repo) ──────────────────────────────────
# Usage: symlink <path relative to repo> <destination in $HOME>

symlink() {
    local src="$DOTFILES/$1"
    local dst="$HOME/$2"
    local dst_dir
    dst_dir="$(dirname "$dst")"

    if [ ! -e "$src" ]; then
        warn "Source not in repo, skipping: $src"
        return
    fi

    # Already correct
    if [ -L "$dst" ] && [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
        warn "Already symlinked: $dst"
        return
    fi

    mkdir -p "$dst_dir"

    # Back up if something exists
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mv "$dst" "${dst}.bak"
        warn "Backed up: ${dst}.bak"
    fi

    ln -s "$src" "$dst"
    success "Symlinked $dst → $src"
}

# ── Main ──────────────────────────────────────────────────────────────────────

main() {
    echo ""
    echo -e "\033[1m\033[0;36m╔══════════════════════════════════════╗\033[0m"
    echo -e "\033[1m\033[0;36m║        Dotfiles Migration Script     ║\033[0m"
    echo -e "\033[1m\033[0;36m╚══════════════════════════════════════╝\033[0m"

    # Step 1: clean up .bak files already in repo
    cleanup_bak

    # Step 2: adopt files from home into repo + symlink back
    # These are files/dirs that currently live in ~ or ~/.config
    # and need to be moved into the repo then symlinked
    header "Adopting files into repo"

    adopt ".bashrc"                    ".bashrc"
    adopt ".bash_aliases"              ".bash_aliases"
    adopt ".bash_profile"              ".bash_profile"
    adopt ".profile"                   ".profile"
    adopt ".config/alacritty"          ".config/alacritty"

    # Step 3: symlink files already in repo that don't have a home symlink yet
    header "Symlinking existing repo files"

    symlink ".zshrc"                   ".zshrc"
    symlink ".config/alacritty"        ".config/alacritty"
    symlink ".config/cmus"             ".config/cmus"
    # symlink ".config/nvim"             ".config/nvim"
    symlink ".config/rofi"             ".config/rofi"
    symlink ".config/kitty"            ".config/kitty"
    symlink ".config/dunst"            ".config/dunst"
    symlink ".config/cava"             ".config/cava"
    symlink "bin"                      "bin"

    echo ""
    success "Done! You may want to run: git add -A && git status"
    echo ""
}

main
