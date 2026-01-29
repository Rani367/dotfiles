#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

# Clone repo if it doesn't exist
if [ ! -d "$DOTFILES" ]; then
  git clone https://github.com/Rani367/dotfiles "$DOTFILES"
fi

# Backup existing configs if they're not already symlinks
[ -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -e ~/.wezterm.lua ] && [ ! -L ~/.wezterm.lua ] && mv ~/.wezterm.lua ~/.wezterm.lua.bak
[ -e ~/.ignore ] && [ ! -L ~/.ignore ] && mv ~/.ignore ~/.ignore.bak

# Create symlinks
mkdir -p ~/.config
ln -sf "$DOTFILES/nvim" ~/.config/nvim
ln -sf "$DOTFILES/wezterm/wezterm.lua" ~/.wezterm.lua
ln -sf "$DOTFILES/.ignore" ~/.ignore

echo "Dotfiles installed!"

# Install neovim plugins (runs headless, auto-closes when done)
echo "Installing Neovim plugins..."
nvim --headless "+Lazy! sync" +qa

echo "Done!"
