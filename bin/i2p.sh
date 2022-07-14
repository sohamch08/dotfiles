info $1 > $1
enscript -B -o $1.ps $1
ps2pdf $1.ps ${1}_info.pdf
mv ${1}_info.pdf $HOME/man2pdf/
mv $1{,.ps} $HOME/man2pdf/
