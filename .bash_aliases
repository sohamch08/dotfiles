# Aliases

### Apt
alias pcup='sudo apt update -y && sudo apt upgrade -y'

#alias netshare='sudo killall dnsmasq; sudo hotspot wlan0 start'  # Start Hotspot
#alias netshstop='sudo hotspot wlan0 stop'        # Stop Hotspot


### Exa as ls
alias ls='exa -aG --color=always --group-directories-first --sort=type'
alias sl='ls'
alias ll='exa -aglhHS -s type'

### Git Aliases
alias gc="git clone"
alias gpa="git add -A && git commit -m updated && git push origin"

### Rclone
alias rcg="rclone config"
alias rcc="rclone copy -P"
alias rcs="rclone sync -P"


### Devour
#alias mpv="devour mpv"
#alias zathura="devour zathura"
#alias evince="devour evince"

### cd nevigation
alias cdlatex="cd ~/Arna/academic-notes/"
alias cdx="cd ~/Arna/academic-notes/Course\ Lecture\ Notes/Expander\ Graphs/"
alias cdac="cd ~/Arna/academic-notes/Course\ Lecture\ Notes/Algebra\ and\ Computation/"
alias cdact="cd ~/Arna/academic-notes/Course\ Lecture\ Notes/Coding\ Theory/"
alias cdpar="cd ~/Arna/academic-notes/Course\ Lecture\ Notes/Parallel\ Algorithm\ and\ Complexity/"
alias cddotfiles="cd ~/Github/dotfiles/"
alias cdacad="cd ~/Arna/Markdown/My-Academic-Works/"
alias cdq="cd ~/Arna/Coding/Qiskit"
alias cdweb="cd ~/Arna/Coding/Web\ Coding/sohamch08.github.io"

### Cat
alias c='cat'
alias b='btop --utf-force'

### Others
alias sourced='source ~/.bashrc'
alias del='shred -uzn3'
alias rmdir='rm -rf'
alias info=viminfo
alias v="nvim"
##alias wifi="wine $HOME/.wine/drive_c/Program\ Files\ \(x86\)/Connector/Connector.exe"
alias man2pdf='f() { man -Tpdf $1 > $1.pdf && notify-send "Created $1 Man Page to $1.pdf" -t 2000 && mv $1.pdf ~/man2pdf; unset -f f; }; f'
#alias pdf2jpg='pdftoppm -jpeg -r 1200'
# alias touchtoggle="xinput-toggle.sh 'ELAN071A:00 04F3:30FD Touchpad'"
# srccpy
alias scrh='scrcpy --lock-video-orientation=3'
alias scrhi='scrcpy --lock-video-orientation=1'
alias scrv='scrcpy --lock-video-orientation=0'
alias scrvi='scrcpy --lock-video-orientation=2'
#alias bluetoothrestart='sudo systemctl restart bluetooth'
#alias j='f() { input=$1; javac $input; java $(echo $input | cut -d '.' -f 1); unset -f f; }; f '
#alias spot='f() { spotdl $1 -p "/home/sohamch/Downloads/spotdl/{artists}/{album}/{title}-{artist}.{ext}"; unset -f f; }; f '
alias flac2mp3='f() { input=$1; ffmpeg -y -i $input -codec:a libmp3lame -q:a 0 -map_metadata 0 -id3v2_version 3 -write_id3v1 1 ${input}.mp3; unset -f f; }; f '
alias pstopdf='f() { input=$1; gs -sDEVICE=pdfwrite -sOutputFile=${input}.pdf -dBATCH -dNOPAUSE ${input} ; unset -f f; }; f '
alias mdview='f() { input=$1; pandoc $input > $input.html ; lynx $input.html; unset -f f; }; f'
alias djvu2pdf='f() { input=$1; ddjvu -format=pdf -quality=85 -verbose "$1" "$1.pdf"; unset -f f; }; f'
#alias debinstall='f () { input=$1; sudo debtap $input; sudo pacman -U $input.tar.zst; unset -f f; }; f'
alias python="python3"
alias spotdl="python -m spotdl --bitrate 320k"
alias screenDarkOff="xset dpms 0 0 0 && xset s noblank  && xset s off"
