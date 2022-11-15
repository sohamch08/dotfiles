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


viminfo () {
    nvim -R -M -c "Info $1 $2" +only
}
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
alias netshare='sudo killall dnsmasq; sudo hotspot wlan0 start'  # Start Hotspot
alias netshstop='sudo hotspot wlan0 stop'        # Stop Hotspot

### Grep 
alias gr='grep --color=always'
alias egr='egrep --color=always'

### Exa as ls
alias ls='exa -aG --color=always --group-directories-first --sort=type'
alias sl='ls'
alias ll='exa -aglhHS -s type --icons'

### Git Aliases
alias ga="git add"
alias gc="git commit -m"
alias gd='git diff'
alias gcl="git clone"
alias gp="git push origin"
alias gpa="git add -A && git commit -m updated && git push origin"
alias gs="git status"

### Devour
alias mpv="devour mpv"
alias zathura="devour zathura"
alias okular="devour okular"
alias evince="devour evince"

### cd nevigation
alias ,='cd -'
alias ..='cd ..' 
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
alias cd5='cd ../../../../..'
alias cdlatex='cd ~/Arna/LaTeX/CMI/B.Sc/Sem\ 3'
alias cddotfiles="cd ~/GitHub/dotfiles/"

### Kdeconncet
alias kdec='kdeconnect-cli'
alias kdecpingmsg='kdeconnect-cli --ping-msg'
alias kdecmusname='kdeconnect-cli --ping-msg "$(cmus-remote -Q | grep "tag title" | cut -c 11-)" -n SOHAM_POCO_X3'

### Cat 
alias c='cat'
alias b='bat'

### Others
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias anime='aniwrapper -t doomone'
alias anup='~/GitHub/anup/target/release/anup'
alias sourced='source ~/.bashrc'
alias cmatrix="unimatrix -s 95 -c blue -f"
# alias termicons="~/GitHub/icons-in-terminal/print_icons.sh"
alias del='shred -uzn3'
alias rmdir='rm -rf'
alias info=viminfo
alias v="nvim"
alias wifi="wine $HOME/.wine/drive_c/Program\ Files\ \(x86\)/Connector/Connector.exe"
alias man2pdf='f() { man -Tpdf $1 > $1.pdf && notify-send "Created $1 Man Page to $1.pdf" -t 2000 && mv $1.pdf ~/man2pdf; unset -f f; }; f '
alias touchtoggle="xinput-toggle.sh 'ELAN071A:00 04F3:30FD Touchpad'"
alias grubcorrect="sudo grub-install"
# srccpy
alias scrh='scrcpy --lock-video-orientation=3'
alias scrhi='scrcpy --lock-video-orientation=1'
alias scrv='scrcpy --lock-video-orientation=0'
alias scrvi='scrcpy --lock-video-orientation=2'
alias bluetoothrestart='sudo systemctl restart bluetooth'



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


# Environment Variables
export BW_SESSION="nhqJP42VgvZl682uMvTHS+QRPW0Cp5t+JZtRP6KMKz6vVpuFTTquc6xxnGgxiYQyS9pw2hjnaD8pGSjdIVesPQ=="
export PASSWORD_STORE_ENABLE_EXTENSIONS="true"
export TERM=xterm-256color
export EDITOR=nvim
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export EXA_ICON_SPACING=2
export PS2=""
export BAT_THEME="Monokai Extended"
export ANDROID_HOME="$XDG_DATA_HOME"/android
export HISTFILE="${XDG_STATE_HOME}"/bash/history


eval "$(starship init bash)"
# function _update_ps1() {
#     PS1=$(powerline-shell $?)
# }
#
# if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#     PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi

neofetch 
#--kitty --source ~/.config/neofetch/light.jpg --size 300px --gap 1

