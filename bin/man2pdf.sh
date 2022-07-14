man -Tpdf $1 > $1.pdf
notify-send "Created $1 Man Page to $1.pdf" -t 2000
mv $1.pdf ~/man2pdf
