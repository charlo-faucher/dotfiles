#!/usr/bin/env bash
set -euo pipefail

echo ">>> Installing base packages for Arch..."

pacman -Syu --noconfirm
pacman -S --noconfirm sudo git stow zsh tmux neovim tree fzf ripgrep curl wget
pacman -S --noconfirm --needed base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# Install NerdFonts
yay -S nerd-fonts-fira-code
pacman -S --noconfirm ttf-font-awesome powerline-fonts

