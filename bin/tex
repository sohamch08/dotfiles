dest=~/Documents/.latex_build
mkdir -p $dest
pdflatex $1
pdflatex $1 > $1.build
mv *.log $dest
mv *.out $dest
mv *.gz  $dest
mv *.aux $dest
mv *.toc $dest
mv *.fdb_latexmk $dest
mv *.fls $dest
mv $1.build $dest
