dest=~/Documents/.latex_build/
pdflatex $1
pdflatex $1 > $1.build
find . -name *.aux -exec mv {} $dest \;
find . -name *.log -exec mv {} $dest \;
find . -name *.out -exec mv {} $dest \;
find . -name *.gz -exec mv {}  $dest \;
find . -name *.toc -exec mv {} $dest \;
find . -name *.fdb_latexmk -exec mv {} $dest \;
find . -name *.fls -exec mv {} $dest \;
find . -name $1.build -exec mv {} $dest \;
