#!/usr/bin/bash

function create_py() {
  cd
  mkdir -p ~/workspace/$1/$1
  cd ~/workspace/$1
  echo "Creating Poetry environment with dev dependencies..." 
  poetry init -n -q
  poetry add -nqD black pyright isort flake8 mypy
  echo "Copying project template..." 
  cp ~/dotfiles/project-templates/python/py.gitignore .gitignore
  cp ~/dotfiles/project-templates/python/pyrightconfig.json . 
  cp ~/dotfiles/project-templates/python/Makefile .
  cp ~/dotfiles/project-templates/python/src/* $1/.
  echo "Done." 
  git init 
  touch README.md
  echo '# ${1}' >> README.md
  sed -i "s/project_name/$1/g" $(find . -maxdepth 3 -type f)
  git add .
  git commit -m "Initial commit"
}
