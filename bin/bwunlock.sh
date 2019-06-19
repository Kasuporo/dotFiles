#!/usr/bin/env sh

echo "Enter password:"
read -rs p;

b="$(echo "$p" | bw unlock | rg 'export' | rg -o 'BW_SESSION.+')"

if [[ $b ]]; then
    export "$b"
fi
