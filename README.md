# Dotfiles

[![License Apache 2][badge-license]](LICENSE)

Personal configuration files for shells, editors, window managers, and development tools.

## What's Included

**Shells:** Bash, Zsh, Fish

**Editors:** Neovim, LunarVim, AstroNvim, Helix, Zed

**Terminals:** Alacritty, Kitty, Ghostty, Termite

**Window Managers:** i3, Sway, Yabai, Aerospace

**Development:** Git, Tmux, Zellij, GitUI, Mise, Atuin

**Cloud Tools:** kubectl, helm, terraform, argocd, flux2, k9s, and 40+ more managed via mise/asdf

**AI Assistants:** Claude, Gemini, OpenCode

## Installation

```bash
git clone https://github.com/nlamirault/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
make install
```

The install script creates symlinks from this repository to your home directory.

## Useful Commands

```bash
make install    # Install dotfiles
make test       # Run tests
make validate   # Run pre-commit hooks
```

## Structure

```
.
├── .config/              # Tool configurations (50+ tools)
│   ├── zshrc.d/         # Modular zsh config
│   ├── bashrc.d/        # Modular bash config
│   └── ...              # alacritty, nvim, tmux, etc.
├── bin/                 # Utility scripts
├── .bashrc              # Bash configuration
├── .zshrc               # Zsh configuration
├── .gitconfig           # Git configuration
└── Makefile             # Installation tasks
```

## Git Features

Custom aliases and AI-powered tools:

```bash
git lg      # Beautiful log graph
git s       # Status
git recent  # Recent branches
git pto     # Push to origin with upstream

# AI features (requires Ollama)
git ai-commit-explain  # Explain a commit
git ai-branch-review   # Review current branch
```

## Requirements

- Bash 4.0+ or Zsh 5.0+
- Git 2.30+
- GNU Make

Optional: mise, pre-commit, neovim

## Platform Support

- Linux (X11 and Wayland)
- macOS
- BSD (partial)

## License

See [LICENSE](LICENSE) for details.

## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>

[badge-license]: https://img.shields.io/badge/license-Apache2-green.svg?style=flat
