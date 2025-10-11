# Dotfiles

Personal dotfiles configuration for macOS.

## Prerequisites

**Important:** This configuration requires [GNU Stow](https://www.gnu.org/software/stow/) for symlink management.

Install Stow via Homebrew:
```bash
brew install stow
```

## What's Included

### Terminal & Shell
- **Alacritty** - GPU-accelerated terminal emulator (`.config/alacritty/`)
- **Oh My Posh** - Prompt theme engine with custom theme (`.config/ohmyposh/`)
- **Zsh** - Shell configuration with plugins and aliases

### Tools & Package Managers
- **Homebrew** - macOS package manager
- **NVM** - Node Version Manager
- **Zinit** - Zsh plugin manager
- **fzf** - Fuzzy finder for command-line
- **zoxide** - Smarter cd command

### Zsh Plugins (via Zinit)
- `zsh-syntax-highlighting` - Fish-like syntax highlighting
- `zsh-completions` - Additional completion definitions
- `zsh-autosuggestions` - Fish-like autosuggestions
- `fzf-tab` - Replace tab completion with fzf

### Development Tools
- **nvim** - Neovim text editor
- **lazygit** - Terminal UI for git
- **tmux-sessionizer** - Quick tmux session management (Ctrl+F)
- **kubectl** - Kubernetes CLI
- **pulumi** - Infrastructure as Code
- **Docker** - Container platform

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Use Stow to symlink the configurations:
```bash
# Symlink all configs
stow .

# Or symlink specific configs
stow --target=$HOME .config
```

3. Install Homebrew (if not already installed):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

4. Install required packages:
```bash
brew install alacritty oh-my-posh fzf zoxide nvim lazygit
```

5. Reload your shell:
```bash
source ~/.zshrc
```

## Key Aliases

### Git
- `gs` - git status
- `ga` - git add
- `gc` - git commit
- `gp` - git push
- `gpl` - git pull
- `gsw` - git switch to previous branch
- `gsc` - git switch -c (create new branch)
- `yeet` - git push -u origin HEAD
- `g` / `lg` - lazygit

### Kubernetes
- `k` - kubectl
- `kcu` - kubectl config use-context
- `kcg` - kubectl config get-contexts

### Pulumi
- `p` - pulumi
- `ps` - pulumi stack ls
- `pspro` - select production stack
- `pspre` - select pre-production stack

### Other
- `v` - nvim
- `ls` - ls with color output

## Key Bindings

- `Ctrl+F` - Launch tmux-sessionizer
- `Ctrl+P` - History search backward
- `Ctrl+N` - History search forward

## Configuration Details

### History Settings
- Size: 5000 commands
- Duplicates: Automatically removed
- Shared across all sessions
- Ignores commands starting with space

### Completion
- Case-insensitive matching
- fzf-tab integration
- Preview enabled for cd and zoxide

## Notes

- AWS Profile is set to `infra_sdlc` by default
- Go binaries path is included in PATH
- LLVM path configured via Homebrew
- Oh My Posh is disabled in Apple Terminal
