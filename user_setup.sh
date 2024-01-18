#!/bin/bash

echo "Running Custom Setup"

# Pull .config files from github if dir doesn't already exist
if [ ! -d "/home/$USER/.config" ]; then
    git clone https://github.com/DeLaPF/.config.git /home/$USER/.config
fi

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
if [ ! -d "/home/$USER/.zsh" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        /home/$USER/.zsh/plugins/zsh-syntax-highlighting
fi

exit
