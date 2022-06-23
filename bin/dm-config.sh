#!/usr/bin/env bash

declare -a options=(
"alacritty - $HOME/.config/alacritty/alacritty.yml"
"kitty - $HOME/.config/kitty/kitty.conf"
"i3 - $HOME/.config/i3/config"
"polybar - $HOME/.config/polybar/config.ini"
"bashrc - $HOME/.bashrc"
"picom - $HOME/.config/picom.conf"
"starship - $HOME/.config/starship.toml"
"cava - $HOME/.config/cava/config"
"vis - $HOME/.config/vis/config"
"nvim-init - $HOME/.config/nvim/init.vim"
"nvim-set - $HOME/.config/nvim/user/sets.vim"
"nvim-plugin - $HOME/.config/nvim/user/plugins.vim"
"nvim-maps - $HOME/.config/nvim/user/mapping.vim"
"quit"
)
choice=$(printf '%s\n' "${options[@]}" | dmenu -l 5 -i -p "Config: ")
if [[ "$choice" == "quit" ]]
then exit 1
elif [ "$choice" ]; then
    path=$(printf '%s\n' "${choice}" | awk '{print $NF}')
    kitty -e nvim "$path"
fi
