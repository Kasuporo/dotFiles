#!/bin/bash

FOLDER=$(dirname $0)

backup_file()
{
    if [[ `ls $HOME/$1 2>/dev/null` ]]; then
        printf "Backing up old $1...\n"
        cp $HOME/$1 $HOME/$1.dotfile.bak
        rm $HOME/$1
    fi
}


# Setup Hyper
if [[ `command -v hyper` ]]; then
    printf "Setting up hyper\n"
    backup_file '.hyper.js'
    ln $FOLDER/hyper.js $HOME/.hyper.js
    printf "Done\n\n"
fi


# Setup Vim
printf "Setting up vimrc\n"
backup_file '.vimrc'
ln $FOLDER/vimrc $HOME/.vimrc
mkdir -p $HOME/.vim/backup $HOME/.vim/swap $HOME/.vim/undo
printf "Installing Vundle\n"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 2>/dev/null
printf "Done\n\n"


# Setup ZSH
if [[ `echo $SHELL` = '/bin/zsh' ]]; then
    printf "Setting up zshrc\n"
    backup_file '.zshrc'
    ln $FOLDER/zshrc $HOME/.zshrc
    printf "Installing Oh My Zsh\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    printf "Done\n\n"
fi


# Setup Tmux
if [[ `command -v tmux` ]]; then
    printf "Setting up tmux\n"
    backup_file 'tmux.conf'
    ln $FOLDER/tmux.conf $HOME/tmux.conf
    printf "Done\n\n"
fi


# Setup ptpython
printf "Setting up ptpython\n"
if [[ ! `command -v ptpython` ]]; then
    printf "Installing ptpython\n"
    pip install ptpython
fi
mkdir -p $HOME/.ptpython
backup_file '.ptpython/config.py'
ln $FOLDER/ptpython/config.py $HOME/.ptpython/config.py
printf "Done\n\n"


# Finish
printf "All done!\n"
printf "Check to make sure everything works -- You can delete all the backups with this command:\n\n"
printf "rm ~/.*.dotfile.bak && test -e ~/.ptpython/config.py.dotfile.bak && rm ~/.ptpython/config.py.dotfile.bak\n\n"
