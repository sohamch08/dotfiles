#!/bin/bash
option=$(find $HOME/Books/ -name '*.pdf' -o -name '*.djvu' -o -name '*.epub' | cut -c 1- | sort | dmenu -i -p 'Books:' -l 20) && okular  "$option"
