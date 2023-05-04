#!/usr/bin/bash

PNAME=""
ISPRIVATE=false
USEAI=false
USEEMOJI=false
USAGE="usage: cpy [--name <>| -n <>][--private| -p][--emoji| -e][--ai| -a][--help| -h]"
DIVIDER="=============================================================================="

function create_py() {
  if [ $# -eq 0 ]; then
      >&2 echo $USAGE
  fi

  while (( "$#" )); do
    case $1 in 
      -h|--help) echo $USAGE; shift ;;
      -n|--name) PNAME="$2"; shift;shift ;;
      -p|--private) ISPRIVATE=true; shift ;;
      -e|--emoji) USEEMOJI=true; shift ;;
      -a|--ai) USEAI=true; shift ;;
      *) echo "Unknown argument passed: $1"; shift ;;
  esac; done

  if [[ ! -z "$PNAME" ]]; then
    echo $DIVIDER
    echo "Creating project $PNAME..."
    echo $DIVIDER
    cd ~/workspace

    if [[ "$ISPRIVATE" = true ]]; then
      gh repo create $PNAME --add-readme --private 
      EXITCODE=$?
    else 
      gh repo create $PNAME --add-readme --public
      EXITCODE=$?
    fi

    if [[ "$EXITCODE" != "0" ]]; then
      echo $DIVIDER
      echo "Could not create repo with GH CLI. Creating manually..."
      echo $DIVIDER
      mkdir ~/workspace/$PNAME 
      cd ~/workspace/$PNAME
      git init 
      touch README.md
      echo '# ${PNAME}' >> README.md
      sed -i "s//$PNAME/g" $(find . -maxdepth 3 -type f)
      git add .
      git commit -m "Initial commit"
    else 
      gh repo clone $PNAME ~/workspace/$PNAME
      cd ~/workspace/$PNAME
    fi

    echo $DIVIDER
    echo "Initializing Poetry project with dev dependencies..." 
    echo $DIVIDER
    mkdir -p $PNAME/src 
    poetry init -n -q
    poetry add -nq -G dev black pyright isort flake8 pydocstyle mypy pre-commit
    echo $DIVIDER
    echo "Copying project template..." 
    echo "With Emoji: $USEEMOJI"
    echo "With AI: $USEAI"
    echo $DIVIDER
    cp ~/dotfiles/project-templates/python/py.gitignore .gitignore
    cp ~/dotfiles/project-templates/python/pyrightconfig.json . 
    cp ~/dotfiles/project-templates/python/.pre-commit-config.yaml . 
    cp ~/dotfiles/project-templates/python/Makefile .

    if [[ "$USEEMOJI" = true ]]; then
      cp ~/dotfiles/project-templates/python/emoji.commitlint.config.js ./temp.js
    else 
      cp ~/dotfiles/project-templates/python/commitlint.config.js ./temp.js
    fi

    if [[ "$USEAI" = true ]]; then
      node -p "console.log(`module.exports = ${JSON.stringify({...require('./temp.js'), prompt: {...require('./temp.js').prompt, useAI: true, aiNumber: 3}})}`)" > commitlint.config.js
    fi

    cp ~/dotfiles/project-templates/python/src/* $PNAME/src/.
    echo $DIVIDER
    echo "Creating Poetry environment..."
    echo $DIVIDER
    poetry install --no-root
    echo $DIVIDER
    echo "Setup pre-commit..."
    echo $DIVIDER
    poetry run pre-commit autoupdate
    poetry run pre-commit install --hook-type commit-msg
    poetry run pre-commit install
  fi
  echo $DIVIDER
  echo "Done. Launching subshell..."
  echo $DIVIDER
  # poetry shell
}
