read $file
pdffile=$file.pdf
man -Tpdf $file > $pdffile
mv $pdffile ~/man2pdf
