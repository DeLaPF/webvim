#!/bin/bash

echo "Running Custom Setup"

# TODO: Pull '.' files from github 

# TMUX Config
if [ ! -f "/home/$USER/.tmux.conf" ]; then
    ln -s /home/$USER/.config/.tmux.conf /home/$USER/.tmux.conf
fi
if [ ! -d "/home/$USER/.tmux" ]; then
    git clone https://github.com/tmux-plugins/tpm /home/$USER/.tmux/plugins/tpm
fi

# ZSH Config
if [ ! -f "/home/$USER/.zshrc" ]; then
    ln -s /home/$USER/.config/.zshrc /home/$USER/.zshrc
fi
if [ ! -f "/usr/local/bin/starship" ]; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
if [ ! -d "/home/$USER/.zsh" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        /home/$USER/.zsh/plugins/zsh-syntax-highlighting
fi

# Nvim Config
if [ ! -d "/home/$USER/.local/share/nvim/site" ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        /home/$USER/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# Ensure proper ownership of all newly added files
chown -R $USER /home/$USER

exit
