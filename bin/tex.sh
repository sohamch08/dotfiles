pdflatex $1tex
pdflatex $1tex
find . -name '*.aux' -exec rm {} \;
find . -name '*.log' -exec rm {} \;
find . -name '*.out' -exec rm {} \;
find . -name '*.gz' -exec rm {}  \;
find . -name '*.toc' -exec rm {} \;
find . -name '*.fdb_latexmk' -exec rm {} \;
find . -name '*.fls' -exec rm {} \;
find . -name '*.bbl' -exec rm {} \;
find . -name '*.blg' -exec rm {} \;
