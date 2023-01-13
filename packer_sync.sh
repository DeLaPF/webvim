#! /bin/bash

# Get name of user owning packer.lua
echo "Please enter the name of the user in 'nvim/lua/<user>/packer.lua'"
read user
echo "Looking for 'nvim/$user/packer.lua'"

# Weird Packer Shenanigans
if [ -f "$HOME/.config/nvim/lua/$user/packer.lua" ]; then
    echo "Running 'PackerSync' on 'nvim/$user/packer.lua'"
    echo "Please close with Ctrl-c after about 5-10s"
    nvim $HOME/.config/nvim/lua/$user/packer.lua --headless \
        -c 'so' -c 'PackerSync' 2>/dev/null \
else
    echo "Error: 'nvim/$user/packer.lua' not found"
fi

exit
