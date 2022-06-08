# Use powerline
USE_POWERLINE="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi


# Aliases

### Pacman, Yay, Paru
alias inst='sudo pacman -Sy'
alias pcup='sudo pacman -Syu'                  # update only standard pkgs
alias pacuup='sudo pacman -Syyu'                # Refresh pkglist & update standard pkgs
alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)' # remove orphaned packages

### Exa as ls
alias ls='exa -aG --sort=type'
alias ll='exa -aglhHS -s type --icons'

### LaTeX
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias cdlatex='cd ~/Arna/LaTeX/CMI/B.Sc/Sem\ 2'

alias anicli='~/GitHub/ani-cli/ani-cli'
alias anup='~/GitHub/anup/target/release/anup'

alias sourced='source ~/.bashrc'
alias cat='bat'
alias cmatrix="unimatrix -s 95 -c blue -f"

# Devour
alias mpv="devour mpv"
alias zathura="devour zathura"
alias okular="devour okular"

#eval "$(starship init zsh)"
. "$HOME/.cargo/env"
neofetch
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

