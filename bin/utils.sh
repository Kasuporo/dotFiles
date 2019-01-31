
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
whi=$'\e[0m'

bld=$'\e[1m' # bold
und=$'\e[4m' # underline
rst=`tput sgr0` # reset

# print green arrow
printgarr()
{
    echo $grn"===>"$whi$bld $1$rst
}

# print blue arrow
printbarr()
{
    echo $blu"===>"$whi$bld $1$rst
}

# print error
printerr()
{
    echo $red"Error:"$whi$bld $1$rst
}

printtxt()
{
    echo "$bld    $1$rst"
}

newline()
{
    printf "\n"
}
