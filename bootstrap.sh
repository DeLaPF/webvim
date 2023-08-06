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

# Add permissions to scripts
chmod +x /usr/local/bin/*.sh

# Extra Setup
echo "Looking for setup.sh..."
if [ -f "/usr/local/bin/setup.sh" ]; then
    echo "Setup Found"
    setup.sh
else
    echo "Skipping. Setup Not Found"
fi

echo "Starting Wetty Server"
wetty

exit
