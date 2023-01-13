#! /bin/bash

# Weird Packer Shenanigans
if [ -f "/home/$USER/.config/nvim/lua/$USER/packer.lua" ]; then
    echo "Running PackerSync"
    nvim /home/$USER/.config/nvim/lua/$USER/packer.lua --headless \
        -c 'so' -c 'PackerSync' 2>/dev/null \
	#& 
    #pid=$!
    #sleep 30
    #kill $pid
fi
