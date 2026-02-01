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

## Windows 11 (Zed only)

PowerShell one-liner to install Zed config:

```powershell
irm https://raw.githubusercontent.com/Rani367/dotfiles/main/zed/settings.json -OutFile "$env:APPDATA\Zed\settings.json"; irm https://raw.githubusercontent.com/Rani367/dotfiles/main/zed/keymap.json -OutFile "$env:APPDATA\Zed\keymap.json"; irm https://raw.githubusercontent.com/Rani367/dotfiles/main/zed/tasks.json -OutFile "$env:APPDATA\Zed\tasks.json"
```

This copies the config files directly to `%APPDATA%\Zed\` (avoids Windows symlink issues).

## Requirements

- [Zed](https://zed.dev/)
- [WezTerm](https://wezfurlong.org/wezterm/)
- [FiraCode Nerd Font](https://www.nerdfonts.com/)
