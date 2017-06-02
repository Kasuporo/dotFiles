#!/bin/bash

# Creates syslinks for stuff

# i3
cp ~/.i3/config ~/.i3/config-backup
rm ~/.i3/config
ln -s ~/dotfiles/i3/config ~/.i3/config

# Polybar
cp ~/.config/polybar/config ~/.config/polybar/config-backup
rm ~/.config/polybar/config
ln -s ~/dotfiles/polybar/config ~/.config/polybar/config

# Vimrc
cp ~/.vimrc ~/.vimrc-backup
rm ~/.vimrc
ln -s ~/dotfiles/vimrc ~/.vimrc

# Xresources
cp ~/.Xresources ~/.Xresources-backup
rm ~/.Xresources
ln -s ~/dotfiles/Xresouces ~/.Xresources
