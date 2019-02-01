#!/bin/bash

# A dotfiles setup script for my MacOS install

set -e

cd $(dirname $0)/../
source bin/utils.sh

DIR=`pwd`

backup_file()
{
    if [[ -f "$HOME/$1" ]]; then
        printbarr "Backing up old $1"
        cp ~/$1 ~/$1.dotfile.bak
    fi
}

is_command()
{
    local check_command="$1"
    command -v "${check_command}" >/dev/null 2>&1
}


# Setup Hyper
printgarr "Setting up$grn hyper"
backup_file '.hyper.js'
ln -sFf $DIR/hyper.js ~/.hyper.js
newline


# Setup mackup
printgarr "Setting up$grn mackup"
backup_file '.mackup.cfg'
ln -sFf $DIR/mackup.cfg ~/.mackup.cfg
newline


# Setup Vim
printgarr "Setting up$grn vimrc"
backup_file '.vimrc'
ln -sFf $DIR/vimrc ~/.vimrc
mkdir -p ~/.vim/backup ~/.vim/swap ~/.vim/undo
if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
    printgarr "Installing Vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
newline


# Setup ZSH
printgarr "Setting up$grn zshrc"
backup_file '.zshrc'
ln -sFf $DIR/zshrc ~/.zshrc
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    printf "Installing Oh My Zsh\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
newline


# Setup Tmux
if is_command tmux ; then
    printgarr "Setting up$grn tmux"
    backup_file 'tmux.conf'
    ln -sFf $DIR/tmux.conf ~/tmux.conf
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        printgarr "Installing TPM"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
    newline
fi


# Setup ptpython
printgarr "Setting up$grn ptpython"
if ! is_command ptpython ; then
    printgarr "Installing ptpython"
    pip install ptpython
fi
mkdir -p ~/.ptpython
backup_file '.ptpython/config.py'
ln -sFf $DIR/ptpython/config.py ~/.ptpython/config.py
newline


# Setup Ctags
printgarr "Setting up$grn ctags"
backup_file '.ctags'
ln -sFf $DIR/ctags ~/.ctags
newline


# Setup 2FA recovery code file
read -p "$bld    Do you want to setup a file for 2FA recovery codes? [y/N] " response
case "$response" in
[yY][eE][sS]|[yY])

    newline
    printtxt "Please enter a directory to store the file (not including the file)."
    read -e -p "$bld    [e.g '~/Documents']: " directory
    eval mkdir -p "$directory"

    newline
    printgarr "Generating recovery script"
    directory_esc=$(echo $directory | sed 's/\//\\\//g')
    sed "s/#cd_placeholder#/cd $directory_esc/g" bin/recover.sh.sample > bin/recover.sh
    chmod +x bin/recover.sh

    eval cd "$directory"

    newline
    if [[ -f "codes.txt.enc" ]]; then
        printbarr "Found existing$grn codes.txt.enc"
    else
        printbarr "Please enter a password to encrypt the file"
        touch codes.txt
        $DIR/bin/recover.sh

        newline
        printbarr "Recovery code file has been saved as$grn $directory/codes.txt.enc"
    fi

    cd - 1>/dev/null

    printbarr "You can open it with the zsh alias:$grn 2fa_recovery"
    ;;
esac
newline


# Finish
printbarr "Removing backups"
rm ~/.*.dotfile.bak && test -e ~/.ptpython/config.py.dotfile.bak && rm ~/.ptpython/config.py.dotfile.bak
newline

printtxt "All done!"
printtxt "Please restart your terminal for some things to take effect."
newline
