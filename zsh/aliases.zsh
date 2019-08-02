#
# Docker Stuffs
#

# I think there's a homebrew package for this, but I'm a lazy boi
alias docker-clean="docker ps -a | grep 'Exited\|Created' | cut -d ' ' -f 1 | xargs docker rm"

#
# Virtual Env stuffs
#

# Create virtual environment for current directory
function mkenv()
{
    if [[ -d "env/" ]]; then
        printerr "\`env\` already exisits in the current directory!"
    else
        printgarr "Creating \`env\`."
        python3 -m venv env

        printgarr "Sourcing \`env\`."
        source env/bin/activate

        printgarr "Upgrading pip."
        # Because I don't like that annoying message
        pip install --upgrade pip

        if [ -f "requirements.txt" ]; then
           printgarr "Found \`requirements.txt\`. Installing."
           pip install -r requirements.txt
        fi

        find_env

        printifo "Virtual environment created."
    fi
}

# Remove virtual environment
function rmenv()
{
    if [ "$VIRTUAL_ENV" ]; then
        printgarr "Removing \`env\` folder."
        eval rm -rf $VIRTUAL_ENV
        printgarr "Deactivaing virtual env."
        deactivate
    elif [[ -d "env/" ]]; then
        printgarr "Removing \`env\` folder."
        rm -rf env/
    else
        printerr "No \`env\` folder in the current directory!"
        return
    fi

    printifo "Virtual environment removed."
}

#
# Git stuffs
#

function gitme()
{
    git pull
    git add -A
    git commit -m $1
    git push
}


#
# Misc
#

alias ptpy="ptpython"
# Kitty
alias icat="kitty +kitten icat"
# 2FA recovery script
alias recover_mfa="cd ~/Nextcloud/documents/recovery && $DOTFILES/bin/enc.sh codes.txt && cd -"
# minetest
alias minetest="open /usr/local/Cellar/minetest/5.0.1/minetest.app"
# bw unlock
alias bwu="source $DOTFILES/bin/bwunlock.sh"
# bw generate
alias bwg="bw generate -lusn --length 24 | pbcopy"

#
# Quick cds
#

alias cdev="cd ~/dev"
alias ncdev="cd ~/Nextcloud/code"
