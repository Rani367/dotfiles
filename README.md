# Dotfiles

My dotfiles for Neovim and Zed.

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
├── zed/           # Zed config (macOS) → ~/Library/Application Support/Zed/
├── zed-windows/   # Zed config (Windows) → %APPDATA%\Zed\
└── install.sh     # Symlink installer (macOS)
```

## Windows 11 (Zed only)

PowerShell one-liner to install Zed config:

```powershell
md "$env:APPDATA\Zed" -Force; @('settings.json','keymap.json','tasks.json','run.ps1') | % { irm "https://raw.githubusercontent.com/Rani367/dotfiles/main/zed-windows/$_" -OutFile "$env:APPDATA\Zed\$_" }
```

This downloads Windows-compatible config files to `%APPDATA%\Zed\` including a PowerShell code runner script.

## Requirements

- [Neovim](https://neovim.io/) 0.11+
- [Zed](https://zed.dev/)
- [FiraCode Nerd Font](https://www.nerdfonts.com/)
