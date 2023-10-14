#!/bin/bash
# Setup bashrc
if [[ -e "$HOME/.bashrc" ]]; then
    mv $HOME/.bashrc $HOME/.bashrc.bak
    ln -s $(pwd)/.bashrc $HOME/.bashrc
else
    ln -s $(pwd)/.bashrc $HOME/.bashrc
fi

# Setup starship prompt
if [[ -e "$HOME/.config/starship.toml" ]]; then
    mv $HOME/.config/starship.toml $HOME/.config/starship.toml.bak
    ln -s $(pwd)/.config/starship.toml $HOME/.config/starship.toml
else
    ln -s $(pwd)/.config/starship.toml $HOME/.config/starship.toml
fi
# Setup cmus
if [ -d "$HOME/.config/cmus" ]; then
    mv $HOME/.config/cmus $HOME/.config/cmus.bak
    ln -s $(pwd)/.config/cmus $HOME/.config/cmus
else 
    ln -s $(pwd)/.config/cmus $HOME/.config/cmus
fi

# Setup neofetch
if [ -d "$HOME/.config/neofetch" ]; then
    mv $HOME/.config/neofetch $HOME/.config/neofetch.bak
    ln -s $(pwd)/.config/neofetch $HOME/.config/neofetch
else 
    ln -s $(pwd)/.config/neofetch $HOME/.config/neofetch
fi

# Setup nvim
if [ -d "$HOME/.config/nvim" ]; then
    mv $HOME/.config/nvim $HOME/.config/nvim.bak
    ln -s $(pwd)/.config/nvim $HOME/.config/nvim
else 
    ln -s $(pwd)/.config/nvim $HOME/.config/nvim
fi


# Setup rofi
if [ -d "$HOME/.config/rofi" ]; then
    mv $HOME/.config/rofi $HOME/.config/rofi.bak
    ln -s $(pwd)/.config/rofi $HOME/.config/rofi
else 
    ln -s $(pwd)/.config/rofi $HOME/.config/rofi
fi

# Setup bin
if [ -d "$HOME/bin" ]; then
    mv $HOME/bin $HOME/bin.bak
    ln -s $(pwd)/bin $HOME/bin
else 
    ln -s $(pwd)/bin $HOME/bin
fi

