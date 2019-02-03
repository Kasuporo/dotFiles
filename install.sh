#!/bin/bash

if [ -d "~/dotfiles" ]; then
    printf "Removing old dotfiles.\n"
    rm -rf ~/dotfiles
fi

git clone https://github.com/beanpuppy/dotfiles ~/dotfiles && ~/dotfiles/bin/setup.sh
