# Dotfiles

My dotfiles for Neovim, Zed, and WezTerm.

> **Note:** Primarily using Neovim. Zed config included for occasional use, but not planning to switch anytime soon.

## Install

One-liner:

```bash
curl -fsSL https://raw.githubusercontent.com/Rani367/dotfiles/main/install.sh | bash
```

Or manually:

```bash
git clone https://github.com/Rani367/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Structure

```
dotfiles/
├── nvim/          # Neovim config → ~/.config/nvim
├── zed/           # Zed config → ~/.config/zed
├── wezterm/       # WezTerm config → ~/.wezterm.lua
├── images/        # Shared assets (background image)
└── install.sh     # Symlink installer
```

## Requirements

- [Neovim](https://neovim.io/) 0.10+
- [Zed](https://zed.dev/)
- [WezTerm](https://wezfurlong.org/wezterm/)
- [FiraCode Nerd Font](https://www.nerdfonts.com/)
