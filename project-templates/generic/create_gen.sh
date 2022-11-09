#!/usr/bin/bash

function create_gen() {
    cd
    mkdir ~/workspace/$1
    cd ~/workspace/$1
    git init
    cp ~/dotfiles/project-templates/generic/gen.gitignore .gitignore 
    git remote add origin git@github.com:julianstephens/$1
    touch README.md
    echo '# ${1}' >> README.md
    git add .
    git commit -m "Initial commit"
}

# source ./create_gen.sh
