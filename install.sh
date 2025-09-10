#!/usr/bin/env bash

set -e

echo "Detecting OS..."
case "$(uname -s)" in
  Linux*)
    if [ -f /etc/arch-release ]; then
      echo "ARCH installation!"
      bash setup/base/arch.sh
    elif [ -f /etc/lsb-release ]; then
      echo "Ubuntu installation!"
      bash setup/base/ubuntu.sh
    else
      echo "Unsupported Linux distro"
      exit 1
    fi
    ;;
  Darwin*)
    echo "MacOS installation!"
    bash setup/base/mac.sh
    ;;
  *)
    echo "Unsupported OS"
    exit 1
    ;;
esac

# Deploy configs with stow
stow -t "$HOME" config
