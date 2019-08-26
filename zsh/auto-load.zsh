#
# auto load things
#
autoload -Uz add-zsh-hook

#
# AUTO Activate/Deactivate Virtual Env
#

# If we leave the project directory, I want the env to deactivate
function auto_deactivate()
{
    # Get project directory
    local project="${VIRTUAL_ENV%/env}"

    # If we are in the project this will be the directory of the project we are in
    # e.g if
    #   $project=/home/justin/dev/python-project
    # and
    #   $PWD=/home/justin/dev/python-project/test
    # then
    #   $current_dir=/test
    local current_dir="${PWD##$project}"

    # Now we only need to check if $project + $current_dir is an actual directory
    if [ ! -d "$project$current_dir" ]; then
        deactivate
    fi
}

add-zsh-hook -D chpwd auto_deactivate
add-zsh-hook chpwd auto_deactivate

# Gives the path to the nearest parent env file or nothing if it gets to root
function find_env()
{
    local check_dir=$1

    if [ -z "$check_dir" ]; then
      check_dir=$PWD
    fi

    if [[ "$VIRTUAL_ENV" = "${check_dir}/env" ]]; then
      return
    fi

    if [[ -d "${check_dir}/env" ]]; then
        # Activate this env
        source "${check_dir}/env/bin/activate"
        return
    else
        if [ "$check_dir" = "/" ]; then
            return
        fi
        next=$(dirname "$check_dir")
        find_env "$(dirname "$check_dir")"
    fi
}


add-zsh-hook -D chpwd find_env
add-zsh-hook chpwd find_env

# auto-detect virtualenv on zsh startup
[[ -o interactive ]] && find_env
