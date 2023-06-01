option=$(find ~/Books/ -name '*.pdf' -o -name '*.djvu' -o -name '*.epub' | sort | dmenu -i -p 'Books:' -l 20) && okular $option
