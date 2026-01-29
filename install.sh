#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

# Backup existing configs if they're not already symlinks
[ -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -e ~/.wezterm.lua ] && [ ! -L ~/.wezterm.lua ] && mv ~/.wezterm.lua ~/.wezterm.lua.bak

# Create symlinks
mkdir -p ~/.config
ln -sf "$DOTFILES/nvim" ~/.config/nvim
ln -sf "$DOTFILES/wezterm/wezterm.lua" ~/.wezterm.lua

echo "Dotfiles installed!"
