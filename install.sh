#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"

declare -A LINKS=(
    ["$HOME/.config/nvim"]="$DOTFILES/nvim"
    ["$HOME/.config/zed"]="$DOTFILES/zed"
    ["$GHOSTTY_DIR/config"]="$DOTFILES/ghostty/config"
    ["$GHOSTTY_DIR/shaders"]="$DOTFILES/ghostty/shaders"
)

for target in "${!LINKS[@]}"; do
    source="${LINKS[$target]}"
    if [ -e "$target" ] || [ -L "$target" ]; then
        rm -rf "$target"
    fi
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    echo "linked $target -> $source"
done
