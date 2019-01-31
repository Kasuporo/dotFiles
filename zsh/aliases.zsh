#
# Docker Stuffs
#

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

alias open_recovery_file="$DOTFILES_PATH/bin/recover.sh"

#
# Quick cd into ~/dev directory
#

alias cdd="cd ~/dev"
