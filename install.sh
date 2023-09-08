#!/bin/zsh

mkdir ~/bin ~/cegep ~/projets

sudo pacman -Sy git neovim gcc gdb python3 python-pip kitty tree

cp ~/dotfiles/.zshrc ~
cp ~/dotfiles/.aliases ~
cp ~/dotfiles/.functions ~
