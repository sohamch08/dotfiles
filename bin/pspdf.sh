#!/bin/bash

input_directory="$(pwd)"
output_directory="output_pdf_files"

mkdir -p "$output_directory"

for ps_file in "$input_directory"/*.ps; do
    base_name=$(basename "$ps_file" .ps)
    pdf_file="$output_directory/$base_name.pdf"
    
    ps2pdf -dPDFSETTINGS=/prepress -dColorImageResolution=300 -dGrayImageResolution=300 -dMonoImageResolution=1200 "$ps_file" "$pdf_file"
    
    echo "Converted: $ps_file -> $pdf_file"
done

echo "Batch conversion complete!"
