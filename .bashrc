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
alias grep='grep --color=always'

### Exa as ls
alias ls='exa -aG --sort=type'
alias ll='exa -aglhHS -s type --icons'

### Git Aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push origin"
alias gcl="git clone"

alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias anime='aniwrapper -t doomone'
alias anup='~/GitHub/anup/target/release/anup'
alias sourced='source ~/.bashrc'
alias cmatrix="unimatrix -s 95 -c blue -f"
alias termicons="~/GitHub/icons-in-terminal/print_icons.sh"
### Devour
alias mpv="devour mpv"
alias zathura="devour zathura"
alias okular="devour okular"
alias evince="devour evince"
alias v="nvim"


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
# lf icons
export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.conf=:\
*config=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.font=ﯔ:\
*.ttf=ﯔ:\
*.otf=ﯔ:\
*.gitconfig=:\
*.git-credentials=:\
*.githubtoken=:\
*.git-credentials=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.ini=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.vimrc=:\
*.nvim=:\
*.viminfo=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.bashrc=:\
*.bash_history=:\
*.bash_profile=:\
*.bash_logout=:\
*.zshrc=:\
*.zshenv=:\
*.zhistory=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg==🖼️:\
*.jpeg=🖼️:\
*.mjpg=🖼️:\
*.mjpeg=🖼️:\
*.gif=🖼️:\
*.bmp=🖼️:\
*.pbm=🖼️:\
*.pgm=🖼️:\
*.ppm=🖼️:\
*.tga=🖼️:\
*.xbm=🖼️:\
*.xpm=🖼️:\
*.tif=🖼️:\
*.tiff=🖼️:\
*.png=🖼️:\
*.svg=🖼️:\
*.svgz=🖼️:\
*.mng=🖼️:\
*.pcx=🖼️:\
*.mov=📽:\
*.mpg=📽:\
*.mpeg=📽:\
*.m2v=📽:\
*.mkv=📽:\
*.webm=📽:\
*.ogm=📽:\
*.mp4=📽:\
*.m4v=📽:\
*.mp4v=📽:\
*.vob=📽:\
*.qt=📽:\
*.nuv=📽:\
*.wmv=📽:\
*.asf=📽:\
*.rm=📽:\
*.rmvb=📽:\
*.flc=📽:\
*.avi=📽:\
*.fli=📽:\
*.flv=📽:\
*.gl=🖼️:\
*.dl=🖼️:\
*.xcf=🖼️:\
*.xwd=🖼️:\
*.yuv=🖼️:\
*.cgm=🖼️:\
*.emf=🖼️:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.djvu=:\
*.epub=:\
*.nix=:\
*.xml=謹:\
*.tex=烈:\
*.txsprofile=烈ףּ:\
*.iso=💿:\
"

eval "$(starship init bash)" 

neofetch 
#--kitty --source ~/.config/neofetch/light.jpg --size 300px --gap 1
# colorscript random
