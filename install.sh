#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "Detecting OS..."
case "$(uname -s)" in
  Linux*)
    if [ -f /etc/arch-release ]; then
      echo "ARCH installation!"
      bash "$DOTFILES_DIR/setup/base/arch.sh"
    elif [ -f /etc/lsb-release ]; then
      echo "Ubuntu installation!"
      bash "$DOTFILES_DIR/setup/base/ubuntu.sh"
    else
      echo "Unsupported Linux distro"
      exit 1
    fi
    ;;
  Darwin*)
    echo "MacOS installation!"
    bash "$DOTFILES_DIR/setup/base/mac.sh"
    ;;
  *)
    echo "Unsupported OS"
    exit 1
    ;;
esac

echo "Setting up zsh as default shell..."

# Prefer common zsh locations over /usr/sbin/zsh
if [ -x /bin/zsh ]; then
  ZSH_PATH=/bin/zsh
elif [ -x /usr/bin/zsh ]; then
  ZSH_PATH=/usr/bin/zsh
elif [ -x /usr/local/bin/zsh ]; then
  ZSH_PATH=/usr/local/bin/zsh
else
  # fallback (whatever which finds)
  ZSH_PATH=$(command -v zsh)
fi

# Ensure it's listed in /etc/shells
if ! grep -qx "$ZSH_PATH" /etc/shells; then
  echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi

# Change default shell
chsh -s "$ZSH_PATH"

echo "Default shell set to: $ZSH_PATH"

echo "Deploying dotfiles with stow..."
stow -d "$DOTFILES_DIR/config" -t $HOME zsh nvim tmux
