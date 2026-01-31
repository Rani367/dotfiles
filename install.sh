#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

# Check for required commands
command -v git >/dev/null 2>&1 || { echo "git is required but not installed."; exit 1; }

# Clone repo if it doesn't exist
if [ ! -d "$DOTFILES" ]; then
  git clone https://github.com/Rani367/dotfiles "$DOTFILES"
fi

# Zed config location (macOS)
ZED_CONFIG="$HOME/Library/Application Support/Zed"

# Backup existing configs if they're not already symlinks
[ -e "$ZED_CONFIG/settings.json" ] && [ ! -L "$ZED_CONFIG/settings.json" ] && mv "$ZED_CONFIG/settings.json" "$ZED_CONFIG/settings.json.bak"
[ -e "$ZED_CONFIG/keymap.json" ] && [ ! -L "$ZED_CONFIG/keymap.json" ] && mv "$ZED_CONFIG/keymap.json" "$ZED_CONFIG/keymap.json.bak"
[ -e "$ZED_CONFIG/tasks.json" ] && [ ! -L "$ZED_CONFIG/tasks.json" ] && mv "$ZED_CONFIG/tasks.json" "$ZED_CONFIG/tasks.json.bak"
[ -e ~/.wezterm.lua ] && [ ! -L ~/.wezterm.lua ] && mv ~/.wezterm.lua ~/.wezterm.lua.bak
[ -e ~/.ignore ] && [ ! -L ~/.ignore ] && mv ~/.ignore ~/.ignore.bak

# Create symlinks
mkdir -p "$ZED_CONFIG"
ln -sf "$DOTFILES/zed/settings.json" "$ZED_CONFIG/settings.json"
ln -sf "$DOTFILES/zed/keymap.json" "$ZED_CONFIG/keymap.json"
ln -sf "$DOTFILES/zed/tasks.json" "$ZED_CONFIG/tasks.json"
ln -sf "$DOTFILES/wezterm/wezterm.lua" ~/.wezterm.lua
ln -sf "$DOTFILES/.ignore" ~/.ignore

echo "Dotfiles installed!"
