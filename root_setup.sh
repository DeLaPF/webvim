cp -r /root/.cargo /home/$1/
chown -R $1:users /home/$1/.cargo
mkdir -p /home/$1/.local/share/
cp -r /root/.local/share/bob /home/$1/.local/share/
chown -R $1:users /home/$1/.local
