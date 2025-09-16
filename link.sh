DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"
echo "AAAAAAAAAAAA"

stow -d "$DOTFILES_DIR/config" -t $HOME zsh nvim
echo "BBBBBBBBBBBB"

mkdir -p "$HOME/.config/tmux"

echo "CCCCCCCCCCCCCC"

if [ ! -f "$HOME/.config/tmux/tmux.conf" ]; then
  ln -s "$DOTFILES_DIR/config/tmux/.tmux/.tmux.conf" \
     "$HOME/.config/tmux/tmux.conf" 
fi

echo "DDDDDDDDDDD"

if [ ! -f "$HOME/.config/tmux/tmux.conf.local" ]; then
  cp "$DOTFILES_DIR/config/tmux/.tmux.conf.local" \
     "$HOME/.config/tmux/tmux.conf.local"
fi
