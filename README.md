# Dotfiles

Personal configuration files for Unix/macOS development environment.

## Installation

### Quick Start

```bash
# Clone the repository
git clone https://github.com/ptarjan/dotfiles.git ~/dotfiles

# Run the install script
cd ~/dotfiles
./install.sh
```

The install script will:
- Create symlinks for all dotfiles to your home directory
- Back up any existing files (as `filename.backup`)
- Set up `.config/` directories (htop, nvim)

### Vim Setup

```bash
# Install Vundle plugin manager
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Create required directories for backup/swap/undo
mkdir -p ~/.vim/{backup_files,swap_files,undo_files}

# Install plugins
vim +PluginInstall +qall
```

## What's Included

### Shell Configuration

| File | Description |
|------|-------------|
| `.bashrc` | Bash configuration with prompt, aliases, and functions |
| `.bash_profile` | Login shell setup, PATH configuration, pyenv/rbenv |
| `.zshrc` | Zsh configuration with vi mode |
| `.inputrc` | Readline configuration for vi-style editing |

### Editor Configuration

| File | Description |
|------|-------------|
| `.vimrc` | Vim configuration with plugins, keybindings, and language support |
| `.vim/` | Vim color schemes, syntax files, and spell checking |
| `.config/nvim/` | Neovim configuration |

### Version Control

| File | Description |
|------|-------------|
| `.gitconfig` | Git configuration with aliases and colors |
| `.gitignore` | Global gitignore patterns |
| `.git-prompt.sh` | Git branch display in shell prompt |

### Terminal Multiplexers

| File | Description |
|------|-------------|
| `.tmux.conf` | Tmux configuration (prefix: `Ctrl-a`) |
| `.screenrc` | GNU Screen configuration |

### Other Configs

| File | Description |
|------|-------------|
| `.pryrc` | Pry (Ruby REPL) configuration |
| `.pythonrc.py` | Python REPL startup file |
| `.gemrc` | RubyGems configuration |
| `.gdbinit` | GDB debugger configuration |
| `.editrc` | Line editor configuration |

## Key Features

### Vi Mode Everywhere

Vi-style editing is enabled across the environment:
- **Bash/Readline**: `set editing-mode vi` in `.inputrc`
- **Zsh**: `bindkey -v` in `.zshrc`
- **Vim**: Full vim configuration with plugins

Use `jk` to exit insert mode (works in bash, zsh, and vim).

### Vim Plugins

Managed via [Vundle](https://github.com/gmarik/Vundle.vim):

- **Git**: fugitive, rhubarb (GitHub integration)
- **Navigation**: NERDTree, FZF (`Ctrl-P`)
- **Editing**: surround, nerdcommenter, multiple-cursors, easymotion
- **Linting**: ALE (async linting)
- **Autocomplete**: coc.nvim
- **Languages**: JavaScript/TypeScript, Ruby, Go, C/C++, Python

### Vim Key Mappings

| Mapping | Action |
|---------|--------|
| `jk` | Exit insert mode |
| `;` | Enter command mode (instead of `:`) |
| `Ctrl-P` | Fuzzy file finder (FZF) |
| `Ctrl-h/j/k/l` | Window navigation |
| `th/tj/tk/tl` | Tab navigation |
| `,p` | Toggle paste mode |
| `,s` | Toggle spell check |
| `,gb` | Git blame |
| `,gs` | Git status |
| `,gh` | Open in GitHub |

### Git Aliases

Defined in `.gitconfig`:

| Alias | Command | Description |
|-------|---------|-------------|
| `g st` | `git status -uno` | Show status (tracked files only) |
| `g co` | `git checkout` | Checkout |
| `g br` | `git branch` | Branch management |
| `g di` | `git diff` | Show diff |
| `g cam "msg"` | `git commit -a -m "msg"` | Commit all with message |
| `g ca` | `git commit --amend -a -C HEAD` | Amend last commit |
| `g p` | Push + open PR page | Push and open compare page in browser |
| `g pf` | `git push --force-with-lease` | Force push (safe) |
| `g rom` | `git rebase origin/master` | Rebase on origin/master |
| `g ri` | `git rebase origin/master -i` | Interactive rebase |
| `g rc` | Add all + continue rebase | Continue rebase after resolving conflicts |
| `g gcbr` | Delete merged branches | Clean up merged branches |

## Utility Scripts

Located in `bin/`:

| Script | Description |
|--------|-------------|
| `g` | Git shortcut |
| `replace` | Find and replace across files with git commit |
| `replace-no-commit` | Find and replace without committing |
| `multi-grep` | Grep across multiple patterns |
| `multi-sed` | Sed across multiple files |
| `gcbr` | Delete old merged git branches |
| `git-delete-old-branches` | Remove stale branches |
| `f` / `fa` | File finding utilities |
| `t` / `td` | Task/todo utilities |
| `yaml2json` | Convert YAML to JSON |

## Shell Functions

### kshell

Quickly get a shell in a running Kubernetes pod:

```bash
kshell <pod-name-prefix> [container-name]
```

## Dependencies

Some features require additional tools:

- **FZF**: Fuzzy finder - `brew install fzf`
- **fd**: Fast file finder - `brew install fd`
- **ripgrep**: Fast grep - `brew install ripgrep`
- **pyenv**: Python version manager - `brew install pyenv`
- **rbenv**: Ruby version manager - `brew install rbenv`
- **nvm**: Node version manager

## Platform Notes

Primarily configured for macOS with some Linux compatibility. Some features (like iTerm2 integration) are macOS-specific.

## License

MIT
