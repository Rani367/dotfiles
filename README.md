# Dotfiles

My dotfiles for Zed.

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
├── zed/           # Zed config (macOS) → ~/Library/Application Support/Zed/
└── install.sh     # Symlink installer (macOS)
```

## Requirements

- [Zed](https://zed.dev/)
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
