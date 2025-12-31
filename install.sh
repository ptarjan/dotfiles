#!/bin/bash

# Dotfiles installer - symlinks all dotfiles to home directory

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Symlink all dotfiles (excluding .git)
for src in "$DOTFILES_DIR"/.*; do
  name="$(basename "$src")"

  # Skip . .. .git
  [[ "$name" == "." || "$name" == ".." || "$name" == ".git" ]] && continue

  dst="$HOME/$name"

  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "Backing up: $dst -> $dst.backup"
    mv "$dst" "$dst.backup"
  fi

  echo "Linking: $name"
  ln -s "$src" "$dst"
done

echo ""
echo "Done! Add bin to PATH if not already present:"
echo "  export PATH=\"\$PATH:$DOTFILES_DIR/bin\""
