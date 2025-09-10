# Path to oh-my-zsh
export ZSH="$HOME/dotfiles/config/zsh/oh-my-zsh"

# Load oh-my-zsh
ZSH_THEME="bureau"
plugins=(git z fzf)

source $ZSH/oh-my-zsh.sh

# Load custom configs
source $HOME/dotfiles/config/zsh/common.zsh

case "$(uname -s)" in
  Linux*)  source $HOME/dotfiles/config/zsh/linux.zsh ;;
  Darwin*) source $HOME/dotfiles/config/zsh/mac.zsh ;;
esac

# Load aliases
source $HOME/dotfiles/aliases/.aliases-common
