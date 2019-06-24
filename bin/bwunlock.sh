#!/bin/bash

echo "Enter password:"
read -r -s p;

b="$(echo "$p" | bw unlock | rg 'export' | rg -o 'BW_SESSION.+')"

if [ "$b" ]; then
    export "${b}?"
fi
