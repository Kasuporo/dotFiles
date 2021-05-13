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
           env LDFLAGS="-L$(brew --prefix openssl)/lib" CFLAGS="-I$(brew --prefix openssl)/include" pip install -r requirements.txt
           pip install black flake8
        fi

        find_env

        printifo "Virtual environment created."
    fi
}

# Remove virtual environment
function rmenv()
{
    if [ "$VIRTUAL_ENV" ]; then
        printgarr "Deactivaing virtual env."
        deactivate
        printgarr "Removing \`env\` folder."
        eval rm -rf $VIRTUAL_ENV
    elif [[ -d "env/" ]]; then
        printgarr "Removing \`env\` folder."
        rm -rf env/
    else
        printerr "No \`env\` folder in the current directory!"
        return
    fi

    printifo "Virtual environment removed."
}

function jdk()
{
    version=$1
    export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
    java -version
}

# Do sudo with touch id
function sudo()
{
    unset -f sudo
    if [[ "$(uname)" == 'Darwin' ]] && ! grep 'pam_tid.so' /etc/pam.d/sudo --silent; then
        echo "Adding touch id"
        sudo sed -i -e '1s;^;auth       sufficient     pam_tid.so\n;' /etc/pam.d/sudo
    fi
    sudo "$@"
}

#
# Misc
#

alias ls="lsd"
alias cat="bat"
alias sed="gsed"
alias http="python3 -m http.server 8000 --bind 127.0.0.1"
alias contessh="/Users/justin/dev/git.waifu.church/justin/contessh/contessh.py"
# because I'm an idiot
alias rm="rm -i"
alias mv="mv -i"
