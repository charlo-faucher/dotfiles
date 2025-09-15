#!/usr/bin/env bash
set -euo pipefail

echo ">>> Installing base packages for Arch..."

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git stow zsh tmux neovim fzf ripgrep curl wget

