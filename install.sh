#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"


echo ">>> Detecting OS..."
case "$(uname -s)" in
  Linux*)
    if [ -f /etc/arch-release ]; then
      echo ">>> Running Arch setup..."
      bash "$DOTFILES_DIR/setup/base/arch.sh"
    elif command -v lsb_release >/dev/null && lsb_release -is | grep -qi ubuntu; then
      echo ">>> Running Ubuntu setup..."
      bash "$DOTFILES_DIR/setup/base/ubuntu.sh"
    else
      echo ">>> Unsupported Linux distribution"
    fi
    ;;
  Darwin*)
    echo ">>> Running macOS setup..."
    bash "$DOTFILES_DIR/setup/base/mac.sh"
    ;;
  *)
    echo ">>> Unsupported OS"
    exit 1
    ;;
esac


echo ">>> Initializing submodules..."
git -C "$DOTFILES_DIR" submodule update --init --recursive


echo ">>> Setting zsh as default shell (if available)..."
if command -v zsh >/dev/null 2>&1; then
    echo "Setting default shell to zsh..."
    ZSH_PATH="$(command -v zsh)"
    chsh -s "$(which zsh)" || true
fi


echo ">>> Deploying dotfiles..."
cd "$DOTFILES_DIR"
echo "stow"
stow -d "$DOTFILES_DIR/config" -t $HOME zsh nvim
echo "mkdir"
mkdir -p "$HOME/.config/tmux"
echo "first if"
if [ ! -f "$HOME/.config/tmux/tmux.conf" ]; then
  ln -s "$DOTFILES_DIR/config/tmux/.tmux/.tmux.conf" \
     "$HOME/.config/tmux/tmux.conf" 
fi
echo "sec if"
if [ ! -f "$HOME/.config/tmux/tmux.conf.local" ]; then
  cp "$DOTFILES_DIR/config/tmux/.tmux.conf.local" \
     "$HOME/.config/tmux/tmux.conf.local"
fi
cd "$HOME"
tree -a

echo ">>> Done! Restart your shell to apply changes."

