#!/usr/bin/bash

function create() {
    cd
    mkdir /mnt/d/workspace/$1
    cd /mnt/d/workspace/$1
    git init -b main
    git remote add origin git@github.com:julianstephens/$1
    touch README.md
    git add .
    git commit -m "Initial commit"
    git push -u origin main
}

# source ~/.my_commands.sh
