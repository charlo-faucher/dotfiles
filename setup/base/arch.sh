#!/usr/bin/env bash
set -euo pipefail

echo ">>> Installing base packages for Arch..."

pacman -Syu --noconfirm
pacman -S --noconfirm sudo git stow zsh tmux neovim fzf ripgrep curl wget

