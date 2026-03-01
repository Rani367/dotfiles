#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"

link() {
    if [ -e "$2" ] || [ -L "$2" ]; then
        rm -rf "$2"
    fi
    mkdir -p "$(dirname "$2")"
    ln -sf "$1" "$2"
    echo "linked $2 -> $1"
}

link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/zed" "$HOME/.config/zed"
link "$DOTFILES/ghostty/config" "$GHOSTTY_DIR/config"
link "$DOTFILES/ghostty/shaders" "$GHOSTTY_DIR/shaders"
