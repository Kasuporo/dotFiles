#
# Docker Stuffs
#

# I think there's a homebrew package for this, but I'm a lazy boi
alias docker-clean="docker ps -a | grep 'Exited\|Created' | cut -d ' ' -f 1 | xargs docker rm"

function docker-enter() {
    if [ -n "$1" ]
    then
        docker-compose run rm --service-ports $1 /bin/bash
    else
        docker-compose run --rm --service-ports app /bin/bash
    fi
}

function docker-enter-again() {
    if [ -n "$1" ]
    then
        docker-compose run rm $1 /bin/bash
    else
        docker-compose run --rm app /bin/bash
    fi
}

#
# 2FA recovery script
#

alias recover_mfa="$DOTFILES_PATH/bin/recover.sh"

#
# Quick cd into ~/dev directory
#

# Create a static named directory '~d'
hash -d d=~/dev

# Swtich to ~/dev using '~d' without 'cd'
setopt AUTO_CD
