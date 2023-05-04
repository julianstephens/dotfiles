#!/usr/bin/bash

PNAME=""
ISPRIVATE=false
USAGE="usage: cpy [--name <project_name>| -n <project_name>][--private| -p][--help| -h]"

function create_py() {
  if [ $# -eq 0 ]; then
      >&2 echo $USAGE
  fi

  while (( "$#" )); do
    case $1 in 
      -h|--help) echo $USAGE; shift ;;
      -n|--name) PNAME="$2"; shift;shift ;;
      -p|--private) ISPRIVATE=true; shift ;;
      *) echo "Unknown argument passed: $1"; shift ;;
  esac; done

  if [[ ! -z "$PNAME" ]]; then
    echo "Creating project $PNAME..."
    cd ~/workspace

    if [[ "$ISPRIVATE" = true ]]; then
      gh repo create $PNAME --add-readme --private 
      EXITCODE=$?
    else 
      gh repo create $PNAME --add-readme --public
      EXITCODE=$?
    fi

    if [[ "$EXITCODE" != "0" ]]; then
      echo "Could not create repo with GH CLI. Creating manually..."
      cd ~/workspace/$PNAME
      git init 
      touch README.md
      echo '# ${PNAME}' >> README.md
      sed -i "s/project_name/$PNAME/g" $(find . -maxdepth 3 -type f)
      git add .
      git commit -m "Initial commit"
    else 
      gh repo clone $PNAME
      cd ~/workspace/$PNAME
    fi

    echo "Initializing Poetry project with dev dependencies..." 
    mkdir -p $PNAME/src 
    poetry init -n -q
    poetry add -nq -G dev black pyright isort flake8 pydocstyle mypy pre-commit
    echo "Copying project template..." 
    cp ~/dotfiles/project-templates/python/py.gitignore .gitignore
    cp ~/dotfiles/project-templates/python/pyrightconfig.json . 
    cp ~/dotfiles/project-templates/python/Makefile .
    cp ~/dotfiles/project-templates/python/src/* $PNAME/src/.
    echo "Creating Poetry environment..."
    make venv
    echo "Installing Git hook scripts..."
    poetry run pre-commit install
    git add .
    git commit -m ""
  fi
}
