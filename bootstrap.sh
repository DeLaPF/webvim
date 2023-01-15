#!/bin/bash

user=${USER:=dev}
password=${PASSWORD:=dev}

# Set Up New User If they Don't Already Exist
getent passwd $user  > /dev/null
if [ ! $? -eq 0 ]; then
    useradd $user
    echo "$user:$password" | chpasswd
    echo "root:$password" | chpasswd
    adduser $user sudo
    chsh -s /bin/zsh $user
    chown -R $user /home/$user
fi

# Extra Setup
if [ -f "/usr/local/bin/setup.sh" ]; then
    echo "Setup Found"
    setup.sh
fi

wetty

exit
