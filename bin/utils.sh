
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
whi=$'\e[0m'

bld=$'\e[1m' # bold
und=$'\e[4m' # underline

# print green arrow
printgarr()
{
    echo $grn"===>"$whi$bld $1
}

# print blue arrow
printbarr()
{
    echo $blu"===>"$whi$bld $1
}

# print error
printerr()
{
    echo $red"Error:"$whi$bld $1
}

printtxt()
{
    echo "$bld    $1"
}

newline()
{
    printf "\n"
}
