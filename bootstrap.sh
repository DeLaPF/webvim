#!/bin/bash

user=${USER:=dev}
password=${PASSWORD:=dev}

# Set Up New User If they Don't Already Exist
getent passwd $user  > /dev/null
if [ ! $? -eq 0 ]; then
    useradd -g users -G sudo -s /bin/zsh -m $user
    echo "$user:$password" | chpasswd
    echo "root:$password" | chpasswd
    chown $user /home/$user
fi

# Add permissions to scripts
chmod +x /usr/local/bin/*.sh

# Extra Setup
## Root
echo "Looking for root_setup.sh..."
if [ -f "/usr/local/bin/root_setup.sh" ]; then
    echo "Root Setup Found"
    root_setup.sh
else
    echo "Skipping. Root Setup Not Found"
fi
echo "Looking for user_setup.sh..."
## User
if [ -f "/usr/local/bin/user_setup.sh" ]; then
    echo "User Setup Found"
    cd /home/$user
    su $user -c user_setup.sh
    cd ~
else
    echo "Skipping. User Setup Not Found"
fi

echo "Starting Wetty Server"
wetty

exit
