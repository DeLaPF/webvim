#!/bin/bash

user=${USER:=dev}
password=${PASSWORD:=dev}
wsname=${WORKSPACE_NAME:=workspace}

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
setup=/home/$user/$wsname/setup.sh
if [ -f "$setup" ]; then
    echo "Setup Found"
    chmod +x $setup && $setup
fi

wetty

exit
