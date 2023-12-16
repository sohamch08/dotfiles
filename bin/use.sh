#!/bin/bash

base_url="https://www.cs.cmu.edu/~harchol/Probability/chapters/chpt"  # Replace with your base URL

for i in {1..9}; do
    url="$base_url$i.pdf"
    wget "$url"
    getPage=$(cpdf -pages chpt$i.pdf)
    cpdf -add-rectangle "500 30" -pos-left "20 0" -color white chpt$i.pdf 1-$getPage -o 0$i.pdf
done



