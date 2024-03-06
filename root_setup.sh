# Install GNU stow
apt install stow -y

# Install and Setup Starship
if [ ! -f "/usr/local/bin/starship" ]; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
