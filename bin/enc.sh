#!/bin/bash

# Script to encyrpt and decrypt file
# arg1 = file

source $DOTFILES/bin/utils.sh

file=$1;

try_again()
{
    newline
    read -p "$bld    Do you want to try again? [y/N] " response
    case "$response" in
    [yY][eE][sS]|[yY])
        $DOTFILES/bin/enc.sh "$file";;
    esac
}

if [ -f $file ]; then
    newline
    printbarr "Encrypting$grn $file"
    newline
    openssl enc -aes-256-cbc -salt -in "$file" -out "$file.enc" 2>/dev/null
    if [[ $? -eq 0 ]]; then
        rm $file
    else
        printerr "Passwords don't match."
        try_again
    fi
elif [ -f $file.enc ]; then
    newline
    printbarr "Decrypting$grn $file.enc"
    newline
    openssl enc -aes-256-cbc -d -in "$file.enc" -out "$file" 2>/dev/null
    if [[ $? -eq 0 ]]; then
        rm $file.enc

        nvim $file && $DOTFILES/bin/enc.sh "$file"
    else
        rm $file

        printerr "Wrong password."
        try_again
    fi
else
    touch "$file"
    $DOTFILES/bin/enc.sh "$file"
fi
