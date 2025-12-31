# Dotfiles

Personal configuration files for Unix/macOS development environment.

## Installation

```bash
git clone https://github.com/ptarjan/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The install script symlinks all dotfiles to your home directory, backing up any existing files.

### Vim Setup

```bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mkdir -p ~/.vim/{backup_files,swap_files,undo_files}
vim +PluginInstall +qall
```

## Highlights

- **Vi mode everywhere** - bash, zsh, and vim all use vi keybindings. Use `jk` to exit insert mode.
- **Vim plugins** via Vundle - see `.vimrc` for the full list
- **Git aliases** - see `.gitconfig` for shortcuts like `g co`, `g cam`, `g p`
- **Utility scripts** in `bin/` - add to your PATH

## Dependencies

Some features need: `fzf`, `fd`, `ripgrep`, `pyenv`, `rbenv`, `nvm`
