#!/bin/bash

echo "Running Custom Setup"

# Dotfile Config
dot_dir="/home/$USER/.dotfiles"
if [ ! -d $dot_dir ]; then
    git clone git@github.com:DeLaPF/.dotfiles.git $dot_dir
    $(cd $dot_dir && stow nvim scripts shell)
fi

# TMUX Plugins Config
tmux_plug_dir="/home/$USER/.tmux/plugins"
if [ ! -d $tmux_plug_dir ]; then
    git clone https://github.com/tmux-plugins/tpm.git "${tmux_plug_dir}/tpm"
fi

# ZSH Plugins Config
zsh_plug_dir="/home/$USER/.zsh/plugins"
if [ ! -d $zsh_plug_dir ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
	    "${zsh_plug_dir}/zsh-syntax-highlighting"
fi

exit
