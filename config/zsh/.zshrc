# Path to oh-my-zsh
export ZSH="$HOME/dotfiles/config/zsh/.config/oh-my-zsh"

# Load oh-my-zsh
ZSH_THEME="bureau"
#plugins=(git z fzf)

source $ZSH/oh-my-zsh.sh

# Load custom configs
source $HOME/dotfiles/config/shell/common.zsh

case "$(uname -s)" in
  Linux*)  source $HOME/dotfiles/config/shell/linux.zsh ;;
  Darwin*) source $HOME/dotfiles/config/shell/mac.zsh ;;
esac

# Load aliases
source $HOME/dotfiles/aliases/.aliases-common

# Use tmux config
export TMUX_CONF="$HOME/.config/tmux/tmux.conf"
