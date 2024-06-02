#!/bin/bash
# Setup bashrc
if [[ -e "$HOME/.bashrc" ]]; then
    mv $HOME/.bashrc $HOME/.bashrc.bak
    ln -s $(pwd)/.bashrc $HOME/.bashrc
else
    ln -s $(pwd)/.bashrc $HOME/.bashrc
fi
# Setup .profile
if [[ -e "$HOME/.profile" ]]; then
    mv $HOME/.profile $HOME/.profile.bak
    ln -s $(pwd)/.profile $HOME/.profile
else
    ln -s $(pwd)/.profile $HOME/.profile
fi

# Setup starship prompt
if [[ -e "$HOME/.config/starship.toml" ]]; then
    mv $HOME/.config/starship.toml $HOME/.config/starship.toml.bak
    ln -s $(pwd)/.config/starship.toml $HOME/.config/starship.toml
else
    ln -s $(pwd)/.config/starship.toml $HOME/.config/starship.toml
fi

# Setup betterlockscreen
if [[ -e "$HOME/.config/betterlockscreenrc" ]]; then
    mv $HOME/.config/betterlockscreenrc $HOME/.config/betterlockscreenrc.bak
    ln -s $(pwd)/.config/betterlockscreenrc $HOME/.config/betterlockscreenrc
else
    ln -s $(pwd)/.config/betterlockscreenrc $HOME/.config/betterlockscreenrc
fi
# Setup alacritty
if [ -d "$HOME/.config/alacritty" ]; then
    mv $HOME/.config/alacritty $HOME/.config/alacritty.bak
    ln -s $(pwd)/.config/alacritty $HOME/.config/alacritty
else
    ln -s $(pwd)/.config/alacritty $HOME/.config/alacritty
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

# Setup i3
if [ -d "$HOME/.config/i3" ]; then
    mv $HOME/.config/i3 $HOME/.config/i3.bak
    ln -s $(pwd)/.config/i3 $HOME/.config/i3
else 
    ln -s $(pwd)/.config/i3 $HOME/.config/i3
fi

# Setup polybar
if [ -d "$HOME/.config/polybar" ]; then
    mv $HOME/.config/polybar $HOME/.config/polybar.bak
    ln -s $(pwd)/.config/polybar $HOME/.config/polybar
else 
    ln -s $(pwd)/.config/polybar $HOME/.config/polybar
fi

# Setup bin
if [ -d "$HOME/bin" ]; then
    mv $HOME/bin $HOME/bin.bak
    ln -s $(pwd)/bin $HOME/bin
else 
    ln -s $(pwd)/bin $HOME/bin
fi
