# Dotfiles

My dotfiles for Zed and WezTerm.

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
├── zed/           # Zed config → ~/Library/Application Support/Zed/
├── wezterm/       # WezTerm config → ~/.wezterm.lua
├── images/        # Shared assets (background image)
└── install.sh     # Symlink installer
```

## Requirements

- [Zed](https://zed.dev/)
- [WezTerm](https://wezfurlong.org/wezterm/)
- [FiraCode Nerd Font](https://www.nerdfonts.com/)
