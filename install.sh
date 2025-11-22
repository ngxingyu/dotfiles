#!/bin/bash
# dotfiles/install.sh
# Backup existing files and symlink all configs from this repo

DOTFILES_DIR="$HOME/dotfiles"

# List of files to symlink (key: source in repo, value: destination in home)
declare -A FILES=(
    ["tmux.conf"]="$HOME/.tmux.conf"
    ["vimrc"]="$HOME/.vimrc"
    ["bash_aliases"]="$HOME/.bash_aliases"
)

echo "Installing dotfiles..."

for SRC in "${!FILES[@]}"; do
    DEST="${FILES[$SRC]}"
    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
        echo "Backing up existing $DEST to $DEST.bak"
        mv "$DEST" "$DEST.bak"
    fi
    echo "Creating symlink $DEST -> $DOTFILES_DIR/$SRC"
    ln -s "$DOTFILES_DIR/$SRC" "$DEST"
done

echo "Done. To load bash aliases, run: source ~/.bash_aliases"

