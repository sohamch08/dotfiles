cd $HOME/Books/
option=$(find . -name '*.pdf' -o -name '*.djvu' -o -name '*.epub' | cut -c 3- | sort | dmenu -i -p 'Books:' -l 20) && okular $HOME/Books/"$option"
