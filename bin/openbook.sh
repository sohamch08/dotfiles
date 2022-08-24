option=$(find ~/Books/ -name '*.pdf' -o -name '*.djvu' -o -name '*.epub' | dmenu -i -p 'Books:' -l 20) && okular $option
