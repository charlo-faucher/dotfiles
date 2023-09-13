#!/bin/zsh

mkdir ~/bin ~/cegep ~/projets

sudo pacman -Sy git neovim gcc gdb python3 python-pip kitty tree

cp -fu dotfiles/.zshrc ~
cp -fu dotfiles/.aliases ~
cp -fu dotfiles/.functions ~
