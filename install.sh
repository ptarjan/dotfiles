#!/bin/bash

# Dotfiles installer
# Creates symlinks from home directory to dotfiles

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Files to symlink to home directory
FILES=(
  .bashrc
  .bash_profile
  .zshrc
  .vimrc
  .vim
  .gitconfig
  .gitignore
  .inputrc
  .tmux.conf
  .screenrc
  .pryrc
  .pythonrc.py
  .gemrc
  .gdbinit
  .editrc
  .git-prompt.sh
  .iterm2_shell_integration.bash
)

# Config directories to symlink
CONFIG_DIRS=(
  htop
  nvim
)

echo "Installing dotfiles from $DOTFILES_DIR"

# Create symlinks for dotfiles
for file in "${FILES[@]}"; do
  src="$DOTFILES_DIR/$file"
  dst="$HOME/$file"

  if [ -e "$src" ]; then
    if [ -L "$dst" ]; then
      echo "Removing existing symlink: $dst"
      rm "$dst"
    elif [ -e "$dst" ]; then
      echo "Backing up existing file: $dst -> $dst.backup"
      mv "$dst" "$dst.backup"
    fi

    echo "Linking: $dst -> $src"
    ln -s "$src" "$dst"
  fi
done

# Create .config directory if needed
mkdir -p "$HOME/.config"

# Create symlinks for config directories
for dir in "${CONFIG_DIRS[@]}"; do
  src="$DOTFILES_DIR/.config/$dir"
  dst="$HOME/.config/$dir"

  if [ -d "$src" ]; then
    if [ -L "$dst" ]; then
      echo "Removing existing symlink: $dst"
      rm "$dst"
    elif [ -d "$dst" ]; then
      echo "Backing up existing directory: $dst -> $dst.backup"
      mv "$dst" "$dst.backup"
    fi

    echo "Linking: $dst -> $src"
    ln -s "$src" "$dst"
  fi
done

# Add bin to PATH reminder
echo ""
echo "Done! Add this to your shell config if not already present:"
echo "  export PATH=\"\$PATH:$DOTFILES_DIR/bin\""

# Vim setup reminder
echo ""
echo "For Vim setup, run:"
echo "  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
echo "  mkdir -p ~/.vim/{backup_files,swap_files,undo_files}"
echo "  vim +PluginInstall +qall"
