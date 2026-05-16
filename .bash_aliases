alias sourced="source ~/.bashrc"
alias bashedit="nvim ~/.bashrc"
alias aliasedit="nvim ~/.bash_aliases"

# eza aliases
alias ls='eza -aG --color=always --group-directories-first --sort=type --icons=always'
alias sl='ls'
alias ll='eza -lghH --color=always --group-directories-first --sort=type --icons=always --git'
alias lla='eza -alghH --color=always --group-directories-first --sort=type --icons=always --git'
alias lt='eza -aT --color=always --group-directories-first --icons=always'
alias lt2='eza -aT --level=2 --color=always --group-directories-first --icons=always'
alias lS='eza -alghH --color=always --group-directories-first --sort=size --icons=always'
alias lm='eza -alghH --color=always --group-directories-first --sort=modified --icons=always'


# ─── RCLONE GENERAL ALIASES ───────────────────────────────────────────────────

# List all configured remotes
alias rcremotes='rclone listremotes'

# Show rclone config
alias rcconfig='sed "s/token = .*/token = ██████████████████████████████/" ~/.config/rclone/rclone.conf | bat --language=ini'
# alias rcconfig='bat ~/.config/rclone/rclone.conf'

# Edit rclone config
alias rcedit='nvim ~/.config/rclone/rclone.conf'

# Show rclone log
alias rclog='tail -f ~/.config/rclone/rclone.log'

# Clear rclone log
alias rclog-clear='> ~/.config/rclone/rclone.log'

# Show all rclone aliases and usage
rchelp() {
    bat --language=bash --style=plain <<'EOF'
# ── GENERAL ──────────────────────────────────────────────
rchelp                                  # Show this help
rcremotes                               # List all configured remotes
rcconfig                                # Show rclone config
rcedit                                  # Edit config in nvim
rclog                                   # Live tail of log
rclog-clear                             # Clear log

# ── LISTING ──────────────────────────────────────────────
rcls visa:                              # List files on remote
rctree gdrive:                          # Tree view via eza

# ── MOUNT ────────────────────────────────────────────────
rcmount visa:                           # Mount remote
rcumount visa:                          # Unmount remote
# Mounts to: ~/.rclone-mounts/<remotename>

# ── TRANSFER ─────────────────────────────────────────────
rcpull "visa:Visa Application" ~/local  # Download remote → local
rcpush ~/local "visa:Visa Application"  # Upload local → remote

# ── SYNC (DESTRUCTIVE) ───────────────────────────────────
rcsync-down "visa:Visa Application" ~/local  # Mirror remote → local
rcsync-up ~/local "visa:Visa Application"    # Mirror local → remote
# ⚠ Always dry run first!

# ── DRY RUN (SAFE PREVIEW) ───────────────────────────────
rcdry-down "visa:Visa Application" ~/local   # Preview download
rcdry-up ~/local "visa:Visa Application"     # Preview upload

# ── STATUS (GIT-LIKE) ────────────────────────────────────
rcgit "visa:Visa Application" ~/local        # Full git-like summary
rcstatus "visa:Visa Application" ~/local     # Diff with symbols
rcremote-only "visa:Visa Application" ~/local  # Remote ahead
rclocal-only "visa:Visa Application" ~/local   # Local ahead
rcdiff "visa:Visa Application" ~/local         # Files that differ

# Symbols:  = identical  < local ahead  > remote ahead  * different
EOF
}

# ─── RCLONE FUNCTIONS (remote specific) ───────────────────────────────────────

# List files on any remote (human readable)
rcls() {
    rclone ls "$1" --human-readable
}

# Tree view of any remote via eza (mounts temporarily)
rctree() {
    local remote="$1"
    local mount="$HOME/${remote}-mounts"
    mkdir -p "$mount"
    rclone mount "$remote:" "$mount" --daemon --vfs-cache-mode full
    lt "$mount"
}

# Mount a remote
rcmount() {
    local remote="$1"
    local mount="$HOME/${remote}-mounts/"
    mkdir -p "$mount"
    rclone mount "$remote:" "$mount" --daemon --vfs-cache-mode full
    echo "Mounted $remote: at $mount"
}

# Unmount a remote
rcumount() {
    local remote="$1"
    local mount="$HOME/${remote}-mounts/"
    fusermount -u "$mount" && echo "Unmounted $remote:"
}

# Copy remote → local
rcpull() {
    rclone copy "$1" "$2" --progress
}

# Copy local → remote
rcpush() {
    rclone copy "$1" "$2" --progress
}

# Sync remote → local
rcsync-down() {
    rclone sync "$1" "$2" --progress
}

# Sync local → remote
rcsync-up() {
    rclone sync "$1" "$2" --progress
}

# Dry run: preview download
rcdry-down() {
    rclone copy "$1" "$2" --dry-run --progress
}

# Dry run: preview upload
rcdry-up() {
    rclone copy "$1" "$2" --dry-run --progress
}

# ─── RCLONE STATUS (git-like) ─────────────────────────────────────────────────

# Full status with symbols
rcstatus() {
    echo "=  identical"
    echo "<  only on local (local ahead)"
    echo ">  only on remote (remote ahead)"
    echo "*  different on both"
    echo "──────────────────────────────"
    rclone check "$1" "$2" --combined -
}

# Files only on remote
rcremote-only() {
    echo "Remote ahead — files only on $1:"
    rclone check "$1" "$2" --missing-on-destination -
}

# Files only on local
rclocal-only() {
    echo "Local ahead — files only in $2:"
    rclone check "$1" "$2" --missing-on-source -
}

# Files that differ
rcdiff() {
    echo "Files that differ between $1 and $2:"
    rclone check "$1" "$2" --differ -
}

# Full git-like summary
rcgit() {
    local remote="$1"
    local local_path="$2"
    echo ""
    echo "📡 Remote: $remote"
    echo "💻 Local:  $local_path"
    echo "──────────────────────────────────────"

    echo ""
    echo "🔼 Local ahead (only on local):"
    rclone check "$remote" "$local_path" --missing-on-source - 2>/dev/null || echo "  none"

    echo ""
    echo "🔽 Remote ahead (only on remote):"
    rclone check "$remote" "$local_path" --missing-on-destination - 2>/dev/null || echo "  none"

    echo ""
    echo "📝 Different on both:"
    rclone check "$remote" "$local_path" --differ - 2>/dev/null || echo "  none"

    echo "──────────────────────────────────────"
}
