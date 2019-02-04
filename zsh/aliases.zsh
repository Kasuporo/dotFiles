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

        printgarr "Found \`requirements.txt\`. Installing."
        if [[ -f "requirements.txt" ]]; then
           pip install -r requirements.txt
        fi

        find_env

        printifo "Virtual environment created."
    fi
}

# Remove virtual environment
function rmenv()
{
    if [[ "$VIRTUAL_ENV" ]]; then
        printgarr "Removing \`env\` folder."
        rm -rf $VIRTUAL_ENV
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
# 2FA recovery script
#

alias recover_mfa="$DOTFILES/bin/recover.sh"

#
# Quick cd into ~/dev directory
#

# Create a static named directory '~d'
# I know it's only 3 less characters, I'm just lazy okay?!
hash -d d=~/dev
# Swtich to ~/dev using '~d' without 'cd'
setopt AUTO_CD
