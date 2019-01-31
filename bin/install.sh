#!/bin/bash

set -e

cd $(dirname $0)/../

FOLDER=`pwd | sed 's/\~/$HOME/g'`
FOLDERESC=$(echo $FOLDER | sed 's/\//\\\//g')

backup_file()
{
    if [[ -f "$HOME/$1" ]]; then
        printf "Backing up old $1...\n"
        cp ~/$1 ~/$1.dotfile.bak
    fi
}

is_command()
{
    local check_command="$1"

    command -v "${check_command}" >/dev/null 2>&1
}


# Setup Hyper
if is_command hyper ; then
    printf "Setting up hyper\n"
    backup_file '.hyper.js'
    ln -sFf $FOLDER/hyper.js ~/.hyper.js
    printf "Done\n\n"
fi


# Setup Vim
printf "Setting up vimrc\n"
backup_file '.vimrc'
ln -sFf $FOLDER/vimrc ~/.vimrc
mkdir -p ~/.vim/backup ~/.vim/swap ~/.vim/undo
if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
    printf "Installing Vundle\n"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
printf "Done\n\n"


# Setup path variables
printf "Setting up path variables for zshrc\n"
if [[ $DOTFILES_PATH && "$DOTFILES_PATH" != "$FOLDER" ]]; then
    sed -i.sed_.bak "s/export DOTFILES_PATH=/export DOTFILES_PATH=$FOLDERESC/g" $FOLDER/zshrc && rm $FOLDER/zshrc.sed_.bak
else
    echo "export DOTFILES_PATH=$FOLDER" | cat - $FOLDER/zshrc > temp && mv temp $FOLDER/zshrc
fi
printf "Done\n\n"


# Setup ZSH
printf "Setting up zshrc\n"
backup_file '.zshrc'
ln -sFf $FOLDER/zshrc ~/.zshrc
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    printf "Installing Oh My Zsh\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
printf "Done\n\n"


# Setup Tmux
if is_command tmux ; then
    printf "Setting up tmux\n"
    backup_file 'tmux.conf'
    ln -sFf $FOLDER/tmux.conf ~/tmux.conf
    printf "Done\n\n"
fi


# Setup ptpython
printf "Setting up ptpython\n"
if ! is_command ptpython ; then
    printf "Installing ptpython\n"
    pip install ptpython
fi
mkdir -p ~/.ptpython
backup_file '.ptpython/config.py'
ln -sFf $FOLDER/ptpython/config.py ~/.ptpython/config.py
printf "Done\n\n"


# Setup Ctags
printf "Setting up ctags\n"
backup_file '.ctags'
ln -sFf $FOLDER/ctags ~/.ctags
printf "Done\n\n"


# Setup 2FA recovery code file
read -r -p "${1:-Do you want to setup a file for 2FA recovery codes? [y/N]} " response
case "$response" in
[yY][eE][sS]|[yY])

    printf "\nPlease enter a directory to store the file (excluding the file).\n"
    read -r -p "${1:-[e.g '~/Documents/']:} " directory
    eval mkdir -p "$directory"

    printf "Generating recovery script\n"
    directory_esc=$(echo $directory | sed 's/\//\\\//g')
    sed "s/#cd_placeholder#/cd $directory_esc/g" bin/recover.sh.sample > bin/recover.sh

    printf "Please enter a password to encrypt the file\n"
    chmod +x bin/recover.sh
    bin/recover.sh

    printf "\nRecovery code file has been saved as $directory/codes.txt.enc\n"
    printf "You can open it with the zsh alias 'open_recovery_file'\n"

    ;;
esac

# Finish
printf "Removing backups\n"
rm ~/.*.dotfile.bak && test -e ~/.ptpython/config.py.dotfile.bak && rm ~/.ptpython/config.py.dotfile.bak

source ~/.zshrc

printf "All done!\n"
