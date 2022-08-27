pdflatex $1
pdflatex $1
find . -name '*.aux' -exec rm {} \;
find . -name '*.log' -exec rm {} \;
find . -name '*.out' -exec rm {} \;
find . -name '*.gz' -exec rm {}  \;
find . -name '*.toc' -exec rm {} \;
find . -name '*.fdb_latexmk' -exec rm {} \;
find . -name '*.fls' -exec rm {} \;
