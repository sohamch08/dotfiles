# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc


[ -f "/home/sohamch/.ghcup/env" ] && source "/home/sohamch/.ghcup/env" # ghcup-env

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

alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias anicli='~/GitHub/ani-cli/ani-cli'
alias anup='~/GitHub/anup/target/release/anup'
alias sourced='source ~/.bashrc'
alias cat='bat'
alias cmatrix="unimatrix -s 95 -c blue -f"

### Devour
alias mpv="devour mpv"
alias zathura="devour zathura"
alias okular="devour okular"

# Specific Directories
alias cdlatex='cd ~/Arna/LaTeX/CMI/B.Sc/Sem\ 2'
alias cddotfiles="cd ~/GitHub/dotfiles/"

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# MAN PAGE COLORIZE
export LESS_TERMCAP_mb=$'\E[01;31m'             # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'             # begin bold
export LESS_TERMCAP_me=$'\E[0m'                 # end mode
export LESS_TERMCAP_se=$'\E[0m'                 # end standout-mode                 
export LESS_TERMCAP_so=$'\E[01;44;33m'          # begin standout-mode - info box                              
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[01;32m'             # begin underline
#export MANPAGER="/usr/bin/most -s"             # color using most
eval "$(zoxide init bash)"
eval "$(starship init bash)" 
. "$HOME/.cargo/env"


# neofetch
colorscript random
