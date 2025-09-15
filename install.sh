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
if command -v zsh >/dev/null; then
  ZSH_PATH="$(command -v zsh)"
  if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
  fi
  if [ "$SHELL" != "$ZSH_PATH" ]; then
    chsh -s "$ZSH_PATH" || true
  fi
else
  echo ">>> zsh not installed, skipping default shell change."
fi


echo ">>> Deploying dotfiles with stow..."
cd "$DOTFILES_DIR"
stow -d "$DOTFILES_DIR/config" -t $HOME zsh nvim tmux


echo ">>> Ensuring tmux configuration..."
if [ ! -f "$HOME/.config/tmux/.tmux.conf.local" ]; then
  cp "$HOME/.config/tmux/.tmux.conf.local" \
     "$HOME/.config/tmux/tmux.conf.local"
fi

echo ">>> Done! Restart your shell to apply changes."

