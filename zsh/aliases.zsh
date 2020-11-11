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

function jdk() {
    version=$1
    export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
    java -version
}


#
# Misc
#

alias ls="lsd"
alias cat="bat"
alias sed="gsed"
# 2FA recovery script
alias recover_mfa="cd ~/Sync/jd_misc/recovery && $DOTFILES/bin/enc.sh codes.txt && cd -"
# bw unlock
alias bwu="source $DOTFILES/bin/bwunlock.sh && bwc"
# bw generate
alias bwg="bw generate -lusn --length 24 | pbcopy"
