#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$DOTFILES_DIR"

stow -d "$DOTFILES_DIR/config" -t $HOME zsh nvim

mkdir -p "$HOME/.config/tmux"

if [ ! -f "$HOME/.config/tmux/tmux.conf" ]; then
  ln -s "$DOTFILES_DIR/config/tmux/.tmux/.tmux.conf" \
     "$HOME/.config/tmux/tmux.conf" 
fi

if [ ! -f "$HOME/.config/tmux/tmux.conf.local" ]; then
  cp "$DOTFILES_DIR/config/tmux/.tmux.conf.local" \
     "$HOME/.config/tmux/tmux.conf.local"
fi

cd "$HOME"
