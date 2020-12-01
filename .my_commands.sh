#!/usr/bin/bash

function create() {
    cd
    mkdir /mnt/d/workspace/$1
    cd /mnt/d/workspace/$1
    git init
    git remote add origin git@github.com:julianstephens/$1
    touch README.md
    git add .
    git commit -m "Initial commit"
    git push -u origin master
}

# source ~/.my_commands.sh
